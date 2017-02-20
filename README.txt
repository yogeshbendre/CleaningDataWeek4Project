==================================================================
Modified Human Activity Recognition Using Smartphones Dataset
Version 1.0
==================================================================
Yogesh B
Student - Coursera Data Science Specialization
==================================================================

This data is obtained from the original data of Smartlab - Non Linear Complex Systems Laboratory, DITEN - Università degli Studi di Genova.

The original experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

This data is obtained by processing the original data to make it a tidy dataset.

The original data has for each record:
======================================
- An identifier of the subject who carried out the experiment.
- Its activity label. 
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 


The modified dataset includes the following files:
=========================================

- 'README.txt'

- 'dataset.txt': the dataset file

- 'Codebook.pdf': the complete details of the features of modified dataset

- 'features_names.txt': Descriptive names of the variables

How to read data in R:
=======================================
To read this file in R use bellow:
>mydata=read.table("dataset.txt",header = TRUE)


Notes: 
======
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.


Process of cleaning the original dataset to obtain the modified dataset:
============================================================================
The original dataset is cleaned and processed using script "run_analysis.R"
The script should be placed inside original dataset folder.
The script performs following operations in sequence.

1) Read the training data (x_train.txt), prepend it with subject id read from subject_train.txt file and append a column of activity numbers from labels file (y_train.txt)
Apply similar procedure on test data files. Finally, append the testing data to training data to form one combined data frame x.

2) Read features.txt file to get the names of the features. Filter the feature names that contain either "mean" or "std" which represent the features corresponding to the mean or standard deviation.
Use this to filter out features from the above data frame x.

3) Read activity_labels.txt file to get names of activities corresponding to each activity number. Create factor using this mapping. Change the activity column in the data frame x by using this to corresponding activity labels.

4) Rename the feature names to make them more descriptive. Here, we clean the orignial variable names to make them more descriptive. The feature names have following components:

Time Domain: The signal is in time domain
Freq. Domain: The signal is in frequency domain
Gyroscope: The reading from gyroscope
Accelerometer: The reading from accelerometer
X, Y or Z: X or Y or Z component of the signal
Euclidean Norm: Magnitude of Euclidean Norm of the signal

Example feature name:   Freq. Domain Body Gyroscope mean X

5) Finally, find out mean value of each variable for each subject and each activity using aggregate function. Store this dataset in a file "dataset.txt"
To read this file in R use bellow:
>mydata=read.table("dataset.txt",header = TRUE)