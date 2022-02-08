# setup_ibis
# By: Bryan Petersen
# Date: 12.05.21

setup_ibis <- function(file = "ibis_flag.infile", path, irestart = 1,
                       irstyear, iyear0 = 1750, nrun, soilcspin = 0,
                       flg_wrestart = 1, iyearout = 1, imonthout = 0,
                       idailyout = 0, ihourlyout = 0, isimveg, 
                       nstress = 1, imiscanthus0, irotation, iholdsoiln = 1,
                       co2init, snorth, ssouth, swest, seast){
  
  # Get working directory
  wkdir <- getwd()
  
  # Set working directory
  setwd(path)
  
  # Read flag file
  flag_lines <- readLines(file)
  
  if(length(irestart) == 1){
    lines <- gsub(pattern = "!IRESTART!", replacement = irestart, x = flag_lines)
  }else{
    warning("Length of irestart is not equal 1")
  }
  
  if(length(irstyear) == 1){
    lines <- gsub(pattern = "!IRSTYEAR!", replacement = irstyear, x = lines)
  }else{
    warning("Length of irstyear is not equal 1")
  }
  
  if(length(iyear0) == 1){
    lines <- gsub(pattern = "!IYEAR0!", replacement = iyear0, x = lines)
  }else{
    warning("Length of iyear0 is not equal 1")
  }
  
  if(length(nrun)==1){
    lines <- gsub(pattern = "!NRUN!", replacement = nrun, x = lines)
  }else{
    warning("Length of nrun is not equal 1")
  }
  
  if(length(soilcspin)==1){
    lines <- gsub(pattern = "!SOILCSPIN!", replacement = soilcspin, x = lines)
  }else{
    warning("Length of soilcspin is not equal 1")
  }
  
  if(length(flg_wrestart)==1){
    lines <- gsub(pattern = "!FLG_WRESTART!", replacement = flg_wrestart, x = lines)
  }else{
    warning("Length of flg_wrestart is not equal 1")
  }
  
  if(length(iyearout)==1){
    lines <- gsub(pattern = "!IYEAROUT!", replacement = iyearout, x = lines)
  }else{
    warning("Length of iyearout is not equal 1")
  }
  
  if(length(imonthout)==1){
    lines <- gsub(pattern = "!IMONTHOUT!", replacement = imonthout, x = lines)
  }else{
    warning("Length of imonthout is not equal 1")
  }
  
  if(length(idailyout)==1){
    lines <- gsub(pattern = "!IDAILYOUT!", replacement = idailyout, x = lines)
  }else{
    warning("Length of idailyout is not equal 1")
  }
  
  if(length(ihourlyout)==1){
    lines <- gsub(pattern = "!IHOURLYOUT!", replacement = ihourlyout, x = lines)
  }else{
    warning("Length of ihourlyout is not equal 1")
  }
  
  if(length(isimveg)==1){
    lines <- gsub(pattern = "!ISIMVEG!", replacement = isimveg, x = lines)
  }else{
    warning("Length of isimveg is not equal 1")
  }
  
  if(length(nstress)==1){
    lines <- gsub(pattern = "!NSTRESS!", replacement = nstress, x = lines)
  }else{
    warning("Length of nstress is not equal 1")
  }
  
  if(length(imiscanthus0)==1){
    lines <- gsub(pattern = "!IMISCANTHUS0!", replacement = imiscanthus0, x = lines)
  }else{
    warning("Length of imiscanthus is not equal 1")
  }
  
  if(length(irotation)==1){
    lines <- gsub(pattern = "!IROTATION!", replacement = irotation, x = lines)
  }else{
    warning("Length of irotation is not equal 1")
  }
  
  if(length(iholdsoiln)==1){
    lines <- gsub(pattern = "!IHOLDSOILN!", replacement = iholdsoiln, x = lines)
  }else{
    warning("Length of iholdsoiln is not equal 1")
  }
  
  if(length(co2init)==1){
    lines <- gsub(pattern = "!CO2INIT!", replacement = co2init, x = lines)
  }else{
    warning("Length of co2init is not equal 1")
  }
  
  if(length(snorth)==1){
    lines <- gsub(pattern = "!SNORTH!", replacement = snorth, x = lines)
  }else{
    warning("Length of snorth is not equal 1")
  }
  
  if(length(ssouth)==1){
    lines <- gsub(pattern = "!SSOUTH!", replacement = ssouth, x = lines)
  }else{
    warning("Length of ssouth is not equal 1")
  }
  
  if(length(swest)==1){
    lines <- gsub(pattern = "!SWEST!", replacement = swest, x = lines)
  }else{
    warning("Length of swest is not equal 1")
  }
  
  if(length(seast)==1){
    lines <- gsub(pattern = "!SEAST!", replacement = seast, x = lines)
  }else{
    warning("Length of seast is not equal 1")
  }
  
  writeLines(lines, con = "ibis.infile")
  unlink(flag_lines)
  unlink(lines)
  
  # Set back to working directory
  setwd(wkdir)
  
}
