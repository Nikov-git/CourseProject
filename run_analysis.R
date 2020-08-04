library(dplyr)
data_file <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if(!file.exists(data_file)){
      download.file(data_file, destfile = "CP_data.zip", method = "curl")
}
unzip("CP_data.zip")
