

## 0. configuration
The dplyr package will be used at the end of the code to facilitate some operation, it is loaded here
```{r}
library(dplyr)
```

## 1. Merges the training and the test sets to create one data set
File is downloaded directly from the Internet. Being quite heavy (~56Mb), this part can be commented so that it does not get downloaded everytime the script is launched
```{r}
download / Unzip original file
data_url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
#download.file(data_url, "my_original_data.zip") 
#unzip("my_original_data.zip")
```

Feature list is stored in the features.txt file. It is read as the beginning so that it can be used while reading the other files
```{r}
features_file <- "UCI HAR Dataset/features.txt"
features_DF <- read.table(features_file)
```


The 3 "train" files are located so that they can be read
```{r}
train_X_file <- "UCI HAR Dataset/train/X_train.txt"
train_Y_file <- "UCI HAR Dataset/train/Y_train.txt"
train_subject_file <- "UCI HAR Dataset/train/subject_train.txt"
```

The 3 "train" files are read using the read.table function. Column name is based on features original name already loaded before (see above). Descriptive name is given for activities and subject data
```{r}
train_X <- read.table(train_X_file, col.names = features_DF[, 2])
train_Y <- read.table(train_Y_file, col.names = "activitylabel")
train_subject <- read.table(train_subject_file, col.names = "subject")
```

Once read, the 3 "train" files are bombined with the cbind function. It is easy as they have the same number of rows
```{r}
train_DF <- cbind(train_subject, train_Y, train_X)
```



The exact same approach is used for test files. See above for details
```{r}
test_X_file <- "UCI HAR Dataset/test/X_test.txt"
test_Y_file <- "UCI HAR Dataset/test/Y_test.txt"
test_subject_file <- "UCI HAR Dataset/test/subject_test.txt"

# get the three different files into separate date frame
test_X <- read.table(test_X_file, col.names = features_DF[, 2])
test_Y <- read.table(test_Y_file, col.names = "activitylabel")
test_subject <- read.table(test_subject_file, col.names = "subject")

# combine the different column to create the full Train data set
test_DF <- cbind(test_subject, test_Y, test_X)
```


Test and Train data frames are combined using the rbind function. It is possible as they have the exact same columns
```{r}
my_DF <- rbind(train_DF, test_DF)
```

The previous process has led to the creation of quite many heavy variables. They are removed as they will not be used anymore
```{r}
rm(test_DF, test_X, test_Y, test_subject, train_DF, train_X, train_Y, train_subject, features_DF)
```

## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 


Until now, the data frame includes all original features. It is only necessary to keep the mean/standard deviation values. These are identified based on the feature name which contains eather mean or std, by using the grep function
```{r}
my_DF2 <- my_DF[, c(1,2, grep("mean|std", names(my_DF)))]
```
## 3. Uses descriptive activity names to name the activities in the data set


Activity list is created based on information found in original codebook. It is then used to replace original data (coded on integer from 1 to 6) by a descriptive information (e.g. standing", "laying"). This is done using the sapply and a very simple anonymous function
```{r}
activity_list <- c("walking", "walkingupstairs", "walkingdownstairs", "sitting", "standing", "laying")
my_DF2$activitylabel <- sapply(my_DF2$activitylabel, function(x) {activity_list[x]})
```


## 4. Appropriately labels the data set with descriptive variable names. 


gsub function with a regular expression is used to remove any non alphanumeric caracter of the variables name (e.g. _). Choice is made to keep capital letters which from my point of view improve readability
```{r}
names(my_DF2) <- gsub("[^[:alnum:]]", "", names(my_DF2)) 
```

## 5. From the data set in step 4, creates a second, independent tidy data set 

Finally, a summarized dataset is created using dplyr and pipe functionality. First data is grouped based on subject and activity label, then mean values of all variables is calculated. 
```{r}
my_DF_mean <- my_DF2 %>% group_by(subject, activitylabel) %>% summarize(across(everything(), list(mean))) 
names(my_DF_mean) <- gsub("[^a-zA-Z]", "", names(my_DF_mean)) 
```

