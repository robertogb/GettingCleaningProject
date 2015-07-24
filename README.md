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
,,,{r}
source('run_analysis.R')
,,,

1. Downloads the file from the web if it does not exist.
2. Unzips the file, so the data folder structure is created.
2. Reads the different files into data sets.
3. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Appropriately labels the data set with descriptive variable names. 
4. Adds the columns with subject and activity to the data set.
5. Uses descriptive activity names to name the activities in the data set.
6. Transforms the data set from a wide format (81 columns: 79 features plus subject and activity) into a long format (4 columns: subject, activity, feature and value).
7. Creates a second, independent tidy data set with the average of each feature for each activity and each subject.

#Script usage
