library(dplyr)

# Script for getting and cleaning UCI Humam Activity Recognition dataset.
#
# This script can download and unzip HAR data, merge test and train data, select mean and standard deviation
# variables, add activity labels, rename variables names, and create a summarized dataset generation a tidy
# dataset.
# 
# More information about Human Activity Recognition dataset can get obteined in UCI site:
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
# 
# Author: Rafael Tartalia (rafael.tartalia@gmail.com)
#
har.dataset <- function() {

        datasetFileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        datasetPath <- "./data/UCI_HAR_Dataset"
        datasetFile <- "./data/UCI_HAR_Dataset.zip"
        outputPath <- "./out"
        summarizedDatasetFile <- "uci_har_dataset_tidy.txt" 

        mergedTestDataset <- NULL
        mergedTrainDataset <- NULL       
        mergedDataset <- NULL
        summarizedDataset <- NULL
        
        # control variables
        selectMeanAndStdVariables <- FALSE
        variablesRenamed <- FALSE

        # This function download and unzip HAR dataset. If the dataset already exists, the function do nothing. 
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
        
        # This function merge test dataset using merge function and cache the merged dataset.
        mergeTest <- function() {
                print("Merging test dataset..")
                mergedTestDataset <<- merge(dataset = "test")
                print("Done.")
                mergedTestDataset
        }
        
        # This function merge train dataset using merge function and cache the merged dataset.
        mergeTrain <- function() {
                print("Merging train dataset..")
                mergedTrainDataset <<- merge(dataset = "train")
                print("Done.")
                mergedTrainDataset
        }
        
        # This function is generic and can be used to merge test or train dataset.
        # The merge (train or test) process comprise in read all the variables computed from the dataset (in X files),
        # the subjects and activities related, and bind (by column) all toguether.
        merge <- function(dataset) {
                validDatasets <- c("test", "train")        
                if (is.null(dataset)) {
                        stop("dataset could not be null.")        
                }

                if (length(intersect(validDatasets, dataset)) == 0) {
                        stop("dataset must be \"test\" or \"train\".")
                }

                # load x and set variables names to features - these files are "big",
                # so read informing class names types
                partial <- read.table(paste(datasetPath, "/", dataset, "/X_", dataset, ".txt", sep = ""), nrows = 10)
                classes <- sapply(partial, class)
                x <- read.table(paste(datasetPath, "/", dataset, "/X_", dataset, ".txt", sep = ""), colClasses = classes)                
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

        # This function bind (by row) merge test and train dataset computed by merge. 
        # The function check if both test and train dataset was merged, and if not, 
        # call merge for both. The merged dataset is cached.
        mergeTestAndTrain <- function() {
                # Merge test and train datasets if not merged
                if (is.null(mergedTestDataset)) mergeTest()
                if (is.null(mergedTrainDataset)) mergeTrain()
        
                print("Merging test and train dataset..")
                mergedDataset <<- rbind(mergedTestDataset, mergedTrainDataset)
                
                # when compute mergedDataset, assert correct state
                selectMeanAndStdVariables <<- FALSE
                variablesRenamed <<- FALSE
                
                print("Done.")
                mergedDataset
        }
        
        # This function selects mean and standard deviation variables from the merged test and train dataset. 
        # If the merged dataset (test and train) isn't cached, the function throw an error and stop.
        selectMeanAndStdMeasures <- function() {
                if (is.null(mergedDataset)) {
                        stop("The datasets are not merged (tip: you need to call dataset$mergeTestAndTrain() before select mean and std)")
                }
                meanAndStdMeasures <- grep("Subject|ActivityId|ActivityName|Source|mean\\(|std\\(", names(mergedDataset))
                mergedDataset <<- mergedDataset[, meanAndStdMeasures]
                selectMeanAndStdVariables <<- TRUE
                mergedDataset
        }
        
        # This function add activity labels to the dataset. 
        # If the merged dataset (test and train) isn't cached, the function throw an error and stop.
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
        
        # This function rename all variables names, following best practices to produce and share data with staticians.
        # If mean and standard deviation was not selected, the function throw an error and stop. 
        renameVariablesNames <- function() {
                if (selectMeanAndStdVariables == FALSE) {
                        stop("The mean and standard deviation was not selected (tip: you need to call dataset$selectMeanAndStdMeasures() before rename variable names)")
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
                variablesRenamed <<- TRUE
                mergedDataset
        }
        
        # This function summarizes the dataset cached, calculating the mean for each variable grouped by Activity and Subject.  
        # If variable was not renamed, the function throw an error and stop. 
        summarize <- function() {
                if (variablesRenamed == FALSE) {
                        stop("The variables need to be renamed before summarize (tip: you need to call dataset$renameVariablesNames() before summarize data)")
                }
                summarizedDataset <<- tbl_df(mergedDataset)
                byActivityAndSubject <- summarizedDataset %>% group_by(ActivityName, Subject)                
                summarizedDataset <<- byActivityAndSubject %>% summarise_each(funs(mean), grep("Time|Frequency", names(summarizedDataset)))
                summarizedDataset
        }
        
        # Write summarized dataset to filesystem (into ./out directory).
        # If summarizedDataset was not computed/cached, the function throw an error and stop. 
        saveSummarized <- function() {
                if (is.null(summarizedDataset)) {
                        stop("The summarize dataset was not computed (tip: you need to call dataset$summarize() before flush summarized dataset to file system)")
                }
                if (!file.exists(outputPath)) {dir.create(outputPath)}
                write.table(summarizedDataset, file = paste(outputPath, "/", summarizedDatasetFile, sep = ""), row.names = FALSE)
        }

        # Exposed functions
        list(download = download, mergeTestAndTrain = mergeTestAndTrain, selectMeanAndStdMeasures = selectMeanAndStdMeasures,
             addActivitiesLabels = addActivitiesLabels, renameVariablesNames = renameVariablesNames, summarize = summarize,
             saveSummarized = saveSummarized)
}
