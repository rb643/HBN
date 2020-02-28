## Generic function to:
  ## Extract the left and right hemisphere Euler indices
  ## Assumes freesurfer has been run and is installed on the platform on which this will be run
  
  ## By:
  ## Richard A.I. Bethlehem
  ## University of Cambridge
  ## ©rb643 2019
  
  ## NOTE: 
  ## this does not run in RStudio only from command line 
  ## as RStudio does not read the default path settings so freesurfer won't work as a system command
  
  ## EXAMPLE USAGE:
  ## extractEuler("./UKB/Data/UKB4201528/surfaces/UKB4201528/surf","UKB4201528")

extractEuler <- function(fsDir,eid,... ) {
  
  ## initialize a temporary dataframe
  output <- data.frame(eid=character(),
                       eulerLeft=double(),
                       eulerRight=double())
  output[nrow(output)+1,] <- NA #just to avoid having to assign values to an empty data-frame
  output$eid <- eid
    
  ##set default files
  infileL <- paste(fsDir,'lh.orig.nofix',sep=.Platform$file.sep)
  outfileL <- paste(fsDir,'_lh_euler.txt',sep=.Platform$file.sep)
  
  infileR <- paste(fsDir,'rh.orig.nofix',sep=.Platform$file.sep)
  outfileR <- paste(fsDir,'_rh_euler.txt',sep=.Platform$file.sep)
  
  ##run mris_euler_number on both hemis, save output to text file for future reference, read txt file and extract the Euler index
  system2("mris_euler_number", 
          args = paste(infileL,"2>",outfileL,sep = " "))
  dataLeft <- grep("holes",readLines(outfileL),value = TRUE)
  ## check datalength
  nlengthL <- nchar(strsplit(dataLeft,"--> ")[[1]][2])-5
  output$eulerLeft <- as.numeric(substr(strsplit(dataLeft,"--> ")[[1]][2], start = 1, stop = nlengthL))


  system2("mris_euler_number", 
          args = paste(infileR,"2>",outfileR,sep = " "))
  dataRight <- grep("holes",readLines(outfileR),value = TRUE)
  ## check datalength
  nlengthR <- nchar(strsplit(dataRight,"--> ")[[1]][2])-5
  output$eulerRight <- as.numeric(substr(strsplit(dataRight,"--> ")[[1]][2], start = 1, stop = nlengthR))

  return(output)
}
  
