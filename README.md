# G-and-C-Data-Final-Project
Final course project for Coursera's "Getting and Cleaning Data" 

# Overview
This repository is used to demonstrate a working knowledge of reading in, cleaning, and tidying real-world data for Coursera's "Getting and Cleaning Data" course. This repository contains three different files:

# run_analysis.R
This function extracts data from the UCI Machine Learning Respository's "Human Activity Recognition Using Smartphone Dataset".
  link - http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
This function does the following:
1. Loads the data into your working directory
2. Extracts only the mean and standard deviation measurements for each measurement variable
  a. Note - mean and standard deviation variables are taken to mean ONLY variables that have mean() or std(), not including any variables   that have gravitymean, meanFreq, etc. as these were interpreted as being different from an explicit mean of a measurement variable 
3. Merges the test and training sets (not Intertial Signals directory), the subject set, and the activity datasets into one dataset
4. Appropriately labels all variable names in dataset
5. Creates two datasets for use: 'aggregateTidyData.txt', which houses all measurements, subjectids, and activities for analysis use in a wide tidy data format; and 'averageTidyData.txt', which houses averages for all variables grouped by subjectids and activities in a narrow tidy data format.

# CodeBook.md
This file describes the variables, data and transformations that were made to clean up the original data set from UCI.

# aggregateTidyData.txt
This file shows the data for the averageTidyData.txt file. 
