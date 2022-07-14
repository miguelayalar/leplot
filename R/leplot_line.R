#' Line
#'
#' leplot_line() creates a dated line chart
#'
#' @param a Dataframe in long format with 3 columns: date, variable and value.
#' @param ttl The text for the title.
#' @param lh_units The text for the LHS axis.
#' @param x_range Date range entered in d/m/yy format.
#' @param y_range Y axis range.
#' @param x_break Frequency of x axis ticks. Defaults to 1 year.
#' @param srce Defaults to "Source: ABS".
#' @param leg Legend entries. Defaults to variable names.
#' @param leg_pos Positioning of legend in cartesian coordinate format.
#' @param leg_col Number of columns in the legend. Defaults to 1.
#' @param fc Adds a forecast line. FC==1 or FC==2 places forecast label next to, or above forecast line respectively.
#' @param fc_date Date at which the forecast line appears.
#' @param y2_range Range for a second y axis.
#' @param thm Chart theme - function that defines style of chart. Defaults to Layman Economics theme.
#' @param rh_units Units for second y axis.
#' @param nudge_rh_units Positioning of RH axis labeling can be messy - this nudges the label left/right.
#' @param rhs_var Variable to be plotted on RHS axis.
#' @param FY X axis in financial years (defaults to CY).
#' @param log Log scale graph. Uses natural log transformation. Y-axis breaks defined by doubling the lower value in y_range. If min(y_range)==0, guesses bottom of new y_range based on the specified y_axis interval.
#' @param hlines Horizontal lines you want added to the chart.
#' @param hlinestyle The style of the horizontal lines. Defaults to solid. Use numbers to define alternate styles i.e. 2 = dashed.
#' @param colours Change the order of the colour palette. Input as numbers of the positions you want used first.
#' @param eventdate Vertical line to signify a date 'event'  N.B. multiple events can be plotted by concatenating dates/labels etc.
#' @param eventlinestyle The style of the vertical lines. Defaults to solid. "dashed" is a valid entry.
#' @param event Text for your event.
#' @param eventhjust Nudge to event label left/right.
#' @param x_seq Frequency of labels on ticks. Defaults to every third tick.
#' @param x_format Date format on x axis. Defaults to YYYY.
#' @param event_ypos Where the event label shows up on the y_axis (defaults to top of range).
#' @param ltype Change manually the appearance of lines using a vector of line type for each line. Use numbers to define alternate types (2 = dashed). Line types available are “blank”, “solid”, “dashed”, “dotted”, “dotdash”, “longdash”, “twodash”.
#' @param no_leg Binary. Set to 1 if you want to suppress the legend.
#' @param invert_axis Allows you to invert the LHS axis (only when two axes are specified). Can only invert the LHS axis for now. rhs_var variables will not be inverted, all others will. You need to be careful how the legend is specified. You may also need to re-install the ggplot package (previous versions had a bug).
#' @param no_zero Suppresses zero line.
#' @param no_forc Suppresses the automated forecast line.
#' @param var_order Custom order of variables to plot. Specify ALL variables by name is required.
#'
#'
#' @return
#' @export
#'
#' @examples
#'\donttest{le_geomline(x,"Current Account","%, share of GDP",c(2000,2023),c(-10,4,2),fc=1,fc_date='1/3/2019')}
#'
#' \donttest{le_geomline(x,"Retail Turnover & Consumer Confidence","%, year-ended growth",c(2000,2019),c(0,12,2),y2_range=c(80,140,10),rh_units="Index",rhs_var="ausvcc")}
#' @import tidyr
#' @import dplyr
#' @importFrom rlang is_empty
#' @importFrom lubridate %m+%
#' @importFrom lubridate years
#' @importFrom rlang .data
leplot_line <- function(a, ttl, lh_units,
                        x_range, y_range, x_break="1 year",
                        srce="Source: ABS", leg=NULL, leg_pos=c(0.02,0.9),
                        leg_col=1, fc=0, fc_date=NULL,
                        y2_range=NULL, thm = 'le_theme', rh_units=lh_units,
                        nudge_rh_units=0, rhs_var=NULL, FY=0,
                        log=0, hlines=NULL, hlinestyle=1,
                        colours=NULL, eventdate=NULL, eventlinestyle=1,
                        event="Specify an event title", eventhjust=-0.02, x_seq=2,
                        x_format="%Y", event_ypos=y_range[2], ltype=rep(1,nlevels(as.factor(a$variable))),
                        no_leg=0, invert_axis=0, no_zero=0,
                        no_forc=0, var_order=NULL, lescale=.8){

  th <- ifelse(thm=='le_theme',le_theme, le_theme2)
  #Some checks
  if(fc==1 & is.null(fc_date)){stop("If you're going to have a forecast line, you need to specify the forecast date")}
  if(is.null(y2_range)){second_axis <- 0}else{second_axis <- 1}
  if(second_axis==1 & is.null(rhs_var)){stop("If you're going to have a second axis, you need to specify at least one variable as the rhs_var")}
  if(invert_axis==1){y2_range[1:2] <- rev(y2_range[1:2])
  y2_range[3] <- -y2_range[3]}
  #Define the colour pallette
  le_colours <- c("#1098F7", "#392759", "#EC0868", "#6874E8", "#EE7B30", "#E43F6F")
  if(!is.null(colours)){le_colours <- c(le_colours[colours],le_colours[-colours])}

  #Defining y-axis breaks for log scale charts
  if(log==1){
    m <- y_range[1]
    if(m==0){m=floor(y_range[3]/2)}
    x <- y_range[2]
    temp <- m*2
    lseq <- c(m,temp)
    while(temp<x){temp <- temp*2
    lseq <- c(lseq,temp)}
    lh_units <- paste0(lh_units,", log scale")}

  if(second_axis==1){
    # Renaming and rescaling the variables that are on the RHS

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
  #Defining the x axis range
  if(is.numeric(x_range)){
    x_range <- x_rng(x_range,a,FY)} else {
      x_range <- as.Date(x_range,"%d/%m/%Y")
    }

  #If no forecast line is selected, this checks whether data from model are being plotted, and automates a forecast line
  if(fc==0 & exists('h_end') & no_forc==0){
    dts <-h_end[which(h_end$variable %in% unique(a$variable)),]
    if(!is_empty(dts$hist_end)){
      md <- min(dts$hist_end)
      aa <- drop_na(select(a,date,variable,value))
      if(!is.na(md) & md < x_range[2] & md < max(aa$date)){
        fc=2
        fc_date=md}}}

  #The sequence for ticks and labels on the x-axis
  b_seq <- seq.Date(x_range[1],x_range[2],x_break)
  if(FY==0){l_seq <- as.character(b_seq,x_format)} else {l_seq <- as.character(b_seq %m+% years(1),x_format)}
  #l_seq[c(FALSE,rep(TRUE,x_seq-1))] <- ""

  if(!is.null(var_order)){a$variable <- factor(a$variable,levels=var_order)
  if(length(var_order)!=length(unique(droplevels(a$variable)))){stop("Your variable order doesn't equal the number of variables you want to plot")}
  }

  #Building the plot

  h <- ggplot(a,aes(x=date, y=value, group=variable)) +

    geom_line(aes(colour=variable,linetype=variable),size=1.05833*lescale)+

    th(leg_pos,lescale)+

    scale_x_date(breaks=b_seq,labels=l_seq,limits=x_range[1:2],expand=c(0,0))+

    scale_linetype_manual(values=ltype,guide = "none") +

    labs(y="",caption = srce, title = ttl, subtitle = lh_units)

  if(is.null(leg)){
    h <- h+scale_colour_manual(values=le_colours)
  }else{
    h <- h+scale_colour_manual(values=le_colours,labels=leg)}

  if(second_axis==1){
    if(invert_axis==1){
      h <- h+ scale_y_continuous(trans='reverse', breaks = seq(y_range[1],y_range[2],y_range[3]),
                                 limits = c(y_range[2],y_range[1]),expand=c(0,0),
                                 sec.axis = sec_axis(trans=trans,breaks=seq(y2_range[1],y2_range[2],y2_range[3]))) +
        annotate("text",label=rh_units,y=y_range[1],x=x_range[2],hjust=0.5+nudge_rh_units,vjust=-1,
                 family = ifelse(thm=='le_theme',"sans",""),
                 size = ifelse(thm=='le_theme',18/2.83465, 20/2.83465*lescale),
                 color = ifelse(thm=='le_theme',"#495057", "black"))}
    else{
      h <- h + scale_y_continuous(breaks = seq(y_range[1],y_range[2],y_range[3]), limits=c(y_range[1],y_range[2]), expand=c(0,0),
                                 sec.axis = sec_axis(trans = trans,
                                                     breaks = seq(y2_range[1],y2_range[2],y2_range[3]),
                                                     name = rh_units))
      #+
      #  annotate("text",label=rh_units,y=y_range[2],x=x_range[2],hjust=0.5+nudge_rh_units,vjust=-1,
      #           family = ifelse(thm=='le_theme',"sans","sans"),
      #           size = ifelse(thm=='le_theme',18/2.83465, 20/2.83465*lescale),
      #           color = ifelse(thm=='le_theme',"#495057", "black"))
      }}
  else{
    if(log==1){
      h <- h+ scale_y_continuous(trans="log",breaks=lseq,limits=c(lseq[1],lseq[length(lseq)]),expand=c(0,0))}
    else{
      h <- h+ scale_y_continuous(breaks=seq(y_range[1],y_range[2],y_range[3]),limits=c(y_range[1],y_range[2]),expand=c(0,0))}}


  if(fc==1){
    h <- h+geom_vline(xintercept = as.numeric(as.Date(fc_date,"%d/%m/%Y")),size=1*lescale,
                      color = ifelse(thm=='le_theme',"#495057", "black")) +
      annotate("text",label="Forecast",y=ifelse(invert_axis==0,y_range[2],y_range[1]),x=as.Date(fc_date,"%d/%m/%Y"),hjust=-0.05,vjust=1,
               family = ifelse(thm=='le_theme',"sans",""),
               size = ifelse(thm=='le_theme',18/2.83465, 20/2.83465*lescale),
               color = ifelse(thm=='le_theme',"#495057", "black"))

  }else
    if(fc==2){h <- h+geom_vline(xintercept = as.numeric(as.Date(fc_date,"%d/%m/%Y")),size=1*lescale,
                                color = ifelse(thm=='le_theme',"#495057", "black")) +
      annotate("label",label="Forecast",label.size=0,y=ifelse(invert_axis==0,y_range[2],y_range[1]),x=as.Date(fc_date,"%d/%m/%Y"),hjust=0.5,vjust=0.5,
               family = ifelse(thm=='le_theme',"sans",""),
               size = ifelse(thm=='le_theme',18/2.83465, 20/2.83465*lescale),
               color = ifelse(thm=='le_theme',"#495057", "black"))
    }

  if(y_range[1]<0 & y_range[2]>0 & no_zero==0){
    h <- h+geom_hline(yintercept = 0,size=1*lescale,color = ifelse(thm=='le_theme',"#495057", "black"))}

  if(leg_col!=1){h <- h+guides(col=guide_legend(ncol=leg_col))}

  if(FY==1){
    h <- h+annotate("text",label="FY",y=y_range[1],x=x_range[2],hjust=1,vjust=3.2,
                    family = ifelse(thm=='le_theme',"sans",""),
                    size = ifelse(thm=='le_theme',18/2.83465, 20/2.83465*lescale),
                    color = ifelse(thm=='le_theme',"#495057", "black"))}

  if(!is.null(hlines)){h <- h+geom_hline(yintercept=hlines,size=1*lescale,linetype=hlinestyle,
                                         color = ifelse(thm=='le_theme',"#495057", "black"))}

  if(!is.null(eventdate)){h <- h+geom_vline(xintercept = as.numeric(as.Date(eventdate,"%d/%m/%Y")),
                                            size=1*lescale,linetype=eventlinestyle,
                                            color = ifelse(thm=='le_theme',"#495057", "black")) +
    # annotate("text",label=event,event_ypos,x=as.Date(eventdate,"%d/%m/%Y"),size=20/2.83465,hjust=eventhjust,vjust=1)}
    annotate("text",label=event,event_ypos,x=as.Date(eventdate,"%d/%m/%Y"),
             hjust=eventhjust,vjust=1,
             family = ifelse(thm=='le_theme',"sans",""),
             size = ifelse(thm=='le_theme',18/2.83465, 20/2.83465*lescale),
             color = ifelse(thm=='le_theme',"#495057", "black"))}

  if(no_leg==1){h <- h+theme(legend.position="none")}

  #if(edit==0){h <- titles_left(h)}

  return(h)

}
