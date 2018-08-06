# Getting-and-Cleaning-Data-Course-Project
Coursera Data Science Project

Repository Contains 3 following files:

1. CodeBook.md - describes the variables, data, and transformations
2. README.md - Explains the analysis files is clear and understandable
3. run_analysis.R, does the following:

a. Download the dataset if it does not already exist in the working directory.<br />
b. Load the activity and feature info.<br />
c. Loads both the training and test datasets, keeping only those columns which reflect a mean or standard deviation.<br />
d. Loads the activity and subject data for each dataset, and merges those columns with the dataset.<br />
e. Merges the two datasets.<br />
f.  Converts the activity and subject columns into factors.<br />
g. Creates a tidy dataset that consists of the average (mean) value of each variable for each subject and activity pair.<br />
h. The end result is shown in the file tidy.txt.<br />
