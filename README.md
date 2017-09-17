##Getting and Cleaning Data - Course Project

###This is the course project for the Getting and Cleaning Data Coursera course. The R script, run_analysis.R, does the following:

1) Creates directory with data files
2) Download the data if it does not already exist in the working directory and unzip it
3) Load activity labels and features and make them characters 
4) Extract only "mean" and "std" features and make them tidy
5) Download data for train and test into datatables
6) Merge data sets
7) Convert activities and features into factors
7) Calculate the average of each variable for each activity and each subject and makes the dataset tidy
 
Resut of script is stored in tidy.txt.