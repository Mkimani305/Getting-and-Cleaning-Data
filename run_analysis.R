#Merging training and test tests to create one data set
X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)
Subject <- rbind(subject_train, subject_test)
Full_Merge <- cbind(Subject, Y, X)

#Extracts only the measurements on the mean and standard deviation for each measurement
mean_SD <- Full_Merge %>% select(subject, code, contains("mean"), contains("std"))

#Uses descriptive activity names to name the activities in the data set
mean_SD$code <- activities[mean_SD$code, 30]

#Appropriately labels the data set with descriptive variable names
names(mean_SD)[30] = "activity"
names(mean_SD)<-gsub("^t", "time", names(mean_SD))
names(mean_SD)<-gsub("^f", "frequency", names(mean_SD))
names(mean_SD)<-gsub("Acc", "Accelerometer", names(mean_SD))
names(mean_SD)<-gsub("Gyro", "Gyroscope", names(mean_SD))
names(mean_SD)<-gsub("Mag", "Magnitude", names(mean_SD))
names(mean_SD)<-gsub("BodyBody", "Body", names(mean_SD))

#creates a second, independent tidy data set with the average of each variable for each activity and each subject.
Independent_Set <- mean_SD %>%
  group_by(subject, activity)%>%
  summarise_all(funs(mean))
write.table(Independent_Set, "Independent_Set.txt", row.name = FALSE)
