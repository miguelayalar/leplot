% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/leplot_line.R
\name{leplot_line}
\alias{leplot_line}
\title{Line}
\usage{
leplot_line(
  a,
  ttl,
  lh_units,
  x_range,
  y_range,
  x_break = "1 year",
  srce = "Source: ABS",
  leg = NULL,
  leg_pos = c(0.02, 0.9),
  leg_col = 1,
  fc = 0,
  fc_date = NULL,
  y2_range = NULL,
  thm = "le_theme",
  rh_units = lh_units,
  nudge_rh_units = 0,
  rhs_var = NULL,
  FY = 0,
  log = 0,
  hlines = NULL,
  hlinestyle = 1,
  colours = NULL,
  eventdate = NULL,
  eventlinestyle = 1,
  event = "Specify an event title",
  eventhjust = -0.02,
  x_seq = 2,
  x_format = "\%Y",
  event_ypos = y_range[2],
  ltype = rep(1, nlevels(as.factor(a$variable))),
  no_leg = 0,
  invert_axis = 0,
  no_zero = 0,
  no_forc = 0,
  var_order = NULL,
  lescale = 0.8
)
}
\arguments{
\item{a}{Dataframe in long format with 3 columns: date, variable and value.}

\item{ttl}{The text for the title.}

\item{lh_units}{The text for the LHS axis.}

\item{x_range}{Date range entered in d/m/yy format.}

\item{y_range}{Y axis range.}

\item{x_break}{Frequency of x axis ticks. Defaults to 1 year.}

\item{srce}{Defaults to "Source: ABS".}

\item{leg}{Legend entries. Defaults to variable names.}

\item{leg_pos}{Positioning of legend in cartesian coordinate format.}

\item{leg_col}{Number of columns in the legend. Defaults to 1.}

\item{fc}{Adds a forecast line. FC==1 or FC==2 places forecast label next to, or above forecast line respectively.}

\item{fc_date}{Date at which the forecast line appears.}

\item{y2_range}{Range for a second y axis.}

\item{thm}{Chart theme - function that defines style of chart. Defaults to Layman Economics theme.}

\item{rh_units}{Units for second y axis.}

\item{nudge_rh_units}{Positioning of RH axis labeling can be messy - this nudges the label left/right.}

\item{rhs_var}{Variable to be plotted on RHS axis.}

\item{FY}{X axis in financial years (defaults to CY).}

\item{log}{Log scale graph. Uses natural log transformation. Y-axis breaks defined by doubling the lower value in y_range. If min(y_range)==0, guesses bottom of new y_range based on the specified y_axis interval.}

\item{hlines}{Horizontal lines you want added to the chart.}

\item{hlinestyle}{The style of the horizontal lines. Defaults to solid. Use numbers to define alternate styles i.e. 2 = dashed.}

\item{colours}{Change the order of the colour palette. Input as numbers of the positions you want used first.}

\item{eventdate}{Vertical line to signify a date 'event'  N.B. multiple events can be plotted by concatenating dates/labels etc.}

\item{eventlinestyle}{The style of the vertical lines. Defaults to solid. "dashed" is a valid entry.}

\item{event}{Text for your event.}

\item{eventhjust}{Nudge to event label left/right.}

\item{x_seq}{Frequency of labels on ticks. Defaults to every third tick.}

\item{x_format}{Date format on x axis. Defaults to YYYY.}

\item{event_ypos}{Where the event label shows up on the y_axis (defaults to top of range).}

\item{ltype}{Change manually the appearance of lines using a vector of line type for each line. Use numbers to define alternate types (2 = dashed). Line types available are “blank”, “solid”, “dashed”, “dotted”, “dotdash”, “longdash”, “twodash”.}

\item{no_leg}{Binary. Set to 1 if you want to suppress the legend.}

\item{invert_axis}{Allows you to invert the LHS axis (only when two axes are specified). Can only invert the LHS axis for now. rhs_var variables will not be inverted, all others will. You need to be careful how the legend is specified. You may also need to re-install the ggplot package (previous versions had a bug).}

\item{no_zero}{Suppresses zero line.}

\item{no_forc}{Suppresses the automated forecast line.}

\item{var_order}{Custom order of variables to plot. Specify ALL variables by name is required.}
}
\value{

}
\description{
leplot_line() creates a dated line chart
}
\examples{
\donttest{le_geomline(x,"Current Account","\%, share of GDP",c(2000,2023),c(-10,4,2),fc=1,fc_date='1/3/2019')}

\donttest{le_geomline(x,"Retail Turnover & Consumer Confidence","\%, year-ended growth",c(2000,2019),c(0,12,2),y2_range=c(80,140,10),rh_units="Index",rhs_var="ausvcc")}
}
