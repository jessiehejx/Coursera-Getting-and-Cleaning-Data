#-------------------------------- Data Preparation --------------------------------#
getwd()
setwd("/Users/Jessie/Dropbox/Github/CleaningData")

## Download the data file and save it to the "Week4" working directory
if(!file.exists("./Week4")){dir.create("./Week4")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile="./Week4/dataset.zip", method="curl")

## Unzip the downloaded data file
unzip(zipfile="./Week4/dataset.zip", exdir="./Week4")

## Get the list of the file
path <- file.path("./Week4", "UCI HAR Dataset")
files <- list.files(path, recursive=TRUE); files

## Read data from the files into variables
activityTest <- read.table(file.path(path, "test", "Y_test.txt"), header=FALSE)
activityTrain <- read.table(file.path(path, "train", "Y_train.txt"), header = FALSE)

subjectTrain <- read.table(file.path(path, "train", "subject_train.txt"), header = FALSE)
subjectTest  <- read.table(file.path(path, "test" , "subject_test.txt"), header = FALSE)

featuresTest  <- read.table(file.path(path, "test" , "X_test.txt" ), header = FALSE)
featuresTrain <- read.table(file.path(path, "train", "X_train.txt"), header = FALSE)


#-------------------------------- Task 1 --------------------------------#
## Merges the training and the test sets to create one data set
# Concatenate the data tables by rows
dataSubject <- rbind(subjectTrain, subjectTest)
dataActivity<- rbind(activityTrain, activityTest)
dataFeatures<- rbind(featuresTrain, featuresTest)

# Set names to variables
names(dataSubject) <- c("subject")
names(dataActivity) <- c("activity")
dataFeaturesNames <- read.table(file.path(path, "features.txt"), head=FALSE)
names(dataFeatures) <- dataFeaturesNames$V2

# Merge columns to get the data frame data for all data
dataCombine <- cbind(dataSubject, dataActivity)
Data <- cbind(dataFeatures, dataCombine)


#-------------------------------- Task 2 --------------------------------#
## Extracts only the measurements on the mean and standard deviation for each measurement
# Subset Name of Features by measurements on the mean and standard deviation
subdataFeaturesNames <- dataFeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", dataFeaturesNames$V2)]

# Subset the data frame Data by seleted names of Features
selectedNames <- c(as.character(subdataFeaturesNames), "subject", "activity" )
Data <- subset(Data, select=selectedNames)

# Check the structures of the data frame Data
str(Data)

#-------------------------------- Task 3 --------------------------------#
## Uses descriptive activity names to name the activities in the data set
Data$activity[Data$activity == 1] <- "Walking"
Data$activity[Data$activity == 2] <- "Walking Upstairs"
Data$activity[Data$activity == 3] <- "Walking Downstairs"
Data$activity[Data$activity == 4] <- "Sitting"
Data$activity[Data$activity == 5] <- "Standing"
Data$activity[Data$activity == 6] <- "Laying"

# Check
head(Data$activity, 30)


#-------------------------------- Task 4 --------------------------------#
## Appropriately labels the data set with descriptive variable names
names(Data)<-gsub("^t", "time", names(Data))
names(Data)<-gsub("^f", "frequency", names(Data))
names(Data)<-gsub("Acc", "Accelerometer", names(Data))
names(Data)<-gsub("Gyro", "Gyroscope", names(Data))
names(Data)<-gsub("Mag", "Magnitude", names(Data))
names(Data)<-gsub("BodyBody", "Body", names(Data))

# Check
names(Data)

#-------------------------------- Task 5 --------------------------------#
## Creates a second,independent tidy data set and ouput it
library(plyr)
Data2<-aggregate(. ~subject + activity, Data, mean)
Data2<-Data2[order(Data2$subject,Data2$activity), ]
write.table(Data2, file = "tidydata.txt", sep="\t", row.name=FALSE)

# For codebook
write(names(Data), file = "variables.txt", ncolumns = 1)
