# Erwin Lares
# Passing new arguments to the Penguin Predict API
# 2023-02-15

#this is what a successful POST 
# curl -X POST  # -X is for custom requests 
#"https://doit-rci-005458.doit.wisc.edu/content/1312e57f-aef8-42d7-b33c-4fbbf9891da4/predict" 
#-H "accept: */*" 
#-H "Content-Type: application/json" 
#-d "{\"bill_length_mm\":46.8,\"bill_depth_mm\":16.1,\"flipper_length_mm\":250,\"body_mass_g\":4300}"

library(tidyverse)
library(readxl)
library(httr)
library(glue)
library(curl)

#Get the latest data from Googlesheets

sim_data <- googlesheets4::read_sheet("https://docs.google.com/spreadsheets/d/1HEQa23hR202egPcnyAtQHGyPRw1WWv61H6aHnAhjcrc/edit#gid=519943868")

# Put together the http call to the endpoint predit that used the penguin model 
# to guess the species of the penguin captured
# the end point needs four measurements 
specimen_bill_length_mm <- sim_data |> tail(n = 1) |>  select(bill_length_mm) 
specimen_bill_depth_mm <- sim_data |> tail(n = 1) |>  select(bill_depth_mm)
specimen_flipper_length_mm <- sim_data |> tail(n = 1) |>  select(flipper_length_mm)
specimen_body_mass_g <- sim_data |> tail(n = 1) |>  select(body_mass_g)
url <- 'https://doit-rci-005458.doit.wisc.edu/content/1312e57f-aef8-42d7-b33c-4fbbf9891da4/predict'


json_body <- jsonlite::toJSON(list(bill_length_mm = specimen_bill_length_mm,
                                   bill_depth_mm = specimen_bill_depth_mm, 
                                   flipper_length_mm = specimen_flipper_length_mm,
                                   body_mass_g = specimen_body_mass_g),
                              auto_unbox = TRUE)

response <- POST(url, body = json_body, encode = "json")



#jsonlite::prettify(rawToChar(response$headers[[1]]))


#how did it go?
http_status(response)

#what's the answer?
content(response, "parsed")
