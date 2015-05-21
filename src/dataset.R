library(utils)

# Download and unzip dataset if the dataset do not exist.
# Author: Rafael Tartalia (rafael.tartalia@gmail.com)
dataset <- function() {

        datasetFileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        datasetPath <- "./data/UCI_HAR_Dataset"
        datasetFile <- "./data/UCI_HAR_Dataset.zip"

        mergedTestDataset <- NULL
        mergedTrainDataset <- NULL       
        mergedDataset <- NULL

        getDatasetPath <- function() datasetPath
        getMergedTestDataset <- function() mergedTestDataset
        getMergedTrainDataset <- function() mergedTrainDataset

        download <- function() {
                if (!file.exists("./data")) {dir.create("./data")}
                
                if (!file.exists(datasetPath)) {
                        # if the zip file already exists, do not download
                        if (!file.exists(datasetFile)) {
                                print(paste("Downloading file ", datasetFileUrl, "..", sep = ""))
                                download.file(datasetFileUrl, destfile = datasetFile, method = "curl")
                                print(paste("Done."))
                        }
                        print(paste("Unziping ", datasetFile, "..", sep = ""))
                        unzip(datasetFile, exdir = "./data")
                        file.rename("./data/UCI HAR Dataset", datasetPath)
                        print("Done.")
                } else {
                        print("Dataset already downloaded and unziped.")
                }
        }
        
        mergeTest <- function() {
                print("Merging test dataset..")
                xTest <- read.table(paste(datasetPath, "/test/X_test.txt", sep = ""))
                yTest <- read.table(paste(datasetPath, "/test/y_test.txt", sep = ""))
                names(yTest)[1] <- "activityId"
                subjectTest <- read.table(paste(datasetPath, "/test/subject_test.txt", sep = ""))
                names(subjectTest)[1] <- "subject"
                features <- read.table(paste(datasetPath, "/features.txt", sep = ""))
                
                # If the train dataset is already merged, take the index form mergedTrainDataset
                # In that way, if the train has 2947 obs, the index will be from 2947 + 1 to (2947 + xTest obs)
                if (!is.null(mergedTrainDataset)) {
                        index <- seq(dim((mergedTrainDataset)[1] + 1), (dim(mergedTrainDataset)[1] + dim(xTest)[1]))
                } else {
                        # make index from 1 to obs number in xTest
                        index <- seq(1:dim(xTest)[1])
                }
                                
                names(xTest) <- features$V2
                mergedTestDataset <<- cbind(index, subjectTest, yTest, source = "test", xTest)
                print("Done.")
                mergedTestDataset
        }
        
        mergeTrain <- function() {
                print("Merging train dataset..")
                xTrain <- read.table(paste(datasetPath, "/train/X_train.txt", sep = ""))
                yTrain <- read.table(paste(datasetPath, "/train/y_train.txt", sep = ""))
                names(yTrain)[1] <- "activityId"
                subjectTrain <- read.table(paste(datasetPath, "/train/subject_train.txt", sep = ""))
                names(subjectTrain)[1] <- "subject"
                features <- read.table(paste(datasetPath, "/features.txt", sep = ""))
                
                # If the test dataset is already merged, take the index form mergedTestDataset
                # In that way, if the test has 2947 obs, the index will be from 2947 + 1 to (2947 + xTrain obs)
                if (!is.null(mergedTestDataset)) {
                        index <- seq((dim(mergedTestDataset)[1] + 1), (dim(mergedTestDataset)[1] + dim(xTrain)[1]))
                } else {
                        # make index from 1 to obs number in xTrain
                        index <- seq(1:dim(xTrain)[1])
                }
                names(xTrain) <- features$V2
                mergedTrainDataset <<- cbind(index, subjectTrain, yTrain, source = "train", xTrain)
                print("Done.")
                mergedTrainDataset
        }
        
        mergeTestAndTrain <- function() {
                # Merge test and train datasets if not merged
                if (is.null(mergedTestDataset)) mergeTest()
                if (is.null(mergedTrainDataset)) mergeTrain()
        
                print("Merging test and train dataset..")
                mergedDataset <- rbind(mergedTestDataset, mergedTrainDataset)     
                print("Done.")
                mergedDataset
        }

        list(download = download, getDatasetPath = getDatasetPath, getMergedTestDataset = getMergedTestDataset, 
             mergeTest = mergeTest, getMergedTrainDataset = getMergedTrainDataset, mergeTrain = mergeTrain,
             mergeTestAndTrain = mergeTestAndTrain)
}
