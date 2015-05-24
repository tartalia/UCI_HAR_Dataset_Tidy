# UCI HAR Dataset Tidy

This project is part of the course Getting and Cleaning Data from Johns Hopkins University.

The purpose of this project is collect and clean the UCI HAR Dataset to prepare tidy data, so that it can can be used for later analysis.

The UCI HAR Dataset stands for Human Activity Recognition Using Smartphones, and was collect from 30 volunteers that performed 6 activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, and LAYING), and was partitioned into two datasets, test and train, respectively 30% and 70% of the data.

The dataset is hosted by UCI Machine Learning Repository, and more information about the dataset can be obtained in http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

# How the Clean and Prepare Process Works

1. The dataset is downloaded and unziped in the project directory (the dataset itself isn't on source control)
2. For each dataset, train and test, features (HAR measures), features names, subject, and activities identifiers are merged, and after that, the two datasets are merged together
3. The mean and standard deviation features are selected from the merged dataset (plus subject and activities identifiers)
4. The activities names are added to the dataset 
5. The features (mean and standard deviation) are renamed (in accordance with the guidelines described in https://github.com/jtleek/datasharing)
6. The dataset is summarized by calculating the mean for all features, grouped by activity name and subject
7. The resulted dataset is saved on output directory

These steps are derived to the following requirements from Getting and Cleaning Data course:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Project Structure

**./README.md**  
	This file

**./src/har_dataset.R**  
	The source that contain all the logic to collect and clean the raw dataset. In fact, this source can be thought as a library ou API to manipulate the UCI HAR dataset to get and clean the raw dataset, with the capabilities needed to produce the tidy dataset.

**./run_analysis.R**  
	The source to run the collect, clean the raw dataset, and produce the tidy dataset. Use ./src/har_dataset.R

**./out/har_dataset.txt**  
	The tidy dataset generated in the analysis (although this file is not necessary into the source control, we put it for academic reasons only)

# Project Dependencies

Thi project was built with and depends on:

* R version 3.2.0 (2015-04-16)
* Platform: x86_64-pc-linux-gnu (64-bit)
* dplyr version 0.4.1

Although we thought that the project can be run into other *nix platforms without problems, maybe there's some limitation to run on Windows platform due to file system differences.

This project was only executed on Linux Ubuntu platform.

# How to Clean and Prepare Tidy Data

1. Clone this repository
2. Run ./run_analysis.R to perform steps from 1 to 7
3. Check ./out/har_dataset.txt for tidy dataset

You can check ./run_analysis.R to verify how to use ./src/har_dataset.R. 

# Dataset Code Book
