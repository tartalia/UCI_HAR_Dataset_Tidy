library(utils)

# Download and unzip dataset if the dataset do not exist.
# Author: Rafael Tartalia (rafael.tartalia@gmail.com)
download_data <- function() {
        
        datasetFileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        datasetPath <- "./data/UCI_HAR_Dataset"
        datasetFile <- "./data/UCI_HAR_Dataset.zip"
        
        if (!file.exists("./data")) {dir.create("./data")}
        
        if (!file.exists(datasetPath)) {
                # if the zip file already exists, do not download
                if (!file.exists(datasetFile)) {
                        print(paste("Downloading file ", datasetFileUrl))
                        download.file(datasetFileUrl, destfile = datasetFile, method = "curl")
                }
                print(paste("Unziping ", datasetFile))
                unzip(datasetFile, exdir = "./data")
                file.rename("./data/UCI HAR Dataset", datasetPath)
                print("Done")
        } else {
                print("Dataset already exists")
        }
}
