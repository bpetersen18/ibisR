#' @title Creates a general timeseries plot from AgroIBIS output.
#' 
#' @name create_ibis_ts_plot
#' 
#' @param data_tbl Output from get_*_output functions
#' 
#' @return A ggplot object
#' 
#' @author Bryan Petersen - bryan20@iastate.edu
#' @export

create_ibis_ts_plot <- function(data_tbl) {
  `%>%` <- magrittr::`%>%`
  
  # Convert date from a character to a date
  data_tbl <- data_tbl %>%
    dplyr::mutate(date = lubridate::ymd(date))

  # Plot
  p1 <- ggplot2::ggplot(data = data_tbl, mapping = ggplot2::aes(x = date, y = variable_data)) +
    ggplot2::geom_line() +
    ggplot2::labs(x = "Date", y = paste0(unique(data_tbl$variable_name)))

  return(p1)
}
