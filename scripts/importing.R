# Importing data 
library(tidyverse)

#Download data
download.file(
  "https://raw.githubusercontent.com/datacarpentry/r-socialsci/main/episodes/data/SAFI_clean.csv",
  "data-raw/SAFI_clean.csv", mode = "wb"
)

#1. Find the path to the data 
read_csv("data-raw/SAFI_clean.csv")

#2. Potentially identify missing values
interviews <- read_csv("data-raw/SAFI_clean.csv",
         na = "NULL")

#3. Change parsing of data types
#Check the parsing of data types
spec(interviews)

interviews <- read_csv("data-raw/SAFI_clean.csv",
         na = "NULL",
         col_types=cols(
          key_ID=col_integer(),
          no_membrs = col_integer(),
          years_liv = col_integer(),
         ))
# readr example
read_csv

#Write out data
write_csv(interviews, "data/interviews.csv")

#Read it back in 
interviews_new <- read_csv ("data/interviews.csv")
interviews_new

# rm(interveiws_new) #remove an oopsie

