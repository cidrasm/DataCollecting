# CodeBook for run_analysis.R

## Variables
* activities - loaded from "activity_labels.txt" file provided provides the factor labels for activities
* varnames - loaded from "features.txt" file provided provides the variable names for the data in the test and train sets
* test - merged testing data set
* train - merged training data set
* fullData - test and train merged and grouped by subject and activity
* t - fullData run through ddply with sapply doing a mean on fullData minus the subject and activity columns

## Functions
* buildDF - takes one parameter, the subfolder with the test or train data with following variables. Returns a data frame with measurements, subjects and activities
  + dsMeas - Data frame loaded from the measurements data
  + dsAct - activity values for each row in dsMeas as read from the "y_XXXX.txt" file where XXXX = test or train
  + subs - subject values for each row in dsMeas as read from the "subject_XXXX.txt" file where XXXX = test or train

## Output
If all goes well, you will get a text file named dataset.txt in the working folder
The contents of which is the mean value for each measured mean and standard deviation.

