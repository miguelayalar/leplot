test_that("le_theme works", {
  p <- ggplot(mtcars, aes(wt, mpg)) + geom_point()

  p_le <- p + le_theme()

  expect_s3_class(p_le,
                  "gg")
  expect_s3_class(le_theme(),
                  "theme")

  vdiffr::expect_doppelganger("Basic le_theme() plot",
                              p_le)
})
