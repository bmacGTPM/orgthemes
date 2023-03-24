## orgcolors.r
## Define some organization-specific colors.

## Yale colors
## From https://yaleidentity.yale.edu/web
#' A color used in `orgthemes`
yalered       = NA ## no red      for yale, but other orgs probably use this
#' A color used in `orgthemes`
yalelightred  = NA ## no lightred for yale, but other orgs probably use this
#' A color used in `orgthemes`
yaleblue      ='#00356b'
#' A color used in `orgthemes`
yalemedblue   ='#286dc0'
#' A color used in `orgthemes`
yalelightblue ='#63aaff'
#' A color used in `orgthemes`
yaledarkgray  ='#222222'
#' A color used in `orgthemes`
yalemediumgray='#4a4a4a'
#' A color used in `orgthemes`
yalebrowngray ='#978d85'
#' A color used in `orgthemes`
yalelightgray ='#dddddd'
#' A color used in `orgthemes`
yalegreen     ='#5f712d'
#' A color used in `orgthemes`
yaleorange    ='#bd5319'
#' A color used in `orgthemes`
yalebackgray  ='#f9f9f9'

#' A color palette for Yale used in `orgthemes`
#'
#' The colors are listed in the order we typically want to use them
yale.pal = c(yaleblue      , yaleorange,
             yalemediumgray, yalebrowngray,
             yalelightblue , yalegreen,
             yalelightgray , yaleblue)


#' Yale ggplot theme called theme_yale.
#'
#' Same as theme_pub but with the Yale-specific colors
#' @import pubtheme
#' @import ggplot2
#' @param type Same as in `theme_pub`
#' @param base_size Same as in `theme_pub`
#' @param base_family Same as in `theme_pub`
#' @param base_line_size Same as in `theme_pub`
#' @param base_rect_size Same as in `theme_pub`
#' @param facet Same as in `theme_pub`
#' @export
theme_yale <- function (type='line',
                        base_size = 36/3,
                        base_family = "sans",
                        base_line_size=base_size*.35/36*3,
                        base_rect_size=base_size*.35/36,
                        facet=F){
  theme_pub(type=type,
            base_size     =base_size,
            base_family   =base_family,
            base_line_size=base_line_size,
            base_rect_size=base_rect_size,
            facet=facet,
            colors = yale.pal)
}


## CMU
## Copied images here https://www.cmu.edu/brand/brand-guidelines/visual-identity/colors.html
## And opened in MSPaint, color picker, Edit Colors.
## The CMYK values look wrong on the website.
## I should maybe move these elsewhere at some point.
#' A color used in `orgthemes`
cmured        = rgb(196,  18,  48, max=255)
#' A color used in `orgthemes`
cmumediumgray = rgb(110, 110, 110, max=255)
#' A color used in `orgthemes`
cmulightgray  = rgb(190, 190, 190, max=255)
#' A color used in `orgthemes`
cmublue       = rgb(  4,  54, 115, max=255)
#' A color used in `orgthemes`
cmulightblue  = rgb(  0, 139, 192, max=255)
#' A color used in `orgthemes`
cmurose       = rgb(239,  58,  71, max=255)
#' A color used in `orgthemes`
cmugold       = rgb(253, 181,  21, max=255)
#' A color used in `orgthemes`
cmugreen      = rgb(  0, 150,  71, max=255)
#' A color used in `orgthemes`
cmuteal       = rgb(  0, 143, 145, max=255)

#' A color palette for CMU used in `orgthemes`
#'
#' The colors are listed in the order we typically want to use them
#' @import pubtheme
cmu.pal = c(cmured, cmublue, cmumediumgray, cmulightgray,
            cmulightblue, cmugold, cmugreen, cmurose, cmuteal)

#' CMU ggplot theme called theme_cmu.
#'
#' Same as theme_pub but with the CMU-specific colors
#' @import pubtheme
#' @import ggplot2
#' @param type Same as in `theme_pub`
#' @param base_size Same as in `theme_pub`
#' @param base_family Same as in `theme_pub`
#' @param base_line_size Same as in `theme_pub`
#' @param base_rect_size Same as in `theme_pub`
#' @param facet Same as in `theme_pub`
#' @export
theme_cmu <- function (type='line',
                       base_size = 36/3,
                       base_family = "sans",
                       base_line_size=base_size*.35/36*3,
                       base_rect_size=base_size*.35/36,
                       facet=F){
  theme_pub(type=type,
            base_size     =base_size,
            base_family   =base_family,
            base_line_size=base_line_size,
            base_rect_size=base_rect_size,
            facet=facet,
            colors = 'cmu')
}
