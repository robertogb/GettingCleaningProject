---
title: "codebook.md"
author: "Roberto Garrote Bernal"
date: "23 de julio de 2015"
output: word_document
---

## Project Description
The objective is to prepare tiny data from the raw data, so it can be used for later analysis

##Study design and data processing

###Collection of the raw data
The original data is collected from the web page
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
The downloaded file is compressed in zip format.
Once uncompressed, the data is structured in a directory named UCI HAR Dataset.
Under this directory, there are four files:
- 'README.txt': Describes the data set
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the activity labels with their activity code.

The data set is splitted in two separate groups, one for training and one for testing. Esach group of data is stored in the corresponding directory:
- 'train/'
- 'test/'

The structure in those directories is similar:
- 'train/X_train.txt': Training set where is row is an experiment for one subject and one activity. It contains one value for each of the 561 features.
- 'train/y_train.txt': Each row has the activity id of the corresponding row in X_train.txt.
- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
- 'test/X_test.txt': Test set where is row is an experiment for one subject and one activity. It contains one value for each of the 561 features.
- 'test/y_test.txt': Each row has the activity id of the corresponding row in X_test.txt.
- 'test/subject_test.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

Under both directories there is another subdirectory 'Inertial Signals/' which contain data not used in this project. 

###Notes on the original (raw) data 
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

##Creating the tidy datafile

###Guide to create the tidy data file
The R script called run_analysis.R does the following to tidy the data:
. Merges the training and the test sets to create one data set.
. Extracts only the measurements on the mean and standard deviation for each measurement. 
. Appropriately labels the data set with descriptive variable names. 
. Adds the columns with subject and activity to the data set in one table.
. Uses descriptive activity names to name the activities in the data set.
. Transform the data set from a wide format (79 features plus subject and activity) into a long format (Gather 
. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


###Cleaning of the data
Short, high-level description of what the cleaning script does. [link to the readme document that describes the code in greater detail]()

##Description of the variables in the tiny_data.txt file
General description of the file including:
 - Dimensions of the dataset
 - Summary of the data
 - Variables present in the dataset

(you can easily use Rcode for this, just load the dataset and provide the information directly form the tidy data file)

###Variable 1 (repeat this section for all variables in the dataset)
Short description of what the variable describes.

Some information on the variable including:
 - Class of the variable
 - Unique values/levels of the variable
 - Unit of measurement (if no unit of measurement list this as well)
 - In case names follow some schema, describe how entries were constructed (for example time-body-gyroscope-z has 4 levels of descriptors. Describe these 4 levels). 

(you can easily use Rcode for this, just load the dataset and provide the information directly form the tidy data file)

####Notes on variable 1:
If available, some additional notes on the variable not covered elsewehere. If no notes are present leave this section out.

##Sources
Sources you used if any, otherise leave out.

##Annex
If you used any code in the codebook that had the echo=FALSE attribute post this here (make sure you set the results parameter to 'hide' as you do not want the results to show again)

This is an R Markdown document. Markdown is a simple formatting syntax for authoring HTML, PDF, and MS Word documents. For more details on using R Markdown see <http://rmarkdown.rstudio.com>.

When you click the **Knit** button a document will be generated that includes both content as well as the output of any embedded R code chunks within the document. You can embed an R code chunk like this:

```{r}
summary(cars)
```

You can also embed plots, for example:

```{r, echo=FALSE}
plot(cars)
```

Note that the `echo = FALSE` parameter was added to the code chunk to prevent printing of the R code that generated the plot.