# this script is written on 09.02.2020 in Jena by G. Moroz
# this script create a new version of glottolog database in lingtypology

library(tidyverse)
library(data.tree)
tr <- ape::read.tree("https://cdstar.shh.mpg.de/bitstreams/EAEA0-3DAE-E27B-4692-0/tree_glottolog_newick.txt")
df <- read_csv("https://cdstar.shh.mpg.de/bitstreams/EAEA0-3DAE-E27B-4692-0/languages_and_dialects_geo.csv")

affiliation <- map_dfr(seq_along(tr), function(i){
  tibble(affiliation = ToDataFrameTable(as.Node(tr[[i]]), "pathString"))
})


str_split_fixed(affiliation$affiliation, "-l-/", 2) %>%
  as_tibble() %>%
  mutate(V2 = str_remove(V2, "-l-"),
         V1 = ifelse(V2 == V1, "Language isolate", V1),
         V2 = ifelse(V2 == "", "", str_c(V1, V2, sep = "/"))) %>%
  pivot_longer(names_to = "names", values_to = "affiliation", V1:V2) %>%
  select(affiliation) %>%
  filter(affiliation != "Language isolate",
         affiliation != "") %>%
  unlist() %>%
  str_split("/") %>%
  {tibble(name = map_chr(., last),
         affiliation = map_chr(., function(x){str_c(x, collapse = ",")}))} %>%
  mutate(glottocode = str_extract(name, "\\[.*?\\]"),
         glottocode = str_remove_all(glottocode, "\\[|\\]"),
         affiliation = str_remove_all(affiliation, "\\[.*?\\]|(-l-)?"),
         affiliation = str_replace_all(affiliation, "([:upper:])", " \\1"),
         affiliation = str_replace_all(affiliation, "(,|ǂ|-|\\||!|=|3)\\s{1,}", "\\1"),
         affiliation = str_replace_all(affiliation, "^ ", ""),
         affiliation = str_replace_all(affiliation, "\\{ ", " \\("),
         affiliation = str_replace_all(affiliation, "\\}", "\\)"),
         affiliation = str_replace_all(affiliation, "U S A", "USA")) %>%
  select(-name) %>%
  distinct() %>%
  full_join(df, by = "glottocode") ->
  glottolog

glottolog %>%
  rename(language = name,
         iso = isocodes,
         area = macroarea) %>%
  mutate(longitude = ifelse(longitude < -37, longitude + 360, longitude)) ->
  glottolog

setwd("/home/agricolamz/work/packages/lingtypology/lingtypology/data/")
save(glottolog, file="glottolog.RData", compress='xz')
