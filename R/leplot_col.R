
#' Leplot_col()
#'
#'Draws undated columns graphs
#' @param a Dataframe in long format containing 3 columns: Category, variable and value. Categories are on the x axis
#' NOTE: if you don't want any labelling on the x-axis, set category to "". Useful if you only have one category, but multiple variables.
#' @param ttl Title of the graph
#' @param lh_units Units for the LHS axis
#' @param y_range Y axis range
#' @param srce Defaults to "Source: ABS"
#' @param leg Legend entries. Defaults to variable names
#' @param leg_pos Positioning of legend in cartesian coordinate format
#' @param leg_col The desired number of column of legends. Defaults to 1
#' @param y2_range Range for a second y axis
#' @param var_order Binary or character vector. Set to 1 or 2 for variables in ascending/descending order. Custom order using character vector. Must be same length as number of categories in data frame.
#' @param no_leg Binary. Set to 1 if you want to suppress the legend
#' @param rh_units Units for second y axis
#' @param nudge_rh_units Positioning of rh axis label;ling can be messy - this nudges the label left/right
#' @param rhs_var Variable to be plotted on RHS axis
#' @param colours Change the order of the colour palette. Input as numbers of the positions you want used first
#' @param stack Variables stacked into one column (1), or plotted along the axis (0). Defaults to stacked
#' @param flip Binary. Set to 1 for horizontal bar chart. Defaults to 0.
#' @param no_zero Suppresses zero line
#' @param thm Theme for the chart. Defaults to le_theme()
#'
#' @return h The graph as a list object (ggplot2)
#' @export
#'
#' @examples
#' ctry <- rep(c("AUS", 'US', "UK", "NZ"), 3)
#' yr <- c(rep("2019", 4),rep("2020", 4), rep("2021", 4))
#' m <- tibble(category = ctry, variable = yr, value = runif(12))
#' leplot_col(m, ttl = 'Tittle', lh_units = "Y-axis Unit", y_range = c(0,1.5,.3), flip = 1, stack = 0, leg_pos = c(0.9, 0.9))
#'
#' @importFrom forcats fct_reorder
leplot_col <- function(a, ttl, lh_units,
                       y_range, srce = "Source: ABS", leg = NULL,
                       leg_pos = c(0.02,0.9), leg_col = 1, y2_range = NULL,
                       var_order = NULL, no_leg = 0, rh_units = lh_units,
                       nudge_rh_units = 0, rhs_var = NULL, colours = NULL,
                       stack = 1, flip = 0, no_zero=0, thm = 'le_theme'){

  th <- ifelse(thm=='le_theme', le_theme, le_theme)

  #Some checks
  if(is.null(y2_range)){second_axis <- 0}else{second_axis <- 1}
  if(second_axis==1 & is.null(rhs_var)){stop("If you're going to have a second axis, you need to specify at least one variable as the rhs_var")}

  if(!is.null(var_order)){
    if(is.numeric(var_order)){
      if(var_order==1){
        a$category <- factor(a$category, levels = levels(fct_reorder(a$category, a$value)))
      }else if(var_order==2){
        a$category <- factor(a$category, levels = levels(fct_reorder(a$category, -a$value)))}
    }else if(is.character(var_order)) {
      if (length(var_order) != length(unique(a$category))) {
        stop("Your variable order doesn't equal the number of variables you want to plot")}
      a$category <- factor(a$category, levels = var_order)}}

  #Define the colour pallette
  le_colours <- c("#1098F7", "#392759", "#EC0868", "#6874E8", "#EE7B30", "#E43F6F")
  if(!is.null(colours)){le_colours <- c(le_colours[colours],le_colours[-colours])}

  if(second_axis==1){
    # Renaming and re-scaling the variables that are on the RHS
    # Work out the linear transformation from primary to secondary axis

    y1n <- y_range[1] #first axis min
    y2n <- y2_range[1] #second axis min
    y1x <- y_range[2] #first axis max
    y2x <- y2_range[2] #second axis max

    a2 <- (y1x*y2n-y2x*y1n)/(y2n-y2x)
    if(y2n==0){a1 <- (y1x-a2)/y2x}else{a1 <- (y1n-a2)/y2n}

    trans <- ~ (. - a2) / a1

    for (j in rhs_var){
      a$value[a$variable==j] <- a$value[a$variable==j]*a1+a2
      levels(a$variable)[levels(a$variable)==j] <- paste0(j," (RHS)")
    }
  }

  #Building the plot

  if(stack==1 & flip==1){
    h <- ggplot(a)+
      geom_col(aes(category,value,fill=variable),size=1.05833)+
      th(leg_pos, flip=1) + coord_flip() +
      labs(y="", x="",caption=srce, title=ttl, subtitle=lh_units)

  } else if(stack==1 & flip==0){
    h <- ggplot(a)+
      geom_col(aes(category,value,fill=variable),size=1.05833)+
      th(leg_pos)+
      labs(y="", caption=srce, title=ttl, subtitle=lh_units)

  } else if(stack==0 & flip ==1){
    h <- ggplot(a)+
      geom_col(aes(category,value,fill=variable),position=position_dodge(),size=1.05833)+
      th(leg_pos,flip=1)+ coord_flip() +
      labs(y="", x="", caption=srce, title=ttl, subtitle=lh_units)

  } else{
    h <- ggplot(a)+
      geom_col(aes(category,value,fill=variable),position=position_dodge(),size=1.05833)+
      th(leg_pos)+
      labs(y="", caption=srce, title=ttl, subtitle=lh_units)

  }


  if(is.null(leg)){h <- h + scale_fill_manual(values=le_colours)}else{h <- h+scale_fill_manual(values=le_colours,labels=leg)}

  if(second_axis==1){
    h <- h + scale_y_continuous(breaks=seq(y_range[1],y_range[2],y_range[3]),limits=c(y_range[1],y_range[2]),expand=c(0,0),
                                sec.axis = sec_axis(trans=trans, breaks=seq(y2_range[1],y2_range[2],y2_range[3]))) +
      annotate("text", label=rh_units, y=y_range[2], x=length(unique(a$category)) + 0.5, hjust=0.5 + nudge_rh_units, vjust=-1,
               family = ifelse(thm=='le_theme',"sans",""),
               size = ifelse(thm=='le_theme',18/2.83465, 20/2.83465),
               color = ifelse(thm=='le_theme',"#495057", "black"))
  }
  else{h <- h + scale_y_continuous(breaks=seq(y_range[1],y_range[2],y_range[3]),limits=c(y_range[1],y_range[2]),
                                   expand=c(0,0))}

  if(y_range[1] < 0 & y_range[2] > 0 & no_zero==0){
    h <- h+geom_hline(yintercept = 0,size=1,color = ifelse(thm=='le_theme',"#495057", "black"))}

  if(leg_col!=1){h <- h + guides(fill=guide_legend(ncol=leg_col))}
  if(no_leg==1){h <- h + theme(legend.position="none")}
  #if (edit == 0){h <- titles_left(h)}
  return(h)
}
