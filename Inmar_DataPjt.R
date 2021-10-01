
install.packages("tidyverse")
library(tidyverse)
install.packages("data.table")
library(data.table)


data <- list.files(path = "F:\\Personal_Projects\\Inmar_Project", pattern = "*.csv", full.names = T) %>%  extract(sapply(., myfun)==as.Date("2021-09-30 00:37:57 IST"))%>% extract(sapply(., file.size)>2) %>% 
  map_df(~read_csv(., col_types = cols(.default = "c")))

View(data)

str(data)


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

myfun <- function(x)
{
  as.Date(file.info(x)$ctime)
}




