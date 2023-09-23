#install and load packages
install.packages("dplyr")
install.packages("tidyverse")
install.packages("rvest")
install.packages("tibble")

library(dplyr)
library(tidyverse)
library(rvest)
library(tibble)

# HW 01 - Web Scrapping IMDB
url <- "https://www.imdb.com/search/title/?at=0&genres=animation&keywords=anime&num_votes=1000,&sort=user_rating&title_type=tv_series"
anime_name <- url %>%
  read_html() %>%
  html_nodes("h3.lister-item-header") %>%
  html_text2()

ratings <- url %>%
  read_html() %>%
  html_elements("div.ratings-imdb-rating") %>%
  html_text2() %>%
  as.numeric()

votes <- url %>%
  read_html() %>%
  html_elements("p.sort-num_votes-visible") %>%
  html_text2()

anime_times <- url %>%
  read_html() %>%
  html_elements("span.runtime") %>%
  html_text2()

anime_genre <- url %>%
  read_html() %>%
  html_elements("span.genre") %>%
  html_text2()

# replace empty value is 24 min
df <- data.frame(anime_times) %>%
add_row(anime_times = "24 min", .before = 36) %>%
add_row(anime_times = "24 min", .before = 49)

# create a dataframe
anime_df <- data.frame(anime_name, df, anime_genre, ratings, votes)
View(anime_df)

# HW 02 - Web Scrapping - statistic web
# web browser - Top 20 most popular sports in the world in 2023 revealed

sp_url <- "https://sportsbrief.com/other-sports/16715-revealed-top-20-popular-sports-world-2023/"

sp_name <- sp_url %>%
  read_html() %>%
  html_elements("span") %>%
  html_text()

sp_detail <- sp_url %>%
  read_html() %>%
  html_elements("li") %>%
  html_text()

# filter only sp_name
spn_df <- data.frame(sp_name)

spn_df <- spn_df %>%
  filter(row_number() %in% c(4,14,22,34,42,52,60,70,78,88,100,108,120,128,139,147,158,166,174,187))

# separate sp_detail to 4 columns
spd_df <- data.frame(sp_detail)

year_df <- spd_df %>%
  filter(grepl("Year", sp_detail))

governing_df <- spd_df %>%
  filter(grepl("Governing", sp_detail))

first_df <- spd_df %>%
  filter(grepl("First", sp_detail))

famous_df <-spd_df %>%
  filter(grepl("Famous", sp_detail))

# create data.frame

bind_cols(spn_df, year_df, governing_df, first_df, famous_df)

last_df <- data.frame(spn_df, year_df, governing_df, first_df, famous_df)
View(last_df)
