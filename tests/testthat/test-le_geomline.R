test_that("le_geomline works", {
  l <- economics_long[1:3]
  l_a <- le_geomline(l, ttl = "US macro variables",
                     "%", c("2004/1/1", "2016/12/1"), c(0, 9, 2),
                     leg = c("x", "y"),
                     leg_pos = c(0.25, 0.88), thm = 'le_theme')
})
