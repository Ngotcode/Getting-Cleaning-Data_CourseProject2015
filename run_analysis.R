# Coursera Getting and Cleaning Data_Course Project 2015

# Create one R script called run_analysis.R that does the following. 

# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# set working directory  
setwd("~/Desktop/2015_Get-CleaningData/course_project/UCI HAR Dataset")

getfile <- "getdata_dataset.zip"
if (!file.exists("./data")) { dir.create("/.data") }
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
#download.file(fileURL, destfile = "./data/getdata_dataset.zip", method="curl")
download.file(fileURL, getfile, method="curl")
dateDownloaded <- date() 

if (!file.exists("UCI HAR Dataset")) { 
  unzip(getfile) 
}

##########################################################################
# 1. Merges the training and the test sets to create one data set. There are 3 in each set.

        # import training and test data sets
x_train <- read.table("./train/X_train.txt", header = FALSE)
y_train <- read.table("./train/y_train.txt", header = FALSE)
subject_train <- read.table("./train/subject_train.txt", header=FALSE)

x_test <- read.table("./test/x_test.txt", header = FALSE)
y_test <- read.table("./test/y_test.txt", header = FALSE)
subject_test <- read.table("./test/subject_test.txt", header = FALSE)

# create test_data set
test_set <- cbind(y_test, subject_test, x_test)      # combine by columns

# create training_data set
train_set <- cbind(y_train, subject_train, x_train)

# merge training and test sets to create final data set
x_set <- rbind(x_train, x_test)
y_set <- rbind(y_train, y_test)
#y_set
subject_set <- rbind(subject_train, subject_test)

merged_set <- rbind(train_set, test_set)         # combine by rows

#############################################################################################
#2. Extracts only the measurements on the mean and standard deviation for each measurement. 
    #   import features data set
features_set <- read.table("features.txt", header = FALSE)
    # get data with mean and st dev 
mean_std <- grep("mean\\(\\)|std\\(\\)", features_set[, 2])
length(mean_std)      #length = 66 
mean_std

x_set <- x_set[, mean_std]         # change column names
names(x_set) <- features_set[mean_std, 2]
#names(x_set)

#############################################################################################
# 3. Uses descriptive activity names to name the activities in the data set

activity_names <- read.table("activity_labels.txt")
y_set[, 1] <- activity_names[y_set[, 1], 2]
names(y_set) <- "activity"      
#  six activies: 1 WALKING 2 WALKING_UPSTAIRS 3 WALKING_DOWNSTAIRS 4 SITTING 5 STANDING 6 LAYING
#y_set

#############################################################################################
# 4. Appropriately labels the data set with descriptive variable names. 

names(subject_set) <- "subject"

names(x_set) <- gsub("Acc", "Accelerator", names(x_set))
names(x_set) <- gsub("Mag", "Magnitude", names(x_set))
names(x_set) <- gsub("Gyro", "Gyroscope", names(x_set))
names(x_set) <- gsub("t", "time", names(x_set))
names(x_set) <- gsub("f", "frequency", names(x_set))
names(x_set) <- gsub("Bodybody", "Body", names(x_set))
names(x_set)

final_set <- cbind(x_set, y_set, subject_set)

#############################################################################################
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of 
#each variable for each activity and each subject.

# install.packages("dplyr")     # need to install if not already
library(plyr)

#length(mean_std)      #length = 66 
tidydata_average <- ddply(final_set, .(subject, activity), .fun=function(x) colMeans(x[, 1:66]))

write.table(tidydata_average, "tidydata_average.txt", row.name=FALSE)

