# create_weather_plot
# By: Bryan Petersen
# Date: 02.20.22

create_weather_plot <- function(model_path){
  # Load libraries
  require(tidyverse)
  
  # Source functions
  source("get_daily_output.R")
  
  # Get daily maximum and minimum temperature
  ncvars <- c("tmax", "tmin")
  temp_tbl <- map_dfr(ncvars, ~get_daily_output(paste0(model_path, "/output/daily/weather.nc"), ., average_spatial = T)) %>% 
    mutate(date = ymd(date), variable_data = variable_data - 273.15)
  
  # Get daily precipitation
  precip_tbl <- get_daily_output(paste0(model_path, "/output/daily/weather.nc"), "precip", average_spatial = T) %>% 
    mutate(date = ymd(date))
  
  # Set limits for graph
  ylim.sec <- c(min(temp_tbl$variable_data), max(temp_tbl$variable_data))
  ylim.prim <- c(0, max(precip_tbl$variable_data))
  b <- diff(ylim.prim)/diff(ylim.sec)
  a <- ylim.prim[1] - b*ylim.sec[1]
  
  # Create plot
  p1 <- ggplot() + 
    geom_col(data = precip_tbl, mapping = aes(x = date, y = variable_data)) +
    geom_line(data = temp_tbl, mapping = aes(x = date, y = a + variable_data*b, color = variable_name)) +
    scale_y_continuous(name = "Precipitation (mm)",
                       sec.axis = sec_axis(~ (. - a)/b, name = "Temperature (degC)")) +
    labs(x = "Date", color = "Temperature") +
    theme_classic()
  
  return(p1)
  
}
