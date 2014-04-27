#Source utility file
source("label_decoders.R")

#Set path for test,training data sets and feature description file

testFile<-"./UCI\ HAR\ Dataset/test/X_test.txt"
testSubjectFile<-"./UCI\ HAR\ Dataset/test/subject_test.txt"
testActivityFile<-"./UCI\ HAR\ Dataset/test/y_test.txt"
trainFile="./UCI\ HAR\ Dataset/train/X_train.txt"
trainSubjectFile<-"./UCI\ HAR\ Dataset/train/subject_train.txt"
trainActivityFile<-"./UCI\ HAR\ Dataset/train/y_train.txt"
featuresFile<-"./UCI\ HAR\ Dataset/features.txt"


#Read test data set
DTTest<-read.table(testFile,sep="")

#Read train data set
DTTrain<-read.table(trainFile,sep="")

#Check the table dimensions
#dim(DTTest)
#dim(DTTrain)

#Combine both to one data set
DTOne<-rbind(DTTest,DTTrain)

#Read feature names from description file
DTFeatures<-read.table(featuresFile,sep="")
featureNames<-DTFeatures[,2]

#Insert feature names as variable names into the table
names(DTOne)<-featureNames

#Get std measurements columns
stdInd<-grep("std",featureNames)
#length(stdInd)
#featureNames[stdInd]

#Get mean measurements columns
meanInd<-grep("mean",featureNames)
#length(meanInd)
#featureNames[meanInd]

#Create output table for means and standar deviations
DTMeansStds<-cbind(DTOne[,meanInd],DTOne[,stdInd])

#Read test activity and subject data
DTTestActivity<-read.table(testActivityFile,sep="")
DTTestSubject<-read.table(testSubjectFile,sep="")

#Read train activity and subject data
DTTrainActivity<-read.table(trainActivityFile,sep="")
DTTrainSubject<-read.table(trainSubjectFile,sep="")

#Bind Activity and Subject variables to the data table
DTOne<-cbind(rbind(DTTestActivity,DTTrainActivity),DTOne)
DTOne<-cbind(rbind(DTTestSubject,DTTrainSubject),DTOne)

#Add new feature variable names into vector


names(DTOne)[1]<-paste("Subject")
names(DTOne)[2]<-paste("Activity")




#Create list of human readable activity names for each row
ActivityName<-lapply(DTOne[,"Activity"],getActivityName)
DTOne<-cbind(data.frame(unlist(ActivityName)),DTOne)

#Change the variable name
names(DTOne)[1]<-paste("ActivityName")


#Iterate Activities and Subjects
DTTidy=data.frame()

## Get test subject id list
Subjects=sort(unique(DTOne$Subject))


for (activity in  unique(DTOne$ActivityName)) {
  for (subject in Subjects){
    #Get subset table with given activity and subject values
    SubT<-subset(DTOne,ActivityName==activity & Subject==subject)
    #Calculate column mean for the subtable
    ColMeans<-colMeans(SubT[,4:ncol(SubT)])
    #Assemble table with ActivityName,Subject,Activity and means
    ASTable<-cbind(SubT[1,1:3],data.frame(t(ColMeans)))
    #Row bind to output table
    DTTidy<-rbind(DTTidy,ASTable)
  }
}
  



#Clean up some temporary data structures to save memory
remove(DTFeatures, featureNames,DTTest, DTTrain, DTTestActivity, DTTestSubject)
remove(DTTrainActivity,DTTrainSubject,ASTable,ColMeans,Subjects)
remove(SubT,ActivityName,activity,meanInd,stdInd,subject)