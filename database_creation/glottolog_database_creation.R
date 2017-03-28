library(tidyverse); library(stringr)
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
glottocode_df$language[grep("ç", glottocode_df$language)] <- gsub("ç", "u", glottocode_df$language[grep("ç", glottocode_df$language)])

new_iso <- paste0("NOCODE_", gsub(" ", "-", glottocode_df[is.na(glottocode_df$iso),1]))
glottocode_df[is.na(glottocode_df$iso),3] <- sapply(new_iso, function(x){
  strsplit(x, "\\(")[[1]][1]})

setwd("/home/agricolamz/_DATA/OneDrive1/_Work/github/lingtypology/lingtypology/database_creation")
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
glottocode_df <- read_tsv("glottocode_df.tsv")
glottocode_df <- full_join(lginfo, glottocode_df)
glottocode_df <- glottocode_df[!(grepl("NOCODE", glottocode_df$iso) & is.na(glottocode_df$glottocode)),]
setwd("/home/agricolamz/_DATA/OneDrive1/_Work/github/lingtypology/lingtypology/database_creation")
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

slots <- names(table(database$slot))
new_df <- data.frame(matrix(vector(), 0, length(slots),
                       dimnames=list(c(), str_replace(slots, " |-|\\+", "_"))),
                stringsAsFactors=F)

i <- 0
sapply(1:nrow(database), function(j){
  if(database$slot[j] == "name"){i <<- i+1}
  new_df[i,which(database$slot[j] == slots)] <<- database$content[j]
  })

new_df <- new_df[,-c(1, 5:7, 10:11, 14:15, 23)]

names(new_df)[6] <- "iso"
names(new_df) <- tolower(names(new_df))
names(new_df)[c(11, 2, 3)] <- c("language", "affiliation", "affiliation-HH")
new_df <- new_df[, c(11, 6, 2, 1, 3:5, 7:10, 12:17)]

new_df$language[grep(", ", new_df$language)] <-
  sapply(grep(", ", new_df$language), function(i){
    paste(str_split(new_df$language[i], ", ")[[1]][2],
          str_split(new_df$language[i], ", ")[[1]][1])
  })

new_df$language[new_df$language == "Norwegian Bokm\\aa{}l"] <- "Norwegian Bokmal"
new_df$language[new_df$language == "\\textdoublebarpipe{}Hua"] <- "Hua"
new_df$language[new_df$language == "\\textdoublebarpipe{}Kx'au||'ein"] <- "Kx'au||'ein"
new_df$language[new_df$language == "Old Proven\\c{c}al"] <- "Old Provencal"
new_df$language[grep("\\\\['~`^]", new_df$language)] <- gsub("\\\\['~`^]", "", new_df$language[grep("\\\\['~`^]", new_df$language)])
new_df$language[grep('\\\\["]', new_df$language)] <- gsub('\\\\["]', "", new_df$language[grep('\\\\["]', new_df$language)])
new_df$alternate_names[grep("\\\\['~`^]", new_df$alternate_names)] <- gsub("\\\\['~`^]", "", new_df$alternate_names[grep("\\\\['~`^]", new_df$alternate_names)])
new_df$alternate_names[grep('\\\\["]', new_df$alternate_names)] <- gsub('\\\\["]', "", new_df$alternate_names[grep('\\\\["]', new_df$alternate_names)])
new_df$affiliation[grep("\\\\['~`^]", new_df$affiliation)] <- gsub("\\\\['~`^]", "", new_df$affiliation[grep("\\\\['~`^]", new_df$affiliation)])
new_df$affiliation[grep('\\\\["]', new_df$affiliation)] <- gsub('\\\\["]', "", new_df$affiliation[grep('\\\\["]', new_df$affiliation)])
new_df$dialects[grep("\\\\['~`^]", new_df$dialects)] <- gsub("\\\\['~`^]", "", new_df$dialects[grep("\\\\['~`^]", new_df$dialects)])
new_df$dialects[grep('\\\\["]', new_df$dialects)] <- gsub('\\\\["]', "", new_df$dialects[grep('\\\\["]', new_df$dialects)])

setwd("/home/agricolamz/_DATA/OneDrive1/_Work/github/lingtypology/lingtypology/database_creation")
write_tsv(new_df, "new_df.tsv")
rm(list = ls())


# 4. combine --------------------------------------------------------------
glottocode_df <- read_tsv("glottocode_df.tsv")
new_df <- read_tsv("new_df.tsv")
glottocode_df <- left_join(glottocode_df, new_df, by = c("iso", "language"))
names(glottocode_df)[c(2, 3)] <- c("longitude", "latitude")

glottocode_df <- glottocode_df[,c(5, 1, 6, 2, 3, 8, 4, 7, 9, 10:21)]
glottocode_df[is.na(glottocode_df$affiliation), 8] <- glottocode_df[is.na(glottocode_df$affiliation), 9]

setwd("/home/agricolamz/_DATA/OneDrive1/_Work/github/lingtypology/lingtypology/database_creation")
write_tsv(glottocode_df, "glottolog.original.tsv")
rm(list = ls())

# 5. changes in glottolog ----------------------------------------------------
setwd("/home/agricolamz/_DATA/OneDrive1/_Work/github/lingtypology/lingtypology/database_creation")
glottolog.original <- read_tsv("glottolog.original.tsv")
glottolog.modified <- glottolog.original
circassian <- read_csv("circassian.csv")
countries <- read_tsv("country.names.csv")

# 5.1 add Calle Börstell SL data ----------------------------------------------
sl_data <- read_delim("glottolog_sls.csv", delim = ";")
sl_data$longitude <- as.double(sl_data$longitude)
sl_data$latitude <- as.double(sl_data$latitude)

sapply(1:length(sl_data$iso), function(x){
  glottolog.modified[which(glottolog.modified$iso == sl_data$iso[x]),c(2, 1, 5, 4)] <<- sl_data[x,]})

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
glottolog.modified$language <- gsub("Northeast Sahaptin", "Walla Walla", glottolog.modified$language)
glottolog.modified$language <- gsub("Northwest Sahaptin", "Yakima", glottolog.modified$language)
glottolog.modified$language <- gsub("Abkhazian", "Abkhaz", glottolog.modified$language)
glottolog.modified[glottolog.modified$language %in% "International Sign", 7] <- "Eurasia"
glottolog.modified[glottolog.modified$language %in% "'Hawai'i Pidgin Sign Language'", 7] <- "Papua"
glottolog.modified[glottolog.modified$language %in% "Hawai'i Creole English", 7] <- "Papua"


glottolog.modified[glottolog.modified$area %in% "Papua" &
                     !is.na(glottolog.modified$longitude) &
                     glottolog.modified$longitude < -80, 4] <- glottolog.modified[glottolog.modified$area %in% "Papua" & !is.na(glottolog.modified$longitude) & glottolog.modified$longitude < -80, 4] + 360
glottolog.modified[glottolog.modified$area %in% "Eurasia" &
                     !is.na(glottolog.modified$longitude) &
                     glottolog.modified$longitude < -80, 4] <- glottolog.modified[glottolog.modified$area %in% "Eurasia" & !is.na(glottolog.modified$longitude) & glottolog.modified$longitude < -80, 4] + 360
glottolog.modified[grepl("America", glottolog.modified$area) &
                     !is.na(glottolog.modified$longitude), 4] <- glottolog.modified[grepl("America", glottolog.modified$area) & !is.na(glottolog.modified$longitude), 4] + 360

glottolog.modified[glottolog.modified$language %in% "Georgian", 4] <- 44.318829
glottolog.modified[glottolog.modified$language %in% "Georgian", 5] <- 41.815745
glottolog.modified[glottolog.modified$language %in% "Abaza", 4] <- 41.7879221
glottolog.modified[glottolog.modified$language %in% "Abaza", 5] <- 44.4498344
glottolog.modified[glottolog.modified$language %in% "Ossetian", 4] <- 44.68333
glottolog.modified[glottolog.modified$language %in% "Ossetian", 5] <- 43.01667
glottolog.modified[glottolog.modified$language %in% "Ingush", 4] <- 44.81667
glottolog.modified[glottolog.modified$language %in% "Ingush", 5] <- 43.16667
glottolog.modified[is.na(glottolog.modified)

]
grep("America", area.lang(x))

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

glottolog.modified$language_status <- sapply(glottolog.modified$language_status, function(x){
  paste0(strsplit(x, "\\)")[[1]][1], ")")})

# save files --------------------------------------------------------------
setwd("/home/agricolamz/_DATA/OneDrive1/_Work/github/lingtypology/lingtypology/data")
save(glottolog.modified, file="glottolog.modified.RData", compress= 'xz')
save(glottolog.original, file="glottolog.original.RData", compress='xz')
save(circassian, file="circassian.RData", compress='xz')
save(countries, file="countries.RData", compress='xz')
rm(list = ls())

# remove some files -------------------------------------------------------
setwd("/home/agricolamz/_DATA/OneDrive1/_Work/github/lingtypology/lingtypology/database_creation/")
file.remove(c("glottocode_df.tsv", "new_df.tsv"))
