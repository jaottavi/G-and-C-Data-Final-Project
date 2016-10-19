# check to see if Getting & Cleaning Data direcotry created, 
# download file from internet, unzip it, then set it as the Working Directory
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if (!dir.exists("UCI HAR Dataset")) {download.file(url, "uci.zip", "curl")}
unzip("uci.zip")
setwd("./UCI HAR Dataset")


# get necessary packages
library(dplyr)
library(reshape2)


#download individual files according to their specific constraints
features <- read.table("features.txt", sep = " ", col.names = c("featureid", "feature"))
activitylabels <- read.table("activity_labels.txt", sep = " ", col.names = c("activityid", "activity"))
subjectTrain <- read.table("./train/subject_train.txt", col.names = "subjectid")
activityTrain <- read.table("./train/y_train.txt", col.names = "activityid")
subjectTest <- read.table("./test/subject_test.txt",col.names ="subjectid")
activityTest <- read.table("./test/y_test.txt", col.names = "activityid")
dataTrain <- read.table("./train/X_train.txt")
dataTest <- read.table("./test/X_test.txt")


# rename column names for dataTest and dataTrain
colnames(dataTrain) <- as.character(features$feature)
colnames(dataTest) <- as.character(features$feature)


# 1. rbind() analagous datasets into data frames
combinedData <- rbind(dataTrain, dataTest)
combinedActivity <- rbind(activityTrain, activityTest)
combinedSubject <- rbind(subjectTrain, subjectTest)


# 2. Acceptable colnames for data; the interpretation of "measurements on mean and standard deviation
# was taken to mean that only the explicit columns where mean() and std() occurred
# should be extracted from the dataset, not meanFreq() or gravityMean, etc.
names <- grep("mean\\(\\)|std\\(\\)",names(combinedData), value = TRUE)
combinedData2 <-combinedData[,names]


# 3., 4. merge() data from activitylabels and combinedActivity to get activity labels
# lined up with activity data
aggregateData <- cbind(combinedSubject,combinedActivity, combinedData2)
aggregateData2 <- merge(activitylabels, aggregateData, by="activityid")


# 5. Other tidy data that gives averages of each variable for each subject AND activity; the narrow form of tidy
# data was used
meltAggregateData <- melt(aggregateData2, id.vars = c("subjectid", "activityid", "activity"))
avgVariableSubject <- meltAggregateData %>% select(subjectid, activity, variable, value) %>% rename(measurement = variable) %>%
    group_by(subjectid, activity, measurement) %>% summarize(avgValue = mean(value))


write.table(aggregateData2, "aggregateTidyData.txt", row.names = FALSE)
write.table(avgVariableSubject, "averageTidyData.txt", row.names=FALSE)
