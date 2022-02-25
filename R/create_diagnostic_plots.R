
# create_diagnostic_plots
# By: Bryan Petersen
# Date: 02.21.22
# Creates plots of weather, plai, and adnpp

create_diagnostic_plots <- function(model_path, create_interactive = F, save_dir = NULL){
  # Load libraries
  require(tidyverse)
  require(lubridate)
  require(patchwork)
  require(htmlwidgets)
  require(plotly)
  require(gapminder)
  
  # Source functions
  source("get_daily_output.R")
  source("create_weather_plot.R")
  source("create_ibis_ts_plot.R")
  
  # Create weather plot
  weather_plt <- create_weather_plot(model_path)
  
  # Get plai data
  plai_tbl <- get_daily_output(paste0(model_path, "/output/daily/plai.nc"), "plai",
                               pft = 16, average_spatial = T) %>% 
    mutate(date = ymd(date))
  
  # Plot plai data
  plai_plt <- create_ibis_ts_plot(plai_tbl)
  
  # Get adnpp data
  adnpp_tbl <- get_daily_output(paste0(model_path, "/output/daily/adnpp.nc"), "adnpp",
                            pft = 16, average_spatial = T) %>% 
    mutate(date = ymd(date))
  
  # Plot adnpp data
  adnpp_plt <- create_ibis_ts_plot(adnpp_tbl)
  
  # Create composite plot
  plt <- (adnpp_plt + plai_plt)/weather_plt
  
  plt
  
  # Create interactive plots
  if (create_interactive == T){
    weather_plt_interactive <- ggplotly(weather_plt, tooltip = c("text", "y", "x"), dynamicTicks = T)
    saveWidget(as_widget(weather_plt_interactive),
               if_else(is.null(save_dir), "WeatherPlot.html", paste0(save_dir, "/WeatherPlot.html")))
    
    plai_plt_interactive <- ggplotly(plai_plt, dynamicTicks = T)
    saveWidget(as_widget(plai_plt_interactive),
               if_else(is.null(save_dir), "PlaiPlot.html", paste0(save_dir, "/PlaiPlot.html")))
    
    adnpp_plt_interactive <- ggplotly(adnpp_plt, dynamicTicks = T)
    saveWidget(as_widget(adnpp_plt_interactive),
               if_else(is.null(save_dir), "AdnppPlot.html", paste0(save_dir, "/AdnppPlot.html")))
  }
  
  return(plt)
}