#
# Download and Unzip the dataset
#
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "get2.zip", method = "wget")
unzip("get2.zip")

#
# Read train and test sets and makes them readable
#
train <- read.table("UCI HAR Dataset//train//X_train.txt")
colnames(train) <- read.table("UCI HAR Dataset//features.txt")[, 2]
train$subjid <- as.matrix(read.table("UCI HAR Dataset/train/subject_train.txt"))
train$activityid <- as.matrix(read.table("UCI HAR Dataset/train/y_train.txt"))
train$activityid[train$activityid == 1] <- "walking"
train$activityid[train$activityid == 2] <- "upstairs"
train$activityid[train$activityid == 3] <- "downstairs"
train$activityid[train$activityid == 4] <- "sitting"
train$activityid[train$activityid == 5] <- "standing"
train$activityid[train$activityid == 6] <- "laying"

test <- read.table("UCI HAR Dataset//test//X_test.txt")
colnames(test) <- read.table("UCI HAR Dataset//features.txt")[, 2]
test$subjid <- as.matrix(read.table("UCI HAR Dataset/test/subject_test.txt"))
test$activityid <- as.matrix(read.table("UCI HAR Dataset/test/y_test.txt"))
test$activityid[test$activityid == 1] <- "walking"
test$activityid[test$activityid == 2] <- "upstairs"
test$activityid[test$activityid == 3] <- "downstairs"
test$activityid[test$activityid == 4] <- "sitting"
test$activityid[test$activityid == 5] <- "standing"
test$activityid[test$activityid == 6] <- "laying"

#
# Merges data frames 
#
merged <- rbind(test, train)

#
# Selects column relative to means or standard deviations
#
std_cols <- grep(pattern = "std", x = colnames(merged))
mean_cols <- grep(pattern = "mean", x = colnames(merged))
merged <- merged[, c(562, 563, std_cols, mean_cols)]

#
# Aggregates data in a new tidy dataset
# wich is then written in a txt file
#
tidy <- aggregate(merged[, 3:81], by = list(subject=merged[,1], activity=merged[,2]), mean)
tidy <- tidy[order(tidy$subject, tidy$activity), ]
write.table(tidy, "tidy_data.txt")