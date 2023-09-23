library(dplyr)
library(tidyverse)
library(patchwork)

glimpse(diamonds)

## Chart 1 - geom_histogram of carat (one variable)
  ggplot(diamonds, aes(carat)) +
    geom_histogram(bins = 30, fill = "salmon") +
    theme_classic() +
    labs(
      title = "Determine amount of diamonds in each carat range",
      x = "Carat",
      y = "Diamonds",
      subtitle = "Most of diamonds are available between 0.25 to 1.25 carat",
      caption = "Datasource: diamonds in ggplot2"
    )

## Chart 2 - New table + geom_col (one variable)
diamonds %>%
  mutate(carat = ifelse(diamonds$carat <= 1 , "1",
                        ifelse(diamonds$carat <= 2, "2",
                               ifelse(diamonds$carat <= 3, "3",
                                      ifelse(diamonds$carat <= 4, "4", "5"))))) %>%
           
count(carat) %>%
ggplot(aes(carat, n)) +
geom_col(fill = "salmon") +
theme_classic() +
labs(
  title = "Determine amount of diamonds in each carat 1-5 range",
  x = "Carat",
  y = "Diamonds",
  subtitle = "Most of diamonds is 1 carat",
  caption = "Datasource: diamonds in ggplot2"
)

## Chart 3 - Scatter plot and use to linear model for predicted.(two variables)
set.seed(13)
diamonds %>% 
  sample_n(10000) %>%
ggplot(aes(carat, price)) +
  geom_point(col="salmon", size=2) +
  geom_smooth(method = "lm") +
  theme_classic() +
  labs(
    title = "Relationship between price and carat",
    x = "Carat",
    y = "Price",
    subtitle = "sample size 20% describe overall data as when the carat weight higher, trend to price is increase.",
    caption = "Datasource : diamonds in ggplot2"
  )

## Chart 4 - bar plot and fill function(two variables)
ggplot(diamonds, aes(cut, fill = clarity)) +
  geom_bar(position = "fill") +
  scale_fill_manual(
    values = c("#fbb4ae",
               "#b3cde3",
               "#ccebc5",
               "#decbe4",
               "#fed9a6",
               "#a68a64",
               "#e5d8bd",
               "#fddaec")
  ) +
  theme_minimal() +
  labs(
    title = "Relationship of the quantity of diamonds're clarity in each cut category",
    x = "Cut",
    y = "Amount of diamonds",
    subtitle = "Fair cut have most I1 clarity and Ideal cut have most IF clarity",
    caption = "Datasource : diamonds in ggplot2"
  )

## Chart 5 - Joining multiple charts
c1 <- ggplot(diamonds %>% sample_frac(0.1), aes(carat)) +
  geom_histogram(bins = 15, fill = "salmon")
c2 <- ggplot(diamonds %>% sample_frac(0.1), aes(cut)) +
  geom_bar(fill = "salmon")
c3 <- ggplot(diamonds %>% sample_frac(0.1), aes(color)) +
  geom_bar(fill = "salmon")
c4 <- ggplot(diamonds %>% sample_frac(0.1), aes(clarity)) +
  geom_bar(fill = "salmon")
c5 <- ggplot(diamonds %>% sample_frac(0.1), aes(depth)) +
  geom_histogram(bins = 15, fill = "salmon")
c6 <- ggplot(diamonds %>% sample_frac(0.1), aes(table)) +
  geom_histogram(bins = 15, fill = "salmon")
c7 <- ggplot(diamonds %>% sample_frac(0.1), aes(price)) +
  geom_histogram(bins = 15, fill = "salmon")

(c2 + c3 + c4) / (c1 + c5 + c6) / c7
