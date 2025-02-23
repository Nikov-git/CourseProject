#Call needed library
library(dplyr)

#Download and decompress data.
data_file <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if(!file.exists(data_file)){
      download.file(data_file, destfile = "CP_data.zip", method = "curl")
}
unzip("CP_data.zip")

#Reading text files as a vector. 
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activity_label <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
ID_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "ID")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")
ID_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "ID")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")

#Prepare data for merge:  
#With rbind() function agroupe x variables (measurement) and y variables (code from label)
#You have to create a variable for subject's ID also to identify. 
#We're just taking data, not labels vectors (features and activity) <- 
      #Use View(features/activity_labels to see why)
X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)
ID <- rbind(ID_train, ID_test)

#Create a data frame with cbind()
      #Remember that every variable must take a colum, we have three variables (ID, measurement and labels)
mydata <- cbind(ID, Y, X)

#Now that we have a data frame, we can create a dataset with just a few variables (mean and standard desviation)
#We'll use 3  techniques to simplify: 
      #Pipe operator (%>%): So we can give more than an order at once
      #select(): So we can take just a part of our data frame
      #Regular expressions skills: So we can select those parts by its names. 
                        #Note: called variables by column name. 

finaldata <- mydata %>% select(ID, code, contains("mean"), contains("std"))
#Check selection using View(finaldata ;)
#Change code for activity label to use descriptive activity names. 
finaldata$code <- activity_label[finaldata$code, 2]

#Set appropriately labels the data set with descriptive variable names.
names(finaldata) <- gsub("code", "Activity", names(finaldata))
names(finaldata)<-gsub("Acc", "Accelerometer", names(finaldata))
names(finaldata)<-gsub("Gyro", "Gyroscope", names(finaldata))
names(finaldata)<-gsub("BodyBody", "Body", names(finaldata))
names(finaldata)<-gsub("Mag", "Magnitude", names(finaldata))
names(finaldata)<-gsub("^t", "Time", names(finaldata))
names(finaldata)<-gsub("^f", "Frequency", names(finaldata))
names(finaldata)<-gsub("tBody", "TimeBody", names(finaldata))
names(finaldata)<-gsub("-mean()", "Mean", names(finaldata), ignore.case = TRUE)
names(finaldata)<-gsub("-std()", "STD", names(finaldata), ignore.case = TRUE)
names(finaldata)<-gsub("-freq()", "Frequency", names(finaldata), ignore.case = TRUE)
names(finaldata)<-gsub("angle", "Angle", names(finaldata))
names(finaldata)<-gsub("gravity", "Gravity", names(finaldata))

#Creatting an independent tidy data set with the average of each variable
#for each activity and each subject.
AverageData<- finaldata %>% group_by(ID, Activity) %>%
summarise_all(funs(mean))
write.table(AverageData, "AverageData.txt", row.name=FALSE)