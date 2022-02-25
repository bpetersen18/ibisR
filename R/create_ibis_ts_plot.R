# create_ibis_ts_plot
# By: Bryan Petersen
# Date: 02.21.22
# Purpose: Creates a timeseries plot of the output from *output.R functions

create_ibis_ts_plot <- function(data_tbl) {
  # Load libraries
  require(tidyverse)
  require(lubridate)

  # Convert date from a character to a date
  data_tbl <- data_tbl %>%
    mutate(date = ymd(date))

  # Plot
  p1 <- ggplot(data = data_tbl, mapping = aes(x = date, y = variable_data)) +
    geom_line() +
    labs(x = "Date", y = paste0(unique(data_tbl$variable_name)))

  return(p1)
}
