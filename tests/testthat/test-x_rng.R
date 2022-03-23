test_that("x_range works", {
  x_range <- c(2004, 2016)
  a <- economics
  FY <- 0
  x_rng(x_range,a,FY)
})
