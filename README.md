---
title: "README.md"
author: "Roberto Garrote Bernal"
date: "23 de julio de 2015"
output:
  html_document:
    keep_md: yes
---

##Description of the script
The R script 'run_analysis.R' reads a zip file from a web site and through a number of transformations for tidying the data, writes a text file in the working directory.

###Usage
Set the working directory to the directory where the script is located and then executes the following command
```{r}
source('run_analysis.R')
```
###Input
The script get the zip file from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip. If the zip file already exist, it is not downloaded again.

###Output
The file 'tiny dataset.txt' is created in the working directory. If the file already exists, it is overwritten.

###Process
1. Downloads the file from the web if it does not exist.
2. Unzips the file, so the data folder structure is created.
2. Reads the different files into data sets. There are two reference files with information about activities and features:
  ```{r}
activityLabels <- read.table("./UCI HAR Dataset/activity_labels.txt",
                             sep = " ",
                             col.names = c("ActivityId", "Activity"))

featureLabels <- read.table("./UCI HAR Dataset/features.txt",
                             sep = " ",
                             stringsAsFactors = FALSE,
                             col.names = c("FeatureId", "Feature"))
  ```
    There are 6 data files: 2 groups (test and train) x 3 files/group (X_\<group\>.txt, subject_\<group\>.txt and y_\<group\>.txt):
  ```{r}
dataset <- read.fwf("./UCI HAR Dataset/test/X_test.txt", 
                 widths = rep(16,561), buffersize=100)
dataset2 <- read.fwf("./UCI HAR Dataset/train/X_train.txt", 
                  widths = rep(16,561), buffersize=100)
subjects <- read.table("./UCI HAR Dataset/test/subject_test.txt", 
                       col.names = "SubjectId")
subjects2 <- read.table("./UCI HAR Dataset/train/subject_train.txt", 
                       col.names = "SubjectId")
activity <- read.table("./UCI HAR Dataset/test/y_test.txt", 
                       col.names = "ActivityId")
activity2 <- read.table("./UCI HAR Dataset/train/y_train.txt", 
                        col.names = "ActivityId")
  ```
3. Merges the training and the test sets to create one data set. After that, unuseful variables are deleted to save memory:
  ```{r}
dataset <- rbind(dataset, dataset2)
rm(dataset2)

subjects <- rbind(subjects, subjects2)
rm(subjects2)

activity <- rbind(activity, activity2)
rm(activity2)
  ```
2. Extracts only the measurements on the mean and standard deviation for each measurement.

  ```{r}
hasMeanStd <- sapply(featureLabels$Feature, 
                     function(x){ grep("mean()|std()", x) > 0 })
selectCols <- which(as.vector(hasMeanStd, mode = "logical"))
dataset <- dataset[, selectCols]
  ```
  I'm just considering the measurements which represent the mean or the standard deviation of other measurements, and not the measurements which use the mean or standard deviation of other measurements, like for example "angle(X, gravityMean)". To obtain also the latest ones, the call to grep must be:
  ```{r}
grep("mean|std", x, ignore.case = TRUE)
  ```
3. Appropriately labels the data set with descriptive variable names.

  ```{r}
names(dataset) <- featureLabels[selectCols,"Feature"]
  ```
4. Adds the columns with subject and activity to the data set.

  ```{r}
dataset <- dataset %>%
    mutate(Subject = subjects$SubjectId, ActivityId = activity$ActivityId) %>% ...
  ```
5. Uses descriptive activity names to name the activities in the data set, so activity label is added to activity id

  ```{r}
... %>% join(activityLabels, by = "ActivityId") %>% 
        select(Subject, Activity, 1:79) %>% ...
  ```
6. Transforms the data set from a wide format (81 columns: 79 features plus subject and activity) into a long format (4 columns: subject, activity, feature and value).
  ```{r}
... %>% gather(Feature, Value, -(Subject:Activity))
  ```
7. Creates a second, independent tidy data set with the average of each feature for each activity and each subject.
  ```{r}
tinydata <- dataset %>%
    group_by(Subject, Activity, Feature) %>%
    summarise(Mean = mean(Value, na.rm = TRUE))

tinydata %>% write.table(file = "tiny dataset.txt", row.names = FALSE)
  ```

