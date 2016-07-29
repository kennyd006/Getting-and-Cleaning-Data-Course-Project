## Getting and Cleaning Data Course Project




### Source Data
A full description of the data is available at the site where the data was obtained:(http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

The source data for the project can be found here:(https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

The source data is downloaded and unzipped into the current working directory

### Section 1. Merge the training and the test sets to create one data set
Read into R the features data from the following file:
* features.txt

Read into R the test data from the following files:
* subject_test.txt
* X_test.txt
* y_test.txt

Assign column names to test tables and combine into one

Read into R the training data from the following files:
* subject_train.txt
* X_train.txt
* y_train.txt

Assign column names to training tables and combine into one

Merge test and training tables into one

## Section 2. Extract only the measurements on the mean and standard deviation for each measurement 
Get all column names from merged data
Create a logical vector indicating columns that include 'std' or 'mean'(or are the subjectId or activity columns)
Keep only the appropriate columns

## Section 3. Use descriptive activity names to name the activities in the data set
Read into R the activityLabels data from the following files:
* activity_labels.txt

Label activities in the data set by merging data set with the activityLabels table to inlude descriptive activity names

## Section 4. Appropriately label the data set with descriptive variable names
Alter variable names using gsub function to replace truncated terms with expanded labels.

## Section 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject
Aggregate and Order data set 
Write into the following file in the current working directory the tidy data set:
* tidyData.txt
