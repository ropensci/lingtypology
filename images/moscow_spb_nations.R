library(tidyverse)
setwd("/home/agricolamz/_DATA/OneDrive1/_Work/github/lingtypology/images")
df <- read.csv("moscow_spb_nations.csv")
df %>%
  filter(city == "St. Petersburg") %>%
#  filter(city == "Moscow") %>%
  ggplot(aes(nation, number/1000, fill = nation))+
  geom_bar(stat = "identity")+
  scale_y_continuous("log(1000/x) people", breaks = 10^(1:5), limits = c(1, 10000), trans = "log")+
  xlab("")+
  theme_bw()+
  theme(axis.text = element_text(size = rel(1.3)))+
  coord_flip()+
  guides(fill=FALSE) #+
  # facet_wrap(~city)


