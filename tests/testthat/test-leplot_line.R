test_that("le_geomline() plots a line chart", {
  l <- ggplot2::economics_long[economics_long$variable == 'pce',][c(1,2,4)]
  names(l)[3] <- 'value'
  l_a <- le_geomline(a = l,
                     ttl = "US macro variables",
                     #leg = c('Consumption', 'Population', 'Savings rate', 'Median Unemploy', 'Unemploy'),
                     lh_units = "% pct",
                     x_range = c(2004, 2016),
                     y_range = c(0, 1, 0.2),
                     leg_col = 2,
                     #leg_pos = c(0.25, 0.88),
                     #rh_units = "pct",
                     #nudge_rh_units = 0.2,
                     #rhs_var = c('pop','pce'),
                     #y2_range = c(0, 1, 0.2),
                     invert_axis = 0,
                     thm = 'le_theme')
})
