extractEuler_run <- function(site,...) {
  filelist <- read.table(paste(site,'_subs.txt',sep=""))
  source("extractEuler.R")

  outp <- data.frame()

  for (i in filelist$V1) {
    eid <- i
    inputdir <-
      paste(
        '/lustre/archive/q10021/HBN/',
        site,
        '/derivatives/',
        eid,
        if (site == "Site-CBIC"){
        'T1w_HCP_run-01/freesurfer/surf/'
      } else {
        'freesurfer/surf/'
      }
        ,sep = .Platform$file.sep
      )
    if (file.exists(paste(inputdir,'/lh.orig.nofix',sep=""))) {
      print(eid)
      tempOut <- extractEuler(inputdir, eid)
      tempOut$site <- site
      outp <- rbind(outp, tempOut)
    }
  }

  write.table(outp,
              file = '/lustre/archive/q10021/HBN/Data_Out/Euler.csv',
              quote=FALSE,
              row.names = FALSE,
              col.names = TRUE,
              sep = ",")

}
