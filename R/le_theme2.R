
le_theme2 <- function(text_size = 12,
                            leg_pos = c(0.9, 0.9),lescale = 0.8) {
  suppressMessages(extrafont::loadfonts())
  titillium_present <- "Titillium Web" %in% extrafont::fonts()

  if (!titillium_present) {
    message("Roboto Condensed font not found; install with hrbrthemes::import_titillium_web()")
    font <- "sans"
  } else {
    font <- "Titillium Web"
  }


  theme_foundation(base_size = 12, base_family = "sans")+
    theme(
      line = element_line(colour = "black"),
      rect = element_rect(fill = "#F0F0F0",#light gray
                          linetype = 0, colour = NA),
      text = element_text(colour = "#3C3C3C"), #dark gray
      axis.title = element_blank(),
      axis.text = element_text(),
      axis.text.y.right= element_text(margin=unit(c(0.5,0.5,0.5,0.35)*lescale, "cm")),
      axis.ticks = element_blank(),
      axis.line = element_blank(),
      legend.background = element_rect(),
      legend.position = "bottom",
      legend.direction = "horizontal",
      legend.box = "vertical",
      panel.grid = element_line(colour = NULL),
      panel.grid.major =
        element_line(colour = "#D2D2D2"),
      panel.grid.minor = element_blank(),
      # unfortunately, can't mimic subtitles TODO!
      plot.title = element_text(hjust = 0, size = rel(1.5), face = "bold"),
      plot.margin = margin(0,10,0,5)*lescale,
      strip.background = element_rect()
      )

}
