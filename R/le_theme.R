#' Define the theme of Layman Economics blog
#'
#'Sets chart borders, font, title size and positioning for html publications
#'
#' @param leg_pos Legend position
#' @param scale Size of legend text and title. Plot title is text size * 1
#' @param flip Binary to flip margins
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
#'@importFrom extrafont fonts

le_theme <- function(scale = 0.8, flip = 0,
                     rm_x_leg = FALSE, rm_y_leg = FALSE){

  if(flip==1){pm <- margin(0,30,0,5)*scale}else{pm <- margin(0,10,0,5)*scale}

  if (rm_x_leg == TRUE) {
    x_leg <- element_blank()
  }else{x_leg <- element_text(margin=unit(c(0,-0.1,0,0.75)*scale, "cm"))
  }

  if (rm_y_leg == TRUE) {
    y_leg <- element_blank()
  }else{y_leg <- element_text(angle = 90,margin=unit(c(0,-0.1,0,0.75)*scale, "cm"))
  }


  theme_foundation(base_size = 14, base_family = "sans") +

    theme(text = element_text(
                              colour = '#3C3C3C',#Dark Gray
                              ),
          line = element_line(colour = "black", linewidth = 1*scale),
          rect = element_rect(fill = "#F0F0F0",
                             linetype = 0, colour = NA),

          axis.title.y.left = y_leg,
          axis.title.y.right = element_text(angle=0,vjust=1.08,hjust=0,margin=unit(c(0,0,0,-1.5)*scale, "cm"), size=18*scale),
          axis.title.x = x_leg,

          axis.ticks = element_blank(),

          axis.text = element_text(angle = 0,colour="#495057",size=18*scale),
          axis.text.x = element_text(margin=unit(c(0.35,0.35,0,0.5)*scale, "cm")),
          axis.text.y = element_text(margin=unit(c(0.5,0.35,0.5,0.5)*scale, "cm")),
          axis.text.y.right= element_text(margin=unit(c(0.5,0.5,0.5,0.35)*scale, "cm")),

          axis.line = element_blank(),

          legend.key = element_rect(colour=NA, fill=NA),
          legend.margin = margin(0,0,0,0),
          legend.text = element_text(size = 18*scale),
          legend.title = element_blank(),
          legend.background = element_rect(),
          legend.spacing.x = unit(0,'cm'),
          legend.spacing.y = unit(0,'cm'),

          plot.title = element_text(margin=unit(c(0.2,0,0.15,0)*scale,"cm"),size=24*scale, hjust=0.0, face = 'bold'),
          plot.subtitle = element_text(hjust=0.0,margin=unit(c(0.15,0,0.5,0)*scale,"cm"),size=18*scale),
          plot.caption = element_text(hjust=0.0,size=14*scale,margin=unit(c(0.25,0,0.15,0)*scale,"cm")),
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
