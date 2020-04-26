# this script is written on 09.02.2020 in Jena by G. Moroz
# this script create a new version of glottolog database in lingtypology
setwd("/home/agricolamz/work/packages/lingtypology/lingtypology/database_creation")

library(tidyverse)
library(data.tree)
tr <- ape::read.tree("https://cdstar.shh.mpg.de/bitstreams/EAEA0-18EC-5079-0173-0/tree_glottolog_newick.txt")
df <- read_csv("https://cdstar.shh.mpg.de/bitstreams/EAEA0-18EC-5079-0173-0/languages_and_dialects_geo.csv")

affiliation <- map_dfr(seq_along(tr), function(i){
  tibble(affiliation = ToDataFrameTable(as.Node(tr[[i]]), "pathString"))
})

str_split_fixed(affiliation$affiliation, "-l-/", 2) %>%
  as_tibble() %>%
  separate(V2, into = c("V2", "V3", "V4", "V5", "V6", "V7"), sep = "/", fill = "right") %>%
  mutate_all(function(x){ifelse(is.na(x), "", x)}) %>%
  mutate(V2 = str_remove(V2, "-l-"),
         V3 = str_remove(V3, "-l-"),
         V4 = str_remove(V4, "-l-"),
         V5 = str_remove(V5, "-l-"),
         V6 = str_remove(V6, "-l-"),
         V7 = str_remove(V7, "-l-"),
         V1 = ifelse(V2 == V1, "Language isolate", V1),
         V7 = ifelse(V2 == "", "", str_c(V1, V2, V3, V4, V5, V6, V7, sep = "/")),
         V6 = ifelse(V2 == "", "", str_c(V1, V2, V3, V4, V5, V6, sep = "/")),
         V5 = ifelse(V2 == "", "", str_c(V1, V2, V3, V4, V5, sep = "/")),
         V4 = ifelse(V2 == "", "", str_c(V1, V2, V3, V4, sep = "/")),
         V3 = ifelse(V2 == "", "", str_c(V1, V2, V3, sep = "/")),
         V2 = ifelse(V2 == "", "", str_c(V1, V2, sep = "/"))) %>%
  pivot_longer(names_to = "names", values_to = "affiliation", V1:V7) %>%
  select(affiliation) %>%
  filter(affiliation != "Language isolate",
         affiliation != "") %>%
  mutate(affiliation = str_remove(affiliation, "/{1,}$")) %>%
  distinct() %>%
  unlist() %>%
  str_split("/") %>%
  {tibble(name = map_chr(., last),
         affiliation = map_chr(., function(x){
           ifelse(length(x) == 1,
                  str_c(x, collapse = ","),
                  str_c(x[-length(x)], collapse = ","))}))} %>%
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


# get info about retired languages --------------------------------------
library(rvest)

glottolog %>%
  filter(is.na(affiliation)) %>%
  mutate(retired = map_lgl(glottocode, function(i){
    print(i)
    source <- read_html(str_c("https://glottolog.org/resource/languoid/id/", i))
    source %>%
      html_nodes("div.alert") %>%
      html_text() ->
      result
    length(result) != 0
  })) ->
    glottolog_retiered

glottolog_retiered %>%
  mutate(affiliation = ifelse(retired, "retired", affiliation),
         affiliation = ifelse(str_detect(language, "Sign"), "Sign Language", affiliation)) %>%
  select(-retired) ->
  glottolog_retiered

glottolog_retiered %>%
  filter(is.na(affiliation)) %>%
  mutate(affiliation = map_chr(glottocode, function(i){
    print(i)
    source <- read_html(str_c("https://glottolog.org/resource/languoid/id/", i))
    source %>%
      html_nodes("h3") %>%
      html_text() ->
      result
    result[1] %>%
      str_extract(".*?:") %>%
      str_remove("^\\s{1,}") %>%
      str_remove(":")
  })) ->
  glottolog_nas

glottolog_nas %>%
  mutate(affiliation = ifelse(affiliation == "Dialect", NA, affiliation)) ->
  glottolog_nas

glottolog_nas %>%
  filter(is.na(affiliation)) %>%
  write_csv("glottolog_check_affiliation.csv", na = "")

glottolog_manual_check <- read_csv("glottolog_check_affiliation.csv")

glottolog_retiered %>%
  filter(!is.na(affiliation)) %>%
  bind_rows(glottolog_nas) %>%
  filter(!is.na(affiliation)) %>%
  bind_rows(glottolog_manual_check) ->
  non_standard_glottolog

glottolog %>%
  filter(!is.na(affiliation)) %>%
  bind_rows(non_standard_glottolog) %>%
  distinct() %>%
  filter(!is.na(glottocode))->
  glottolog

setwd("/home/agricolamz/work/packages/lingtypology/lingtypology/data/")
save(glottolog, file="glottolog.RData", compress='xz')
