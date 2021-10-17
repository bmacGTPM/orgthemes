## add.logo.r

add_logo = function(g = NULL,
                    org='yale'){

  ## get base_size from the ggplot object
  base_size = g$theme$text$size

  ## read in logo
  #logo <- readPNG(system.file("img", "Rlogo.png", package="png"), TRUE)
  logo <- readPNG(paste0('logo/', org, '.png'), TRUE)

  logo.grob = rasterGrob(logo,
                         #x = 1-50/144, y=0+50/144,
                         x=.5, y=.25, ## this will put lower right corner in the middle of the grob
                         hjust = 1, vjust=0,
                         height=unit(120, 'points')*base_size/36)


  gt = ggplot_gtable(ggplot_build(g))
  t = gt$layout %>% filter(name=='background') %>% select(b)
  l = gt$layout %>% filter(name=='background') %>% select(r)
  gt = gtable_add_grob(x=gt, grobs = logo.grob, t=t, l=l, clip = 'off')
  gg = gt %>% as.ggplot()
  gg
}
