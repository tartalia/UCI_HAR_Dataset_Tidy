# UCI HAR Dataset Tidy

This project is part of the course Getting and Cleaning Data from Johns Hopkins University.

The purpose of this project is collect and clean the UCI HAR Dataset to prepare tidy data, so that it can can be used for later analysis.

This document provide information about the project structure and dependencies, how to collect and clean the raw dataset, and how to check the tidy dataset.

For more information about the raw and tidy dataset, see [Code Book](https://github.com/tartalia/UCI_HAR_Dataset_Tidy/blob/master/CodeBook.md).

# Project Structure

**./README.md**  
	This file.

**./CodeBook.md**  
	The dataset code book.

**./src/har_dataset.R**  
	The source that contain all the logic to collect and clean the raw dataset. In fact, this source can be thought as a library ou API to manipulate the UCI HAR dataset to get and clean the raw dataset, with the capabilities needed to produce the tidy dataset.

**./run_analysis.R**  
	The source to run the collect, clean the raw dataset, and produce the tidy dataset. Use ./src/har_dataset.R.

**./out/uci_har_dataset_tidy.txt**  
	The tidy dataset generated in the analysis (although this file is not necessary into the source control, we put it for academic reasons only)

# Project Dependencies

This project was built with and depends on:

* Ubuntu 14.04.2 LTS, codename trusty
* R version 3.2.0 (2015-04-16)
* Platform: x86_64-pc-linux-gnu (64-bit)
* dplyr version 0.4.1

Although we thought that the project can be run in others *nix platforms without problems, maybe there's some limitation to run on Windows platform due to file system differences.

# How to Collect, Clean and Generate Tidy Dataset

1. Clone this repository
2. Run ./run_analysis.R

You can check ./run_analysis.R to verify how to use ./src/har_dataset.R. 

# Check Tidy Dataset

You can read ./out/uci_har_dataset_tidy.txt

```
dataset <- read.table("./out/uci_har_dataset_tidy.txt", header = TRUE)
dim(dataset)
[1] 180  68
```

