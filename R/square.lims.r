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