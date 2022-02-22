# get_daily_output
# By: Bryan Petersen
# Date: 02.19.22

get_daily_output <- function(filepath, ncvar, pft = NULL, average_spatial = T, location_name = NULL){
  # Load libraries
  require(tidyverse)
  require(ncdf4)
  require(lubridate)
  
  # Open NetCDF file
  ncid <- nc_open(filepath)
  
  # Read variable of interest
  matrix <- ncvar_get(ncid, varid = ncvar)
  
  # Get the number of dimensions
  ndim <- length(dim(matrix))
  
  # If the variable doesn't have a pft dimension
  if (is.null(pft)){
    # Average over the spatial dimension
    if (average_spatial){
      if (ndim != 1){
        data_vector <- apply(matrix, MARGIN = ndim, FUN = mean, na.rm = T)
      } else{
        data_vector <- matrix
      }
    }
  }else{
    # Get specific pft
    if (ndim == 2){
      matrix <- matrix[pft,]
    } else if (ndim == 3){
      matrix <- matrix[,pft,]
    } else if (ndim == 4){
      matrix <- matrix[,,pft,]
    } else{
      stop("Dimensions of variable are weird")
    }
    # Average over the spatial dimension
    if (average_spatial){
      if (ndim != 1){
        data_vector <- apply(matrix, MARGIN = ndim, FUN = mean, na.rm = T)
      } else{
        data_vector <- matrix
      }
    }
  }
  
  # Read time vector
  date_vector <- as_date(ncvar_get(ncid, varid = "time"), origin = ymd("1749-12-31"))
  
  # Put into a tibble
  tbl <- tibble(date = as.character(date_vector),
                variable_name = ncvar,
                variable_data = data_vector)
  
  # Return tibble
  return(tbl)
}