## Source utility file
source("label_decoders.R")

## Set path variables
sourceTestDirPath<-"./UCI\ HAR\ Dataset/test/"
sourceTrainDirPath<-"./UCI\ HAR\ Dataset/train/"

## Set path for test,training data sets and feature description file

testFile<-paste0(sourceTestDirPath,"X_test.txt")
testSubjectFile<-paste0(sourceTestDirPath,"subject_test.txt")
testActivityFile<-paste0(sourceTestDirPath,"y_test.txt")
trainFile=paste0(sourceTrainDirPath,"X_train.txt")
trainSubjectFile<-paste0(sourceTrainDirPath,"subject_train.txt")
trainActivityFile<-paste0(sourceTrainDirPath,"y_train.txt")
featuresFile<-"./UCI\ HAR\ Dataset/features.txt"

## Output file

outFile="tidydata.txt"


## Read test data set
testDF<-read.table(testFile,sep="")

##Read train data set
trainDF<-read.table(trainFile,sep="")


## Combine both to one output data set
mergedDataSet<-rbind(testDF,trainDF)


## Read feature names from description file
featureDF<-read.table(featuresFile,sep="")
featureNameList<-featureDF[,2]

## Insert feature names as variable names into the table
names(mergedDataSet)<-featureNameList

## Get std measurements columns
stdInd<-grep("std",featureNameList)
## Get mean measurements columns
meanInd<-grep("mean",featureNameList)

## Create output table for means and standard deviations for one output table
meansStdsTable<-cbind(mergedDataSet[,meanInd],mergedDataSet[,stdInd])


## Read test and training activity and subject data
testActivityDF<-read.table(testActivityFile,sep="")
testSubjectDF<-read.table(testSubjectFile,sep="")
trainActivityDF<-read.table(trainActivityFile,sep="")
trainSubjectDF<-read.table(trainSubjectFile,sep="")

## Bind Activity and Subject variables to the data table
mergedDataSet<-cbind(rbind(testActivityDF,trainActivityDF),mergedDataSet)
mergedDataSet<-cbind(rbind(testSubjectDF,trainSubjectDF),mergedDataSet)

## Add new feature variable names into vector
names(mergedDataSet)[1]<-paste("Subject")
names(mergedDataSet)[2]<-paste("Activity")


## Create list of human readable activity names for each row
activityNameList<-lapply(mergedDataSet[,"Activity"],getActivityName)
mergedDataSet<-cbind(data.frame(unlist(activityNameList)),mergedDataSet)

## Change the feautre variable name
names(mergedDataSet)[1]<-paste("ActivityName")



## Split by ActivityName and Subject factors. The result is huge list but short code :-)
SplittedByFactors<-split(mergedDataSet, list(mergedDataSet$ActivityName,mergedDataSet$Subject))


## Output data frame
tidyTB <-data.frame()

## Loop thorugh all factored cases, calculate column mean and store to output data frame
for(case in SplittedByFactors){
  cMeans<-t(colMeans(case[,4:ncol(case)]))
  tmpTB<-cbind(ActivityName=case[1,1],Subject=case[1,2],Activity=case[1,3],data.frame(cMeans))
  tidyTB <-rbind(tidyTB ,tmpTB)
}



## Write tidyTB to file
if(file.exists(outFile)) file.remove(outFile)
write.table(tidyTB ,outFile,sep=" ")


## Clean up some temporary data structures to save memory and to clean output 
remove(featureDF)
remove(featureNameList,activityNameList)
remove(trainActivityDF,trainSubjectDF)
remove(case,cMeans,testDF,tmpTB,trainDF)
remove(SplittedByFactors,meanInd,stdInd)
remove(featuresFile,outFile,sourceTestDirPath,sourceTrainDirPath)
remove(testActivityFile,testFile,testSubjectFile,trainActivityFile)
remove(trainFile,trainSubjectFile)
remove(testActivityDF,testSubjectDF)
