#' @title Creates a plot that shows daily max and min temperature and precipitation
#'
#' @name create_weather_plot
#'
#' @param model_path Path to the model directory
#'
#' @return A ggplot object
#' @author Bryan Petersen - bryan20@iastate.edu
#'
#' @export

create_weather_plot <- function(model_path) {
  `%>%` <- magrittr::`%>%`

  # Get daily maximum and minimum temperature
  ncvars <- c("tmax", "tmin")
  temp_tbl <- purrr::map_dfr(ncvars, ~ ibisR::get_daily_output(paste0(model_path, "/output/daily/weather.nc"), ., average_spatial = T)) %>%
    dplyr::mutate(date = lubridate::ymd(date), variable_data = variable_data - 273.15)

  # Get daily precipitation
  precip_tbl <- ibisR::get_daily_output(paste0(model_path, "/output/daily/weather.nc"), "precip", average_spatial = T) %>%
    dplyr::mutate(date = lubridate::ymd(date))

  # Set limits for graph
  ylim.sec <- c(min(temp_tbl$variable_data), max(temp_tbl$variable_data))
  ylim.prim <- c(0, max(precip_tbl$variable_data))
  b <- diff(ylim.prim) / diff(ylim.sec)
  a <- ylim.prim[1] - b * ylim.sec[1]

  # Create plot
  p1 <- ggplot2::ggplot(data = temp_tbl, mapping = ggplot2::aes(
    x = date, y = a + variable_data * b, group = variable_name,
    color = variable_name,
    text = paste0(
      "Temp: ", round(variable_data, digits = 1), " degC \n",
      "Date: ", date
    )
  )) +
    ggplot2::geom_line() +
    ggplot2::geom_col(data = precip_tbl, mapping = ggplot2::aes(x = date, y = variable_data), inherit.aes = F) +
    ggplot2::scale_y_continuous(
      name = "Precipitation (mm)",
      sec.axis = ggplot2::sec_axis(~ (. - a) / b, name = "Temperature (degC)")
    ) +
    ggplot2::labs(x = "Date", color = "Temperature") +
    ggplot2::theme_classic()

  return(p1)
}
