

1. Merges the training and the test sets to create one data set. There are 3 in each set.

import data sets and merge them to one set

x_train = 7352 obs of 561 variables
y_train = 7352 obs of 1 variable
subject_train = 7352 of 1 variable

x_test = 2947 obs of 561 variables
y_test = 2947 of 1 variable
subject_test = 2947 obs of 1 variable

use cbind to merge:
test_set = 2947 obs of 563 variables
train_set = 7352 obs of 563 variables

use rbind to merge:
x_set
y_set

subject_set
merged_set = 10299 obs of 563 variables

#2. Extracts only the measurements on the mean and standard deviation for each measurement. 
    #   import features data set

---import features data set
---use grep to search for:
-------mean_std: mean and standard deviation for each measurement from features data set

---find length of mean_std   (= 66)

---update x_set column names

# 3. Uses descriptive activity names to name the activities in the data set

--import activities data set
---update activity names for y set
        six activies: 1 WALKING 2 WALKING_UPSTAIRS 3 WALKING_DOWNSTAIRS 4 SITTING 5 STANDING 6 LAYING
        
# 4. Appropriately labels the data set with descriptive variable names. 

---label subject in subject set
---use gsub to rename the test desccriptions, "Acc" to "Accelerator"
---use cbind to make final_set from x_set, y_set, and subjecct_set


# 5. From the data set in step 4, creates a second, independent tidy data set with the average of 
#each variable for each activity and each subject.

---use plyr library
---use ddply to create data set: tidydata_average
---use write.table to create a txt table of the tidy data set