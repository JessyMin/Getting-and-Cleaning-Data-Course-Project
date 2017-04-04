library(plyr)
filename <- "dataset.zip"

# Download and unzip the dataset:
if (!file.exists(filename)){
        fileUrl <- ""
        download.file(fileUrl, filename, method="curl")
}
if (!file.exists("UCI HAR Dataset")){
        unzip(filename)
}
setwd("./UCI HAR Dataset")


# 1.Merge the training and the test sets

trainSubjects <- read.table("train/subject_train.txt")
testSubjects <- read.table("test/subject_test.txt")
subjects <- rbind(trainSubjects, testSubjects)

trainActivities <- read.table("train/y_train.txt")
testActivites <- read.table("test/y_test.txt")
activities <- rbind(trainActivities, testActivites)

trainSet <- read.table("train/X_train.txt")
testSet <- read.table("test/X_test.txt")
mergedSet <- rbind(trainSet, testSet)


# 2.Load features and extract only the mean and standard deviation
features <- read.table("features.txt")

featuresSelected <- grep("mean\\(|std\\(", features[,2])
mergedSet <- mergedSet[, featuresSelected]
names(mergedSet) <- features[featuresSelected, 2]

# 3. add descriptive activity names
activityLabel <- read.table("activity_labels.txt")
activities[,1] <- activityLabel[activities[,1],2]
names(activities) <- "activity"

# 4. merge test/train datasets and add labels
names(subjects) <- "subject"
allData <- cbind(subjects, activities, mergedSet)
write.table(allData, "allData.txt")

# 5.creates a second, independent tidy data set 
#   with the average of each variable for each activity and each subject.
averageData <- ddply(allData, .(subject, activity), function(x) colMeans(x[,3:68]))
write.table(averageData, "averageData.txt")
