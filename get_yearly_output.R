# get_output
# By: Bryan Petersen
# Date: 12.07.21

get_yearly_output <- function(filepath, ncvar, is.miscanthus = T, location = NULL){
  
  # Load libraries
  require(tidyverse)
  require(ncdf4)
  require(lubridate)
  
  # Open NetCDF file
  ncid <- nc_open(filepath)
  
  # Read variable of interest
  matrix <- ncvar_get(ncid, varid = ncvar)
  if (length(dim(matrix)) == 2){
    vector <- matrix[16,]
  } else if (length(dim(matrix)) == 3){
    matrix <- matrix[,16,]
    vector <- colMeans(matrix, na.rm = T)
  } else{
    matrix <- matrix[,,16,]
    matrix <- colMeans(matrix, na.rm = T)
    vector <- colMeans(matrix, na.rm = T)
  }
  
  # Read time vector
  year_vector <- year(as_date(ncvar_get(ncid, varid = "time"), origin = ymd("1749-12-31")))
  
  if (is.miscanthus == T){
    # Calculate stand age if simulating miscanthus
    stand_age <- 1:length(year_vector)
    
    # Compile to dataframe
    df <- tibble(location = location,
                 year = year_vector,
                 stand_age = stand_age,
                 variable = vector)
    colnames(df)[4] <- ncvar
  }else{
    # Compile to dataframe
    df <- tibble(location = location,
                 year = year_vector,
                 variable = vector)
    colnames(df)[4] <- ncvar
  }
  return(df)

}