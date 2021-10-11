
<!-- README.md is generated from README.Rmd. Please edit that file -->

# themesn

<!-- badges: start -->
<!-- badges: end -->

The package `themesn` contains a `ggplot` theme `theme_sn` for creating
data journalism-style data visualizations with color palettes and
formatting similar to those used by BBC, NY Times, and ESPN.

## Installation

You can install the GitHub version of `themesn` with:

``` r
devtools::install_github("bmacGTPM/themesn")
```

If you get an error about download method, try changing this option
before installing.

``` r
options(download.file.method = 'libcurl')
```

The theme will change some of your ggplot defaults the first time you
use it. To change them back, restart R, or use

`restore.ggplot.defaults()`

## Example Figures

See the help file `?theme_sn` for code that generates these figures.

## Scatter plot example

<img src="Example Scatter Plot.jpg" width="60%" />

## Line plot example

<img src="Example Line Plot.jpg" width="60%" />

## Histogram example

<img src="Example Histogram.jpg" width="60%" />

## Bar plot example

<img src="Example Bar Plot.jpg" width="60%" />

## Grid plot example

<img src="Example Grid Plot.jpg" width="60%" />

## Faceting example

<img src="Example Plot with Faceting.jpg" width="60%" />

## Default colors

This theme changes your default ggplot colors using

``` r
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
scale_colour_discrete <- function(...) scale_color_manual(values=default.pal)
scale_fill_discrete   <- function(...) scale_fill_manual( values=default.pal)
```

If more than 5-6 colors are needed, the 14-color colorblind friendly
palette `cb14` can be used by adding `+ scale_color_manual(values=cb14)`
or `+ scale_fill_manual( values=cb14)` to a plot.

To use an organizations colors, use for example
`theme_sn(..., colors='yale')`. Equivalently, use `theme_yale(...)`.

To add organization-specific color scheme that does not yet exist in the
package, open `colors.r`, and add a section for your org that defines
the official colors, a color palette with those colors, and a theme
function. For example

``` r
## Yale
## Colors from https://yaleidentity.yale.edu/web
yaleblue      ='#00356b'
yalemedblue   ='#286dc0'
yalelightblue ='#63aaff'
yaledarkgray  ='#222222'
yalemediumgray='#4a4a4a'
yalebrowngray ='#978d85'
yalelightgray ='#dddddd'
yalegreen     ='#5f712d'
yaleorange    ='#bd5319'
yalebackgray  ='#f9f9f9'

## Palette
yale.pal = c(yaleblue   , yaleorange,
             yalemediumgray, yalebrowngray,
             yalelightblue , yalegreen,
             yalelightgray , yaleblue)


## Yale theme.  Same as theme_sn but with the Yale-specific colors
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
```

and then make a pull-request. It is recommended that you make a copy of
another organizations colors, palette, and theme function (like the
above chunk), and edit it for your organization.
