library(tidyverse)
library(scales)

svred         = rgb(200,  20,  40, max=255) ## red for highlighted data
svlightred    = rgb(230, 140, 140, max=255) ## red for background data
svdarkgray    = rgb( 30,  30,  30, max=255) ## gray for highlighted data (dark)
svmediumgray  = rgb(135, 135, 135, max=255) ## medium gray for subtitle and caption
svlightgray   = rgb(210, 210, 210, max=255) ## gray for background data
svtextgray    = rgb(100, 100, 100, max=255) ## dark gray for text
svbackgray    = rgb(240, 240, 240, max=255) ## very light gray for image background
svblue        = rgb(  5, 140, 200, max=255) ## blue for highlighted data
svlightblue   = rgb(130, 180, 210, max=255) ## blue for background data

d.pal = c(svred, svblue, svtextgray,  svlightred, svlightblue)
scale_colour_discrete <- function(...) scale_color_manual(values=d.pal)
scale_fill_discrete   <- function(...) scale_fill_manual( values=d.pal)


#' A ggplot theme
#'
#' A ggplot theme for making uniformly formatted viz in the SCORE network
#' @param type Text indicating the type of plot the theme is being used for.  Supported types are currently 'line', 'bar', 'hist', 'grid', 'scatter' which can be used for plots with `geom_line`, `geom_bar`, `geo_histogram`, `geom_tile`, and `geom_point`.  Other plot types will be added later.
#' @param base_size base font size, given in pts. For saving images, 36 is required. For viewing in RStudio, something much smaller like 36/3 = 12 (the default) is recommended.
#' @param base_family base font family.  The default is `'sans'`, which is available cross-platform by default.
#' @param base_line_size base size for line elements. Default is `base_size*.35/36`, and should typically not be changed.
#' @param base_rect_size base size for rect elements. Default is `base_size*.35/36`, and should typically not be changed.
#' @param facet Indicates whether or not `facet_wrap` or `facet_grid` are being used for this plot.  The default is `facet=FALSE`.
#' @return When used in conjunction with ggplot, it returns a plot formatted using the default sv theme.
#' @examples
#'
#' ## Load required packages
#' library(tidyverse)
#' library(scales)
#'
#' ## Change the default color palette
#' d.pal = c(svred, svblue, svtextgray,  svlightred, svlightblue)
#' scale_colour_discrete <- function(...) scale_color_manual(values=d.pal)
#' scale_fill_discrete   <- function(...) scale_fill_manual( values=d.pal)
#'
#'
#' ## Scatter plot example
#' dg = mtcars %>% select(wt, mpg)
#' g = ggplot(dg, aes(x=wt, y=mpg))+
#'   geom_point(color=svred)+
#'   labs(title = 'Title in Upper Lower',
#'        subtitle = 'Optional Subtitle In Upper Lower',
#'        caption = "Optional caption, giving additional information",
#'        x = 'Horizontal Axis Label in Upper Lower',
#'        y = 'Vertical Axis Label in Upper Lower')+
#'   scale_x_continuous(limits=c(0, 6), breaks=c(0, 3, 6), oob=squish, expand = c(0,0))+
#'   scale_y_continuous(limits=c(0,40), breaks=c(0,20,40), oob=squish, expand = c(0,0))+
#'   theme_sv(type='scatter', base_size = 36/3) ## use 36/3=12 in RStudio, use 36 to save as image
#' print(g)
#'
#' ## Use `ggsave` and `base_size=36` when saving an image.
#' ## Do not adjust the width. Height can be adjusted if desired.
#' ## A square image is often preferred, so when in doubt, keep height at 20.
#' ggsave(filename='Example Scatter Plot.jpg',
#'        plot=g + theme_sv(type='scatter', base_size=36),
#'        width=20,   ## do not change
#'        height=20,  ## can change if desired. In most cases, a square figure (height=20) is probably preferred.
#'        units='in', ## do not change
#'        dpi=72)     ## do not change
#'
#' ## Line plot
#' dg = economics_long
#' dg = dg %>% mutate(variable = toupper(variable)) ## avoid using all lowercase letters in a legend
#' g = ggplot(dg, aes(x=date, y=value01, color=variable))+
#'  geom_line()+
#'  labs(   title = 'Title in Upper Lower', ## Required.
#'       subtitle = 'Optional Subtitle in Upper Lower', ## Optional.
#'        caption = "Optional caption, giving additional information", ## Optional.
#'              x = 'Horizontal Axis Label in Upper Lower', ## Required.
#'              y = 'Vertical Axis Label in Upper Lower')+  ## Required.
#'  scale_x_date(      expand = expansion(mult=c(0,0)))+ ## mult=c(0,0) is usually required.
#'  scale_y_continuous(expand = expansion(mult=c(0,0)), limits=c(0,1), breaks=c(0, .5, 1))+ ## Required
#'  theme_sv(type='line', base_size=36/3) ## Use 36/3=12 or smaller in RStudio, use 36 to save as image
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
#' ggsave(filename='Example Line Plot.jpg',
#'        plot=g + theme_sv(type='line', base_size=36),
#'        width=20,   ## do not change
#'        height=20,  ## can change if desired. In most cases, a square figure (height=20) is probably preferred.
#'        units='in', ## do not change
#'        dpi=72)     ## do not change
#'
#'
#' ## Histogram example
#' dg = economics %>% filter(date<='2008-01-01')
#' g  = ggplot(dg, aes(x=unemploy))+
#'   geom_histogram(fill=svred, color=svbackgray, binwidth=500, ) + ## set a reasonable binwidth
#'   labs(  title = 'Title in Upper Lower', ## Required.
#'          subtitle = 'Optional Subtitle in Upper Lower', ## Optional.
#'          caption = "Optional caption, giving additional information", ## Optional.
#'          x = 'Horizontal Axis Label in Upper Lower', ## Required.
#'          y = 'Vertical Axis Label in Upper Lower')+  ## Required.
#'   scale_y_continuous(expand = expansion(mult=c(0,0.0), add=c(0,0)))+
#'   theme_sv(type='hist', base_size=36/3) ## use 12 to show in RStudio, use 36 to save as image
#'
#' print(g)
#'
#' ## Use `ggsave` and `base_size=36` when saving an image.
#' ## Do not adjust the width. Height can be adjusted if desired.
#' ## A square image is often preferred, so when in doubt, keep height at 20.
#' ggsave(filename='Example Histogram.jpg',
#'        plot = g + theme_sv(type='hist', base_size=36),
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
#'          max = 35) ## same number as upper limit below
#'
#' g = ggplot(dg, aes(x=mpg, y=cyl))+
#'   geom_bar(stat='identity', aes(x=max), color=NA, fill=svlightgray, width=0.8)+ ## option full-length gray bars in the background. Use same number as in `limits` below
#'   geom_bar(stat='identity', fill=svred, color=NA, width=0.8)+ ## the 0.8 increases the gap between bars
#'   geom_text(aes(label=round(mpg,2)), hjust=-0.1)+ ## optionally, add numbers with reasonable number of digits
#'   labs(  title = 'Title in Upper Lower', ## Required.
#'          subtitle = 'Optional Subtitle in Upper Lower', ## Optional.
#'          caption = "Optional caption, giving additional information", ## Optional.
#'          x = 'Horizontal Axis Label in Upper Lower', ## Optional. If used, use Upper Lower.
#'          y = NULL)+  ## Optional. If used, use Upper Lower. If not used, use y=NULL. Do not use y=''.
#'   scale_x_continuous(expand = expansion(mult=c(0,0.0), add=c(0,0)), limits=c(0,35), breaks=c(0,10,20,30))+ ## add expansion or change limits so the text fits
#'   theme_sv(type='bar', base_size=36/3) ## use 12 to show in RStudio, use 36 to save as image
#'
#' print(g)
#'
#' ## Use `ggsave` and `base_size=36` when saving an image.
#' ## Do not adjust the width. Height can be adjusted if desired.
#' ## A square image is often preferred, so when in doubt, keep height at 20.
#' ggsave(filename='Example Bar Plot.jpg',
#'        plot = g + theme_sv(type='bar', base_size=36),
#'        width=20,   ## do not change
#'        height=15,  ## can change if desired. In most cases, a square figure (height=20) is probably preferred.
#'        units='in', ## do not change
#'        dpi=72)     ## do not change
#'
#' ## Grid plot example
#' dg = airquality %>%
#'   mutate(Month= month.abb[Month],
#'          Month = factor(Month, levels=rev(month.abb))) # use rev for May at top, Sep at bottom
#'
#' dg
#'
#' g = ggplot(dg, aes(x=Day, y=Month, fill=Temp))+
#'   #g = ggplot(dg, aes(x=carat, y=color, fill=price))+
#'   geom_tile(size=0.4, show.legend = F) +
#'   scale_fill_gradient(low = svbackgray,
#'                       high = svred,
#'                       na.value = 'white',
#'                       oob=squish) +
#'   labs(  title = 'Title in Upper Lower', ## Required.
#'          subtitle = 'Optional Subtitle in Upper Lower', ## Optional.
#'          caption = "Optional caption, giving additional information", ## Optional.
#'          x = 'Day (Optional Axis Label in Upper Lower)', ## Optional
#'          y = NULL)+  ## Optional. If used, use Upper Lower. If not used, use y=NULL. Do not use y=''.
#'   geom_vline(xintercept=1:(length(unique(dg$Day ))+1)-.5, color=svdarkgray, size=0.2)+ # vert  lines
#'   geom_hline(yintercept=1:(length(unique(dg$Month   ))+1)-.5, color=svdarkgray, size=0.2)+ # horiz lines between each square
#'   scale_x_continuous(expand = c(0, 0), position='top', breaks=seq(2,30,by=2))+
#'   scale_y_discrete(expand = c(0, 0)) +
#'   theme_sv(type='grid', base_size=36/3) ## use 16 or 12 to show in RStudio, use 36 to save as image
#'
#' print(g)
#'
#'
#' ## Use `ggsave` and `base_size=36` when saving an image.
#' ## Do not adjust the width. Height can be adjusted if desired.
#' ## When in doubt, choose height so that the tiles are square
#' ggsave(filename='Example Grid Plot.jpg',
#'        plot=g + theme_sv(type='grid', base_size=36),
#'        width=20,   ## do not change
#'        height=10,  ## can change if desired. In this case, 10 is used to make the tiles square
#'        units='in', ## do not change
#'        dpi=72)     ## do not change
#'
#'
#' ## Faceting example
## We'll use our scatter plot example, but with facet-wrap to make separate plots for each cyl
#' dg = mtcars %>%
#'   select(wt, mpg, cyl) %>%
#'   mutate(cyl = paste0(cyl, '-cylinder'))
#'
#' g = ggplot(dg, aes(x=wt, y=mpg))+
#'   geom_point(color=svred)+
#'   labs(title = 'Title in Upper Lower',
#'        subtitle = 'Optional Subtitle In Upper Lower',
#'        caption = "Optional caption, giving additional information",
#'        x = 'Horizontal Axis Label in Upper Lower',
#'        y = 'Vertical Axis Label in Upper Lower')+
#'   scale_x_continuous(limits=c(0, 6), breaks=c(0, 3, 6), oob=squish, expand = c(0,0))+
#'   scale_y_continuous(limits=c(0,40), breaks=c(0,20,40), oob=squish, expand = c(0,0))+
#'   theme_sv(type='scatter', base_size = 36/3) ## use 36/3=12 in RStudio, use 36 to save as image
#' print(g)
#' g = g +
#'   facet_wrap(~cyl, nrow=1) +
#'   theme_sv(type='scatter', base_size=36/3, facet=T)
#' print(g)
#'
#' ## Use `ggsave` and `base_size=36` when saving an image.
#' ## Do not adjust the width. Height can be adjusted if desired.
#' ## Square images are often preferred, so when in doubt, choose height so that each subplot is square.
#' ggsave(filename='Example Plot with Faceting.jpg',
#'        plot=g + theme_sv(type='scatter', base_size=36, facet=T),
#'        width=20,   ## do not change
#'        height=13,  ## can change if desired. Here, 13 was chosen so that each subplot is square
#'        units='in', ## do not change
#'        dpi=72)     ## do not change
#'

theme_sv <- function (type='line',
                      base_size = 36/3,
                      base_family = "sans",
                      base_line_size=base_size*.35/36*3,
                      base_rect_size=base_size*.35/36,
                      facet=F){


  base_size <- base_size
  px <- 1/1440*20*base_size/36 ## Number of inches in one pixel. Assumes 72dpi and 20x20 image

  ## default geom settings
  ## for some reason geom_text and theme define font sizes differently.  Use the 0.35 conversion for points to mm here for geom_text
  update_geom_defaults("point", list(size=  8*base_size/36, color=svtextgray))
  update_geom_defaults("line" , list(size=  3*base_size/36, color=svtextgray))
  update_geom_defaults("text" , list(size=.35*base_size   , color=svtextgray, family='sans'))
  update_geom_defaults("bar"  , list(width=.8             , color=svtextgray))

  th = theme(line = element_line(colour = svtextgray,
                                 size = base_line_size,
                                 linetype = 1,
                                 lineend = "butt"),
             rect = element_rect(fill = svbackgray,
                                 colour = NA,
                                 size = base_rect_size,
                                 linetype = 1),
             text = element_text(family = base_family,
                                 face = "plain",
                                 colour = svtextgray,
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
             axis.ticks = element_line(colour = svtextgray),
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
             legend.title      = element_blank(), #element_text(hjust = 0),
             legend.title.align= NULL,
             legend.position   = "top",
             legend.direction  = NULL,
             legend.justification = "left",
             legend.box            = NULL,
             legend.box.just       = NULL,
             legend.box.margin     = margin(0, 0, 50*px, -140*px, "in"),
             legend.box.background = element_blank(),
             legend.box.spacing    = NULL, #unit(50*px, "pt"),
             #panel.background = element_rect(fill = "white", colour = NA, size=1),
             #panel.border = element_rect(fill = NA, colour = "grey20", size=1),
             panel.background = element_rect(fill=svbackgray, color=NA),
             panel.border     = element_blank(),
             panel.spacing = unit(50*px, "in"),
             panel.spacing.x = NULL,
             panel.spacing.y = NULL,
             panel.grid         = NULL, #element_blank(), ## default is to have no grid lines
             panel.grid.major   = NULL,
             panel.grid.minor   = element_blank(),
             panel.grid.major.x = element_blank(),
             panel.grid.major.y = element_line(colour = svlightgray), ## add only horizontal major gridlines
             panel.grid.minor.x = NULL,
             panel.grid.minor.y = NULL,
             panel.ontop        = FALSE,
             plot.background = element_rect(),
             plot.title    = element_text(size = 50/36*base_size, hjust = 0, vjust = 1, margin = margin(0,0,b = 70*px, 0, unit='in'), color=svdarkgray, face='bold'),
             plot.title.position = 'plot',
             plot.subtitle = element_text(size = 42/36*base_size, hjust = 0, vjust = 1, margin = margin(-40*px,0,b = 70*px, 50*px, unit='in'), color=svmediumgray), ## black is not an option
             plot.caption  = element_text(size = 33/36*base_size, hjust = 0, vjust = 1, margin = margin(50*px, 0, 0, 0, 'in'), color=svmediumgray),
             plot.caption.position = 'plot',
             plot.tag      = element_text(size =       base_size, hjust = 0.5, vjust = 0.5),
             plot.tag.position = "topleft",
             plot.margin = margin(t = 70*px,
                                  r = 50*px,
                                  b = 50*px,
                                  l = 50*px, unit='in'),
             strip.background   = element_rect(color=svtextgray, fill=svlightgray),
             strip.background.x = NULL,
             strip.background.y = NULL,
             strip.placement    = "outside",
             strip.placement.x  = NULL,
             strip.placement.y  = NULL,
             strip.text = element_text(colour = svtextgray, size = base_size,
                                       margin = margin(20*px, 20*px, 20*px, 20*px, unit='in')),
             strip.text.x = NULL,
             strip.text.y = element_text(angle = -90),
             strip.switch.pad.grid = unit(base_size/4, "pt"),
             strip.switch.pad.wrap = unit(base_size/4, "pt"),
             complete = TRUE,
             validate = TRUE)

  ## Change the base theme based on the type of plot specified by the user.
  if(type=='scatter'){th = th + theme(panel.grid.major.x = element_line(colour = svlightgray))}
  if(type=='line'   ){th = th #+ theme(#axis.line.y  = element_blank(), axis.ticks.y = element_line(colour = svlightgray))
  }
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

  if(facet==T       ){th = th + theme(panel.border = element_rect(color=svtextgray, fill=NA))}

  return(th)
}




