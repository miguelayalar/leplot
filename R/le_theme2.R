
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


  theme_foundation(base_size = base_size, base_family = base_family)+
    theme(
      line = element_line(colour = "black"),
      rect = element_rect(fill = colors["Light Gray"],
                          linetype = 0, colour = NA),
      text = element_text(colour = colors["Dark Gray"]),
      axis.title = element_blank(),
      axis.text = element_text(),
      axis.ticks = element_blank(),
      axis.line = element_blank(),
      legend.background = element_rect(),
      legend.position = "bottom",
      legend.direction = "horizontal",
      legend.box = "vertical",
      panel.grid = element_line(colour = NULL),
      panel.grid.major =
        element_line(colour = colors["Medium Gray"]),
      panel.grid.minor = element_blank(),
      # unfortunately, can't mimic subtitles TODO!
      plot.title = element_text(hjust = 0, size = rel(1.5), face = "bold"),
      plot.margin = unit(c(1, 1, 1, 1), "lines"),
      strip.background = element_rect()
      )

}
