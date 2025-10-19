
<!-- README.md is generated from README.Rmd. Please edit that file -->

# leplot

<!-- badges: start -->

<!-- badges: end -->

A package for drawing graphs in the Layman Economics blog style

## Installation

You can install the development version of leplot with:

``` r
# install.packages("devtools")
devtools::install_github("miguelayalar/leplot")
```

## Usage

``` r
#library(leplot)
devtools::load_all()
library(tidyverse)
cols <- le_palette()
```

## Example

### Line plot:

``` r

ggplot2::economics_long %>% 
  dplyr::select(-4) %>%
  dplyr::filter(variable %in% c('psavert')) %>% 
  ggplot(aes(date, value, colour = variable)) +
  geom_line(linewidth = 1.1) +
  scale_colour_manual(values = cols) +
  labs(title = "This is a title",
       subtitle = "Personal savings rate",
       caption = "this is a caption") +
  ylab("%") +
  le_theme(rm_x_leg = TRUE) +
  theme(legend.position = "none")
```

<img src="man/figures/README-example 1-1.png" width="100%" />

### Column plot:

``` r

ctry <- rep(c("AUS", 'US', "UK", "NZ"), 3)
yr <- c(rep("2019", 4),rep("2020", 4), rep("2021", 4))

m <- data.frame(category = ctry, variable = yr, value = runif(12))

m %>% 
  ggplot(aes(category, value, fill = variable)) +
  geom_col(position = "dodge", colour = "black") +
  scale_fill_manual(values = cols) +
  coord_flip() +
  labs(title = "This is a title",
       subtitle = "This is a subtitle",
       caption = "this is a caption") +
  le_theme(rm_x_leg = TRUE, rm_y_leg = TRUE)
```

<img src="man/figures/README-example 2-1.png" width="100%" />

### Scatter plot:

``` r

ggplot2::economics %>% 
  ggplot(aes(pce, psavert)) +
  geom_point(shape = 21, fill = NA, colour = cols[1], stroke = 1) +
  labs(title = "This is a title",
       subtitle = "This is a subtitle",
       caption = "this is a caption") +
  le_theme()
```

<img src="man/figures/README-example 3-1.png" width="100%" />

### Bar plot:

``` r
specie <- c(rep("sorgho" , 4) , rep("poacee" , 4) , rep("banana" , 4) , rep("triticum" , 4))
condition <- rep(c("Normal" , "Stress" , "Nitrogen", "Other") , 4)
value <- rnorm(16 , -5 , 15)
data <- data.frame(specie,condition,value)


data <- data %>% 
  arrange(specie, rev(value)) %>% 
  dplyr::group_by(specie) %>% 
  dplyr::mutate(label_y = cumsum(value)-0.5*value)

data %>% 
  ggplot(aes(fill=condition, y=value, x=specie)) + 
  geom_bar(position="stack", stat="identity", colour = "black") +
  scale_fill_manual(values = cols) +
  facet_wrap(~condition) +
  labs(title = "This is a title",
       subtitle = "This is a subtitle",
       caption = "this is a caption") +
  le_theme(rm_x_leg = TRUE)
```

<img src="man/figures/README-example 4-1.png" width="100%" />
