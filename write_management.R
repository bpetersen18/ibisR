# write_management
# By: Bryan Petersen
# Date: 01.13.21

# Libraries
require(raster)
require(ncdf4)
require(lubridate)

# # Get working directory
# wkdir <- getwd()
# 
# # Set working directory
# model_path <- "~/gridmet/"
# setwd(model_path)
# 
# # Read grid
# grid <- raster("input/surta.nc")
# 
# # Set date in year
# md <- "0401"
# dt <- ymd(paste0("2000",md))
# jday <- yday(dt)
# 
# # Fill raster with julian date
# values(grid) <- as.integer(jday)
# 
# 
# # Get lat and lon
# lon <- xFromCol(grid)
# lat <- yFromRow(grid)
# 
# # Set number of years
# yrs <- 1
# 
# # Create array
# date_array <- array(values(grid), dim = c(length(lon), length(lat), yrs, 1))
# 
# # Path and file name, set dimension name
# ncpath <- "input/management/"
# ncname <- "planting_date_average"
# ncfname <- paste0(ncpath, ncname, ".nc")
# dname <- "planting.date"
# 
# # Create and write the NetCDF file
# # Define dimensions
# londim <- ncdim_def("lon", "degrees_east", as.double(lon))
# latdim <- ncdim_def("lat", "degrees_north", as.double(lat))
# timedim <- ncdim_def("year", "year_number", as.integer(yrs))
# leveldim <- ncdim_def("level", "unitless", 1)
# 
# # Define variables
# fillvalue <- 9E20
# dlname <- "Planting Date"
# date_def <- ncvar_def("planting.date", "Julian day", list(londim, latdim, timedim, leveldim),
#                       fillvalue, dlname, prec = "float")
# 
# 
# # Create NetCDF file and put arrays
# ncout <- nc_create(ncfname, list(date_def))
# 
# # Put variables
# ncvar_put(ncout, date_def, date_array)
# 
# # Put additional attributes into dimension and data variables
# ncatt_put(ncout, "lon", "axis", "X")
# ncatt_put(ncout, "lat", "axis", "Y")
# ncatt_put(ncout, "year", "axis", "T")
# ncatt_put(ncout, "level", "axis", "L")

ncid <- nc_open("input/management/planting_date_average.nc", write = T)

nc_df <- NetCDF("input/management/planting_date_average.nc")

vals <- rep(92, times = prod(nc_df$dimension$len))

ncvar_put(ncid, "planting.date", vals)



nc_close(ncid)


