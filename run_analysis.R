##Run_Analysis.R
##Patrick Flynn - Coursera 11/5/2017


require("dplyr")
##Dplyr required for Group By and Summarize Functions

##Reading in the test/training data and binding them into one data frame
x_test <- read.table("test/X_test.txt")
x_train <- read.table("train/X_train.txt")
x_test <- cbind(read.table("test/y_test.txt"), x_test)
x_train <- cbind(read.table("train/y_train.txt"), x_train)
subjects <- rbind(read.table("test/subject_test.txt"), read.table("train/subject_train.txt"))

##Creating an activity data frame to be able to bind to main dataset
features <- read.table("features.txt")
name <- data.frame(0, "activity")
names(name) <- c("V1", "V2")
features <- rbind(name, features)

##Binding activity/subjects and renaming variables
dataset <- rbind(x_test, x_train)
names(dataset) <- features$V2
dataset<- cbind(subjects, dataset)
names(dataset)[1] <- "subjectID"

##Activities renamed to be viewer/reader friendly
dataset[which(dataset[,2] == 1),][2] <- "WALKING"
dataset[which(dataset[,2] == 2),][2] <- "WALKING_UPSTAIRS"
dataset[which(dataset[,2] == 3),][2] <- "WALKING_DOWNSTAIRS"
dataset[which(dataset[,2] == 4),][2] <- "SITTING"
dataset[which(dataset[,2] == 5),][2] <- "STANDING"
dataset[which(dataset[,2] == 6),][2] <- "LAYING"

##Remove no longer needed variables
rm(name, features, x_test, x_train, subjects)

##Removing fields that are not Mean or Standard Deviation and leaving Subject ID and Activity
dataset <- dataset[grep("subjectID|activity|mean|std", names(dataset))]
dataset <- dataset[-grep("Freq", names(dataset))]

##Renaming all variables to improve readability
names(dataset) <- gsub("tBody", "Time_", names(dataset))
names(dataset) <- gsub("fBody", "Frequency_", names(dataset))
names(dataset) <- gsub("^t", "Time_", names(dataset))
names(dataset) <- gsub("Acc", "Acceleration", names(dataset))
names(dataset) <- gsub("Gyro", "Gyroscope", names(dataset))
names(dataset) <- gsub("mean[[:punct:]][[:punct:]]", "MEAN", names(dataset))
names(dataset) <- gsub("std[[:punct:]][[:punct:]]", "SD", names(dataset))
names(dataset) <- gsub("-", "_", names(dataset))

##Using DPLYR to create tidy data frame for averages on each User/Activity
tidyData <- dataset %>% 
    group_by(subjectID,activity) %>%
    summarize_all(funs(mean))

