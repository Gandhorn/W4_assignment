---
title: "CodeBook for assignment"
author: "Me"
date: "04/02/2021"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## Variables
The tidy data set is called my_DF2. It includes the following variables:

* subject: The ID of the actual person who got measured
* activitylabel: The actual activity which was conducted
* 81 variables representing the standard deviation and mean values of the initial features


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
  + Initial datasets were split into two differnent datasets