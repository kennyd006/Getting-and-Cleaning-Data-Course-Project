# Download the dataset into the current working directory
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url,destfile="Dataset.zip")

# Unzip dataSet.zip into the current working directory
unzip(zipfile="Dataset.zip")

## 1. Merge the training and the test sets to create one data set

# Read features into R
features <- read.table('UCI HAR Dataset/features.txt')

# Read test tables into R
subject_test <- read.table("UCI Har Dataset/test/subject_test.txt")
X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")

# Add column names to test tables
colnames(subject_test) <- "subjectId"
colnames(X_test) <- features[ ,2]
colnames(y_test) <- "activity"

# Combine test tables into one table
test <- cbind(subject_test, y_test, X_test)

# Read training tables into R
subject_train <- read.table("UCI Har Dataset/train/subject_train.txt")
X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")

# Add column names to training tables
colnames(subject_train) <- "subjectId"
colnames(X_train) <- features[ ,2]
colnames(y_train) <- "activity"

# Combine training tables into one table
train <- cbind(subject_train, y_train, X_train)

# Merge the test and training tables into one
mergedData <- rbind(test,train)

## 2. Extract only the measurements on the mean and standard deviation for each measurement

# get all column names from merged data
allColumnNames <- colnames(mergedData)

# Create a logical vector indicating columns that include 'std' or 'mean' 
#  (or are the subjectId or activity columns)

stdOrMean <- (grepl("std..", allColumnNames) | grepl("mean..", allColumnNames) |
              grepl("activity", allColumnNames) | grepl("subjectId", allColumnNames)  
             )
# Keep only the appropriate columns
stdOrMeanData <- mergedData[ , stdOrMean == TRUE]

## 3. Use descriptive activity names to name the activities in the data set

# Read activity labels into R and label columns
activityLabels = read.table('UCI HAR Dataset/activity_labels.txt')
colnames(activityLabels) <- c('activity','activityType')

# label activities
stdOrMeanData <- merge(stdOrMeanData, activityLabels,
                              by='activity',
                              all.x=TRUE)

## 4. Appropriately label the data set with descriptive variable names

# Attempt to make feature variables easier to read
names(stdOrMeanData) <- gsub("Acc", "Accelerometer", names(stdOrMeanData))
names(stdOrMeanData) <- gsub("Gyro", "Gyroscope", names(stdOrMeanData))
names(stdOrMeanData) <- gsub("Mag", "Magnitude", names(stdOrMeanData))
names(stdOrMeanData) <- gsub("^t", "time", names(stdOrMeanData))
names(stdOrMeanData) <- gsub("^f", "frequency", names(stdOrMeanData))

## 5. Create a second, independent tidy data set with the average of each 
#  variable for each activity and each subject

tidyData <- aggregate(. ~subjectId + activity, stdOrMeanData, mean)
tidyData <- tidyData[order(tidyData$subjectId, tidyData$activity ),]

# Write tidy data set to .txt file in current working directory
write.table(tidyData, "tidyData.txt", row.name=FALSE)

