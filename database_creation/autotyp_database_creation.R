download.file("https://github.com/autotyp/autotyp-data/raw/master/data/autotyp.RData",
              destfile = "~/Desktop/autotyp.RData")
load("~/Desktop/autotyp.RData")
rm(Definitions)

library(tidyverse)
map_dfr(ls(), function(i){
  data.frame(file = i,
             variable = colnames(get(i)))
}) ->
  file_variables

system("cd ~/Desktop/; git clone https://github.com/autotyp/autotyp-data")
files <- list.files("~/Desktop/autotyp-data/data/csv", recursive = TRUE)


file_variables %>%
  distinct(file) %>%
  pull(file) %>%
  map_dfr(function(i){
    data.frame(file = i,
               path = str_subset(files, str_c(i, ".csv")))
  }) %>%
  full_join(file_variables) %>%
  filter(!(variable %in% c("LID", "Glottocode", "Language", "NPStructureExample", "Examples"))) ->
  autotyp

save(autotyp, file="data/autotyp.RData", compress= 'xz')
