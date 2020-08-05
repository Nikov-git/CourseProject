# Course Project Code Book
<hr>
## Modifications made
*Merges the training and the test sets to create one data set.
*Extracts only the measurements on the mean and standard deviation for each measurement.
*Uses descriptive activity names to name the activities in the data set
*Appropriately labels the data set with descriptive variable names.
*From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Introduction to Course Project
Once data is read, a vectos for each data table is created.
<br>
     *function used: read.table()*
<br>
I've created variables using those vector.
<br>
      *function used: rbind()*
<br>
I've created a data frame.
<br>
      *function used: cbind()*
<br>
I've merged data and creating a Tiny Dataset with means and stds.
<br> 
      *functions used: pipper operator.*
           <br>
            *regular expressions skills.*
            <br>
           *dplyr::select()*
            <br>
I've replace code for its activity name.
<br>
      *function used: pipper operator*
      <br>
I've renamed variables (it was unintelligible)
<br>
      *functions used: name()*
      <br>
           *gsub()*
<br>
I've created an independent tidy data set with the average of each variable for each activity and each subject.
    <br>
      *functions used: pipper operator*
      <br>
           *group_by()*
          <br>
            *summarise_all()*
            <br>
            *funs()*
