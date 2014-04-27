#Utility functions are placed into this file

#getActivityName converts values to activity labels as in
#UCI HAR Dataset/activity_labels.txt 

getActivityName<-function(x) {
  if(x==1)
    return("WALKING")
  else if (x==2)
    return("WALKING_UPSTAIRS")
  else if (x==3)
    return("WALKING_DOWNSTAIRS")
  else if (x==4)
    return("WALKING_DOWNSTAIRS")
  else if (x==5)
    return("SITTING")
  else if (x==6)
    return("STANDING")
  else if (x==7)
    return("LAYING")
  else
    message("Unexpected activity value detected ",x)
}
