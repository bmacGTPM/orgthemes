## colors.r

## define colors

## Default colors
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

## colorblind friendly color palette
## from https://jacksonlab.agronomy.wisc.edu/2016/05/23/15-level-colorblind-friendly-palette/
cb14 =  c("#000000","#004949","#009292","#ff6db6","#ffb6db",
          "#490092","#006ddb","#b66dff","#6db6ff","#b6dbff",
          "#920000","#924900","#db6d00","#24ff24","#ffff6d")
cb14[15] = 'lightgray' ## replace the yellow with gray, since yellow is almost impossible to see.
cb14 = cb14[-2] ## remove this since it is so close to the next one


## Organization specific colors

## Yale
## Colors from https://yaleidentity.yale.edu/web
yalered       = NA
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
yale.pal = c(yaleblue   , yaleorange,
             yalemediumgray, yalebrowngray,
             yalelightblue , yalegreen,
             yalelightgray , yaleblue)


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



## CMU
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
cmu.pal = c(cmured, cmublue, cmumediumgray, cmulightgray,
            cmulightblue, cmugold, cmugreen, cmurose, cmuteal)

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
