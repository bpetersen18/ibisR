#' @title Writes planting date data to NetCDF file
#' 
#' @name write_management
#'
#' @param model_path Path to the model directory.
#' @param yr Year or vector of years to change planting date.
#' @param doy Day of year to change planting date for the specific year(s).
#' 
#' @author Bryan Petersen - bryan20@iastate.edu
#'
#' @export
write_management <- function(model_path, yr, doy) {
  # Check to see if day of year is a character
  if (is.character(doy)) {
    doy <- lubridate::yday(lubridate::mdy(paste0(doy, "-", yr)))
  }

  # Open planting data NetCDF
  ncid <- ncdf4::nc_open(paste0(ibis_dir, "/input/management/planting_date_average.nc"), write = T)

  # Read header file
  hdr <- scan(file = paste0(ibis_dir, "/input/management/planting_date_and_cultivar.hdr"), what = character(), sep = "\n")

  # Get starting year
  year0 <- as.numeric(stringr::str_split(hdr, pattern = "!")[[1]][1])

  # Number of years
  nyears <- as.numeric(stringr::str_split(hdr, pattern = "!")[[2]][1])

  # Create vector of years
  years <- seq(from = year0, by = 1, length.out = nyears)

  # Get structure NetCDF
  nc_df <- ncdump::NetCDF(paste0(ibis_dir, "/input/management/planting_date_average.nc"))

  # Check to see header file and time dimension match
  if (nyears != nc_df$dimension$len[4]) {
    error("Number of years in header file and length of time dimension in planting_date.nc do not match")
  }

  # Get planting date variable
  vals <- ncdf4::ncvar_get(ncid, varid = "planting.date", collapse_degen = F)

  # Loop through years
  for (i in 1:length(yr)) {
    vals[, , , years == yr[i]] <- doy
  }

  # Write to NetCDF file
  ncdf4::ncvar_put(ncid, "planting.date", vals)

  # Close file
  ncdf4::nc_close(ncid)
}
