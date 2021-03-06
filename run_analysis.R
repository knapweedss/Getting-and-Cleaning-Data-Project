library(reshape2)

file <- "getdata_dataset.zip"


if (!file.exists(file)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
  download.file(fileURL, file, method="curl")
}  
if (!file.exists("UCI HAR Dataset")) { 
  unzip(file) 
}


labels <- read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt")

labels[,2] <- as.character(labels[,2])
features[,2] <- as.character(features[,2])


meanAndStdCols <- grep("-(mean|std).*", as.character(features[,2]))
meanAndStdColNames <- features[meanAndStdCols, 2]
meanAndStdColNames <- gsub("-mean", "Mean", meanAndStdColNames)
meanAndStdColNames <- gsub("-std", "Std", meanAndStdColNames)
meanAndStdColNames <- gsub("[-()]", "", meanAndStdColNames)



trainX <- read.table("UCI HAR Dataset/train/X_train.txt")[meanAndStdCols]
trainY <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainS <- read.table("UCI HAR Dataset/train/subject_train.txt")

testX <- read.table("UCI HAR Dataset/test/X_test.txt")[meanAndStdCols]
testY <- read.table("UCI HAR Dataset/test/Y_test.txt")
testS <- read.table("UCI HAR Dataset/test/subject_test.txt")

trainX <- cbind(trainS, trainY, trainX)
testX <- cbind(testS, testY, testX)


finalData <- rbind(trainX, testX)
colnames(finalData) <- c("subject", "activity", meanAndStdColNames)

finalData$activity <- factor(finalData$activity, levels = labels[,1], labels = labels[,2])
finalData$subject <- as.factor(finalData$subject)

finalData.melted <- melt(finalData, id = c("subject", "activity"))
finalData.mean <- dcast(finalData.melted, subject + activity ~ variable, mean)

write.table(finalData.mean, "tidy_data.txt", row.names = FALSE, quote = FALSE)
