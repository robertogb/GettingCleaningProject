# This script gets, unzips, read and transforms the zip file indicated by the url
# "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"


## GETTING, UNZIPPING AND READING THE FILES

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zipFile <- "getdata_projectfiles_UCI HAR Dataset.zip"

if (!file.exists(zipFile)) {
    download.file(url = fileUrl, destfile = zipFile, method = "libcurl")
}    

unzip(zipFile)


## READ the different tables in the data set

activityLabels <- read.table("./UCI HAR Dataset/activity_labels.txt",
                             sep = " ",
                             col.names = c("ActivityId", "Activity"))

featureLabels <- read.table("./UCI HAR Dataset/features.txt",
                             sep = " ",
                             stringsAsFactors = FALSE,
                             col.names = c("FeatureId", "Feature"))

# buffersize reduced to 100 due to memory issues
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

## TRANSFORMING THE FILES

# (Step 1) Merges the training and the test sets to create one data set.
dataset <- rbind(dataset, dataset2)
rm(dataset2)

subjects <- rbind(subjects, subjects2)
rm(subjects2)

activity <- rbind(activity, activity2)
rm(activity2)


# (Step 2) Extracts only the measurements on the mean and standard deviation
# for each measurement. 
# I'm just considering the measurements which represent the mean or the
# standard deviation of other measurements, and not the measurements which use
# the mean or standard deviation of other measurements, like for example
# "angle(X, gravityMean)". 
# To obtain also the latest ones, the call to grep must be:
# grep("mean|std", x, ignore.case = TRUE)
hasMeanStd <- sapply(featureLabels$Feature, 
                     function(x){ grep("mean()|std()", x) > 0 })
selectCols <- which(as.vector(hasMeanStd, mode = "logical"))
dataset <- dataset[, selectCols]

# (Step 4) Appropriately labels the data set with descriptive variable names. 
# Duplicated names exist in features, so it is better first to select the
# columns and then to rename them.
names(dataset) <- featureLabels[selectCols,"Feature"]



library(tidyr)
library(plyr)
library(dplyr)

dataset <- dataset %>%
    mutate(Subject = subjects$SubjectId, ActivityId = activity$ActivityId) %>%
    join(activityLabels, by = "ActivityId") %>% # (Step 3) Uses descriptive activity names to name the activities in the data set
    select(Subject, Activity, 1:79) %>%
    gather(Feature, Value, -(Subject:Activity)) # "long" form

# Step 5. Creates a second, independent tidy data set with the average of 
# each variable for each activity and each subject.
tidydata <- dataset %>%
    group_by(Subject, Activity, Feature) %>%
    summarise(Mean = mean(Value, na.rm = TRUE))

tidydata %>% write.table(file = "tidy dataset.txt", row.names = FALSE)

