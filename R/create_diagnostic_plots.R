#' @title Creates plots that are useful when testing AgroIBS.
#' 
#' @name create_diagnostic_plots
#' 
#' @param model_path Path to the model directory
#' @param create_interactive Logical, indicating if you want to create interactive plots which will be output has html files
#' @param save_dir If create_interactive is TRUE, this is the directory where the interactive plots will be saved.
#' 
#' @return A ggplot object
#' 
#' @author Bryan Petersen - bryan20@iastate.edu
#' @export

create_diagnostic_plots <- function(model_path, create_interactive = F, save_dir = NULL){
  # Create weather plot
  weather_plt <- ibisR::create_weather_plot(model_path)
  
  # Get plai data
  plai_tbl <- ibisR::get_daily_output(paste0(model_path, "/output/daily/plai.nc"), "plai",
                               pft = 16, average_spatial = T) %>% 
    dplyr::mutate(date = lubridate::ymd(date))
  
  # Plot plai data
  plai_plt <- ibisR::create_ibis_ts_plot(plai_tbl)
  
  # Get adnpp data
  adnpp_tbl <- ibisR::get_daily_output(paste0(model_path, "/output/daily/adnpp.nc"), "adnpp",
                            pft = 16, average_spatial = T) %>% 
    dplyr::mutate(date = lubridate::ymd(date))
  
  # Plot adnpp data
  adnpp_plt <- ibisR::create_ibis_ts_plot(adnpp_tbl)
  
  # Create composite plot
  design <- "AB
             CC"
  plt <- patchwork::wrap_plots(A = adnpp_plt, B = plai_plt, C = weather_plt, design = design)
  
  plt
  
  # Create interactive plots
  if (create_interactive == T){
    weather_plt_interactive <- plotly::ggplotly(weather_plt, tooltip = c("text", "y", "x"), dynamicTicks = T)
    htmlwidgets::saveWidget(plotly::as_widget(weather_plt_interactive),
               dplyr::if_else(is.null(save_dir), "WeatherPlot.html", paste0(save_dir, "/WeatherPlot.html")))
    
    plai_plt_interactive <- plotly::ggplotly(plai_plt, dynamicTicks = T)
    htmlwidgets::saveWidget(ploty::as_widget(plai_plt_interactive),
               dplyr::if_else(is.null(save_dir), "PlaiPlot.html", paste0(save_dir, "/PlaiPlot.html")))
    
    adnpp_plt_interactive <- plotly::ggplotly(adnpp_plt, dynamicTicks = T)
    htmlwidgets::saveWidget(plotly::as_widget(adnpp_plt_interactive),
               dplyr::if_else(is.null(save_dir), "AdnppPlot.html", paste0(save_dir, "/AdnppPlot.html")))
  }
  
  return(plt)
}