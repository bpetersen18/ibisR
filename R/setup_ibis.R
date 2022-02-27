#' @title Set the ibis.infile
#'
#' @param model_path Path to the model directory.
#' @param file Name of the ibis_flag.infile
#' @param irestart 0: not a restart run  1: restart run
#' @param irstyear actual calendar year of restart run
#' @param iyear0 initial year of simulation (don't change for restart)
#' @param nrun number of years in this simulation (change for restart)
#' @param soilcspin 0: no soil spinup, 1: acceleration procedure used
#' @param flg_wrestart 1(default): write restart files  0: no restart files
#' @param iyearout 0: no yearly output, 1: yearly output   2: yearly output,  in a yearly basis
#' @param imonthout 0: no monthly output, 1: monthly output 2: monthly output, in a yearly basis
#' @param idailyout 0: no daily output, 1: daily output
#' @param ihourlyout 0: no hourly output, 1: hourly output
#' @param isimveg 0: static veg, 1: dynamic veg, 2: dynamic veg-cold start
#' @param nstress 0: no nitrogen stress, 1: apply nitrogen stress
#' @param imiscanthus0 0: miscanthus not grown 1: miscanthus grown everywhere
#' @param irotation 0: none -- 1: w. wheat/fallow -- 2: corn/soy -- 3: corn/corn/soy -- 4: soy/w. wheat/corn -- 5: soy/corn (opposite of 2) -- 6: biomass sorghum/soybean
#' @param iholdsoiln 0: doesn't save soil inorganic N from restart 1: save inorganic soil N
#' @param co2init initial co2 concentration in mol/mol (ex: 0.000400)
#' @param snorth northern latitude for subsetting in/output
#' @param ssouth southern latitude for subsetting in/output
#' @param swest western longitude for subsetting in/output
#' @param seast eastern longitude for subsetting in/output
#'
#' @return Writes out to ibis.infile
#' 
#' @author Bryan Petersen - bryan20@iastate.edu
#'
#' @export

setup_ibis <- function(model_path, file = "ibis_flag.infile", irestart,
                       irstyear, iyear0 = 1751, nrun, soilcspin,
                       flg_wrestart, iyearout, imonthout,
                       idailyout, ihourlyout, isimveg,
                       nstress, imiscanthus0, irotation, iholdsoiln,
                       co2init, snorth, ssouth, swest, seast) {

  # Get working directory
  wkdir <- getwd()

  # Set working directory
  setwd(model_path)

  # Read flag file
  flag_lines <- readLines(file)

  if (length(irestart) == 1) {
    lines <- gsub(pattern = "!IRESTART!", replacement = irestart, x = flag_lines)
  } else {
    warning("Length of irestart is not equal 1")
  }

  if (length(irstyear) == 1) {
    lines <- gsub(pattern = "!IRSTYEAR!", replacement = irstyear, x = lines)
  } else {
    warning("Length of irstyear is not equal 1")
  }

  if (length(iyear0) == 1) {
    lines <- gsub(pattern = "!IYEAR0!", replacement = iyear0, x = lines)
  } else {
    warning("Length of iyear0 is not equal 1")
  }

  if (length(nrun) == 1) {
    lines <- gsub(pattern = "!NRUN!", replacement = nrun, x = lines)
  } else {
    warning("Length of nrun is not equal 1")
  }

  if (length(soilcspin) == 1) {
    lines <- gsub(pattern = "!SOILCSPIN!", replacement = soilcspin, x = lines)
  } else {
    warning("Length of soilcspin is not equal 1")
  }

  if (length(flg_wrestart) == 1) {
    lines <- gsub(pattern = "!FLG_WRESTART!", replacement = flg_wrestart, x = lines)
  } else {
    warning("Length of flg_wrestart is not equal 1")
  }

  if (length(iyearout) == 1) {
    lines <- gsub(pattern = "!IYEAROUT!", replacement = iyearout, x = lines)
  } else {
    warning("Length of iyearout is not equal 1")
  }

  if (length(imonthout) == 1) {
    lines <- gsub(pattern = "!IMONTHOUT!", replacement = imonthout, x = lines)
  } else {
    warning("Length of imonthout is not equal 1")
  }

  if (length(idailyout) == 1) {
    lines <- gsub(pattern = "!IDAILYOUT!", replacement = idailyout, x = lines)
  } else {
    warning("Length of idailyout is not equal 1")
  }

  if (length(ihourlyout) == 1) {
    lines <- gsub(pattern = "!IHOURLYOUT!", replacement = ihourlyout, x = lines)
  } else {
    warning("Length of ihourlyout is not equal 1")
  }

  if (length(isimveg) == 1) {
    lines <- gsub(pattern = "!ISIMVEG!", replacement = isimveg, x = lines)
  } else {
    warning("Length of isimveg is not equal 1")
  }

  if (length(nstress) == 1) {
    lines <- gsub(pattern = "!NSTRESS!", replacement = nstress, x = lines)
  } else {
    warning("Length of nstress is not equal 1")
  }

  if (length(imiscanthus0) == 1) {
    lines <- gsub(pattern = "!IMISCANTHUS0!", replacement = imiscanthus0, x = lines)
  } else {
    warning("Length of imiscanthus is not equal 1")
  }

  if (length(irotation) == 1) {
    lines <- gsub(pattern = "!IROTATION!", replacement = irotation, x = lines)
  } else {
    warning("Length of irotation is not equal 1")
  }

  if (length(iholdsoiln) == 1) {
    lines <- gsub(pattern = "!IHOLDSOILN!", replacement = iholdsoiln, x = lines)
  } else {
    warning("Length of iholdsoiln is not equal 1")
  }

  if (length(co2init) == 1) {
    lines <- gsub(pattern = "!CO2INIT!", replacement = co2init, x = lines)
  } else {
    warning("Length of co2init is not equal 1")
  }

  if (length(snorth) == 1) {
    lines <- gsub(pattern = "!SNORTH!", replacement = snorth, x = lines)
  } else {
    warning("Length of snorth is not equal 1")
  }

  if (length(ssouth) == 1) {
    lines <- gsub(pattern = "!SSOUTH!", replacement = ssouth, x = lines)
  } else {
    warning("Length of ssouth is not equal 1")
  }

  if (length(swest) == 1) {
    lines <- gsub(pattern = "!SWEST!", replacement = swest, x = lines)
  } else {
    warning("Length of swest is not equal 1")
  }

  if (length(seast) == 1) {
    lines <- gsub(pattern = "!SEAST!", replacement = seast, x = lines)
  } else {
    warning("Length of seast is not equal 1")
  }

  writeLines(lines, con = "ibis.infile")
  unlink(flag_lines)
  unlink(lines)

  # Set back to working directory
  setwd(wkdir)
}
