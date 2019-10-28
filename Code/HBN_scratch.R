setwd("~/GitHub/HBN")

## setup
rm(list = ls()) # clear the workspace
library(easypackages) # then we can do the rest in one go

# get a list of all potentially useful packages
list.of.packages <- c("Hmisc","ggplot2","caret","gplots","Rmisc","dplyr",
                      "MatchIt","optmatch","data.table","plotrix","ggthemes", "knitr",
                      "viridis","coin","plyr","psytabs","RColorBrewer","boot", "kableExtra",
                      "msir","lmtest", "ggpubr","stats", "reshape2","xtable",
                      "ez","apa","parallel", "jmuOutlier","Rtsne","fpc", "cluster",
                      "RCurl","nlme","foreach","doParallel", "gridExtra","cowplot")

source("https://bit.ly/2q4XQ66")

# check if they are already installed and otherwise install them
# note: this doesn't work for biocLite tools
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)>0) { install.packages(new.packages)}

# then load them all
libraries(list.of.packages)
rm(list.of.packages, new.packages)


## load some data
df <- 
  do.call(rbind,
          lapply(paste('./Data/Euler/',list.files('./Data/Euler/', pattern = '*.Euler.csv'),sep=""), read.csv))


df <- melt(df, id.vars = c("eid","site"))

# check for site differences
summary(lm(value ~ site + variable, data = df))

# plot distribution
pdf('./Figures/Euler_by_site.pdf', height = 6, width = 9)
ggplot(data = df, aes(y = value, x = site, fill = site)) +
  geom_flat_violin(position = position_nudge(x = .2, y = 0), alpha = .8) +
  geom_point(aes(y = value), position = position_jitter(width = .15), 
             size = 1.5, alpha = 0.8) +
  geom_boxplot(width = .1, guides = FALSE, outlier.shape = NA, alpha = 0.5) +
  expand_limits(x = 1.5) +
  guides(fill = FALSE) +
  guides(color = FALSE) +
  xlab("Site") +
  ylab("Euler Index") +
  coord_flip() +
  theme_cowplot() +
  facet_wrap(~variable)
  dev.off()
  
  
  df <- read.csv('./Data/data-2019-10-26T14_33_12.929Z.csv')  
  df$age <- as.numeric(as.character(df$Basic_Demos.Age))
  df <- df[!(is.na(df$age) | df$age==""), ]
 
  age <- ggplot(data = df, aes(y = age, x = Basic_Demos.Sex, fill = Basic_Demos.Sex)) +
    geom_flat_violin(position = position_nudge(x = .2, y = 0), alpha = .8) +
    geom_point(aes(y = age), position = position_jitter(width = .15), 
               size = 1.5, alpha = 0.8) +
    geom_boxplot(width = .1, guides = FALSE, outlier.shape = NA, alpha = 0.5) +
    expand_limits(x = 1.5) +
    guides(fill = FALSE) +
    guides(color = FALSE) +
    xlab("Sex") +
    ylab("Age") +
    coord_flip() +
    theme_cowplot() 
  
  df$bmi <- as.numeric(as.character(df$Physical.BMI))
  df <- df[!(is.na(df$bmi) | df$bmi==""), ]
  
  bmi <- ggplot(data = df, aes(y = bmi, x = Basic_Demos.Sex, fill = Basic_Demos.Sex)) +
    geom_flat_violin(position = position_nudge(x = .2, y = 0), alpha = .8) +
    geom_point(aes(y = bmi), position = position_jitter(width = .15), 
               size = 1.5, alpha = 0.8) +
    geom_boxplot(width = .1, guides = FALSE, outlier.shape = NA, alpha = 0.5) +
    expand_limits(x = 1.5) +
    guides(fill = FALSE) +
    guides(color = FALSE) +
    xlab("Sex") +
    ylab("BMI") +
    coord_flip() +
    theme_cowplot() 
  
  ggarrange(age,bmi,ncol=2)
  