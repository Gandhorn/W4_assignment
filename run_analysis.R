## 0. configuration
library(dplyr)

## 1. Merges the training and the test sets to create one data set

# download /unzip original file
data_url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

# line is commented to avoid downloading the file several times (59Mb)
#download.file(data_url, "my_original_data.zip") 
#unzip("my_original_data.zip")


## update data frame names based on features list
features_file <- "UCI HAR Dataset/features.txt"
features_DF <- read.table(features_file)


## put together data regarding train datasets

# current file location
train_X_file <- "UCI HAR Dataset/train/X_train.txt"
train_Y_file <- "UCI HAR Dataset/train/Y_train.txt"
train_subject_file <- "UCI HAR Dataset/train/subject_train.txt"

# get the three different files into separate date frame
train_X <- read.table(train_X_file, col.names = features_DF[, 2])
train_Y <- read.table(train_Y_file, col.names = "activitylabel")
train_subject <- read.table(train_subject_file, col.names = "subject")

# combine the different column to create the full Train data set
train_DF <- cbind(train_subject, train_Y, train_X)



## put together data regarding test datasets

# current file location
test_X_file <- "UCI HAR Dataset/test/X_test.txt"
test_Y_file <- "UCI HAR Dataset/test/Y_test.txt"
test_subject_file <- "UCI HAR Dataset/test/subject_test.txt"

# get the three different files into separate date frame
test_X <- read.table(test_X_file, col.names = features_DF[, 2])
test_Y <- read.table(test_Y_file, col.names = "activitylabel")
test_subject <- read.table(test_subject_file, col.names = "subject")

# combine the different column to create the full Train data set
test_DF <- cbind(test_subject, test_Y, test_X)

## combine test and train data sets
my_DF <- rbind(train_DF, test_DF)

## remove unused variables
rm(test_DF, test_X, test_Y, test_subject, train_DF, train_X, train_Y, train_subject, features_DF)


## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
my_DF2 <- my_DF[, c(1,2, grep("mean|std", names(my_DF)))]


## 3. Uses descriptive activity names to name the activities in the data set

## replace activity code by actual activity name
activity_list <- c("walking", "walkingupstairs", "walkingdownstairs", "sitting", "standing", "laying")
my_DF2$activitylabel <- sapply(my_DF2$activitylabel, function(x) {activity_list[x]})

## 4. Appropriately labels the data set with descriptive variable names. 
# Technically, there are still capital letters but I think they help readying these very long / technical names
names(my_DF2) <- gsub("[^[:alnum:]]", "", names(my_DF2)) 

## 5. From the data set in step 4, creates a second, independent tidy data set 
## with the average of each variable for each activity and each subject.
my_DF_mean <- my_DF2 %>% group_by(subject, activitylabel) %>% summarize(across(everything(), list(mean))) 
names(my_DF_mean) <- gsub("[^a-zA-Z]", "", names(my_DF_mean)) 
