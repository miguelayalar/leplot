
<!-- README.md is generated from README.Rmd. Please edit that file -->

# leplot

<!-- badges: start -->

<!-- badges: end -->

leplot is to make charts in the Layman Economics blog style

## Installation

You can install the development version of leplot from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("miguelayalar/leplot")
```

## Example

This is a basic example:

``` r
devtools::install_github("miguelayalar/leplot")
#> Skipping install of 'leplot' from a github remote, the SHA1 (48d3bfc7) has not changed since last install.
#>   Use `force = TRUE` to force installation
library(tidyverse)
#> ── Attaching packages ─────────────────────────────────────── tidyverse 1.3.1 ──
#> ✓ ggplot2 3.3.5     ✓ purrr   0.3.4
#> ✓ tibble  3.1.6     ✓ dplyr   1.0.8
#> ✓ tidyr   1.2.0     ✓ stringr 1.4.0
#> ✓ readr   2.1.2     ✓ forcats 0.5.1
#> ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
#> x dplyr::filter() masks stats::filter()
#> x dplyr::lag()    masks stats::lag()
library(leplot)
## basic example code

economics_long %>% 
  dplyr::select(-3) %>%
  rename(value = value01) %>%
  filter(variable %in% c('psavert', 'uempmed', 'unemploy')) %>% 
  leplot_line(a =., 
              ttl = "US macro variables",
              leg = c('Savings rate', 'Median Unemployed', 'Unemployed'),
              lh_units = "%", 
              x_range = c(2004, 2016), 
              y_range = c(0, 1, 0.2),
              leg_col = 1,
              rh_units = "pct",
              nudge_rh_units = 0.2,
              rhs_var = 'uempmed',
              y2_range = c(0, 1, 0.2),
              invert_axis = 0,
              thm = 'le_theme')
#> Roboto Condensed font not found; install with hrbrthemes::import_roboto_condensed()
#> Warning: Removed 1314 row(s) containing missing values (geom_path).
```

<img src="man/figures/README-example-1.png" width="100%" />
