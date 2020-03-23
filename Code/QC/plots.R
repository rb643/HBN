filelistFD <- list.files('../../Data/QC/QC_Stats/FD/')

fd_mean <- matrix(NA,nrow = length(filelistFD),ncol = 1)
fd_median <- matrix(NA,nrow = length(filelistFD),ncol = 1)
fd_max <- matrix(NA,nrow = length(filelistFD),ncol = 1)
fd_min <- matrix(NA,nrow = length(filelistFD),ncol = 1)

for (i in 1:length(filelistFD)){
  fd_mean[i,] <- mean(as.vector(read.table(paste('../../Data/QC/QC_Stats/FD/',filelistFD[i],sep=""))$V1))
  fd_median[i,] <- median(as.vector(read.table(paste('../../Data/QC/QC_Stats/FD/',filelistFD[i],sep=""))$V1))
  fd_max[i,] <- max(as.vector(read.table(paste('../../Data/QC/QC_Stats/FD/',filelistFD[i],sep=""))$V1))
  fd_min[i,] <- min(as.vector(read.table(paste('../../Data/QC/QC_Stats/FD/',filelistFD[i],sep=""))$V1))
  
}
library(ggplot2)
library(viridis)
library(ggridges)

df <- as.data.frame(cbind(fd_mean,fd_median,fd_max,fd_min))
colnames(df) <- c("mean","median","max","min")                    
df <- melt(df)

fdplot <- ggplot(data=df, aes(x=value,y=variable,fill=variable)) +
  geom_density_ridges(alpha = 0.5) +
  scale_fill_viridis(discrete = T) + 
  theme_minimal() +
  xlim(-1,5) +
  labs(x = "Framewise displacement (mm)") +
  theme(legend.position = "none",
        axis.title.y = element_blank(),
        axis.title.x = element_text()) 


filelistSP <- list.files('../../Data/QC/QC_Stats/SP/')

sp_mean <- matrix(NA,nrow = length(filelistSP),ncol = 1)
sp_median <- matrix(NA,nrow = length(filelistSP),ncol = 1)
sp_max <- matrix(NA,nrow = length(filelistSP),ncol = 1)
sp_min <- matrix(NA,nrow = length(filelistSP),ncol = 1)

for (i in 1:length(filelistSP)){
  sp_mean[i,] <- mean(as.vector(read.table(paste('../../Data/QC/QC_Stats/SP/',filelistSP[i],sep=""))$V1))
  sp_median[i,] <- median(as.vector(read.table(paste('../../Data/QC/QC_Stats/SP/',filelistSP[i],sep=""))$V1))
  sp_max[i,] <- max(as.vector(read.table(paste('../../Data/QC/QC_Stats/SP/',filelistSP[i],sep=""))$V1))
  sp_min[i,] <- min(as.vector(read.table(paste('../../Data/QC/QC_Stats/SP/',filelistSP[i],sep=""))$V1))
  
}


df <- as.data.frame(cbind(sp_mean,sp_median,sp_max,sp_min))
colnames(df) <- c("mean","median","max","min")                    
df <- melt(df)

spplot <- ggplot(data=df, aes(x=value,y=variable,fill=variable)) +
  geom_density_ridges(alpha = 0.5) +
  scale_fill_viridis(discrete = T) + 
  theme_minimal() +
  labs(x = "Spike percentage") +
  theme(legend.position = "none",
        axis.title.y = element_blank(),
        axis.title.x = element_text()) 

library(ggpubr)
fig <- ggarrange(fdplot,spplot, ncol = 2)

png(filename = '../../Figures/qc_fd_sp.png', width = 800, height = 200)
  plot(fig)
dev.off()

filelistMotion <- list.files('../../Data/QC/QC_Stats/Motion/')