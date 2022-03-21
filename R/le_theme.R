#le_theme

#Sets chart borders, font, title size and positioning for html publications


le_theme <- function(leg_pos,lescale=1,flip=0){

  if(flip==1){pm <- margin(0,30,0,5)*lescale}else{pm <- margin(0,10,0,5)*lescale}

  theme_cowplot() %+replace%

    theme(text = element_text(angle=0,
                              size = 20*lescale,
                              face="plain",
                              colour= "#495057",
                              family = "Segoe UI"),
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
