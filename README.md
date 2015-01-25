### Introduction

This repository contains:
    
    1. run_analysis.R : script for performing the analysis
    2. finalDataSet.txt : the tidy data set resulting of the execution of run_analysis.R
    3. README.md : this file, explaining the content and how the script work
    4. CodeBook.md : a code book that describes the variables, the data, and any transformations and work performed 
        to clean up the data
        

### Execution of the script
In order to execute the script you have to enter the R command:
    source(run_analysis)
    

### Things that the script do

The data needed will be downloaded from this URL:    
    https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

This zip file will be decompressed and the files saved in a subfolder inside the working directory.

The next steps will be: 
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
