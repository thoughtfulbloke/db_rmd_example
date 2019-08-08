## setup
## creating a sqlite database if it is not in the directory
## use birds at sea observations from Te Papa
library(lubridate)
library(dplyr)
library(DBI)

boats <- read.csv("https://www.tepapa.govt.nz/sites/default/files/at-sea_seabird_observation_data_ship_data_by_record_id_1.csv",
                  stringsAsFactors = FALSE) %>%
  select(-X, -X.1)
names(boats)[2] <- "RECORDID"

mydb <- dbConnect(RSQLite::SQLite(), "xmpldb.sqlite")
dbWriteTable(mydb, "boats", boats)
dbDisconnect(mydb)



