#run_analysis.R Code book 


## DTOne variables
1. ActivityName
2. Subject
3. Activity
4. Variable in same order as in /UCI HAR Dataset/features.txt 

### Activity, ActivityName 
variable value and mapping to name as in /UCI HAR Dataset/activity_labels.txt
* 1 WALKING
* 2 WALKING_UPSTAIRS
* 3 WALKING_DOWNSTAIRS
* 4 SITTING
* 5 STANDING
* 6 LAYING

### Subject - variable range
* 1..30 - subject test persons

## DTMeansStds variables
* 1..46 "mean" columns from the merged data set DTOne
* 47..79 "std" columns from the merged data set DTOne

## DTTidy variables
* ActivityName
* Subject
* Activity
* 4...564 means for given activity and subject

