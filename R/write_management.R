# write_management
# By: Bryan Petersen
# Date: 01.13.21

write_management <- function(ibis_dir, yr, doy) {

  # Load Libraries
  require(raster)
  require(ncdf4)
  require(lubridate)
  require(stringr)
  require(ncdump)

  # Check to see if day of year is a character
  if (is.character(doy)) {
    doy <- yday(mdy(paste0(doy, "-", yr)))
  }

  # Open planting data NetCDF
  ncid <- nc_open(paste0(ibis_dir, "/input/management/planting_date_average.nc"), write = T)

  # Read header file
  hdr <- scan(file = paste0(ibis_dir, "/input/management/planting_date_and_cultivar.hdr"), what = character(), sep = "\n")

  # Get starting year
  year0 <- as.numeric(str_split(hdr, pattern = "!")[[1]][1])

  # Number of years
  nyears <- as.numeric(str_split(hdr, pattern = "!")[[2]][1])

  # Create vector of years
  years <- seq(from = year0, by = 1, length.out = nyears)

  # Get structure NetCDF
  nc_df <- NetCDF(paste0(ibis_dir, "/input/management/planting_date_average.nc"))

  # Check to see header file and time dimension match
  if (nyears != nc_df$dimension$len[4]) {
    error("Number of years in header file and length of time dimension in planting_date.nc do not match")
  }

  # Get planting date variable
  vals <- ncvar_get(ncid, varid = "planting.date", collapse_degen = F)

  # Loop through years
  for (i in 1:length(yr)) {
    vals[, , , years == yr[i]] <- doy
  }

  # Write to NetCDF file
  ncvar_put(ncid, "planting.date", vals)

  # Close file
  nc_close(ncid)
}
