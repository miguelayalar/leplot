
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

This is a basic example which shows you how to solve a common problem:

``` r
devtools::install_github("miguelayalar/leplot")
#> Downloading GitHub repo miguelayalar/leplot@HEAD
#> 
#> * checking for file ‘/private/var/folders/t7/rpfm2__n6r939snv6vql2v9w0000gn/T/RtmpPinUVF/remotes9f12367fbe6d/miguelayalar-leplot-438da28/DESCRIPTION’ ... OK
#> * preparing ‘leplot’:
#> * checking DESCRIPTION meta-information ... OK
#> * checking for LF line-endings in source and make files and shell scripts
#> * checking for empty or unneeded directories
#> * building ‘leplot_0.0.0.9000.tar.gz’
#> Installing package into '/private/var/folders/t7/rpfm2__n6r939snv6vql2v9w0000gn/T/RtmpZoQuo9/temp_libpath63c42f72eb9'
#> (as 'lib' is unspecified)
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
  le_geomline(a =., 
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
