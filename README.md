### Introduction

This repository contains the files:
    
    1. run_analysis.R : script for performing the analysis
    2. finalDataSet.txt : the tidy data set resulting of a previous execution of run_analysis.R
    3. README.md : this explanatory file
    4. CodeBook.md : a code book that describes the variables, the data, and the transformations and work performed 
        to clean up the data
        

### Execution of the script

In order to execute the script you have to enter this in the R command line/RStudio:
    
    source("run_analysis.R")
    
    
### Visualizing the results

If you want to view the "finalDataSet.txt" file in R you can use the following code:

    data <- read.table("finalDataSet.txt", header = TRUE) 
    View(data)

As described in the forum thread "David's Project FAQ" from David Hood:
    https://class.coursera.org/getdata-010/forum/thread?thread_id=49
   
   
### Understanding the results

The dataset "finalDataSet.txt" contains the average (mean function) of each variable selected from the original data set, calculated by subject and the activity.

There are six possible activities: 

    WALKING
    WALKING_UPSTAIRS
    WALKING_DOWNSTAIRS
    SITTING
    STANDING
    LAYING
    
There are 30 subjects in the experiment.

# Rows
Each row contains the information on the activity, the subject and all the calculated means associated with them.
This results on a data set of 6x30 = 180 rows.

#Columns
The two first columns are the subject and the activity.
For the next columns, each one represents the mean of a variable. From the original data sets, only the variables with the strings "mean()" or "std()" in his name are selected. The script calculate the mean on them, for each subject and activity and the results are in the corresponding columns in the final data set.
This results on a set of 2+66 = 68 columns.

The name of the calculated columns is <<nameOfTheOriginalMeasure>> leaving in camel case notation and doing this modifications:

    - Remove the "-" and the "()" characters
    - Replace the string "BodyBody" by "Body", assuming this was an error in the original names
    - Add a suffix "Avg"
    - Change "t" prefix by "time"
    - Change "f" prefix by "frequency"
    - Change "Acc" particle by "Accelerometer"
    - Change "Gyro" particle by "Gyroscope"
    
For information about what the variables means, please refer to the CodeBook.md.
All the variables are normalised in a (-1, 1) range, that means that they come with no units.


### Things that the script do

1. The data needed is downloaded from this URL:    
    https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
    
2. The zip file is decompressed, and the resulting files saved in a subfolder inside the working directory.

3. Merges the training and the test sets contained in the data and create one data set. See more details in the next section "Original files".

4. Extracts only the measurements on the mean and standard deviation for each measurement. 
Only those columns with "mean()" or "std()" in his name (indicated in the file "features.txt") were selected.

5. Uses descriptive activity names to name the activities in the data set.

6. Appropriately labels the data set with descriptive variable names. 

7. From the data set in step 4, creates a second, independent tidy data set with the average of each 
variable for each activity and each subject. This new data set is named finalDataSet.txt.


### Original files

Once the original data is decompressed, inside the resulting directory "UCI HAR Dataset" you can learn in "README.txt" about the experiment, the measurements, the way that it were acquired, the estimated variables, the resulting datasets and files.

The obtained dataset resulting from the experiments has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 
Consequently, you can find the subfolders:

    - "test"
    - "train"

With the associated data within. The variables we want to process are inside the files "X_test.txt" and "X_train.txt".

Each line of the files corresponds to a subject and an activity.
The subjects are identified by a number and are listed in the files "subject_test.txt" and "subject_train.txt". 
The activities are identified by a number and are listed in the files "y_test.txt" and "y_train.txt".

For the purpose of this project, the data inside the folders named "Inertial Signals" is not needed. These are the original measurements, but we only want to work with the estimated variables calculated from the measurements.

In the "UCI HAR Dataset" folder you can find:

    - The description of the original measurements and the estimated variables, listed in "features_info.txt".
    - The order of variables in the datasets, listed in "features.txt".

