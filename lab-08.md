Lab 08 - University of Edinburgh Art Collection
================
Yuxin Xie
3/3/2025

## Load Packages and Data

First, let’s load the necessary packages:

``` r
library(tidyverse) 
#install.packages("skimr")
library(skimr)
library(ggplot2)
library(dplyr)
```

Now, load the dataset. If your data isn’t ready yet, you can leave
`eval = FALSE` for now and update it when needed.

``` r
# Remove eval = FALSE or set it to TRUE once data is ready to be loaded
uoe_art <- read_csv("data/uoe-art.csv")
```

## Exercise 9

\##Let’s start working with the **title** column by separating the title
and the date:

``` r
uoe_art2 <- uoe_art %>%
  separate(title, into = c("title", "date"), sep = "\\(") %>%
  mutate(year = str_remove(date, "\\)") %>% as.numeric()) %>%
  select(title, artist, year, link)  
```

    ## Error: object 'uoe_art' not found

## Exercise 10

\##get some errors, Some title values don’t contain (, so date is
assigned NA. \##Some title values contain multiple (, and separate()
keeps only the first split. \##Some date values don’t just contain valid
years (e.g., “circa 1890” or “Unknown”) and as.numeric() converts them
to NA.

## Exercise 11

``` r11
skim(uoe_art2)

uoe_art2 %>%
  summarise(
    missing_artist = sum(is.na(artist)),
    missing_year = sum(is.na(year))
  )
```

## Exercises 12

``` r12
ggplot(uoe_art2, aes(x = year)) +
  geom_histogram(binwidth = 10, fill = "steelblue", color = "black") +
  scale_x_continuous(limits = range(1819:2020, na.rm = TRUE)) +
  labs(title = "Artworks by Year",
       x = "Year",
       y = "Count") +
  theme_minimal()

##removed the art with NA year values. also one artwork the year value generated from last exercise is 2, not a valid year, removed this as well. 
```

## Exercises 13

``` r13
##Death Mask, by H.Dempshall, the year should be 1964 instead of 2. Tropical Bird Study should be 1962, etc.....

uoe_art_corrected <- uoe_art2 %>%
  mutate(
    year = case_when(
      str_detect(title, "Death Mask") ~ 1964,  # Matches even if there are extra spaces or punctuation
      str_detect(title, "Tropical Bird Study") ~ 1962,
      TRUE ~ year  # Keep existing values
    )
  )

ggplot(uoe_art_corrected, aes(x = year)) +
  geom_histogram(binwidth = 10, fill = "steelblue", color = "black") +
  scale_x_continuous(limits = range(1819:2020, na.rm = TRUE)) +
  labs(title = "Artworks by Year",
       x = "Year",
       y = "Count") +
  theme_minimal()
```

## Exercises 14

``` r14
#Who is the most commonly featured artist in the collection? Do you know them? Any guess as to why the university has so many pieces from them?
most_common_artist <- uoe_art_corrected %>%
  count(artist, sort = TRUE)  # Count and sort by most frequent
head(most_common_artist, 10)

##Emma Gillies is the most common one. She was the sister of Sir William Gillies, a renowned Scottish painter and former head of Edinburgh College of Art.
```

## Exercises 15

``` r15
#How many art pieces have the word “child” in their title? 
child_count <- uoe_art_corrected %>%
  filter(str_detect(str_to_lower(title), "child")) %>%
  count()
print(child_count)
```
