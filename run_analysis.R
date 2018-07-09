########################################################
##                    Week 4
##              Peer Graded Project
##                  L. Campbell

## Load required libraries
library(data.table)
library(dplyr)
library(reshape2)

## Establish a vector of variable names
## This allows us to later accomplish objective 4 - assign meaningful names
## later in the program.
vec_names = c("BodyAccelerationXdirection_meantime",
"BodyAccelerationYdirection_meantime",
"BodyAccelerationZdirection_meantime",
"BodyAccelerationXdirection_stdtime",
"BodyAccelerationYdirection_stdtime",
"BodyAccelerationZdirection_stdtime",
"GravityAccelerationXdirection_meantime",
"GravityAccelerationYdirection_meantime",
"GravityAccelerationZdirection_meantime",
"GravityAccelerationXdirection_stdtime",
"GravityAccelerationYdirection_stdtime",
"GravityAccelerationZdirection_stdtime",
"BodyAccelerationJerkXdirection_meantime",
"BodyAccelerationJerkYdirection_meantime",
"BodyAccelerationJerkZdirection_meantime",
"BodyAccelerationJerkXdirection_stdtime",
"BodyAccelerationJerkYdirection_stdtime",
"BodyAccelerationJerkZdirection_stdtime",
"BodyAngularVelocityXdirection_meantime",
"BodyAngularVelocityYdirection_meantime",
"BodyAngularVelocityZdirection_meantime",
"BodyAngularVelocityXdirection_stdtime",
"BodyAngularVelocityYdirection_stdtime",
"BodyAngularVelocityZdirection_stdtime",
"BodyAngularVelocityJerkXdirection_meantime",
"BodyAngularVelocityJerkYdirection_meantime",
"BodyAngularVelocityJerkZdirection_meantime",
"BodyAngularVelocityJerkXdirection_stdtime",
"BodyAngularVelocityJerkYdirection_stdtime",
"BodyAngularVelocityJerkZdirection_stdtime",
"BodyAccelerationMagnitude_meantime",
"BodyAccelerationMagnitude_stdtime",
"GravityAccelerationMagnitude_meantime",
"GravityAccelerationMagnitude_stdtime",
"BodyAccelerationJerkMagnitude_meantime",
"BodyAccelerationJerkMagnitude_stdtime",
"BodyAngularVelocityMagnitude_meantime",
"BodyAngularVelocityMagnitude_stdtime",
"BodyAngularVelocityJerkMagnitude_meantime",
"BodyAngularVelocityJerkMagnitude_stdtime",
"BodyAccelerationXdirection_meanfourier",
"BodyAccelerationYdirection_meanfourier",
"BodyAccelerationZdirection_meanfourier",
"BodyAccelerationXdirection_stdfourier",
"BodyAccelerationYdirection_stdfourier",
"BodyAccelerationZdirection_stdfourier",
"BodyAccelerationFrequencyXdirection_meanfourier",
"BodyAccelerationFrequencyYdirection_meanfourier",
"BodyAccelerationFrequencyZdirection_meanfourier",
"BodyAccelerationJerkXdirection_meanfourier",
"BodyAccelerationJerkYdirection_meanfourier",
"BodyAccelerationJerkZdirection_meanfourier",
"BodyAccelerationJerkXdirection_stdfourier",
"BodyAccelerationJerkYdirection_stdfourier",
"BodyAccelerationJerkZdirection_stdfourier",
"BodyAccelerationJerkFrequencyXdirection_meanfourier",
"BodyAccelerationJerkFrequencyYdirection_meanfourier",
"BodyAccelerationJerkFrequencyZdirection_meanfourier",
"BodyAngularVelocityXdirection_meanfourier",
"BodyAngularVelocityYdirection_meanfourier",
"BodyAngularVelocityZdirection_meanfourier",
"BodyAngularVelocityXdirection_stdfourier",
"BodyAngularVelocityYdirection_stdfourier",
"BodyAngularVelocityZdirection_stdfourier",
"BodyAngularVelocityFrequencyXdirection_meanfourier",
"BodyAngularVelocityFrequencyYdirection_meanfourier",
"BodyAngularVelocityFrequencyZdirection_meanfourier",
"BodyAccelerationMagnitude_meanfourier",
"BodyAccelerationMagnitude_stdfourier",
"BodyAccelerationFrequencyMagnitude_meanfourier",
"BodyAccelerationJerkMagnitude_meanfourier",
"BodyAccelerationJerkMagnitude_stdfourier",
"BodyAccelerationJerkFrequencyMagnitude_meanfourier",
"BodyAngularVelocityMagnitude_meanfourier",
"BodyAngularVelocityMagnitude_stdfourier",
"BodyAngularVelocityFrequencyMagnitude_meanfourier",
"BodyAngularVelocityJerkMagnitude_meanfourier",
"BodyAngularVelocityJerkMagnitude_stdfourier",
"BodyAngularVelocityJerkFrequencyMagnitude_meanfourier")


## Read in the relevant information from the training data.
## Note that column names are assigned immediately after reading
## in the data.
dat_train = fread("X_train.txt", header=FALSE, 
	select=c(1:6,41:46,81:86,121:126,161:166,201,202,214,215,227,228,240,
	241,253,254,266:271,294:296,345:350,373:375,424:429,452:454,
	503,504,513,516,519,526,529,530,539,542,543,552))
	colnames(dat_train) = vec_names

sub_train = fread("subject_train.txt", header=FALSE)
	colnames(sub_train) = "subject"

act_train = fread("y_train.txt", header=FALSE)

## Apply descriptive names to the activities in the dataset.
## This accomplishes #3 in the project objectives.

act_train = mutate(act_train, activity = ifelse(V1 %in% 1, "Walking",
	ifelse(V1 %in% 2, "Walking_up",
	ifelse(V1 %in% 3, "Walking_down",
	ifelse(V1 %in% 4, "Sitting",
	ifelse(V1 %in% 5, "Standing", "Laying"))))))

act_train = act_train[-1]


## Column Bind all of the training data together
train_dat = cbind(sub_train, act_train, dat_train)


## Read in the relevant information from the test data.
dat_test = fread("X_test.txt", header=FALSE, 
	select=c(1:6,41:46,81:86,121:126,161:166,201,202,214,215,227,228,240,
	241,253,254,266:271,294:296,345:350,373:375,424:429,452:454,
	503,504,513,516,519,526,529,530,539,542,543,552))
	colnames(dat_test) = vec_names
sub_test = fread("subject_test.txt", header=FALSE)
	colnames(sub_test) = "subject"
act_test = fread("y_test.txt", header=FALSE)


## Apply descriptive names to the activities in the dataset.
## This accomplishes #3 in the project objectives.

act_test = mutate(act_test, activity = ifelse(V1 %in% 1, "Walking",
	ifelse(V1 %in% 2, "Walking_up",
	ifelse(V1 %in% 3, "Walking_down",
	ifelse(V1 %in% 4, "Sitting",
	ifelse(V1 %in% 5, "Standing", "Laying"))))))

act_test = act_test[-1]

## Column Bind all of the test data together
test_dat = cbind(sub_test, act_test, dat_test)


## Row bind the training and test sets together.
## This accomplishes item #1 in the project objectives.
##                   -------                     

dat = rbind(train_dat, test_dat)

## Declare the data matrix to be a dataframe
dat1 = data.frame(dat)

## Compute the average value for each variable over each subject/activity
## combination.
## This accomplishes objective #5 in the project assignment.
avgdata = aggregate(x=dat1, by = list(subject=dat1$subject, activity=dat1$activity), FUN=mean)
avgdata = avgdata[-c(3,4)]

head(avgdata,10)

## Write the tidy data to a csv file.
write.csv(avgdata, file = "CourseProject.csv", row.names=FALSE)

