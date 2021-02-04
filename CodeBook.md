
```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## Variables
The tidy data set is called my_DF2. It includes the following variables:

* subject: The ID of the subject who carried out the experiment
* activitylabel: The actual activity which was conducted. Only 6 values are possible
  + laying
  + sitting
  + standing
  + walking
  + walkingdownstairs
  + walkingupstairs
* 81 variables representing the standard deviation and mean values of the initial features. The following convention is used for naming


## Data
Original data is based on the "Human Activity Recognition Using Smartphones Dataset, Version 1.0". It was downloaded on Feburary 4th, 2021 a the following address: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  

Full credential:
*Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws*
www.smartlab.ws


## Transformation conducted

* Train and test data sets merge:
  + Initial datasets were split into two differnent datasets (train and test). For each of these (train and test), the data was actually split into 3 different files (ID of the subject who carried out the experiment; ID of the activity conducted, and a third file containing a 561-feature vector). These 3 files where first merged (using cbind), and then the two full data sets (train and test) got merged using rbind
  + Final column names is based on original feature description. Special caracters and numbers got removed. Capital letters were kept to facilitate reading
  + Only features regarding standard deviation and mean values were kept. This was done by checking presence of either "mean" or "std" in the features labels