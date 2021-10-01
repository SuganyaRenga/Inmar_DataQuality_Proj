
install.packages("tidyverse")
library(tidyverse)
install.packages("data.table")
library(data.table)


# creating data pipeline to read only new csv files whose uploaded date match the current job run date and the file is non empty


data <- list.files(path = "F:\\Personal_Projects\\Inmar_Project", pattern = "*.csv", full.names = T) %>%  magrittr::extract(sapply(., myfun)==as.Date("2021-09-30 00:37:57 IST"))%>% magrittr::extract(sapply(., file.size)>2) %>% 
  map_df(~read_csv(., col_types = cols(.default = "c")))

#viewing the data that are read

View(data)

str(data)

# casting the data as per the required document

data$url <- as.character(data$url)
data$address <- as.character(data$address)
data$name <- as.character(data$name)
data$votes <- as.integer(data$votes)
data$phone <- as.integer(data$phone)
data$location <- as.character(data$location)
data$rest_type <- as.character(data$rest_type)
data$dish_liked <- as.array(data$dish_liked)
data$cuisines <- as.character(data$cuisines)
data$reviews_list <- as.array(data$reviews_list)

str(data)


library(stringr)

#cleaning address field to remove commas,period,esclamations etc

data$address <- str_replace_all(data$address,"[^[:alnum:]]",'')

view(data)

#cleaning reviews_list field to remove commas,period, esclamations etc

data$reviews_list <- str_replace_all(data$reviews_list,"[^[:alnum:]]",'')

view(data)

#checking for null values in non null field

is.null(data$name)
is.null(data$phone)
is.null(data$location)
is.null(data$votes)


#function to retrieve the date information from the incoming files

myfun <- function(x)
{
  format(as.Date(file.info(x)$ctime, origin="1900-01-01")+1)
}


