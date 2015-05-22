library(dplyr)

# Humam Activity Recognition dataset library
# Download and unzip dataset if the dataset do not exist.
# Author: Rafael Tartalia (rafael.tartalia@gmail.com)
har.dataset <- function() {

        datasetFileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        datasetPath <- "./data/UCI_HAR_Dataset"
        datasetFile <- "./data/UCI_HAR_Dataset.zip"

        mergedTestDataset <- NULL
        mergedTrainDataset <- NULL       
        mergedDataset <- NULL
        summarisedDataset <- NULL

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
                mergedTestDataset <<- merge(dataset = "test")
                print("Done.")
                mergedTestDataset
        }
        
        mergeTrain <- function() {
                print("Merging train dataset..")
                mergedTrainDataset <<- merge(dataset = "train")
                print("Done.")
                mergedTrainDataset
        }
        
        merge <- function(dataset) {
                validDatasets <- c("test", "train")        
                if (is.null(dataset)) {
                        stop("dataset could not be null.")        
                }

                if (length(intersect(validDatasets, dataset)) == 0) {
                        stop("dataset must be \"test\" or \"train\".")
                }

                # load x and set variables names to features
                x <- read.table(paste(datasetPath, "/", dataset, "/X_", dataset, ".txt", sep = ""))                
                features <- read.table(paste(datasetPath, "/features.txt", sep = ""))
                names(x) <- features$V2
                
                # load activities, rename activity variable on y and create factor variable
                activities <- read.table(paste(datasetPath, "/", dataset, "/y_", dataset, ".txt", sep = ""))
                names(activities)[1] <- "ActivityId"
                
                # load and rename subjects
                subject <- read.table(paste(datasetPath, "/", dataset, "/subject_", dataset, ".txt", sep = ""))
                names(subject)[1] <- "Subject"
                
                # bind variables
                cbind(subject, activities, Source = dataset, x)
        }

        mergeTestAndTrain <- function() {
                # Merge test and train datasets if not merged
                if (is.null(mergedTestDataset)) mergeTest()
                if (is.null(mergedTrainDataset)) mergeTrain()
        
                print("Merging test and train dataset..")
                mergedDataset <<- rbind(mergedTestDataset, mergedTrainDataset)
                print("Done.")
                mergedDataset
        }
        
        selectMeanAndStdMeasures <- function() {
                if (is.null(mergedDataset)) {
                        stop("The datasets are not merged (tip: you need to call dataset$mergeTestAndTrain() before select mean and std)")
                }
                meanAndStdMeasures <- grep("Subject|ActivityId|ActivityName|Source|mean\\(|std\\(", names(mergedDataset))
                mergedDataset <<- mergedDataset[, meanAndStdMeasures]
                mergedDataset
        }
        
        addActivitiesLabels <- function() {
                if (is.null(mergedDataset)) {
                        stop("The datasets are not merged (tip: you need to call dataset$mergeTestAndTrain() before add activities label)")
                }
                activitiesLabels <- read.table(paste(datasetPath, "/activity_labels.txt", sep = ""))
                ActivityName <- factor(mergedDataset$ActivityId, labels = activitiesLabels$V2)
                # add activities labels
                mergedDataset <<- cbind(mergedDataset, ActivityName)
                mergedDataset
        }
        
        renameVariablesNames <- function() {
                if (is.null(mergedDataset)) {
                        stop("The datasets are not merged (tip: you need to call dataset$mergeTestAndTrain() before rename variable names)")
                }
                variableNames <- names(mergedDataset)
                variableNames <- gsub("tBody", "TimeBody", variableNames)
                variableNames <- gsub("fBody", "FrequencyBody", variableNames)
                variableNames <- gsub("tGravity", "TimeGravity", variableNames)
                variableNames <- gsub("Acc", "Accelerometer", variableNames)
                variableNames <- gsub("Gyro", "Gyroscope", variableNames)
                variableNames <- gsub("Mag", "Magnitude", variableNames)
                variableNames <- gsub("-mean[(][)]", "Mean", variableNames)
                variableNames <- gsub("-std[(][)]", "StandardDeviation", variableNames)
                variableNames <- gsub("-Y", "Y", variableNames)
                variableNames <- gsub("-X", "X", variableNames)
                variableNames <- gsub("-Z", "Z", variableNames)
                names(mergedDataset) <<- variableNames
                mergedDataset
        }
        
        summarise <- function() {
                tblMergedDataset <<- tbl_df(mergedDataset)
                byActivityAndSubject <- tblMergedDataset %>% group_by(ActivityName, Subject)                
                summarisedDataset <<- byActivityAndSubject %>% summarise_each(funs(mean), grep("Time|Frequency", names(tblMergedDataset)))
                summarisedDataset
        }

        list(download = download, mergeTestAndTrain = mergeTestAndTrain, selectMeanAndStdMeasures = selectMeanAndStdMeasures,
             addActivitiesLabels = addActivitiesLabels, renameVariablesNames = renameVariablesNames, summarise = summarise)
}
