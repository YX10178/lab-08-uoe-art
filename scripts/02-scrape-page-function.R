# load packages ----------------------------------------------------------------

library(tidyverse)
library(rvest)

add_two <- function(x) {
  x + 2
}
add_two(3)
add_two(10)

##function_name <- function(input) {}

##function_name <- function(url) {
# read page at url
# extract title, link, artist info for n pieces on page
# return a n x 3 tibble
#}

# function: scrape_page --------------------------------------------------------

scrape_page <- function(url){
  
  # read page
  page <- read_html(url)
  
  # scrape titles
  titles <-page %>%
    html_nodes(".iteminfo") %>%
    html_node("h3 a") %>%
    html_text() %>%
    str_squish() #remove the extra space
  
  # scrape links
  links <- page %>%
    html_nodes(".iteminfo") %>%
    html_node("h3 a") %>%
    html_attr("href") %>%
    str_replace("\\.", "___")
  
  
  # scrape artists 
  artists <- page %>%
    html_nodes(".iteminfo") %>%
    html_node(".artist") %>%
    html_text() %>%
    str_squish()
  
  # create and return tibble
  tibble(title = titles [1:10],
         artist = artists [1:10],
         link = links[1:10]
  )
  
}
