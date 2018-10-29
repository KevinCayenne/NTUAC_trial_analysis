library(stringi)
library(tidyverse)
library(ggplot2)
library(ggpubr)
library(gtools)
library(magrittr)
library(tidyr)
library(dplyr)
library(gridExtra)
library(ggsignif)
library(lme4)
library(lmerTest)

setwd("C:/Users/acer/Desktop/NTUAC第七梯/NTUAC分數紀錄_第七梯/") # uppest wd, counting for subjects.
upest.wd <- getwd()
File.list.upest = mixedsort(list.files())

nb.wd <- "C:/Users/acer/Desktop/NTU_AC_FINAL/nback/"
nb.wd.sub <- list.files(nb.wd)
  
sw.wd <- "C:/Users/acer/Desktop/NTU_AC_FINAL/switching/"
sw.wd.sub <- list.files(sw.wd)

inh.wd <- "C:/Users/acer/Desktop/NTU_AC_FINAL/inhibition/"
inh.wd.sub <- list.files(inh.wd)

start.sub <- 1
out.i <- 24

for (first.i in start.sub:length(File.list.upest)){
  
  setwd(paste(upest.wd, "/", File.list.upest[first.i], sep = "")) # second wd for sub.
  File.list.second = mixedsort(list.files())
  
  for (second.i in 1:length(File.list.second)){
  
    setwd(paste(upest.wd, "/", File.list.upest[first.i], "/", File.list.second[second.i], sep="")) # third wd for sessions.
    File.list.third = mixedsort(list.files())
    length(File.list.third)
    if(length(File.list.third) != 0){
      for (third.i in 1:length(File.list.third)){
        
        temp.file.name <- paste(upest.wd, "/", 
                                File.list.upest[first.i], "/", 
                                File.list.second[second.i], "/",
                                File.list.third[third.i], sep="")
        
        temp.name <- unlist(strsplit(File.list.third[third.i], "[.]"))
        
        #decide if the file type is .csv
          if(temp.name[2] == "csv"){ 
            first.char <- substring(temp.name[1], 1, 2)
            if (first.char == "Nb"){
              file.copy(temp.file.name, paste(nb.wd, nb.wd.sub[out.i], sep = ""))
            } else if (first.char == "Sw"){
              file.copy(temp.file.name, paste(sw.wd, sw.wd.sub[out.i], sep = ""))
            } else if (first.char == "St"){
              file.copy(temp.file.name, paste(inh.wd, inh.wd.sub[out.i], sep = ""))
            }
          }
        }
    }
  }
  out.i <- out.i + 1
}
