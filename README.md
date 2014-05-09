#Short intro 
This project merges and tidies data collected by the project

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


##Included files
* run_analysis.R   - main function to merge and clean data set
* label_decoders.R - utility function for converting Activity values to ActivityNames

## Usage

1. Download and unzip into same directory with these scripts
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
2. Execute run_analysis.R script from R console by source("./run_analysis.R")

### Output data structres 
1. mergedDataTB - merged data set is returned
2. meansStdsTB  - data set with only "mean" and "std" columns returned
3. tidyTB       - tidy data frame is returned 

### Output data file
* tidydata.txt - output file including tidyTB data structure with tab delimited fields

## Data
Data variables are documented in the   [CodeBook.md](/CodeBook.md/)


 


