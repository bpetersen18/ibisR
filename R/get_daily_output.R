#' Gets daily output and puts it into a tibble for analysis or plotting
#'
#' @param filepath Path to the daily netCDF file
#' @param ncvar Name of variable of interest
#' @param pft Select the pft of interest. The default is set to NULL
#' @param average_spatial If set equal to false, the variable is not averaged over space
#'
#' @export

get_daily_output <- function(filepath, ncvar, pft = NULL, average_spatial = T) {
  # Load libraries
  requireNamespace(tidyverse)
  requireNamespace(ncdf4)
  requireNamespace(lubridate)
  requireNamespace(reshape2)

  # Open NetCDF file
  ncid <- nc_open(filepath)

  # Read variable of interest
  matrix <- ncvar_get(ncid, varid = ncvar, collapse_degen = F)

  # Read lat and lon
  lon_vector <- ncvar_get(ncid, varid = "longitude")
  lat_vector <- ncvar_get(ncid, varid = "latitude")

  # Read time vector
  date_vector <- as.character(as_date(ncvar_get(ncid, varid = "time"), origin = ymd("1749-12-31")))

  # Get the number of dimensions
  ndim <- length(dim(matrix))

  # Get specific pft and adjust dimensions
  if (!is.null(pft)) {
    if (ndim == 4) {
      matrix <- matrix[, , pft, ]
    } else {
      stop("Dimensions of variable are weird")
    }
  }

  # Name the dimensions
  dimnames(matrix) <- list(lon_vector, lat_vector, date_vector)

  if (average_spatial) {
    # Average over the spatial dimension
    data_vector <- apply(matrix, MARGIN = 3, FUN = mean, na.rm = T)

    # Put into a tibble
    tbl <- tibble(
      date = as.character(date_vector),
      variable_name = ncvar,
      variable_data = data_vector
    )
  } else {
    tbl <- melt(matrix, varnames = names(dimnames(matrix)), value.name = "variable_data") %>%
      rename("longitude" = "Var1", "latitude" = "Var2", "date" = "Var3") %>%
      mutate(variable_name = ncvar)
  }

  # Return tibble
  return(tbl)
}
