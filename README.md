# Getting-and-Cleaning-Data-Course-Project
Coursera Data Science Project

Repository Contains 3 following files:

1. codebook.md - describes the variables, data, and transformations
2. README.md - Explains the analysis files is clear and understandable
3. run_analysis.R, does the following:

Download the dataset if it does not already exist in the working directory
Load the activity and feature info
Loads both the training and test datasets, keeping only those columns which reflect a mean or standard deviation
Loads the activity and subject data for each dataset, and merges those columns with the dataset
Merges the two datasets
Converts the activity and subject columns into factors
Creates a tidy dataset that consists of the average (mean) value of each variable for each subject and activity pair.
The end result is shown in the file tidy.txt.