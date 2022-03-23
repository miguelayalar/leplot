test_that("x_range() converts numeric into date class", {
  expect_equal(x_rng(c(2004, 2016), ggplot2::economics_long), c("2004-01-01","2015-04-01"))

})

test_that("x_range() errors if input lenght > 2", {
  expect_error(x_rng(c(2004, 2016), ggplot2::economics_long), ",")

})
