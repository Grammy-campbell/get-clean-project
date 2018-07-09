READ ME file for end of course project in Getting and Cleaning Data
L. K. Campbell

=====================================================================================
Source of the data:
The end of course project involved working with datasets collected by researchers
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, and Luca Oneto
when they were studying Human Activity Recognition Using Smartphones at
Università degli Studi di Genova.

They provided data from 30 subjects broken into two datasets, a training set (70%) and a 
testing set (30%).  Each subject performed six different activities: Walking, 
Walking Upstairs, Walking Downstairs, Sitting, Standing, and Laying (Lying).

They collected total acceleration data using an accelerometer which they then processed
into body acceleration and acceleration due to gravity.  They also collected data on
angular velocity using a gyroscope.  The raw data was collected by making measurements
in the three axial directions, labeled X, Y and Z. Extensive data was collected for each
observation, but the focus of this work was on the mean values with associated standard
deviations that were recorded. The original dimension for the readings was time.

The data was then processed by computing a Jerk (i.e. the rate of change) value and a
magnitude for the motion which was computed as the Euclidean norm of the three dimensional
readings. Finally, a Fast Fourier Transfer was done on most of the readings to provide
information in the frequency domain.

More details of this work can be found in the README file that is included with this
project.
=====================================================================================

Goal of the end of course project:
The class assignment requested that the final product be an R script called run_analysis.R 
that does the following.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set.
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average 
   of each variable for each activity and each subject.

========================================================================================

Description of the R script:
These goals were all completed. The attached R script accomplishes them as follows:

The training data set was built by reading in text files containing the list of subjects,
the activities being performed, and the measurements corresponding to each observation.
Variables names were assigned at the time each data file was read, and in the case of the
activities, the numerical data was changed to string descriptives at this time.  A column binding
operation was used to create the final training data frame.

The same process was followed for building a final testing data frame.  A row bind operation
effectively merged these two data frames into one total data set.

Next, the aggregate function within the 'dplyr' package was used to summarize the dataset.  An average
(mean) value for each of the 'mean' and 'standard deviation' observations recorded in the total
data set was computed for each subject for each of the six activities.  This tidy dataset was
written as a csv file titled "CourseProject.csv" 
============================================================================================

Naming Convention:
Per the instruction to appropriately label the data with descriptive variable names, new names
were given to the quantitative variables describing each subject's movement.  The new names
were longer than the original names provided by the researchers, but this was done to make them
more descriptive.  Note that I DID NOT follow the recommendation to use only lower case letters
and avoid underlines.  My reasoning for using some upper case letters and adding an underline
was to allow readers to better differentiate between the variables.  So many of them had similar
names that when they were all written using only lower case letters it was very difficult to
distinguish between them.  The convention I developed was:

- Body or Gravity indicating which one the variable applied to
- Acceleration or Angular Velocity
- If it was either a 'Jerk' or 'Magnitude' computed from the data this was placed next
- The axial direction, X, Y, or Z, was indicated
- Following an '_', an indication of whether it was a mean or a standard deviation
- Lastly, an indication of whether the measure was in the original 'time' dimension or whether
	the value represented the Fast Fourier Transformation of the time.  In this latter case the
	value was a frequency
	
A complete listing of the variables is given in the accompanying code book.
==================================================================================================
Files needed to evaluate this project:

To run the required script, the following files are required:
run_analysis.R
X_train/test.txt
subject_train/test.txt
y_train/test.txt

To fully understand the work that was done, see the following:
README.md (this file)
README_original.txt (file provided by the original researchers)
codebook.txt (description of variables in the final tidy dataset)

To view and evaluate the final summary data file:
CourseProj.csv
