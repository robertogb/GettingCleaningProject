---
title: "codebook.md"
author: "Roberto Garrote Bernal"
date: "23 de julio de 2015"
output:
  html_document:
    keep_md: yes
---

## Project Description
The objective is to prepare tiny data from the raw data, so it can be used for later analysis.

##Study design and data processing

###Collection of the raw data
The original data is collected from the web page

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The downloaded file is compressed in zip format.
Once uncompressed, the data is structured in a directory named UCI HAR Dataset. Under this directory, there are four files:
- 'README.txt': Describes the data set.
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the activity labels with their activity code.

The data set is splitted in two separate groups, one for training and one for testing. Each group of data is stored in its corresponding directory:
- 'train/'
- 'test/'

The structure in those directories is similar:
- 'train/X_train.txt': Training set where each row is an experiment for one subject and one activity. It contains one value for each of the 561 features.
- 'train/y_train.txt': Each row has the activity id of the corresponding row in X_train.txt.
- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
- 'test/X_test.txt': Test set where each row is an experiment for one subject and one activity. It contains one value for each of the 561 features.
- 'test/y_test.txt': Each row has the activity id of the corresponding row in X_test.txt.
- 'test/subject_test.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

Under both directories there is another subdirectory 'Inertial Signals/' which contain data not used in this project. 

###Notes on the original (raw) data 

Number of Instances | Number of Variables
--------------------|----------------------
              10299 |                561+2


- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

##Creating the tidy datafile

###Guide to create the tidy data file
The R script called run_analysis.R does the following to obtain and tidy the data:

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

A detailed description of what the cleaning script does is provided in the [README document](README.md)

##Description of the variables in the 'tidy dataset.txt' file
We provide here a general description of the file including:
 - Dimensions of the dataset
 - Summary of the data
 - Variables present in the dataset
 
###Dimensions of the dataset
 
 Number of Instances | Number of Variables |  Size
---------------------|---------------------|---------
               14220 |                4    | 290752 bytes

###Summary of the data

```{r}
summary(tinydata)
    Subject                   Activity                 Feature           Mean         
 Min.   : 1.0   LAYING            :2370   tBodyAcc-mean()-X:  180   Min.   :-0.99767  
 1st Qu.: 8.0   SITTING           :2370   tBodyAcc-mean()-Y:  180   1st Qu.:-0.95242  
 Median :15.5   STANDING          :2370   tBodyAcc-mean()-Z:  180   Median :-0.34232  
 Mean   :15.5   WALKING           :2370   tBodyAcc-std()-X :  180   Mean   :-0.41241  
 3rd Qu.:23.0   WALKING_DOWNSTAIRS:2370   tBodyAcc-std()-Y :  180   3rd Qu.:-0.03654  
 Max.   :30.0   WALKING_UPSTAIRS  :2370   tBodyAcc-std()-Z :  180   Max.   : 0.97451  
                                          (Other)          :13140                     
```

###Variables in the dataset

Variable | Short description | Class | Values/Levels | Unit of measurement
---------|-------------------|-------|---------------|---------------------
Subject | Identifier of the subject who carried out the experiment | integer | 1:30 | none
Activity | Activity label | Factor with 6 levels| WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING | none
Feature | Characteristic to be measured | Factor with 79 levels | See below | none
Mean    | Mean of the values for the subject, activity and feature | number | [-1,1] | no specified in the raw data

####Levels of Feature
 [1] "tBodyAcc-mean()-X"               "tBodyAcc-mean()-Y"              
 [3] "tBodyAcc-mean()-Z"               "tBodyAcc-std()-X"               
 [5] "tBodyAcc-std()-Y"                "tBodyAcc-std()-Z"               
 [7] "tGravityAcc-mean()-X"            "tGravityAcc-mean()-Y"           
 [9] "tGravityAcc-mean()-Z"            "tGravityAcc-std()-X"            
[11] "tGravityAcc-std()-Y"             "tGravityAcc-std()-Z"            
[13] "tBodyAccJerk-mean()-X"           "tBodyAccJerk-mean()-Y"          
[15] "tBodyAccJerk-mean()-Z"           "tBodyAccJerk-std()-X"           
[17] "tBodyAccJerk-std()-Y"            "tBodyAccJerk-std()-Z"           
[19] "tBodyGyro-mean()-X"              "tBodyGyro-mean()-Y"             
[21] "tBodyGyro-mean()-Z"              "tBodyGyro-std()-X"              
[23] "tBodyGyro-std()-Y"               "tBodyGyro-std()-Z"              
[25] "tBodyGyroJerk-mean()-X"          "tBodyGyroJerk-mean()-Y"         
[27] "tBodyGyroJerk-mean()-Z"          "tBodyGyroJerk-std()-X"          
[29] "tBodyGyroJerk-std()-Y"           "tBodyGyroJerk-std()-Z"          
[31] "tBodyAccMag-mean()"              "tBodyAccMag-std()"              
[33] "tGravityAccMag-mean()"           "tGravityAccMag-std()"           
[35] "tBodyAccJerkMag-mean()"          "tBodyAccJerkMag-std()"          
[37] "tBodyGyroMag-mean()"             "tBodyGyroMag-std()"             
[39] "tBodyGyroJerkMag-mean()"         "tBodyGyroJerkMag-std()"         
[41] "fBodyAcc-mean()-X"               "fBodyAcc-mean()-Y"              
[43] "fBodyAcc-mean()-Z"               "fBodyAcc-std()-X"               
[45] "fBodyAcc-std()-Y"                "fBodyAcc-std()-Z"               
[47] "fBodyAcc-meanFreq()-X"           "fBodyAcc-meanFreq()-Y"          
[49] "fBodyAcc-meanFreq()-Z"           "fBodyAccJerk-mean()-X"          
[51] "fBodyAccJerk-mean()-Y"           "fBodyAccJerk-mean()-Z"          
[53] "fBodyAccJerk-std()-X"            "fBodyAccJerk-std()-Y"           
[55] "fBodyAccJerk-std()-Z"            "fBodyAccJerk-meanFreq()-X"      
[57] "fBodyAccJerk-meanFreq()-Y"       "fBodyAccJerk-meanFreq()-Z"      
[59] "fBodyGyro-mean()-X"              "fBodyGyro-mean()-Y"             
[61] "fBodyGyro-mean()-Z"              "fBodyGyro-std()-X"              
[63] "fBodyGyro-std()-Y"               "fBodyGyro-std()-Z"              
[65] "fBodyGyro-meanFreq()-X"          "fBodyGyro-meanFreq()-Y"         
[67] "fBodyGyro-meanFreq()-Z"          "fBodyAccMag-mean()"             
[69] "fBodyAccMag-std()"               "fBodyAccMag-meanFreq()"         
[71] "fBodyBodyAccJerkMag-mean()"      "fBodyBodyAccJerkMag-std()"      
[73] "fBodyBodyAccJerkMag-meanFreq()"  "fBodyBodyGyroMag-mean()"        
[75] "fBodyBodyGyroMag-std()"          "fBodyBodyGyroMag-meanFreq()"    
[77] "fBodyBodyGyroJerkMag-mean()"     "fBodyBodyGyroJerkMag-std()"     
[79] "fBodyBodyGyroJerkMag-meanFreq()"

