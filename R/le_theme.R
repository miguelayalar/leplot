#' Define the theme of Layman Economics blog
#'
#'Sets chart borders, font, title size and positioning for html publications
#'
#' @param scale Size of legend text and title.
#' @param rm_x_leg logical value indicating whether x label be removed from chart
#' @param rm_y_leg logical value indicating whether y label be removed from chart
#'
#' @export
#'
#' @examples
#' library(ggplot2)
#' ggplot(mtcars, aes(wt, mpg)) +
#'   geom_point() +
#'   le_theme()
#'@import ggplot2
#'@import ggthemes

le_theme <- function(scale = 0.8,
                     rm_x_leg = FALSE,
                     rm_y_leg = FALSE){

  if (rm_x_leg == TRUE) {
    x_leg <- element_blank()

  }else{x_leg <- element_text(
    margin = margin(t=0.22*scale, r=0, b=-0.1*scale, l=0.15*scale, unit = "cm")
    )
  }

  if (rm_y_leg == TRUE) {
    y_leg <- element_blank()

  }else{y_leg <- element_text(
    angle = 90,
    margin = margin(t=0, r=0, b=-0.1*scale, l=0.05*scale, unit = "cm")
    )
  }


  theme_foundation(base_size = 14, base_family = "sans") +

    theme(
      text = element_text(colour = '#3C3C3C'),
      line = element_line(colour = "black", linewidth = 1*scale),
      rect = element_rect(fill = "#F0F0F0", linetype = 0, colour = NA),

      axis.title.y.left = y_leg,

      axis.title.y.right = element_text(

        angle = 0,
        vjust = 1.08,
        hjust = 0,
        margin = margin(t=0, r=0, b=0, l=-1.5*scale, unit = "cm"),
        size = 18*scale
        ),

      axis.title.x = x_leg,

      axis.ticks = element_blank(),

      axis.text = element_text(
        angle = 0,
        colour="#495057",
        size=18*scale
        ),

      axis.text.x = element_text(
        margin = margin(t = 0.35 * scale, r = 0.35 * scale, b = 0, l = 0.5 * scale, unit = "cm")
        ),

      axis.text.y = element_text(
        margin = margin(t = 0.5 * scale, r = 0.35 * scale, b = 0.5 * scale, l = 0.5 * scale, unit = "cm")),

      axis.text.y.right = element_text(
        margin = margin(t = 0.5 * scale, r = 0.5 * scale, b = 0.5 * scale, l = 0.35 * scale, unit = "cm")),

      axis.line = element_blank(),

      legend.key = element_rect(colour=NA, fill=NA),

      legend.margin = margin(0,0,0,0),

      legend.text = element_text(size = 18*scale),

      legend.title = element_blank(),

      legend.background = element_rect(),

      legend.spacing.x = unit(0,'cm'),

      legend.spacing.y = unit(0,'cm'),

      plot.title = element_text(
        margin = margin(t = 0.2 * scale, r = 0, b = 0.15 * scale, l = 0, unit = "cm"),
        size=24*scale,
        hjust=0.0,
        face = 'bold',
        colour = "#000000"
        ),

      plot.subtitle = element_text(
        hjust = 0.0,
        margin = margin(t = 0.15 * scale, r = 0, b = 0.5 * scale, l = 0, unit = "cm"),
        size = 18*scale
        ),

      plot.caption = element_text(
        hjust=0.0,
        size=14*scale,
        margin = margin(t = 0.25 * scale, r = 0, b = 0.15 * scale, l = 0, unit = "cm")
        ),

      plot.caption.position = "plot",

      plot.title.position = "plot",

      legend.position = "bottom",

      legend.direction = "horizontal",

      legend.box = "vertical",

      panel.grid = element_line(colour = NULL),

      panel.grid.major = element_line(colour = "#D2D2D2"),

      panel.grid.minor = element_blank(),

      plot.margin = unit(c(1, 1, 1, 1), "lines"),

      strip.background = element_rect()
    )
}
