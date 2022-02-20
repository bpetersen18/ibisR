# get_daily_output
# By: Bryan Petersen
# Date: 02.19.22

get_daily_output <- function(filepath, ncvar, pft = NULL, spatial = F, location_name = NULL){
  # Load libraries
  require(tidyverse)
  require(ncdf4)
  require(lubridate)
  
  # Open NetCDF file
  ncid <- nc_open(filepath)
  
  # Read variable of interest
  matrix <- ncvar_get(ncid, varid = ncvar)
  
  # If the variable doesn't have a pft dimension
  if (is.null(pft)){
    # Average over the spatial dimension
    if (spatial){
      # Get the number of dimensions
      ndim <- length(dim(matrix))
      if (ndim != 1){
        vector <- apply(matrix, MARGIN = ndim, FUN = mean, na.rm = T)
      } else{
        vector <- matrix
      }
    }
  }
  
  # Read time vector
  date_vector <- as_date(ncvar_get(ncid, varid = "time"), origin = ymd("1749-12-31"))
  
  # Put into a tibble
  tbl <- tibble(date = date_vector,
                variable = vector)
  
  # Return tibble
  return(tbl)
}