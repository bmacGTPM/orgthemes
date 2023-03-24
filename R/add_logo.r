#' Function to add a logo to a ggplot that uses theme_pub
#' @param g A ggplot created with theme_pub or an organization-specific theme
#' @param org name of the org. Must match the name of the .png in the logo folder.
#' @import tidyverse
#' @import ggplot2
#' @import scales
#' @import png
#' @import grid
#' @import gtable
#' @import ggplotify
#' @import pubtheme
#' @export
add_logo = function(g = NULL,
                    org='yale'){

  ## get base_size from the ggplot object
  base_size = g$theme$text$size

  ## read in logo
  #logo <- readPNG(system.file("img", "Rlogo.png", package="png"), TRUE)
  logo <- readPNG(paste0('img/', org, '.png'), TRUE)

  logo.grob = rasterGrob(logo,
                         #x = 1-50/144, y=0+50/144,
                         x=.5, y=.25, ## this will put lower right corner in the middle of the grob
                         hjust = 1, vjust=0,
                         height=unit(120, 'points')*base_size/36)

  gt = ggplot_gtable(ggplot_build(g))
  gtlayout = gt$layout
  t = gtlayout[gtlayout$name=='background', 'b']
  l = gtlayout[gtlayout$name=='background', 'r']
  # t = gtlayout %>%
  #   dplyr::filter(name=='background') %>%
  #   dplyr::select(b)
  # l = gtlayout %>%
  #   dplyr::filter(name=='background') %>%
  #   dplyr::select(r)
  gt = gtable_add_grob(x=gt, grobs = logo.grob, t=t, l=l, clip = 'off')
  gg = as.ggplot(gt)
  gg
}
