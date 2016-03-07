# Coursera-Getting-and-Cleaning-Data

## Overview
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.

## Data
One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## R script run_analysis.R abstract
### Data Preparation: 
* Download the data file and save it to the "Week4" (local) working directory: download.file()
* Unzip the downloaded data file: unzip()
* Get the list of the file: path(), files()
* Read data from the files into variables: read.table()

### Task 1 Merges the training and the test sets to create one data set
* Concatenate the data tables by rows: rbind()
* Set names to variables: names()
* Merge columns to get the data frame data for all data: cbind()

### Task 2 Extracts only the measurements on the mean and standard deviation for each measurement
* Subset Name of Features by measurements on the mean and standard deviation
* Subset the data frame Data by seleted names of Features
* Check the structures of the data frame Data

### Task 3 Uses descriptive activity names to name the activities in the data set

### Task 4 Appropriately labels the data set with descriptive variable names: 
gsub()

### Task 5 Creates a second,independent tidy data set and ouput it: 
aggregate(), write.table()



