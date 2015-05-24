# Script for getting and cleaning UCI Humam Activity Recognition dataset.
# 
# This script uses ./src/har_dataset.R to transform HAR raw dataset into tidy dataset.
#
# Author: Rafael Tartalia (rafael.tartalia@gmail.com)

source("./src/har_dataset.R")

har.dataset <- har.dataset()

# download dataset
har.dataset$download()

# Step 1 from project instruction
# merge test and train datasets
ds <- har.dataset$mergeTestAndTrain()

# Step 2 from project instruction
# select mean and std variables
ds <- har.dataset$selectMeanAndStdMeasures()

# Step 3 from project instruction
# add descriptive activities names
ds <- har.dataset$addActivitiesLabels()

# Step 4 from project instruction
# rename variable names
ds <- har.dataset$renameVariablesNames()

# Step 5 from project instruction
# summarize dataset (calculate mean on each variable) by activity and subject
# and write on file system
sds <- har.dataset$summarize()
har.dataset$saveSummarized()
