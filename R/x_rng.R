#' x_rng
#'
#'Sets the x axis range to the start and end of the years specified.
#'
#' @param x A numeric vector with start and end years.
#' @param d A dataframe
#' @param FY Binary. 1 to set range in fiscal years, 0 in calendar years. Defaults to zero.
#' @param bar .
#'
#' @return
#' @export
#' @examples
#' x <- c(2004, 2016)
#' econ <- economics_long
#' (x_rng(x, econ))
#' @import tidyr
#' @import dplyr
#' @importFrom lubridate %m+%
#' @importFrom lubridate years
x_rng <- function(x,d,FY=0,bar=0){

  d_s <- drop_na(d)
  if (FY == 0) {
    m <- paste0(x[1], "-1-1")
    m2 <- paste0(x[2], "-12-31")


    if (bar == 1) {
      xs <- as.Date(m)
      xf <- d_s$date[d_s$date <=m2] %>% max(.)
      xf <- xf%m+%months(1)%m-%days(1) %>% as.Date(.)
    } else {
      xs <- d$date[d$date >= m] %>% min(.) %>% as.Date(.)
      xf <- d_s$date[d_s$date <=m2] %>% max(.) %>% as.Date(.)}
  }
  else if (FY == 1) {
    x1 <- x[1] - 1
    m <- paste0(x1, "-7-1")
    m2 <- paste0(x[2], "-6-30")
    if (bar == 1) {
      xs <- as.Date(m)
      xf <- d_s$date[d_s$date <=m2] %>% max(.)
      xf <- xf%m+%months(1)%m-%days(1) %>% as.Date(.)
    }
    else {
      xs <- d$date[d$date >= m] %>% min(.) %>% as.Date(.)
      xf <- d_s$date[d_s$date <=m2] %>% max(.) %>% as.Date(.)
    }
  }
  x_rng <- c(xs, xf)
}
