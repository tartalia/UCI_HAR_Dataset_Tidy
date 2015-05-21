source("./src/har_dataset.R")

harDs <- har.dataset()

# download dataset
harDs$download()

# merge test and train datasets
mergedDs <- harDs$mergeTestAndTrain()

# select mean and std variables
meanAndStdDs <- harDs$selectMeanAndStdMeasures()

