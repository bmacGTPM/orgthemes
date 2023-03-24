#' Given data, create square limits based on that data
#'
#' Create square limits for scatter plots, meaning x and y have the same limits.
#' @param data Data to base the limits on
#' @param symmetric If TRUE, then the limits will be symmetric about the origin.  Default is FALSE.
#' @export
square.lims = function(data=NULL, symmetric=F){

  ## find min and max
  lims = c(min(data, na.rm=T),
           max(data, na.rm=T))

  if(symmetric==T){
    abs.max = max(abs(lims))
    lims = c(-abs.max, abs.max)
  }
  return(lims)
}
