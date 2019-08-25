setwd("/home/agricolamz/work/packages/lingtypology/lingtypology/database_creation")
library(tidyverse); library(stringr); library(zoo)
# lets download data from glottolog-data github ---------------------------
# 1. glottocodes ----------------------------------------------------------
rm(list = ls())
links <- paste0("https://raw.githubusercontent.com/clld/glottolog/master/languoids/languages_", letters, ".md")
sapply(1:length(letters), function(i){
  assign(letters[i],
         value = read_lines(links[i]),
         envir = .GlobalEnv)})
rm(links)
all <- eval(parse(text =
                    paste0("c(", paste(ls(), collapse = ", "), ")")
))

glottocode_df <- data.frame(matrix(vector(), 0, 3,
                                   dimnames=list(c(), c("language","glottocode", "iso"))),
                            stringsAsFactors = FALSE)

sapply(1:length(all), function(i){
  glottocode_df[i, 1] <<- str_split(str_split(all[i], "]")[[1]][1], " \\[")[[1]][2]
  glottocode_df[i, 2] <<- str_split(str_split(all[i], "]")[[1]][1], " \\[")[[1]][3]
  glottocode_df[i, 3] <<- str_split(str_split(all[i], "]")[[1]][2], "\\[")[[1]][2]
})

glottocode_df$language[grep("á", glottocode_df$language)] <- gsub("á", "a", glottocode_df$language[grep("á", glottocode_df$language)])
glottocode_df$language[grep("é", glottocode_df$language)] <- gsub("é", "e", glottocode_df$language[grep("é", glottocode_df$language)])
glottocode_df$language[grep("í", glottocode_df$language)] <- gsub("í", "i", glottocode_df$language[grep("í", glottocode_df$language)])
glottocode_df$language[grep("ó", glottocode_df$language)] <- gsub("ó", "o", glottocode_df$language[grep("ó", glottocode_df$language)])
glottocode_df$language[grep("ú", glottocode_df$language)] <- gsub("ú", "u", glottocode_df$language[grep("ú", glottocode_df$language)])
glottocode_df$language[grep("à", glottocode_df$language)] <- gsub("à", "a", glottocode_df$language[grep("à", glottocode_df$language)])
glottocode_df$language[grep("è", glottocode_df$language)] <- gsub("è", "e", glottocode_df$language[grep("è", glottocode_df$language)])
glottocode_df$language[grep("ì", glottocode_df$language)] <- gsub("ì", "i", glottocode_df$language[grep("ì", glottocode_df$language)])
glottocode_df$language[grep("ù", glottocode_df$language)] <- gsub("ù", "u", glottocode_df$language[grep("ù", glottocode_df$language)])
glottocode_df$language[grep("â", glottocode_df$language)] <- gsub("â", "a", glottocode_df$language[grep("â", glottocode_df$language)])
glottocode_df$language[grep("ê", glottocode_df$language)] <- gsub("ê", "e", glottocode_df$language[grep("ê", glottocode_df$language)])
glottocode_df$language[grep("î", glottocode_df$language)] <- gsub("î", "i", glottocode_df$language[grep("î", glottocode_df$language)])
glottocode_df$language[grep("ô", glottocode_df$language)] <- gsub("ô", "o", glottocode_df$language[grep("ô", glottocode_df$language)])
glottocode_df$language[grep("ã", glottocode_df$language)] <- gsub("ã", "a", glottocode_df$language[grep("ã", glottocode_df$language)])
glottocode_df$language[grep("ã", glottocode_df$language)] <- gsub("ã", "a", glottocode_df$language[grep("ã", glottocode_df$language)])
glottocode_df$language[grep("õ", glottocode_df$language)] <- gsub("õ", "o", glottocode_df$language[grep("õ", glottocode_df$language)])
glottocode_df$language[grep("ë", glottocode_df$language)] <- gsub("ë", "a", glottocode_df$language[grep("ë", glottocode_df$language)])
glottocode_df$language[grep("ä", glottocode_df$language)] <- gsub("ä", "a", glottocode_df$language[grep("ä", glottocode_df$language)])
glottocode_df$language[grep("ö", glottocode_df$language)] <- gsub("ö", "o", glottocode_df$language[grep("ö", glottocode_df$language)])
glottocode_df$language[grep("ü", glottocode_df$language)] <- gsub("ü", "u", glottocode_df$language[grep("ü", glottocode_df$language)])
glottocode_df$language[grep("ö", glottocode_df$language)] <- gsub("ö", "o", glottocode_df$language[grep("ö", glottocode_df$language)])
glottocode_df$language[grep("ü", glottocode_df$language)] <- gsub("ü", "u", glottocode_df$language[grep("ü", glottocode_df$language)])
glottocode_df$language[grep("ç", glottocode_df$language)] <- gsub("ç", "c", glottocode_df$language[grep("ç", glottocode_df$language)])
glottocode_df$language[grep("ñ", glottocode_df$language)] <- gsub("ñ", "n", glottocode_df$language[grep("ñ", glottocode_df$language)])

new_iso <- paste0("NOCODE_", gsub(" ", "-", glottocode_df[is.na(glottocode_df$iso),1]))
glottocode_df[is.na(glottocode_df$iso),3] <- sapply(new_iso, function(x){
  strsplit(x, "\\(")[[1]][1]})

setwd("/home/agricolamz/work/packages/lingtypology/lingtypology/database_creation")
write_tsv(glottocode_df, "glottocode_df.tsv")
rm(list = ls())

# 2. lginfo ---------------------------------------------------------------
lginfo <- read_lines("https://raw.githubusercontent.com/clld/glottolog-data/master/languoids/forkel_lginfo.tab")
iso <- sapply(1:length(lginfo), function(x){
  str_split(lginfo[x], "\t")[[1]][1]
})
lang <- sapply(1:length(lginfo), function(x){
  str_split(lginfo[x], "\t")[[1]][2]
})
lat <- sapply(1:length(lginfo), function(x){
  str_split(lginfo[x], "\t")[[1]][3]
})
area <- sapply(1:length(lginfo), function(x){
  str_split(lginfo[x], "\t")[[1]][4]
})
somthing_useless <- sapply(1:length(lginfo), function(x){
  str_split(lginfo[x], "\t")[[1]][5]
})

lginfo <- data_frame(iso, lang, lat, area)
lginfo[lginfo$iso == "est", 1] <- "ekk"
glottocode_df <- read_tsv("glottocode_df.tsv")
glottocode_df <- full_join(lginfo, glottocode_df)
glottocode_df <- glottocode_df[!(grepl("NOCODE", glottocode_df$iso) & is.na(glottocode_df$glottocode)),]
setwd("/home/agricolamz/work/packages/lingtypology/lingtypology/database_creation")
write_tsv(glottocode_df, "glottocode_df.tsv")
rm(list = ls())

# 3. whole glottolog ------------------------------------------------------
database <- read_lines("https://raw.githubusercontent.com/clld/glottolog-data/master/languoids/hh17.txt")
database <- str_replace(database, "Locations", "Location")
database <- str_replace(database, "Coordinates source", "Coordinates Source")
database <- str_replace(database, "Population Between 20 and 30 speakers", "Population: Between 20 and 30 speakers")
database <- database[database != ""]

database <- data_frame(slot = sapply(1:length(database), function(x){
  str_split(database[x], ": ")[[1]][1]
}), content =  sapply(1:length(database), function(x){
  paste(str_split(database[x], ": ")[[1]][-1], collapse = "")
}))

database <- database[-c(28198, 31218:31227, 95766, 101556, 106806),]
# remove duplicates "Nauo", "Eka", "Yugh", "Kurnai"

database$iso <-  NA
database[which(database$slot == "name"), 3] <- database[which(database$slot == "ISO 639-3"), 2]
database$iso <- na.locf(database$iso)

database %>%
  unique() %>%
  filter(slot != "ISO 639-3",
         slot != "code+name",) %>%
  spread(key = slot, value = content) ->
  database_new

database_new <- database_new[,-c(2, 6:7, 10:14, 18:20, 22:23)]
names(database_new) <- tolower(names(database_new))
names(database_new)[c(3, 4)] <- c("affiliation", "affiliation-HH")

# new_df$language[grep(", ", new_df$language)] <-
#   sapply(grep(", ", new_df$language), function(i){
#     paste(str_split(new_df$language[i], ", ")[[1]][2],
#           str_split(new_df$language[i], ", ")[[1]][1])
#   })
#
# new_df$language[new_df$language == "Norwegian Bokm\\aa{}l"] <- "Norwegian Bokmal"
# new_df$language[new_df$language == "\\textdoublebarpipe{}Hua"] <- "Hua"
# new_df$language[new_df$language == "\\textdoublebarpipe{}Kx'au||'ein"] <- "Kx'au||'ein"
# new_df$language[new_df$language == "Old Proven\\c{c}al"] <- "Old Provencal"
# new_df$language[grep("\\\\['~`^]", new_df$language)] <- gsub("\\\\['~`^]", "", new_df$language[grep("\\\\['~`^]", new_df$language)])
# new_df$language[grep('\\\\["]', new_df$language)] <- gsub('\\\\["]', "", new_df$language[grep('\\\\["]', new_df$language)])
# new_df$alternate_names[grep("\\\\['~`^]", new_df$alternate_names)] <- gsub("\\\\['~`^]", "", new_df$alternate_names[grep("\\\\['~`^]", new_df$alternate_names)])
# new_df$alternate_names[grep('\\\\["]', new_df$alternate_names)] <- gsub('\\\\["]', "", new_df$alternate_names[grep('\\\\["]', new_df$alternate_names)])
# new_df$affiliation[grep("\\\\['~`^]", new_df$affiliation)] <- gsub("\\\\['~`^]", "", new_df$affiliation[grep("\\\\['~`^]", new_df$affiliation)])
# new_df$affiliation[grep('\\\\["]', new_df$affiliation)] <- gsub('\\\\["]', "", new_df$affiliation[grep('\\\\["]', new_df$affiliation)])
# new_df$dialects[grep("\\\\['~`^]", new_df$dialects)] <- gsub("\\\\['~`^]", "", new_df$dialects[grep("\\\\['~`^]", new_df$dialects)])
# new_df$dialects[grep('\\\\["]', new_df$dialects)] <- gsub('\\\\["]', "", new_df$dialects[grep('\\\\["]', new_df$dialects)])

setwd("/home/agricolamz/work/packages/lingtypology/lingtypology/database_creation")
write_tsv(database_new, "new_df.tsv")
rm(list = ls())


# 4. combine --------------------------------------------------------------
glottocode_df <- read_tsv("glottocode_df.tsv")
new_df <- read_tsv("new_df.tsv")
glottocode_df <- left_join(glottocode_df, new_df, by = c("iso"))
names(glottocode_df)[c(2, 3)] <- c("longitude", "latitude")

glottocode_df <- glottocode_df[,c(5, 1, 6, 2, 3, 8, 4, 7, 9, 10:17)]
glottocode_df[is.na(glottocode_df$affiliation), 8] <- glottocode_df[is.na(glottocode_df$affiliation), 9]

setwd("/home/agricolamz/work/packages/lingtypology/lingtypology/database_creation")
write_tsv(glottocode_df, "glottolog.original.tsv")
rm(list = ls())

# 5. changes in glottolog ----------------------------------------------------
setwd("/home/agricolamz/work/packages/lingtypology/lingtypology/database_creation")
glottolog.original <- read_tsv("glottolog.original.tsv")
glottolog.modified <- glottolog.original
circassian <- read_csv("circassian.csv")
countries <- read_csv("country.names.csv")
ejective_and_n_consonants <- read_csv("ejective_and_n_consonants.csv")
gltcless <- read_csv("gltcless.csv")

# 5.1 add Calle Börstell SL data ----------------------------------------------
sl_data <- read_delim("glottolog_sls.csv", delim = ";")
sl_data$longitude <- as.double(sl_data$longitude)
sl_data$latitude <- as.double(sl_data$latitude)

sapply(1:length(sl_data$iso), function(x){
  glottolog.modified[which(glottolog.modified$iso == sl_data$iso[x]),c(2, 1, 5, 4)] <<- sl_data[x,]})

sapply(1:length(gltcless$iso), function(x){
  glottolog.modified[which(glottolog.modified$iso == gltcless$iso[x]), ] <<- gltcless[x,]})

# 5.2 countries and symbols -------------------------------------------------
glottolog.modified$country[c(1463)] <- c("Netherlands, Aruba")
glottolog.modified$country <- gsub("Afghanistan", "Afganistan", glottolog.modified$country)
glottolog.modified$country <- gsub("Cape Verde Islands", "Cape Verde", glottolog.modified$country)
glottolog.modified$country <- gsub("Congo \\(Kinshasa\\)", "Congo", glottolog.modified$country)
glottolog.modified$country <- gsub("C�te d'Ivoire", "Ivory Coast", glottolog.modified$country)
glottolog.modified$country <- gsub("C\\^ote d'Ivoire", "Ivory Coast", glottolog.modified$country)
glottolog.modified$country <- gsub("Czech Republic", "Czech", glottolog.modified$country)
glottolog.modified$country <- gsub("Democratic Republic of the Congo", "Congo", glottolog.modified$country)
glottolog.modified$country <- gsub("French Guiana", "France, French Guiana", glottolog.modified$country)
glottolog.modified$country <- gsub("French Polynesia", "France, French Polynesia", glottolog.modified$country)
glottolog.modified$country <- gsub("Guadeloupe", "France, Guadeloupe", glottolog.modified$country)
glottolog.modified$country <- gsub("Indonesia \\(Java and Bali\\)", "Indonesia", glottolog.modified$country)
glottolog.modified$country <- gsub("Indonesia \\(Maluku\\)", "Indonesia", glottolog.modified$country)
glottolog.modified$country <- gsub("Indonesia \\(Papua\\)", "Indonesia", glottolog.modified$country)
glottolog.modified$country <- gsub("Korea, South", "South Korea", glottolog.modified$country)
glottolog.modified$country <- gsub("Korea, North", "North Korea", glottolog.modified$country)
glottolog.modified$country <- gsub("Malaysia \\(Peninsular\\)", "Malaysia", glottolog.modified$country)
glottolog.modified$country <- gsub("R�union", "Reunion", glottolog.modified$country)
glottolog.modified$country <- gsub("S�o Tom� e Pr�ncipe", "Sao Tome e Principe", glottolog.modified$country)
glottolog.modified$country <- gsub("Turkey \\(Asia\\)", "Turkey", glottolog.modified$country)
glottolog.modified$country <- gsub("Viet Nam", "Vietnam", glottolog.modified$country)
glottolog.modified$country <- gsub("Russian Federation \\(Asia\\)", "Russia", glottolog.modified$country)
glottolog.modified$language <- gsub("Bininj Kun-Wok", "Gunwinggu", glottolog.modified$language)
glottolog.modified$language <- gsub("Central Guerrero Nahuatl", "Guerrero Nahuatl", glottolog.modified$language)
glottolog.modified$language <- gsub("Lezghian", "Lezgian", glottolog.modified$language)
glottolog.modified$language <- gsub("Northeast Sahaptin", "Walla Walla", glottolog.modified$language)
glottolog.modified$language <- gsub("Northwest Sahaptin", "Yakima", glottolog.modified$language)
glottolog.modified$language <- gsub("Abkhazian", "Abkhaz", glottolog.modified$language)
glottolog.modified$language <- gsub("Khwarshi-Inkhoqwari", "Inkhoqwari", glottolog.modified$language)

glottolog.modified[glottolog.modified$language %in% "Even", 'longitude'] <- 145
glottolog.modified[glottolog.modified$language %in% "Even", 'latitude'] <- 65
glottolog.modified[glottolog.modified$language %in% "Georgian", 'longitude'] <- 44.318829
glottolog.modified[glottolog.modified$language %in% "Georgian", 'latitude'] <- 41.815745
glottolog.modified[glottolog.modified$language %in% "Abaza", 'longitude'] <- 41.7879221
glottolog.modified[glottolog.modified$language %in% "Abaza", 'latitude'] <- 44.4498344
glottolog.modified[glottolog.modified$language %in% "Ossetian", 'longitude'] <- 44.68333
glottolog.modified[glottolog.modified$language %in% "Ossetian", 'latitude'] <- 43.01667
glottolog.modified[glottolog.modified$language %in% "Ingush", 'longitude'] <- 44.81667
glottolog.modified[glottolog.modified$language %in% "Ingush", 'latitude'] <- 43.16667
glottolog.modified[glottolog.modified$language %in% "Avar", 'longitude'] <- 46.66639
glottolog.modified[glottolog.modified$language %in% "Avar", 'latitude'] <- 42.43056
glottolog.modified[glottolog.modified$language %in% "Botlikh", 'longitude'] <- 46.22000
glottolog.modified[glottolog.modified$language %in% "Botlikh", 'latitude'] <- 42.66500
glottolog.modified[glottolog.modified$language %in% "Silesian", 'longitude'] <- 19
glottolog.modified[glottolog.modified$language %in% "Silesian", 'latitude'] <- 50.25
glottolog.modified[glottolog.modified$language %in% "Slavomolisano", 'longitude'] <- 14.746984
glottolog.modified[glottolog.modified$language %in% "Slavomolisano", 'latitude'] <- 41.866702
glottolog.modified[glottolog.modified$language %in% "Estonian", 'longitude'] <- 25.82
glottolog.modified[glottolog.modified$language %in% "Estonian", 'latitude'] <- 58.55
glottolog.modified[glottolog.modified$language %in% "Obdorsk Khanty", 'longitude'] <- 67.09
glottolog.modified[glottolog.modified$language %in% "Obdorsk Khanty", 'latitude'] <- 66.31
glottolog.modified[glottolog.modified$language %in% "Nuu-chah-nulth", 'longitude'] <- -125.2744
glottolog.modified[glottolog.modified$language %in% "Nuu-chah-nulth", 'latitude'] <- 48.898889
glottolog.modified[glottolog.modified$language %in% "Loup A", 'longitude'] <- -72.3013
glottolog.modified[glottolog.modified$language %in% "Loup A", 'latitude'] <- 42.374045
glottolog.modified[glottolog.modified$language %in% "Archi", 'longitude'] <- 46.8678
glottolog.modified[glottolog.modified$language %in% "Archi", 'latitude'] <- 42.0664
glottolog.modified[glottolog.modified$language %in% "Inkhoqwari", 'longitude'] <- 46.044877
glottolog.modified[glottolog.modified$language %in% "Inkhoqwari", 'latitude'] <- 42.410888
glottolog.modified[glottolog.modified$language %in% "Situ", 'longitude'] <- 102.66
glottolog.modified[glottolog.modified$language %in% "Situ", 'latitude'] <- 31.59

glottolog.modified[glottolog.modified$language %in% "Inkhoqwari", 'affiliation'] <- "North Caucasian, East Caucasian, Tsezic, West Tsezic"
glottolog.modified[glottolog.modified$language %in% "Hinuq", 'affiliation'] <- "North Caucasian, East Caucasian, Tsezic, West Tsezic"
glottolog.modified[glottolog.modified$language %in% "Tsez", 'affiliation'] <- "North Caucasian, East Caucasian, Tsezic, West Tsezic"
glottolog.modified[glottolog.modified$language %in% "Tabasaran", 'affiliation'] <- "North Caucasian, East Caucasian, Lezgic, Nuclear Lezgic, East Lezgic"
glottolog.modified[glottolog.modified$language %in% "International Sign", 'area'] <- "Eurasia"
glottolog.modified[glottolog.modified$language %in% "'Hawai'i Pidgin Sign Language'", 'area'] <- "Papua"
glottolog.modified[glottolog.modified$language %in% "Hawai'i Creole English", 'area'] <- "Papua"
glottolog.modified[glottolog.modified$language %in% "Kalaallisut", 'area'] <- "North America"

glottolog.modified[glottolog.modified$area %in% "Papua" &
                     !is.na(glottolog.modified$longitude) &
                     glottolog.modified$longitude < -80, 'longitude'] <- glottolog.modified[glottolog.modified$area %in% "Papua" & !is.na(glottolog.modified$longitude) & glottolog.modified$longitude < -80, 4] + 360
glottolog.modified[glottolog.modified$area %in% "Eurasia" &
                     !is.na(glottolog.modified$longitude) &
                     glottolog.modified$longitude < -80, 'longitude'] <- glottolog.modified[glottolog.modified$area %in% "Eurasia" & !is.na(glottolog.modified$longitude) & glottolog.modified$longitude < -80, 4] + 360
glottolog.modified[grepl("America", glottolog.modified$area) &
                     !is.na(glottolog.modified$longitude), 'longitude'] <- glottolog.modified[grepl("America", glottolog.modified$area) & !is.na(glottolog.modified$longitude), 4] + 360

glottolog.modified$longitude[glottolog.modified$longitude > 400 & !is.na(glottolog.modified$longitude)] <- glottolog.modified$longitude[glottolog.modified$longitude > 400 & !is.na(glottolog.modified$longitude)] - 360


NWC <- read_csv("NWC.csv")
glottolog.modified <- rbind(glottolog.modified, NWC)

# 5.3 double languages ----------------------------------------------------
double_languages <- table(glottolog.modified$language)
double_languages <- names(double_languages[double_languages>1])
changes <- data.frame(id = NA, lang = NA, replacement = NA)

ids <- which(glottolog.modified$language %in% double_languages)
sapply(ids, function(id){
  if(is.na(glottolog.modified$affiliation[id])){
    aff <- last(unlist(strsplit(glottolog.modified$`affiliation-HH`[id], ", ")))
  } else {
    aff <- first(unlist(strsplit(glottolog.modified$affiliation[id], ", ")))
  }
  replacement <- paste0(glottolog.modified$language[id], " (", aff, ")")
  n <- nrow(changes)+1
  changes[n, 1] <<- id
  changes[n, 2] <<- glottolog.modified$language[id]
  changes[n, 3] <<- replacement
})

changes <- changes[-1,]

glottolog.modified[changes$id,1] <- changes$replacement

#glottolog.modified$language_status <- sapply(glottolog.modified$language_status, function(x){
#  paste0(strsplit(x, "\\)")[[1]][1], ")")})

glottolog.modified <- glottolog.modified[!is.na(glottolog.modified$language),]

# 6. autotype data --------------------------------------------------------
autotyp <- read.csv("https://raw.githubusercontent.com/autotyp/autotyp-data/master/data/Register.csv")
autotyp <- cbind.data.frame(LID = autotyp$LID, Glottocode = autotyp$Glottocode)

# 7. wals data ------------------------------------------------------------
wals <- read_tsv("http://wals.info/languoid.tab?sEcho=1&iSortingCols=1&iSortCol_0=0&sSortDir_0=asc")[, 1:2]
colnames(wals)[1] <- "wals.code"

# 8. abvd data ------------------------------------------------------------
abvd <- read_tsv("abvd.tsv")

# 9. oto_mangueanIC data --------------------------------------------------
oto_mangueanIC <- read_csv("oto_mangueanIC.csv")


# 10 CLICS data -----------------------------------------------------------

library(rvest)

clics <- data_frame(id = 1:3180)

sapply(1:3180, function(id) {
  tryCatch({source <- read_html(paste0("https://clics.clld.org/parameters/", id))}, error = function(e){})
  if ("source" %in% ls()) {
    source %>%
      html_nodes("h2") %>%
      html_text() ->
      result
    rm(source)
    result
  } else {NA}}) ->
  clics$concepts

clics %>%
  na.omit() %>%
  mutate(concepts = str_replace(concepts, "Concept ", "")) ->
  clics

write_csv(clics, "clics.csv")

clics <- read_csv("clics.csv")


# 11. UraLex --------------------------------------------------------------
read_csv("https://github.com/lexibank/uralex/raw/master/cldf/languages.csv") %>%
  mutate(language = Name,
         language2 = lang.gltc(Glottocode)) %>%
  select(language, Glottocode, language2) ->
  uralex

write_csv(uralex, "uralex.csv")

# 12 amap -----------------------------------------------------------------

library(rgdal)
library(ggplot2)
setwd("/home/agricolamz/work/packages/lingtypology/lingtypology/database_creation/for amap")
wmap <- readOGR(dsn="ne_110m_land/", layer="ne_110m_land")
bbox <- readOGR(dsn = "ne_110m_wgs84_bounding_box/", layer = "ne_110m_wgs84_bounding_box")
grat <- readOGR("ne_110m_graticules_20/", layer="ne_110m_graticules_20")

theme_opts <- list(theme(panel.grid.minor = element_blank(),
                         panel.grid.major = element_blank(),
                         panel.background = element_blank(),
                         plot.background = element_blank(),
                         panel.border = element_blank(),
                         axis.line = element_blank(),
                         axis.text.x = element_blank(),
                         axis.text.y = element_blank(),
                         axis.ticks = element_blank(),
                         axis.title.x = element_blank(),
                         axis.title.y = element_blank(),
                         plot.title = element_text(size=22)))

bbox_wintri <- spTransform(bbox, CRS("+proj=wintri"))
bbox_wintri <- fortify(bbox_wintri)
wmap_wintri <- spTransform(wmap, CRS("+proj=wintri"))
wmap_wintri <- fortify(wmap_wintri)
grat_wintri <- spTransform(grat, CRS("+proj=wintri"))
grat_wintri <- fortify(grat_wintri)

ggplot(bbox_wintri, aes(long,lat, group=group)) +
  geom_polygon(fill="lightcyan") +
  geom_polygon(data=wmap_wintri, aes(long,lat, group=group, fill=hole)) +
  geom_path(data=grat_wintri, aes(long, lat, group=group, fill=NULL), linetype="dashed", color="grey50") +
  coord_equal() +
  theme_opts +
  scale_fill_manual(values=c("gray75", "lightcyan"), guide="none") ->
  amap

# ogr2ogr ne_110m_graticules_20v2.shp ne_110m_graticules_20.shp -dialect sqlite -sql "SELECT ShiftCoords(geometry,180,0) FROM ne_110m_graticules_20"
# ogr2ogr ne_110m_landv2.shp ne_110m_land.shp -dialect sqlite -sql "SELECT ShiftCoords(geometry,180,0) FROM ne_110m_land"
# ogr2ogr ne_110m_wgs84_bounding_boxv2.shp ne_110m_wgs84_bounding_box.shp -dialect sqlite -sql "SELECT ShiftCoords(geometry,180,0) FROM ne_110m_wgs84_bounding_box"

setwd("/home/agricolamz/work/packages/lingtypology/lingtypology/database_creation/for pmap")
wmap <- readOGR(dsn="ne_110m_land/", layer="ne_110m_landv2")
bbox <- readOGR(dsn = "ne_110m_wgs84_bounding_box/", layer = "ne_110m_wgs84_bounding_boxv2")
grat <- readOGR("ne_110m_graticules_20/", layer="ne_110m_graticules_20v2")

bbox_wintri <- spTransform(bbox, CRS("+proj=wintri"))
bbox_wintri <- fortify(bbox_wintri)
wmap_wintri <- spTransform(wmap, CRS("+proj=wintri"))
wmap_wintri <- fortify(wmap_wintri)
grat_wintri <- spTransform(grat, CRS("+proj=wintri"))
grat_wintri <- fortify(grat_wintri)

ggplot(bbox_wintri, aes(long,lat, group=group)) +
  geom_polygon(fill="lightcyan") +
  geom_polygon(data=wmap_wintri, aes(long,lat, group=group, fill=hole)) +
  geom_path(data=grat_wintri, aes(long, lat, group=group, fill=NULL), linetype="dashed", color="grey50") +
  coord_equal() +
  theme_opts +
  scale_fill_manual(values=c("gray75", "lightcyan"), guide="none")


# 13 phoible --------------------------------------------------------------
phoible <- read_csv("https://raw.githubusercontent.com/phoible/dev/master/data/phoible.csv")
phoible %>%
  distinct(Glottocode) %>%
  mutate(language = lingtypology::lang.gltc(Glottocode)) ->
  phoible

# save files --------------------------------------------------------------
setwd("/home/agricolamz/work/packages/lingtypology/lingtypology/data/")
save(glottolog.modified, file="glottolog.modified.RData", compress= 'xz')
save(glottolog.original, file="glottolog.original.RData", compress='xz')
circassian <- as.data.frame(circassian)
save(circassian, file="circassian.RData", compress='xz')
save(countries, file="countries.RData", compress='xz')
save(phoible, file="phoible.RData", compress='xz')
ejective_and_n_consonants <- as.data.frame(ejective_and_n_consonants)
save(ejective_and_n_consonants, file="ejective_and_n_consonants.RData", compress='xz')
save(autotyp, file="autotyp.RData", compress='xz')
save(wals, file="wals.RData", compress='xz')
save(abvd, file="abvd.RData", compress='xz')
save(uralex, file="uralex.RData", compress='xz')
save(oto_mangueanIC, file="oto_mangueanIC.RData", compress='xz')
save(amap, file="amap.RData", compress='xz')
# save(clics, file="clics.RData", compress='xz')
rm(list = ls())

# remove some files -------------------------------------------------------
setwd("/home/agricolamz/work/packages/lingtypology/lingtypology/database_creation")
file.remove(c("glottocode_df.tsv", "new_df.tsv"))
