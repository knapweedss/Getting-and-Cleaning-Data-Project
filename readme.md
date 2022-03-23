## *Getting and Cleaning Data* 
## Final Project

## Files
* `run_analysis.R` -- script
* `codebook.md` -- codebook
* `tidy_data.txt` -- final data

## What script do
1. Downloads data from the web
2. Loads the activity and feature info
3. Loads both the training and test datasets, keeping only those columns which reflect a mean or standard deviation
4. Loads the activity and subject data for each dataset, and merges those columns with the dataset
5. Merges the two datasets
6. Replace activity to it's name by refering activity label
7. creates `tidy_data.txt` - a final file with tidy data 