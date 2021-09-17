# Motoaki Takahashi
# R version 4.0.4 (2021-02-15) 

rm(list=ls())
# setwd("your folder")
library(tidyr)
library(dplyr)
library(readxl)
library(readr)
library(data.table)
library(haven)
library(stargazer)
library(ggplot2)
library(jtools)
library(ggstance)
library(broom.mixed)
library(stringr)
library(openxlsx)
library(texreg)
library(geosphere)
library(sp)

# write a function that maps centers of population by state data to decimal points of longitude/latitude of centers
get_decimal = function(center_data){
  # select relevant columns
  center_data = center_data[, 1:3]
  names(center_data) = c("state", "n_lat_m_s", "w_lon_m_s")
  
  # translate longtudes and latitudes to the formats that the sp package looks for
  center_data = center_data %>% mutate(lat = sub("°", "d", n_lat_m_s))
  center_data = center_data %>% mutate(lon = sub("°", "d", w_lon_m_s))
  
  # remove the last character
  center_data$lat = str_sub(center_data$lat, 1, nchar(center_data$lat)-1)
  center_data$lon = str_sub(center_data$lon, 1, nchar(center_data$lon)-1)
  
  # replace funny unicode encoding \u2032 (which seems to represent ') with '
  center_data$lat = sub("\u2032", "'", center_data$lat)
  center_data$lon = sub("\u2032", "'", center_data$lon)
  
  # add "\"N" or "\"W" in the last
  center_data$lat = paste(center_data$lat, "\"N", sep = "")
  center_data$lon = paste(center_data$lon, "\"W", sep = "")
  
  center_data$lat = sub(" ", "", center_data$lat)
  center_data$lon = sub(" ", "", center_data$lon)
  
  # add the column that represents latitudes and longitudes in decimal points
  lat_dec = as.numeric(sp::char2dms(center_data$lat))
  lon_dec = as.numeric(sp::char2dms(center_data$lon))
  
  center_data = cbind(center_data, lat_dec)
  center_data = cbind(center_data, lon_dec)
  
  return(center_data)
}

center70 = read_csv("1970.csv")
decimal_70 = get_decimal(center70)

center80 = read_csv("1980.csv")
decimal_80 = get_decimal(center80)

center90 = read_csv("1990.csv")
decimal_90 = get_decimal(center90)

center00 = read_csv("2000.csv")
decimal_00 = get_decimal(center00)

center10 = read_csv("2010.csv")
decimal_10 = get_decimal(center10)

write_csv(decimal_70, "decimal_70.csv")
write_csv(decimal_80, "decimal_80.csv")
write_csv(decimal_90, "decimal_90.csv")
write_csv(decimal_00, "decimal_00.csv")
write_csv(decimal_10, "decimal_10.csv")
