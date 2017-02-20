#This script analyzes the dataset and creates a tidy dataset
#The script should be placed in the dataset folder alongwith train and test folders
#Author: Yogesh B

run_analysis<-function(){
  
  ### STEP 1: Merge Train and Test Datasets @@@

  #Reading train data, labels and subjects
  print("Reading train data, labels and subjects")
  x_train=read.table("train\\x_train.txt")
  y_train=read.table("train\\y_train.txt")
  subject_train=read.table("train\\subject_train.txt")

  #Reading test data, labels and subjects
  print("Reading test data, labels and subjects")
  x_test=read.table("test\\x_test.txt")
  y_test=read.table("test\\y_test.txt")
  subject_test=read.table("test\\subject_test.txt")
  
  #Combine train and test data
  print("Combine train and test data")
  x = rbind(cbind(subject_train,x_train),cbind(subject_test,x_test))
  y = rbind(y_train,y_test)

  
  ### STEP 2: Read features and filter mean and std based features ###
  
  print("Read feature names to process")
  features = read.table("features.txt")[,2]
  filter = grepl("mean|std",features)
  features = features[filter]
  print("Filter features related to mean and deviation")
  x = x[,c(T,filter)]
  
  ### STEP 3: Assign descriptive activity labels ###

  print("Read data about activity labels and replace activity no with names")
  activity_types = read.table("activity_labels.txt")
  y=factor(y[,1],levels=activity_types[,1],labels=activity_types[,2])
  
  ### STEP 4: Create a data frame with appropriate labels and columns ###
  
  print("Convert variable names to descriptive labels")
  final_data = data.frame(cbind(x,y))
  features = gsub("-"," ",features)
  features = sub("^t","Time Domain ",features)
  features = sub("^f","Freq. Domain ",features)
  features = sub("BodyBody","Body",features)
  features = sub("Body","Body ",features)
  features = sub("Gyro","Gyroscope ",features)
  features = sub("Acc","Acclerometer ",features)
  features = sub("Jerk","Jerk ",features)
  features = sub("Gravity","Gravity ",features)
  features = sub("Mag","Euclidean Norm ",features)
  features = gsub("\\(\\)","",features)
  features = gsub("( )+"," ",features)
  names(final_data)=c("Subject ID",features)
  names(final_data)[length(features)+2]="Activity"
  
  print("Format complete data altogether")
  final_data[,features]=as.matrix(sapply(final_data[,features], as.numeric))
  
  ### STEP 5: Create new data based on average values of feature per subject per activity ###
  print("Create new data based on average values of feature per subject per activity")
  new_data=aggregate(final_data[,1:length(features)+1],list(final_data$`Subject ID`,final_data$Activity),mean)
  names(new_data)[1:2]=c("Subject ID","Activity")
  
  ### Store the new dataset in file ###
  print("Store the new dataset in file")
  write.table(new_data,"dataset.txt",row.names = FALSE)

}