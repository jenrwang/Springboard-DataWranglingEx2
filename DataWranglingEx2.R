# Load packages

library(dplyr)
library(tidyr)
library(readr)

# 0: Load raw data into RStudio

Titanic <- read_csv("~/Springboard/DataWranglingEx2/titanic3.csv")
View(Titanic)

# 1: Port of embarkation. Find missing values and replace them with S.

unique(Titanic$embarked)
##[1] "S" "C" NA  "Q"

Titanic$embarked[(!(Titanic$embarked %in% c("S", "C", "Q")))] <- "S"
unique(Titanic$embarked)
##[1] "S" "C" "Q"

# 2: Age. Find missing values and replace them with the mean age.
print(mean(Titanic$age))
##NA
Titanic$age[is.na(Titanic$age)]<-mean(Titanic$age, na.rm=TRUE)
print(mean(Titanic$age))
##[1] 29.88113

# 3: Lifeboat. Tag empty slots in 'boats' with NA
unique(Titanic$boat)
##[1] "2"       "11"      NA        "3"       "10"      "D"       "4"       "9"      
##[9] "6"       "B"       "8"       "A"       "5"       "7"       "C"       "14"     
##[17] "5 9"     "13"      "1"       "15"      "5 7"     "8 10"    "12"      "16"     
##[25] "13 15 B" "C D"     "15 16"   "13 15"  

###QUESTION HERE, it looks like empty spaces are already denoted by 'NA'?

Titanic$boat[is.na(Titanic$boat)]<- "None"
unique(Titanic$boat)

# 4: Cabin. Mark empty cabins. If has cabin=1, if blank=0.
Titanic$cabin[is.na(Titanic$cabin)]<- ""
Titanic <- mutate(Titanic, has_cabin_number = (!(cabin == "")))
Titanic <- Titanic %>% mutate(has_cabin_number = ifelse(has_cabin_number == FALSE, 0, 1))


# 6: Submit project.

View(Titanic)
write.csv(Titanic, "~/Springboard/DataWranglingEx2/Titanic_clean.csv")
