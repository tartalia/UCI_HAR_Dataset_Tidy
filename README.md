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

**./out/uci_har_dataset_tidy.txt**  
	The tidy dataset generated in the analysis (although this file is not necessary into the source control, we put it for academic reasons only)

# Project Dependencies

Thi project was built with and depends on:

* R version 3.2.0 (2015-04-16)
* Platform: x86_64-pc-linux-gnu (64-bit)
* dplyr version 0.4.1

Although we thought that the project can be run into other *nix platforms without problems, maybe there's some limitation to run on Windows platform due to file system differences.

This project was only executed on Linux Ubuntu platform.

# How to Clean and Prepare Tidy Dataset

1. Clone this repository
2. Run ./run_analysis.R to perform steps from 1 to 7

You can check ./run_analysis.R to verify how to use ./src/har_dataset.R. 

# Check Tidy Dataset

You can read ./out/uci_har_dataset_tidy.txt

```
dataset <- read.table("./out/uci_har_dataset_tidy.txt", header = TRUE)
dim(dataset)
[1] 180  68

```

# The Dataset Code Book

## Base Reference

The tidy dataset contain all the following features:

TimeBodyAccelerometer-XYZ
TimeGravityAccelerometer-XYZ
TimeBodyAccelerometerJerk-XYZ
TimeBodyGyroscope-XYZ
TimeBodyGyroscopeJerk-XYZ
TimeBodyAccelerometerMagnitude
TimeGravityAccelerometerMagnitude
TimeBodyAccelerometerJerkMagnitude
TimeBodyGyroMagnitude
TimeBodyGyroJerkMagnitude
FrequencyBodyAccelerometer-XYZ
FrequencyBodyAccelerometerJerk-XYZ
FrequencyBodyGyroscope-XYZ
FrequencyBodyAccMagnitude
FrequencyBodyAccJerkMagnitude
FrequencyBodyGyroscopeMagnitude
FrequencyBodyGyroscopeJerkMagnitude

With the following measures:

Mean
StandardDeviation

## All Dataset Features

| Name | Data Type | Description
| ActivityName | Character |  The descriptive activity name  |
| Subject | Integer |  The subject identifier (vary from 1 to 30)  |
| 
| TimeBodyAccelerometerMeanX | Numeric |  see base reference definition  |
| TimeBodyAccelerometerMeanY | Numeric |  see base reference definition  |
| TimeBodyAccelerometerMeanZ | Numeric |  see base reference definition  |
| TimeBodyAccelerometerStandardDeviationX | Numeric |  see base reference definition  |
| TimeBodyAccelerometerStandardDeviationY | Numeric |  see base reference definition  |
| TimeBodyAccelerometerStandardDeviationZ | Numeric |  see base reference definition  |
| TimeGravityAccelerometerMeanX | Numeric |  see base reference definition  |
| TimeGravityAccelerometerMeanY | Numeric |  see base reference definition  |
| TimeGravityAccelerometerMeanZ | Numeric |  see base reference definition  |
| TimeGravityAccelerometerStandardDeviationX | Numeric |  see base reference definition  |
| TimeGravityAccelerometerStandardDeviationY | Numeric |  see base reference definition  |
| TimeGravityAccelerometerStandardDeviationZ | Numeric |  see base reference definition  |
| TimeBodyAccelerometerJerkMeanX | Numeric |  see base reference definition  |
| TimeBodyAccelerometerJerkMeanY | Numeric |  see base reference definition  |
| TimeBodyAccelerometerJerkMeanZ | Numeric |  see base reference definition  |
| TimeBodyAccelerometerJerkStandardDeviationX | Numeric |  see base reference definition  |
| TimeBodyAccelerometerJerkStandardDeviationY | Numeric |  see base reference definition  |
| TimeBodyAccelerometerJerkStandardDeviationZ | Numeric |  see base reference definition  |
| TimeBodyGyroscopeMeanX | Numeric |  see base reference definition  |
| TimeBodyGyroscopeMeanY | Numeric |  see base reference definition  |
| TimeBodyGyroscopeMeanZ | Numeric |  see base reference definition  |
| TimeBodyGyroscopeStandardDeviationX | Numeric |  see base reference definition  |
| TimeBodyGyroscopeStandardDeviationY | Numeric |  see base reference definition  |
| TimeBodyGyroscopeStandardDeviationZ | Numeric |  see base reference definition  |
| TimeBodyGyroscopeJerkMeanX | Numeric |  see base reference definition  |
| TimeBodyGyroscopeJerkMeanY | Numeric |  see base reference definition  |
| TimeBodyGyroscopeJerkMeanZ | Numeric |  see base reference definition  |
| TimeBodyGyroscopeJerkStandardDeviationX | Numeric |  see base reference definition  |
| TimeBodyGyroscopeJerkStandardDeviationY | Numeric |  see base reference definition  |
| TimeBodyGyroscopeJerkStandardDeviationZ | Numeric |  see base reference definition  |
| TimeBodyAccelerometerMagnitudeMean | Numeric |  see base reference definition  |
| TimeBodyAccelerometerMagnitudeStandardDeviation | Numeric |  see base reference definition  |
| TimeGravityAccelerometerMagnitudeMean | Numeric |  see base reference definition  |
| TimeGravityAccelerometerMagnitudeStandardDeviation | Numeric |  see base reference definition  |
| TimeBodyAccelerometerJerkMagnitudeMean | Numeric |  see base reference definition  |
| TimeBodyAccelerometerJerkMagnitudeStandardDeviation | Numeric |  see base reference definition  |
| TimeBodyGyroscopeMagnitudeMean | Numeric |  see base reference definition  |
| TimeBodyGyroscopeMagnitudeStandardDeviation | Numeric |  see base reference definition  |
| TimeBodyGyroscopeJerkMagnitudeMean | Numeric |  see base reference definition  |
| TimeBodyGyroscopeJerkMagnitudeStandardDeviation | Numeric |  see base reference definition  |
| FrequencyBodyAccelerometerMeanX | Numeric |  see base reference definition  |
| FrequencyBodyAccelerometerMeanY | Numeric |  see base reference definition  |
| FrequencyBodyAccelerometerMeanZ | Numeric |  see base reference definition  |
| FrequencyBodyAccelerometerStandardDeviationX | Numeric |  see base reference definition  |
| FrequencyBodyAccelerometerStandardDeviationY | Numeric |  see base reference definition  |
| FrequencyBodyAccelerometerStandardDeviationZ | Numeric |  see base reference definition  |
| FrequencyBodyAccelerometerJerkMeanX | Numeric |  see base reference definition  |
| FrequencyBodyAccelerometerJerkMeanY | Numeric |  see base reference definition  |
| FrequencyBodyAccelerometerJerkMeanZ | Numeric |  see base reference definition  |
| FrequencyBodyAccelerometerJerkStandardDeviationX | Numeric |  see base reference definition  |
| FrequencyBodyAccelerometerJerkStandardDeviationY | Numeric |  see base reference definition  |
| FrequencyBodyAccelerometerJerkStandardDeviationZ | Numeric |  see base reference definition  |
| FrequencyBodyGyroscopeMeanX | Numeric |  see base reference definition  |
| FrequencyBodyGyroscopeMeanY | Numeric |  see base reference definition  |
| FrequencyBodyGyroscopeMeanZ | Numeric |  see base reference definition  |
| FrequencyBodyGyroscopeStandardDeviationX | Numeric |  see base reference definition  |
| FrequencyBodyGyroscopeStandardDeviationY | Numeric |  see base reference definition  |
| FrequencyBodyGyroscopeStandardDeviationZ | Numeric |  see base reference definition  |
| FrequencyBodyAccelerometerMagnitudeMean | Numeric |  see base reference definition  |
| FrequencyBodyAccelerometerMagnitudeStandardDeviation | Numeric |  see base reference definition  |
| FrequencyBodyBodyAccelerometerJerkMagnitudeMean | Numeric |  see base reference definition  |
| FrequencyBodyBodyAccelerometerJerkMagnitudeStandardDeviation | Numeric |  see base reference definition  |
| FrequencyBodyBodyGyroscopeMagnitudeMean | Numeric |  see base reference definition  |
| FrequencyBodyBodyGyroscopeMagnitudeStandardDeviation | Numeric |  see base reference definition  |
| FrequencyBodyBodyGyroscopeJerkMagnitudeMean | Numeric |  see base reference definition  |
| FrequencyBodyBodyGyroscopeJerkMagnitudeStandardDeviation | Numeric |  see base reference definition  |

