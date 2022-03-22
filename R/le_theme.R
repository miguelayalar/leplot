#' Define the theme of Layman Economics blog
#'
#'Sets chart borders, font, title size and positioning for html publications
#'
#' @param leg_pos Legend position
#' @param lescale Size of legend text and title. Plot title is text size * 1
#' @param flip Binary to flip margins
#'
#' @return
#' @export
#'
#' @examples
#' library(ggplot2)
#' ggplot(mtcars, aes(wt, mpg)) +
#'   geom_point() +
#'   le_theme()
#'@import ggplot2
#'@import cowplot
le_theme <- function(leg_pos = c(0.9,0.9),lescale=1,flip=0){
  supressMessges(extrafont::loadfonts())
  segoeui_present <- "Segoe UI" %in% extrafont::fonts()

  if (!segoeui_present) {
    message("Segoe UI font not found; install with extrafont::font_import(prompt = FALSE, pattern = 'Segoe UI')")
    font <- "sans"
  } else {
    font <- "Segoe UI"
  }

  if(flip==1){pm <- margin(0,30,0,5)*lescale}else{pm <- margin(0,10,0,5)*lescale}

  theme_cowplot() %+replace%

    theme(text = element_text(angle=0,
                              size = 20*lescale,
                              face="plain",
                              colour= "#495057",
                              family = font),
          line = element_line(colour="#495057",size=1*lescale),

          axis.title.y.left = element_text(angle = 0,margin=unit(c(0,-1.3,0,0.75)*lescale, "cm")),
          axis.title.y.right = element_text(angle=0,vjust=1,hjust=0,margin=unit(c(0,0,0,-2.5)*lescale, "cm")),
          axis.title.x =element_blank(),

          axis.ticks = element_line(size=1*lescale, colour= "#495057"),
          axis.ticks.length=unit(0.15*lescale, "cm"),

          axis.text = element_text(angle = 0,colour="#495057",size=18*lescale),
          axis.text.x = element_text(margin=unit(c(0.35,0.35,0,0.5)*lescale, "cm")),
          axis.text.y = element_text(margin=unit(c(0.5,0.35,0.5,0.5)*lescale, "cm")),
          axis.text.y.right= element_text(margin=unit(c(0.5,0.5,0.5,0.35)*lescale, "cm")),

          axis.line.x = element_line(size=1*lescale, colour= "#495057"),
          axis.line.y = element_line(size=1*lescale, colour= "#495057"),

          legend.key = element_rect(colour=NA, fill=NA),
          legend.margin = margin(0,0,0,0),
          legend.text = element_text(size = 18*lescale),
          legend.title = element_blank(),
          legend.background = element_rect(fill=alpha('white', 0)),
          legend.spacing.x = unit(0,'cm'),
          legend.spacing.y = unit(0,'cm'),
          legend.position=leg_pos,

          plot.title = element_text(margin=unit(c(0.2,0,0.15,0)*lescale,"cm"),size=24*lescale, hjust=0.0, face = 'plain'),
          plot.subtitle=element_text(hjust=0.0,margin=unit(c(0.15,0,0.5,0)*lescale,"cm"),size=18*lescale),
          plot.caption=element_text(hjust=0.0,size=16*lescale,margin=unit(c(0,0,0.15,0)*lescale,"cm")),
          plot.margin = pm,

          panel.background = element_rect(fill = "white")
    )
}
