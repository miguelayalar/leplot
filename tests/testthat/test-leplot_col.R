test_that("leplot_col draws a column chart", {

  library(tibble)

  ctry <- rep(c("AUS", 'US', "UK", "NZ"), 3)
  yr <- c(rep("2019", 4),rep("2020", 4), rep("2021", 4))

  m <- tibble(category = ctry, variable = yr, value = runif(12))

  leplot_col(m, ttl = 'Tittle',
                          lh_units = "ylab",
                          y_range = c(0,1.5,.3),
                          flip = 1, stack = 0,
                          leg_pos = c(0.9, 0.9))
})
