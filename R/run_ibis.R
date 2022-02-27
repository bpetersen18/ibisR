#' @title Run Agro-IBIS and copy model output and restart files
#' 
#' @name run_ibis
#'
#' @param model_path Path to the model directory.
#' @param compile_flag If set to TRUE, it will compile the model before running.
#' @param copy_output_path Path to copy the output directory.
#' @param copy_restart_path Path to copy the restart directory.
#' 
#' @author Bryan Petersen - bryan20@iastate.edu
#'
#' @export
run_ibis <- function(model_path = ".", compile_flag = F, copy_output_path = NULL,
                     copy_restart_path = NULL) {

   # Get working directory
   wkdir <- getwd()
  
   # Set working directory
   setwd(model_path)


  # Compile Agro-IBIS
  if (compile_flag == T) {
    system("make")
  }

  # Run Agro-IBIS
  ibis_output <- system("./ibis", intern = T)

  # Check if comgrid matches the number of land points in the simulation
  if (sum(stringr::str_detect(ibis_output, "in surta =")) == 1) {
    # Get the number of land points in the simulation
    npoints <- as.integer(unlist(stringr::str_split(ibis_output[stringr::str_detect(ibis_output, "in surta =")], pattern = " ")))[!is.na(as.integer(unlist(stringr::str_split(ibis_output[stringr::str_detect(ibis_output, "in surta =")], pattern = " "))))][1]

    # Read comgrid_flag file
    comgrid <- readLines("comgrid_flag")

    # Change comgrid.f to match the number of land points in the simulation
    new_comgrid <- gsub(pattern = "!NPOI!", replacement = npoints, x = comgrid)

    # Write to comgrid.f
    writeLines(new_comgrid, con = "comgrid.f")

    unlink(comgrid)
    unlink(new_comgrid)

    # Compile Agro-IBIS
    system("make")

    # Run Agro-IBIS
    ibis_output <- system("./ibis > out.txt", intern = T)
  }
  setwd(wkdir)

  # Copy output and restart files
  if (!is.null(copy_output_path)) {
    system(paste0("mkdir -p ", copy_output_path, "&& cp -r ", model_path, "/output", copy_output_path))
  }
  if (!is.null(copy_restart_path)) {
    system(paste0("mkdir -p ", copy_restart_path, "&& cp -r ", model_path, "/restart", copy_restart_path))
  }
}
