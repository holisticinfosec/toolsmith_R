library(dplyr)
library(tibbletime)
library(tidyverse)

#setwd("C:/coding/R/anomalize/")

logs <- read_csv("https://raw.githubusercontent.com/holisticinfosec/toolsmith_R/master/anomalize/log.csv")

security_access_logs <- logs %>%
  group_by(server) %>%
  as_tbl_time(date)

security_access_logs