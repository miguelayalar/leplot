
le_theme2 <- function(text_size = 12,
                            leg_pos = c(0.9, 0.9)) {
  suppressMessages(extrafont::loadfonts())
  titillium_present <- "Titillium Web" %in% extrafont::fonts()

  if (!titillium_present) {
    message("Roboto Condensed font not found; install with hrbrthemes::import_titillium_web()")
    font <- "sans"
  } else {
    font <- "Titillium Web"
  }


  hrbrthemes::theme_ipsum_tw(base_family = font,
                             grid = FALSE) +
    theme(
      axis.line = element_line(colour = "black"),
      legend.position = legend.position,
      legend.text = element_text(
        size = text_size,
        color = "black"
      ),
      legend.title = element_text(size = text_size),
      plot.title = element_text(
        size = text_size * 2,
        color = "black"
      )
    )
}
