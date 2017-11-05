# Getting and Cleaning Data - Coursera
This is the course project for the Getting and Cleaning Data course on Coursera

---
1. Data is read in using read.table in R.
2. The test and train data and labels are read in from the /test and /train folders respectively 
3. Activity IDs (from the features.txt file) and subject_test.txt (from train/test subfolders) are read in
4. All data is row/column bound in order to have a master dataset
5. The column headers/names are given
6. The activity column is recoded from an integer to a human-friendly string ("WALK", etc.)
7. Any variable/column that is not a mean or a standard deviation is removed using Regex
8. Variable names are reworked to improve readability using Regex
9. A second dataset called "tidyData" is created that groups and averages the data based on subjectID and activity.
