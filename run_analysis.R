source("./src/har_dataset.R")

har.dataset <- har.dataset()

# download dataset
har.dataset$download()

# merge test and train datasets
ds <- har.dataset$mergeTestAndTrain()

# select mean and std variables
ds <- har.dataset$selectMeanAndStdMeasures()

# add descriptive activities names
ds <- har.dataset$addActivitiesLabels()

# rename variable names
ds <- har.dataset$renameVariablesNames()

# summarize dataset (calculate mean on each variable) by activity and subject
sds <- har.dataset$summarize()

# write summarized (tidy) dataset to filesystem (into the output folder)
har.dataset$saveSummarized()

