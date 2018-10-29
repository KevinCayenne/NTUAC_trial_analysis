
setwd("C:/Users/acer/Desktop/NTU_AC_FINAL/switching/")

upest.wd <- getwd()
File.list.upest = mixedsort(list.files())

final.switching.df <- data.frame()

for (first.i in 1:length(File.list.upest)){
  
  sub.task.name <- unlist(strsplit(File.list.upest[first.i], "[_]"))

  setwd(paste("C:/Users/acer/Desktop/NTU_AC_FINAL/switching/", File.list.upest[first.i], sep = ""))
  File.list.subj <- mixedsort(list.files())
  
  subj.id <- sub.task.name[1] # define sublect's id
  task.name <- sub.task.name[2] # define name of task   
  training.times <- length(File.list.subj) # define total task training times  
  
  for (second.i in 1:training.times){
    # define real training times
    real.training.times <- as.numeric(tail(unlist(strsplit(unlist(strsplit(File.list.subj[second.i],"[.]"))[1], "[_]")), n=1))
    
    #define the level of task
    level <- as.numeric(unlist(strsplit(unlist(strsplit(File.list.subj[second.i],"[.]"))[1], "[_]"))[2])
    
    # create dataframe
    temp.ntuac.df <- read.csv(File.list.subj[second.i], header = F, skip = 1)
    colnames(temp.ntuac.df)[1] <- c("ACC")
    temp.ntuac.df.clean <- temp.ntuac.df[temp.ntuac.df$ACC == "1" | temp.ntuac.df$ACC == "0", c(1:3)]
    colnames(temp.ntuac.df.clean) <- c("ACC", "RESP", "RT")
    
    # set data types in df
    temp.ntuac.df.clean$ACC <- as.factor(as.numeric(as.character(temp.ntuac.df.clean$ACC)))
    temp.ntuac.df.clean$RT <- as.numeric(as.character(temp.ntuac.df.clean$RT))
    temp.ntuac.df.clean$RESP <- as.character(temp.ntuac.df.clean$RESP)
    total.trial <- nrow(temp.ntuac.df.clean)
    # create columns
    Subj.ID <- rep(subj.id, total.trial)
    Task.Name <- rep(task.name, total.trial)
    Level <- rep(level, total.trial)
    Training.Times <- rep(second.i, total.trial)
    Real.Training.Times <- rep(real.training.times, total.trial)
    trials <- seq(1:total.trial)
    
    # add columns
    sub.temp.ntuac.df.clean <- cbind(Subj.ID,
                                     Task.Name,
                                     Level,
                                     Training.Times,
                                     Real.Training.Times,
                                     trials,
                                     temp.ntuac.df.clean
                                     )
    
    # merging into one df
    final.switching.df <- rbind(final.switching.df, sub.temp.ntuac.df.clean)
  }
  print(paste("processing:", round((first.i/length(File.list.upest))*100),"%"))
}

# change data type
final.switching.df$Level <- as.factor(final.switching.df$Level)

#final.nback.df
#final.inhibition.df
#final.switching.df

final.ntuac.trial.df <- rbind(final.nback.df, final.inhibition.df, final.switching.df)
nrow(final.ntuac.trial.df)
str(final.ntuac.trial.df)
