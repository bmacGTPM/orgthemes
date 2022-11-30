# library(ggplot2)
# library(ggplotify)
# library(gridExtra)
# library(gtable)
#
# # Template function for creating densities grouped by a variable
# cty_by_var <- function(var) {
#   ggplot(mpg, aes(cty, colour = factor({{var}}), fill = factor({{var}}))) +
#     geom_density(alpha = 0.2)
# }
#
# # Define custom palettes for when there are 1-2, 3, or 4-6 levels
# opts <- options(
#   ggplot2.discrete.fill = list(
#     c("skyblue", "orange"),
#     RColorBrewer::brewer.pal(3, "Set2"),
#     RColorBrewer::brewer.pal(6, "Accent")
#   )
# )
#
# opts <- options(
#   ggplot2.discrete.colour = list(
#     c("skyblue", "orange"),
#     RColorBrewer::brewer.pal(3, "Set2"),
#     RColorBrewer::brewer.pal(6, "Accent")
#   )
# )
# # Two levels
# cty_by_var(year)
#
#
#
# # Dummy plot
# df <- data.frame(x = 1:10, y = 1:10)
# base <- ggplot(df, aes(x, y)) +
#   geom_blank() +
#   theme_bw() +
#   coord_cartesian(clip='off')
# base + annotation_custom(
#   grob = grid::roundrectGrob(),
#   xmin = .9, xmax = 9, ymin = 1, ymax = 10.50
# )
#
# library(magick)
# logo <- image_read("https://www.rstudio.com/wp-content/uploads/2018/10/RStudio-Logo-Flat.png") %>%
#   image_resize(300)
# logo
# base
#
#
# ## Scatter plot example
# dg = mtcars %>% select(wt, mpg, cyl)
# title = 'Title in Upper Lower' ## to be used by ggplot and ggsave
# g = ggplot(dg, aes(x=wt, y=mpg))+
#   geom_point(color=snred)+
#   facet_wrap(~cyl)+
#   labs(title    = title,
#        subtitle = 'Optional Subtitle In Upper Lower',
#        caption  = "Optional caption, giving additional information",
#        x = 'Horizontal Axis Label in Upper Lower',
#        y = 'Vertical Axis Label in Upper Lower')+
#   scale_x_continuous(limits=c(0, 6), breaks=c(0, 3, 6), oob=squish)+
#   scale_y_continuous(limits=c(0,40), breaks=c(0,20,40), oob=squish)+
#   coord_cartesian(clip='off', expand=FALSE)+
#   theme_sn(type='scatter', base_size = 36/3) ## use 36/3=12 in RStudio, use 36 to save as image
# print(g)
#
#
# ## end of add_logo function
#
# g = g +
#   annotation_custom(logo.grob, xmin=9/10*x2+1/10*x1, xmax=x2, ymin=-2*(y2-y1)/10, ymax=-1*(y2-y1)/10);
# g
#
# x1 = ggplot_build(g)$layout$panel_params[[1]]$x.range[1]
# x2 = ggplot_build(g)$layout$panel_params[[1]]$x.range[2]
# y1 = ggplot_build(g)$layout$panel_params[[1]]$y.range[1]
# y2 = ggplot_build(g)$layout$panel_params[[1]]$y.range[2]
#
# g + annotation_custom(gpp, xmin=9/10*x2+1/10*x1, xmax=x2, ymin=-2*(y2-y1)/10, ymax=-1*(y2-y1)/10);
#
#
# library(devtools)
# dev_mode(on=F)
#
# library(ggplot2)
# library(png)
# library(grid)
#
# img <- readPNG(system.file("img", "Rlogo.png", package="png"), TRUE, )
# gpp <- rasterGrob(img, interpolate=TRUE)
# gpp$width <- unit(1, "npc")
# gpp$height <- unit(1, "npc")
# df <- data.frame(x=seq(1,2,0.01),y=seq(1,2,0.01))
# ggplot(df,aes(x=x,y=y)) +
#   annotation_custom(gpp, xmin=1, xmax=2.5, ymin=1, ymax=1.5) +
#   coord_cartesian(clip='off')+
#   geom_point() + theme(panel.ontop=T,
#                        panel.background = element_rect(colour = NA,fill="transparent"))
#
#
# p <- ggplot(df,aes(x=x,y=y))+
#   #theme(plot.margin = unit(c(1,1,1,1), "lines")) +
#   coord_cartesian(clip='off')+
#   annotation_custom(gpp, xmin=.9, xmax=1, ymin=-0.1, ymax=0);
# p
#
#
#
# library(cowplot)
# library(magick)
# img <- image_read("Logo.png")
# grid.draw(logo, x = 1, y = 0, width = 0.09,
#              height = 0.03571429,
#              hjust = 1, vjust=0)
#
# # Set the canvas where you are going to draw the plot and the image
# ggdraw() +
#   # Draw the plot in the canvas setting the x and y positions, which go from 0,0
#   # (lower left corner) to 1,1 (upper right corner) and set the width and height of
#   # the plot. It's advisable that x + width = 1 and y + height = 1, to avoid clipping
#   # the plot
#   draw_plot(p,x = 0, y = 0.15, width = 1, height = 0.85) +
#   # Draw image in the canvas using the same concept as for the plot. Might need to
#   # play with the x, y, width and height values to obtain the desired result
#   draw_image(img,x = 0.85, y = 0.02, width = 0.15, height = 0.15)
