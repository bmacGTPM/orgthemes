library(tidyverse)
library(scales)

## define colors
snred         = rgb(200,  20,  40, max=255) ## red for highlighted data
snlightred    = rgb(230, 140, 140, max=255) ## red for background data
sndarkgray    = rgb( 30,  30,  30, max=255) ## gray for highlighted data (dark)
snmediumgray  = rgb(135, 135, 135, max=255) ## medium gray for subtitle and caption
snlightgray   = rgb(210, 210, 210, max=255) ## gray for background data
sntextgray    = rgb(100, 100, 100, max=255) ## dark gray for text
snbackgray    = rgb(240, 240, 240, max=255) ## very light gray for image background
snblue        = rgb(  5, 140, 200, max=255) ## blue for highlighted data
snlightblue   = rgb(130, 180, 210, max=255) ## blue for background data
default.pal = c(snred, snblue, sntextgray,  snlightred, snlightblue)

## CMU colors
## Copied images here https://www.cmu.edu/brand/brand-guidelines/visual-identity/colors.html
## And opened in MSPaint, color picker, Edit Colors.
## The CMYK values look wrong on the website.
## I should maybe move these elsewhere at some point.
cmured        = rgb(196,  18,  48, max=255)
cmumediumgray = rgb(110, 110, 110, max=255)
cmulightgray  = rgb(190, 190, 190, max=255)
cmublue       = rgb(  4,  54, 115, max=255)
cmulightblue  = rgb(  0, 139, 192, max=255)
cmurose       = rgb(239,  58,  71, max=255)
cmugold       = rgb(253, 181,  21, max=255)
cmugreen      = rgb(  0, 150,  71, max=255)
cmuteal       = rgb(  0, 143, 145, max=255)
cmu.pal = c(cmured, cmublue, cmumediumgray, cmulightgray, cmulightblue, cmugold, cmugreen, cmurose, cmuteal)

## colorblind friendly color palette
## from https://jacksonlab.agronomy.wisc.edu/2016/05/23/15-level-colorblind-friendly-palette/
cb14 =  c("#000000","#004949","#009292","#ff6db6","#ffb6db",
            "#490092","#006ddb","#b66dff","#6db6ff","#b6dbff",
            "#920000","#924900","#db6d00","#24ff24","#ffff6d")
cb14[15] = 'lightgray' ## replace the yellow with gray, since yellow is almost impossible to see.
cb14 = cb14[-2] ## remove this since it is so close to the next one

#' A ggplot theme
#'
#' A ggplot theme for making publication quality visualizations with options for organization-specific colors and logos.
#' @param type Text indicating the type of plot the theme is being used for.  Supported types are currently 'line', 'bar', 'hist', 'grid', 'scatter' which can be used for plots with `geom_line`, `geom_bar`, `geo_histogram`, `geom_tile`, and `geom_point`.  Other plot types will be added later.
#' @param base_size base font size, given in pts. For saving images, 36 is required. For viewing in RStudio, something much smaller like 36/3 = 12 (the default) is recommended.
#' @param base_family base font family.  The default is `'sans'`, which is available cross-platform by default.
#' @param base_line_size base size for line elements. Default is `base_size*.35/36`, and should typically not be changed.
#' @param base_rect_size base size for rect elements. Default is `base_size*.35/36`, and should typically not be changed.
#' @param facet Indicates whether or not `facet_wrap` or `facet_grid` are being used for this plot.  The default is `facet=FALSE`.
#' @param colors Choose the color palette. The default, colors='default", is reds, blues and grays commonly used in journalism.  'cb14' is a colorblind friendly palette with 14 colors. Choosing 'yourorgname' will use specific reds, blues, and grays from the organizations color palette, if they have been implement.
#' @return When used in conjunction with ggplot, it returns a plot formatted using the sn theme.
#' @examples
#'
#' library(themesn)
#'
#' ## Scatter plot example
#' dg = mtcars %>% select(wt, mpg)
#' title = "Title in Upper Lower" ## to be used by ggplot and ggsave
#' g = ggplot(dg, aes(x=wt, y=mpg))+
#'   geom_point(color=snred)+
#'   labs(title    = title,
#'        subtitle = 'Optional Subtitle In Upper Lower',
#'        caption  = "Optional caption, giving additional info or twitter handle",
#'        x = 'Horizontal Axis Label in Upper Lower',
#'        y = 'Vertical Axis Label in Upper Lower')+
#'   scale_x_continuous(limits=c(0, 6), breaks=c(0, 3, 6), oob=squish)+
#'   scale_y_continuous(limits=c(0,40), breaks=c(0,20,40), oob=squish)+
#'   coord_cartesian(clip='off', expand=FALSE)+
#'   theme_sn(type='scatter', base_size = 36/3) ## use 36/3=12 in RStudio, use 36 to save as image
#' print(g)
#'
#' ## Use `ggsave` and `base_size=36` when saving an image.
#' ## Do not adjust the width. Height can be adjusted if desired.
#' ## A square image is often preferred, so when in doubt, keep height at 20.
#' ggsave(filename=paste0("img/", gsub("%", " Perc", title), ".jpg"), ## must have a subfolder called 'img'
#'        plot=g + theme_sn(type='scatter', base_size=36),
#'        width=20,   ## do not change
#'        height=20,  ## can change if desired. In most cases, a square figure (height=20) is probably preferred.
#'        units='in', ## do not change
#'        dpi=72)     ## do not change
#'
#' ## Line plot
#' dg = economics_long
#'
#' ## Since "name" and "value" will be more common column names
#' ## when using these in the wild, rename some columns in this example.
#' ## Continuous variables for x seem to be more common,
#' ## so convert date to days for this example
#' dg = dg %>%
#'   mutate(name = toupper(variable), ## avoid using all lowercase letters in a legend
#'          days = as.numeric(date - min(date)), ## convert date to a continuous variable in days
#'          value= value01) %>%
#'   select(days, name, value)
#' head(dg)
#'
#' title = "Title in Upper Lower" ## to be used by ggplot and ggsave
#' g = ggplot(dg, aes(x=days, y=value, color=name))+
#'   geom_line()+
#'   labs(title    = title,
#'        subtitle = 'Optional Subtitle In Upper Lower',
#'        caption  = "Optional caption, giving additional info or twitter handle",
#'        x = 'Horizontal Axis Label in Upper Lower', ## Required.
#'        y = 'Vertical Axis Label in Upper Lower')+  ## Required.
#'   scale_x_continuous() + ## set limits and breaks. In this case, the defaults are fine.
#'   scale_y_continuous(limits=c(0,1), breaks=c(0, .5, 1))+ ## Required
#'   coord_cartesian(clip='off', expand=FALSE)+
#'   theme_sn(type='line', base_size=36/3) ## Use 36/3=12 or smaller in RStudio, use 36 to save as image
#'
#' print(g)
#'
#' ## Notes:
#' ## Upper Lower means First letter of each word capitalized
#' ## mult=c(0,0) removes the default padding.
#' ## breaks=c(0,.5,1) sets 3 lines at top, middle, and bottom.
#'
#' ## Use `ggsave` and `base_size=36` when saving an image.
#' ## Do not adjust the width. Height can be adjusted if desired.
#' ## A square image is often preferred, so when in doubt, keep height at 20.
#' ggsave(filename=paste0("img/", gsub("%", " Perc", title), ".jpg"), ## must have a subfolder called 'img'
#'        plot=g + theme_sn(type='line', base_size=36),
#'        width=20,   ## do not change
#'        height=20,  ## can change if desired. In most cases, a square figure (height=20) is probably preferred.
#'        units='in', ## do not change
#'        dpi=72)     ## do not change
#'
#'
#' ## Histogram example
#' dg = economics %>%
#'   filter(date<='2008-01-01') %>%
#'   rename(value=unemploy)
#' title = "Title in Upper Lower" ## to be used by ggplot and ggsave
#' g  = ggplot(dg, aes(x=value))+
#'   geom_histogram(fill=snred, color=snbackgray, binwidth=500) + ## set a reasonable binwidth
#'   labs(title    = title,
#'        subtitle = 'Optional Subtitle In Upper Lower',
#'        caption  = "Optional caption, giving additional info or twitter handle",
#'        x = 'Horizontal Axis Label in Upper Lower', ## Required.
#'        y = 'Count')+  ## Usually don't need to change. Can use 'Frequency' or 'Density'
#'   scale_y_continuous(expand = c(0,0))+
#'   theme_sn(type='hist', base_size=36/3) ## use 12 to show in RStudio, use 36 to save as image
#'
#' print(g)
#'
#' ## Use `ggsave` and `base_size=36` when saving an image.
#' ## Do not adjust the width. Height can be adjusted if desired.
#' ## A square image is often preferred, so when in doubt, keep height at 20.
#' ggsave(filename=paste0("img/", gsub("%", " Perc", title), ".jpg"), ## must have a subfolder called 'img'
#'        plot = g + theme_sn(type='hist', base_size=36),
#'        width=20,   ## do not change
#'        height=20,  ## can change if desired. In most cases, a square figure (height=20) is probably preferred.
#'        units='in', ## do not change
#'        dpi=72)     ## do not change
#'
#' ## Bar plot example
#' dg = mtcars %>%
#'   group_by(cyl) %>%
#'   summarise(mpg = mean(mpg)) %>%
#'   mutate(cyl = paste0(cyl, '-cylinder'), ## so that labels look nicer
#'          cyl = factor(cyl, levels=c('8-cylinder', '6-cylinder', '4-cylinder')), ## change order of factors
#'          max = 35) %>% ## same number as upper limit below. For creating light gray background bars
#'   rename(name  = cyl, ## since "name" and "value" will be more common column names,
#'          value = mpg) ## let's use those here
#'
#' title = "Title in Upper Lower" ## to be used by ggplot and ggsave
#' g = ggplot(dg, aes(x=value, y=name))+
#'   geom_bar(stat='identity', aes(x=max), color=NA, fill=snlightgray, width=0.8)+ ## optional full-length gray bars in the background. Use same number as in `limits` below
#'   geom_bar(stat='identity', fill=snred, color=NA, width=0.8)+ ## the 0.8 increases the gap between bars
#'   geom_text(aes(label=round(value,2)), hjust=-0.1)+ ## optionally, add numbers with reasonable number of digits
#'   labs(title    = title,
#'        subtitle = 'Optional Subtitle In Upper Lower',
#'        caption  = "Optional caption, giving additional info or twitter handle",
#'        x = 'Horizontal Axis Label in Upper Lower', ## Optional. If used, use Upper Lower.
#'        y = NULL)+  ## Optional. If used, use Upper Lower. If not used, use y=NULL. Do not use y=''.
#'   scale_x_continuous(limits=c(0,35))+ ## add expansion or change limits so the text fits
#'   theme_sn(type='bar', base_size=36/3) ## use 12 to show in RStudio, use 36 to save as image
#'
#' print(g)
#'
#' ## Use `ggsave` and `base_size=36` when saving an image.
#' ## Do not adjust the width. Height can be adjusted if desired.
#' ## A square image is often preferred, so when in doubt, keep height at 20.
#' ggsave(filename=paste0("img/", gsub("%", " Perc", title), ".jpg"), ## must have a subfolder called 'img'
#'        plot = g + theme_sn(type='bar', base_size=36),
#'        width=20,   ## do not change
#'        height=15,  ## can change if desired. In most cases, a square figure (height=20) is probably preferred.
#'        units='in', ## do not change
#'        dpi=72)     ## do not change
#'
#' ## Grid plot example
#' dg = airquality %>%
#'   mutate(Month= month.abb[Month],
#'          Month = factor(Month, levels=rev(month.abb)))%>% # use rev for May at top, Sep at bottom
#'   rename(name  = Day,
#'          name2 = Month,
#'          value = Temp)
#'
#' title = "Title in Upper Lower" ## to be used by ggplot and ggsave
#' g = ggplot(dg, aes(x=name, y=name2, fill=value))+
#'   geom_tile(size=0.4, show.legend = F) +
#'   scale_fill_gradient(low = snbackgray,
#'                       high = snred,
#'                       na.value = 'white',
#'                       oob=squish) +
#'   labs(title    = title,
#'        subtitle = 'Optional Subtitle In Upper Lower',
#'        caption  = "Optional caption, giving additional info or twitter handle",
#'        x = 'Day (Optional Axis Label in Upper Lower)', ## Optional
#'        y = NULL)+  ## Optional. If used, use Upper Lower. If not used, use y=NULL. Do not use y=''.
#'   geom_vline(xintercept=1:(length(unique(dg$name ))+1)-.5, color=sndarkgray, size=0.2)+ # vert  lines
#'   geom_hline(yintercept=1:(length(unique(dg$name2))+1)-.5, color=sndarkgray, size=0.2)+ # horiz lines between each square
#'   scale_x_continuous(expand = c(0, 0), position='top', breaks=seq(2,30,by=2))+
#'   scale_y_discrete(expand = c(0, 0)) +
#'   theme_sn(type='grid', base_size=36/3) ## use 16 or 12 to show in RStudio, use 36 to save as image
#'
#' print(g)
#'
#' ## Use `ggsave` and `base_size=36` when saving an image.
#' ## Do not adjust the width. Height can be adjusted if desired.
#' ## When in doubt, choose height so that the tiles are square
#' ggsave(filename=paste0("img/", gsub("%", " Perc", title), ".jpg"), ## must have a subfolder called 'img'
#'        plot=g + theme_sn(type='grid', base_size=36),
#'        width=20,   ## do not change
#'        height=10,  ## can change if desired. In this case, 10 is used to make the tiles square
#'        units='in', ## do not change
#'        dpi=72)     ## do not change
#'
#'
#' ## Faceting example
#' ## We'll use our scatter plot example, but with facet-wrap to make separate plots for each cyl
#' dg = mtcars %>%
#'   select(wt, mpg, cyl) %>%
#'   mutate(cyl = paste0(cyl, '-cylinder')) %>%
#'   rename(name = cyl)
#'
#' title = "Title in Upper Lower" ## to be used by ggplot and ggsave
#' g = ggplot(dg, aes(x=wt, y=mpg))+
#'   geom_point(color=snred)+
#'   facet_wrap(~name, nrow=1) +
#'   labs(title    = title,
#'        subtitle = 'Optional Subtitle In Upper Lower',
#'        caption  = "Optional caption, giving additional info or twitter handle",
#'        x = 'Horizontal Axis Label in Upper Lower',
#'        y = 'Vertical Axis Label in Upper Lower')+
#'   scale_x_continuous(limits=c(0, 6), breaks=c(0, 3, 6), oob=squish)+
#'   scale_y_continuous(limits=c(0,40), breaks=c(0,20,40), oob=squish)+
#'   coord_cartesian(clip='off', expand=FALSE)+
#'   theme_sn(type='scatter', base_size=36/3, facet=T)
#' print(g)
#'
#' ## Use `ggsave` and `base_size=36` when saving an image.
#' ## Do not adjust the width. Height can be adjusted if desired.
#' ## Square images are often preferred, so when in doubt, choose height so that each subplot is square.
#' ggsave(filename=paste0("img/", gsub("%", " Perc", title), ".jpg"), ## must have a subfolder called 'img'
#'        plot=g + theme_sn(type='scatter', base_size=36, facet=T),
#'        width=20,   ## do not change
#'        height=13,  ## can change if desired. Here, 13 was chosen so that each subplot is square
#'        units='in', ## do not change
#'        dpi=72)     ## do not change
#'

theme_sn <- function (type='line',
                      base_size = 36/3,
                      base_family = "sans",
                      base_line_size=base_size*.35/36*3,
                      base_rect_size=base_size*.35/36,
                      facet=F,
                      colors = 'default'){


  base_size <- base_size
  px <- 1/1440*20*base_size/36 ## Number of inches in one pixel. Assumes 72dpi and 20x20 image

  ## default geom settings
  ## Use the 0.35 conversion for points to mm here for geom_text.
  ## Necessary because geom_text and themes define font sizes differently.
  ## save default settings, then update defaults, then return to old settings at the end of the
  update_geom_defaults("point" , list(size=  8*base_size/36, color=sntextgray))
  update_geom_defaults("line"  , list(size=  3*base_size/36, color=sntextgray))
  update_geom_defaults("smooth", list(size=  3*base_size/36, color=sntextgray))
  update_geom_defaults("text"  , list(size=.35*base_size   , color=sntextgray, family=base_family))
  update_geom_defaults("bar"   , list(                       color=sntextgray)) ## does width even work?

  ## define colors if needed
  if(colors == 'default'){pal = default.pal}
  if(colors == 'cb14'   ){pal =      cb.pal}
  if(colors == 'cmu'    ){pal =     cmu.pal}
  options(ggplot2.continuous.colour = function() scale_colour_gradient(low=snlightgray, high=snblue)) ## use different blue
  options(ggplot2.continuous.fill   = function() scale_colour_gradient(low=snlightgray, high=snblue)) ## use different blue
  options(ggplot2.discrete.colour   = pal)
  options(ggplot2.discrete.fill     = pal)
  #options(ggplot2.continuous.size   = function() scale_size_continuous(limits=c(5, 10))) ## don't think this is an option

  th = theme(line = element_line(colour = sntextgray,
                                 size = base_line_size,
                                 linetype = 1,
                                 lineend = "butt"),
             rect = element_rect(fill = snbackgray,
                                 colour = NA,
                                 size = base_rect_size,
                                 linetype = 1),
             text = element_text(family = base_family,
                                 face = "plain",
                                 colour = sntextgray,
                                 size = base_size,
                                 lineheight = 0.9,
                                 hjust = 0.5, vjust = 0.5, angle = 0,
                                 margin = margin(10,10,10,10,'pt'),
                                 debug = FALSE),
             title = NULL,
             aspect.ratio = NULL,
             axis.title         = NULL,
             axis.title.x       = element_text(margin = margin(t = 30*px, unit='in'), vjust = 1),
             axis.title.x.top   = element_text(margin = margin(b = 30*px, unit='in'), vjust = 0),
             axis.title.x.bottom= NULL,
             axis.title.y       = element_text(margin = margin(r = 30*px, unit='in'), vjust = 1, angle =  90),
             axis.title.y.left  = NULL,
             axis.title.y.right = element_text(margin = margin(l = 30*px, unit='in'), vjust = 0, angle = -90),
             axis.text         = NULL,
             axis.text.x       = element_text(margin = margin(t = 20*px, unit='in'), vjust = 1),
             axis.text.x.top   = element_text(margin = margin(b = 20*px, unit='in'), vjust = 0),
             axis.text.x.bottom= NULL,
             axis.text.y       = element_text(margin = margin(r = 20*px, unit='in'), hjust = 1),
             axis.text.y.left  = NULL,
             axis.text.y.right = element_text(margin = margin(l = 20*px, unit='in'), hjust = 0),
             axis.ticks = element_line(colour = sntextgray),
             axis.ticks.x        = NULL,
             axis.ticks.x.top    = NULL,
             axis.ticks.x.bottom = NULL,
             axis.ticks.y        = NULL,
             axis.ticks.y.left   = NULL,
             axis.ticks.y.right  = NULL,
             axis.ticks.length          = unit(20*px, "in"),
             axis.ticks.length.x        = NULL,
             axis.ticks.length.x.top    = NULL,
             axis.ticks.length.x.bottom = NULL,
             axis.ticks.length.y        = NULL,
             axis.ticks.length.y.left   = NULL,
             axis.ticks.length.y.right  = NULL,
             axis.line          = element_line(size=base_line_size),
             axis.line.x        = NULL,
             axis.line.x.top    = NULL,
             axis.line.x.bottom = NULL,
             axis.line.y        = NULL,
             axis.line.y.left   = NULL,
             axis.line.y.right  = NULL,
             legend.background = element_rect(),
             legend.margin     = margin(0, 20*px, 0, 0, 'in'),
             legend.spacing    = NULL,
             legend.spacing.x  = unit(20*px, 'in'),
             legend.spacing.y  = NULL,
             legend.key        = element_rect(fill = NA, colour = NA),
             legend.key.size   = unit(30*px, "in"),
             legend.key.height = NULL,
             legend.key.width  = NULL,
             legend.text       = element_text(size = base_size, margin = margin(0,50*px, 0, 0, 'in')),
             legend.text.align = 0,
             legend.title      = element_blank(),
             legend.title.align= NULL,
             legend.position   = "top",
             legend.direction  = NULL,
             legend.justification = "left",
             legend.box            = NULL,
             legend.box.just       = NULL,
             legend.box.margin     = margin(0, 0, 50*px, -140*px, "in"),
             legend.box.background = element_blank(),
             legend.box.spacing    = NULL,
             panel.background = element_rect(fill=snbackgray, color=NA),
             panel.border     = element_blank(),
             panel.spacing = unit(50*px, "in"),
             panel.spacing.x = NULL,
             panel.spacing.y = NULL,
             panel.grid         = NULL,
             panel.grid.major   = NULL,
             panel.grid.minor   = element_blank(),
             panel.grid.major.x = element_blank(),
             panel.grid.major.y = element_line(colour = snlightgray),
             panel.grid.minor.x = NULL,
             panel.grid.minor.y = NULL,
             panel.ontop        = FALSE,
             plot.background = element_rect(),
             plot.title    = element_text(size = 50/36*base_size, hjust = 0, vjust = 1, margin = margin(0,0,b = 70*px, 0, unit='in'), color=sndarkgray, face='bold'),
             plot.title.position = 'plot',
             plot.subtitle = element_text(size = 42/36*base_size, hjust = 0, vjust = 1, margin = margin(-40*px,0,b = 70*px, 50*px, unit='in'), color=snmediumgray), ## black is not an option
             plot.caption  = element_text(size = 33/36*base_size, hjust = 0, vjust = 1, margin = margin(50*px, 0, 0, 0, 'in'), color=snmediumgray),
             plot.caption.position = 'plot',
             plot.tag      = element_text(size =       base_size, hjust = 0.5, vjust = 0.5),
             plot.tag.position = "topleft",
             plot.margin = margin(t = 70*px,
                                  r = 50*px,
                                  b = 50*px,
                                  l = 50*px, unit='in'),
             strip.background   = NULL,
             strip.background.x = NULL,
             strip.background.y = NULL,
             strip.placement    = "outside",
             strip.placement.x  = NULL,
             strip.placement.y  = NULL,
             strip.text = element_text(colour = sntextgray, size = base_size,
                                       margin = margin(20*px, 20*px, 20*px, 20*px, unit='in')),
             strip.text.x = NULL,
             strip.text.y = element_text(angle = -90),
             strip.switch.pad.grid = unit(base_size/4, "pt"),
             strip.switch.pad.wrap = unit(base_size/4, "pt"),
             complete = TRUE,
             validate = TRUE)

  ## Change the base theme based on the type of plot specified by the user.
  if(type=='scatter'){th = th + theme(panel.grid.major.x = element_line(colour = snlightgray))}
  if(type=='line'   ){th = th}
  if(type=='bar'    ){th = th + theme(axis.line  = element_blank(),
                                      axis.ticks = element_blank(),
                                      axis.ticks.length = unit(0, "pt"), # set to 0, otherwise the blank ticks take up whitespace
                                      axis.text.x=element_blank(),
                                      panel.grid.major.y = element_blank()) }
  if(type=='hist'   ){th = th + theme(axis.ticks.x = element_blank(), panel.grid.major.x = element_blank()) }
  if(type=='grid'   ){th = th + theme(axis.ticks = element_blank(),
                                      axis.ticks.length = unit(0, "pt"), # set to 0, otherwise the blank ticks take up whitespace
                                      axis.line.x  = element_blank(),
                                      strip.background = element_blank(),
                                      axis.title.x.top   = element_text(margin = margin(t = -6*px, b = 30*px, unit='in'), vjust = 0),
                                      panel.grid.major = element_blank())}
  if(facet==T       ){th = th + theme(panel.border = element_rect(color=sntextgray, fill=NA),
                                      strip.background   = element_rect(color=sntextgray, fill=snlightgray))}
  return(th)
}

## Yale theme.  Same as theme_sn but with different colors
theme_yale <- function (type='line',
                        base_size = 36/3,
                        base_family = "sans",
                        base_line_size=base_size*.35/36*3,
                        base_rect_size=base_size*.35/36,
                        facet=F){
  theme_sn(type=type,
           base_size     =base_size,
           base_family   =base_family,
           base_line_size=base_line_size,
           base_rect_size=base_rect_size,
           facet=facet,
           colors = 'yale')
}

## CMU theme.  Same as theme_sn but with different colors
theme_cmu <- function (type='line',
                       base_size = 36/3,
                       base_family = "sans",
                       base_line_size=base_size*.35/36*3,
                       base_rect_size=base_size*.35/36,
                       facet=F){
  theme_sn(type=type,
           base_size     =base_size,
           base_family   =base_family,
           base_line_size=base_line_size,
           base_rect_size=base_rect_size,
           facet=facet,
           colors = 'cmu')
}
