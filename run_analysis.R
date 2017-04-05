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

trainData <- read.table("train/X_train.txt")
testData <- read.table("test/X_test.txt")
mergedData <- rbind(trainSet, testSet)


# 2.Load features and extract only the mean and standard deviation
features <- read.table("features.txt")

featuresSelected <- grep("mean\\(|std\\(", features[,2])
mergedData <- mergedData[, featuresSelected]
names(mergedData) <- features[featuresSelected, 2]

# 3. add descriptive activity names and labels
activityLabel <- read.table("activity_labels.txt")
activities[,1] <- activityLabel[activities[,1],2]
names(activities) <- "activity"
names(subjects) <- "subject"

# 4. merge test/train datasets
allData <- cbind(subjects, activities, mergedData)
write.table(allData, "allData.txt")

# 5.creates a second, independent tidy data set 
#   with the average of each variable for each activity and each subject.
averageData <- ddply(allData, .(subject, activity), function(x) colMeans(x[,3:68]))
write.table(averageData, "averageData.txt")
