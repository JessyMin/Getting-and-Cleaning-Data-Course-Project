This is a code book that describes the variables, the data, and transformation/work performed to clean up the data.

<h2>Data source</h2>

The data sets are collected from the accelerometers from the Samsung Galaxy S smartphone. 

* data file(zip) : https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
* full description : http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

`run_analysis.R` uses the following files.

**Labels**
* 'features.txt': List of all features.
* 'activity_labels.txt': List of descriptive activity names.

**Training set**
* `train/X_train.txt`: Measurements data.
* `train/y_train.txt`: Activity labels.
* `train/subject_train.txt` : Subject labels.

**Test set**
* `test/X_test.txt`: Measurements data.
* `test/y_test.txt` : Activity labels.
* `test/subject_test.txt` : Subject labels.


<h2>Variables</h2>

* `trainSubjects`, `testSubjects`, `trainActivities`, `testActivities`, `trainMeasurements` and `testMeasurements` contain the data from the downloaded files.
* `subjects`, `activities` and `mergedData` merge the train and the test datasets.
* `features` contains the feature names for the `mergedData` dataset. 
Only the measurements on the mean and standard deviation are extracted using `featuresSelected`.
* `activityLabel` contains descriptive activity names and applied to the `activities` data set.
* `allData` merges `subjects`, `activities` and `mergedData`.
* Finally, `averageData` contains the average of each variable for each activity and each subject.


<h2>How `run_analysis.R` works</h2>

1. Load the training and the test data sets.
   Merge the training and the test sets respectively.
2. Load the features. 
   Extract the mean and standard deviation feature names and data.
3. Load the activity labels. Add activity labels to the data.
4. Merge subjects, activities and measurements data.  Stores the data in 'allData.txt` file.
5. Caculate average of each variable for each activity and each subject. Stores the table in `averageData.txt` file.
   
