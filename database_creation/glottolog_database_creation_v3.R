library(tidyverse)
read_csv("https://raw.githubusercontent.com/glottolog/glottolog-cldf/master/cldf/codes.csv") %>%
  filter(str_detect(ID, "aes")) %>%
  mutate(new_value = str_c(Name, " (", Description, ")")) %>%
  select(ID, new_value) ->
  aes_codes

read_csv("https://raw.githubusercontent.com/glottolog/glottolog-cldf/master/cldf/values.csv") %>%
  mutate_all(function(x) ifelse(x == "<NA>", NA, x)) %>%
  mutate(Value = ifelse(Parameter_ID == "aes", Code_ID, Value)) %>%
  full_join(aes_codes, c("Value" = "ID")) %>%
  mutate(Value = ifelse(is.na(new_value), Value, new_value)) %>%
  select(-new_value) ->
  values

read_csv("https://raw.githubusercontent.com/glottolog/glottolog-cldf/master/cldf/languages.csv") %>%
  mutate_all(function(x) ifelse(x == "<NA>", NA, x)) ->
  languages

values %>%
  select(Language_ID, Parameter_ID, Value) %>%
  pivot_wider(names_from = Parameter_ID, values_from = Value) %>%
  left_join(languages, c("Language_ID" = "ID")) %>%
  mutate(Longitude = ifelse(Longitude < -37, Longitude + 360, Longitude),
         level = case_when(category == "Artificial_Language" ~ "artificial language",
                           category == "Bookkeeping" ~ "bookkeeping",
                           category == "Mixed_Language" ~ "mixed language",
                           category == "Pidgin" ~ "pidgin",
                           category == "Pseudo_Family" ~ "pseudo family",
                           category == "Sign_Language" ~ "sign language",
                           category == "Speech_Register" ~ "speech register",
                           category == "Unattested" ~ "unattested",
                           category == "Unclassifiable" ~ "unclassifiable",
                           TRUE ~ level)) %>%
  select(Glottocode, Name, ISO639P3code, level,  Macroarea, Latitude, Longitude, Countries, classification, subclassification) %>%
  rename(glottocode = Glottocode,
         language = Name,
         iso = ISO639P3code,
         area = Macroarea,
         latitude = Latitude,
         longitude = Longitude,
         countries = Countries,
         affiliation = classification) ->
  full

full %>%
  select(glottocode, language) ->
  gltc_langs

full %>%
  mutate(affiliation = str_split(affiliation, "/"),
         affiliation = map(affiliation, unlist),
         affiliation = map_chr(affiliation, function(x){
           tibble(glottocode = x) %>%
             inner_join(gltc_langs, by = "glottocode") %>%
             pull(language) %>%
             str_c(collapse = ", ")
         })) ->
  result

library(ape)

result %>%
  mutate(subclassification = str_replace(subclassification,
                                         "\\(\\(arup1240:1\\)mari1442:1\\)unun9935:1;",
                                         "((arup1240:1),mari1442:1)unun9935:1;"),
         subclassification = ifelse(nchar(subclassification) == 11,
                                    str_c("(", subclassification, ")"),
                                    subclassification),
         subclassification = str_replace_all(subclassification, ";\\)", "\\);"),
         subclassification = map_chr(subclassification, function(x){
    # print(x)
    tr <- read.tree(text = x)
    tibble(glottocode = tr$tip.label) %>%
             inner_join(gltc_langs, by = "glottocode") %>%
             pull(language) ->
      tr$tip.label
    write.tree(tr, file = "")
    })) ->
  result

setwd("/home/agricolamz/work/packages/lingtypology/database_creation")
result %>%
  as.data.frame() %>%
  write_csv("glottolog.csv", na = "")
glottolog <- read.csv("glottolog.csv")
setwd("/home/agricolamz/work/packages/lingtypology/data/")
save(glottolog, file="glottolog.RData", compress='xz')
