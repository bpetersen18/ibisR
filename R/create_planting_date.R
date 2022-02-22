# create_planting_date
# By: Bryan Petersen
# Date: 01.28.22

# Load libraries
library(ncdf4)
library(ncdump)

# Read in surta for grid
ncid <- nc_open("/Volumes/lab_ssd/gridmet/surta.nc")

# Get dimensions
nc_df <- NetCDF("/Volumes/lab_ssd/gridmet/surta.nc")

# Get lat and lon
lat <- ncvar_get(ncid, varid = "latitude")
lon <- ncvar_get(ncid, varid = "longitude")

# Set number of years
t <- 1:(2021 - 1950 + 1)

# Create array
date_array <- array(data = 90, dim = c(nc_df$dimension$len[1], nc_df$dimension$len[2], 1, length(t)))

# Create and write the planting date NetCDF file
# # Define dimensions
londim <- ncdim_def("longitude", "degrees_east", as.double(lon))
latdim <- ncdim_def("latitude", "degrees_north", as.double(lat))
timedim <- ncdim_def("time", "year", t)
leveldim <- ncdim_def("level", "unitless", 1)

# Define variables
dlname <- "Planting Date"
date_def <- ncvar_def("planting.date", "Julian day", list(londim, latdim, leveldim, timedim),
                      longname = dlname, prec = "integer")

# Create NetCDF file and put arrays
ncout1 <- nc_create("/Volumes/lab_ssd/gridmet/management/planting_date_average.nc", list(date_def))

# Put variables
ncvar_put(ncout1, date_def, date_array)

# Put additional attributes into dimension and data variables
ncatt_put(ncout1, "longitude", "axis", "X")
ncatt_put(ncout1, "latitude", "axis", "Y")
ncatt_put(ncout1, "time", "axis", "T")
ncatt_put(ncout1, "level", "axis", "L")

# Close NetCDF file
nc_close(ncid)
nc_close(ncout1)
