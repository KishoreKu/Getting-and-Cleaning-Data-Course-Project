#Setting Working Directory Path

dataPath <- "C:/Users/My DELL/Downloads/CourseraProject/UCI HAR Dataset"
setwd(dataPath)

# Creating "data" directory, download and extract all files into it

if(!file.exists("./data")){dir.create("./data")}
dataUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
library(bitops)
library(RCurl)
download.file(dataUrl,destfile = "./data/Dataset.zip",method = "libcurl")
unzip(zipfile = "./data/Dataset.zip",exdir = "./data")

#Installing and loading Required Packages

#install.packages("dplyr")
library(dplyr)
#install.packages("data.table")
library(data.table)
install.packages("tidyr")
library(tidyr)

#Reading Subject Files

dataPath <- "C:/Users/My DELL/Downloads/CourseraProject/UCI HAR Dataset/data"
dataSubjectTrain <- tbl_df(read.table(file.path(dataPath, "train", "subject_train.txt")))
dataSubjectTest  <- tbl_df(read.table(file.path(dataPath, "test" , "subject_test.txt" )))

# Reading activity files
dataActivityTrain <- tbl_df(read.table(file.path(dataPath, "train", "Y_train.txt")))
dataActivityTest  <- tbl_df(read.table(file.path(dataPath, "test" , "Y_test.txt" )))

# Reading data files.
dataTrain <- tbl_df(read.table(file.path(dataPath, "train", "X_train.txt" )))
dataTest  <- tbl_df(read.table(file.path(dataPath, "test" , "X_test.txt" )))
# Merging subject and activity files and renaming variables 
alldataSubject <- rbind(dataSubjectTrain, dataSubjectTest)
setnames(alldataSubject, "V1", "subject")
alldataActivity<- rbind(dataActivityTrain, dataActivityTest)
setnames(alldataActivity, "V1", "activityNum")

#combining the DATA training and test files
dataTable <- rbind(dataTrain, dataTest)

# naming variables according to feature 
dataFeatures <- tbl_df(read.table(file.path(dataPath, "features.txt")))
setnames(dataFeatures, names(dataFeatures), c("featureNum", "featureName"))
colnames(dataTable) <- dataFeatures$featureName

#column names for activity labels
activityLabels<- tbl_df(read.table(file.path(dataPath, "activity_labels.txt")))
setnames(activityLabels, names(activityLabels), c("activityNum","activityName"))

# Merge columns
alldataSubjAct<- cbind(alldataSubject, alldataActivity)
dataTable <- cbind(alldataSubjAct, dataTable)

# Reading "features.txt" and extracting only the mean and standard deviation

dataFeaturesMeanStd <- grep("mean\\(\\)|std\\(\\)",dataFeatures$featureName,value=TRUE)

# Taking only measurements for the mean and standard deviation and add "subject","activityNum"

dataFeaturesMeanStd <- union(c("subject","activityNum"), dataFeaturesMeanStd)
dataTable<- subset(dataTable,select=dataFeaturesMeanStd) 

##enter name of activity into dataTable

dataTable <- merge(activityLabels, dataTable , by="activityNum", all.x=TRUE)

## create dataTable with variable means sorted by subject and Activity

dataTable$activityName <- as.character(dataTable$activityName)
dataAggr<- aggregate(. ~ subject - activityName, data = dataTable, mean) 
dataTable<- tbl_df(arrange(dataAggr,subject,activityName))
head(str(dataTable),2)
#Renaming with descriptive variable names
names(dataTable)<-gsub("std()", "SD", names(dataTable))
names(dataTable)<-gsub("mean()", "MEAN", names(dataTable))
names(dataTable)<-gsub("^t", "time", names(dataTable))
names(dataTable)<-gsub("^f", "frequency", names(dataTable))
names(dataTable)<-gsub("Acc", "Accelerometer", names(dataTable))
names(dataTable)<-gsub("Gyro", "Gyroscope", names(dataTable))
names(dataTable)<-gsub("Mag", "Magnitude", names(dataTable))
names(dataTable)<-gsub("BodyBody", "Body", names(dataTable))
head(str(dataTable),6)

#writing to output file

write.table(dataTable, "TidyData.txt", row.name=FALSE)
