# load packages ----------------------------------------------------------------
##
##using R to iterate over all pages that contain information on the art collection.
##Reminder: The collection has 3312 pieces in total, as of the last time this page was compiled.
##we will develop a list of URLs, each corresponding to a page with 10 art pieces. 
##Then, we will write some code that applies the scrape_page() function to each page and combines the resulting data frames into a single data frame with 3312 rows and 3 columns.

library(tidyverse)
library(rvest)
library(glue)

# list of urls to be scraped ---------------------------------------------------

root <- "https://collections.ed.ac.uk/art/search/*:*/Collection:%22edinburgh+college+of+art%7C%7C%7CEdinburgh+College+of+Art%22?offset="
numbers <- seq(from = 0, to =3310, by = 10)
urls <- glue("{root}{numbers}")

# map over all urls and output a data frame ------------------------------------

uoe_art <- map_dfr(urls, scrape_page)

# write out data frame ---------------------------------------------------------

write_csv(uoe_art, file = "data/uoe-art.csv")
