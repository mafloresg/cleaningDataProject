## run_analysis.R
## This script creates a tidy data set following the instructions in
## https://class.coursera.org/getdata-010/human_grading/view/courses/973497/assessments/3/submissions


## Download and unzip the data files

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile="getdata_projectfiles_UCI HAR Dataset.zip", method="curl")
untar('getdata_projectfiles_UCI HAR Dataset.zip')


## Merge the training and the test sets to create one data set
## Add the activity and the subject info too

testMeasurements <- read.delim("./UCI HAR Dataset/test/X_test.txt", sep="", header=FALSE, colClasses = "numeric")
testActivities <- read.delim("./UCI HAR Dataset/test/y_test.txt", header=FALSE)
names(testActivities) <- "activityid"
testSubjects <- read.delim("./UCI HAR Dataset/test/subject_test.txt", header=FALSE)
names(testSubjects) <- "subject"
testComplete <- cbind(testMeasurements,testActivities,testSubjects)
trainMeasurements <- read.delim("./UCI HAR Dataset/train/X_train.txt", sep="", header=FALSE, colClasses = "numeric")
trainActivities <- read.delim("./UCI HAR Dataset/train/y_train.txt", header=FALSE)
names(trainActivities) <- "activityid"
trainSubjects <- read.delim("./UCI HAR Dataset/train/subject_train.txt", header=FALSE)
names(trainSubjects) <- "subject"
trainComplete <- cbind(trainMeasurements,trainActivities,trainSubjects)
completeDataSet <- rbind(testComplete, trainComplete)


## Extract only the measurements on the mean and standard deviation for each measurement
## Selected those with "mean" or "std" in the name indicated in the file "features.txt"

columnsWeWant <- c(1,2,3,4,5,6,41,42,43,44,45,46,81,82,83,84,85,86,121,122,123,124,125,126,161,
                   162,163,164,165,166,201,202,214,215,227,228,240,241,253,254,266,267,268,269,
                   270,271,294,295,296,346,347,348,349,350,373,374,375,424,425,426,427,428,429,
                   452,453,454,503,504,513,516,517,526,529,530,539,542,543,552,562,563)
limitedDataSet <- completeDataSet[columnsWeWant]


## Appropriately labels the data set with descriptive variable names.

featuresNames <- read.delim("./UCI HAR Dataset/features.txt", sep="", header=FALSE)
featuresNamesC <- as.character(featuresNames[,2])
featuresNamesC[562] <- "activityid"
featuresNamesC[563] <- "subject"
names(limitedDataSet) <- featuresNamesC[columnsWeWant]
names(limitedDataSet) <- sub("\\(\\)","",gsub("-","",names(limitedDataSet)))


## Uses descriptive activity names to name the activities in the data set

labels <- read.delim("./UCI HAR Dataset/activity_labels.txt", sep="", header=FALSE)
workingDataSet <- merge(limitedDataSet, labels, by.x="activityid", by.y="V1")
labelsC <- names(workingDataSet)
labelsC[81] <- "activityname"
names(workingDataSet) <- labelsC


# Creates a second, independent tidy data set with the average of each variable for each activity and each subject

names <- names(limitedDataSet)
names <- names[1:78]
finalDataSet <- aggregate(workingDataSet[names], by=workingDataSet[c("subject","activityname")], FUN=mean)
finalNames <- sapply(names(finalDataSet), paste0, "Avg", simplify = "array", USE.NAMES = FALSE)
finalNames[1] <- "subject"
finalNames[2] <- "activityname"
names(finalDataSet) <- finalNames
write.table(finalDataSet,"finalDataSet.txt", row.name=FALSE)