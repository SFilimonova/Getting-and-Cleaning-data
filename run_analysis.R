#Directory creation with data sets
if (!file.exists("./data")) {
      dir.create("./data")
}
#Download and unzip the data
file_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(file_url, destfile = "./data/hum_act_data.zip", mode = "wb")
setwd("C:/Users/SFilimonova/Desktop/CourseraR/data")

if (!file.exists("UCI HAR Dataset")) { 
      unzip("hum_act_data.zip") 
}
setwd("C:/Users/SFilimonova/Desktop/CourseraR/data/UCI HAR Dataset")

#Load activity labels and features
activities <- read.table("activity_labels.txt")
features <- read.table("features.txt")
activities[,2] <- as.character(activities[,2])
features[,2] <- as.character(features[,2])      
)

#Extract only "mean" and "std" features and make them tidy
features_short <- grep ( ".*mean.*|.*std.*"  , features[ ,2])
features_short_names <- features[features_short,2]
features_short_names <- gsub("mean", "Mean", features_short_names)

#Extract data into datatables

train <- read.table("train/X_train.txt")[features_short]
train_Act <- read.table("train/Y_train.txt")
train_Sub <- read.table("train/subject_train.txt")
train <- cbind(train_Sub, train_Act, train)

test <- read.table("test/X_test.txt")[features_short]
test_Act <- read.table("test/Y_test.txt")
test_Sub <- read.table("test/subject_test.txt")
test <- cbind(test_Sub, test_Act, test)

#merge data and name the columns
alldata <- rbind(train, test)
colnames(alldata) <- c("subject", "activity", features_short_names)

library(reshape2)

#Calculation of average of each variable for each activity and each subject
alldata$activity <- factor(alldata$activity, levels = activities[,1], labels = activities[,2])
alldata$subject <- as.factor(alldata$subject)
alldata_melted <- melt(alldata, id = c("subject", "activity"))
alldata_mean <- dcast(alldata_melted, subject + activity ~ variable, mean)

write.table(alldata_mean, "tidy.txt", row.names = FALSE, quote = FALSE)
