library(tidyverse)
library(lingtypology)
lang <- utils::read.delim("http://www1.icsi.berkeley.edu/wcs/data/20021219/txt/lang.txt",
                          encoding="UTF-8", header = FALSE)
terms <- utils::read.delim("http://www1.icsi.berkeley.edu/wcs/data/20041016/txt/dict.txt",
                           encoding = "UTF-8")
chip <- utils::read.delim("http://www1.icsi.berkeley.edu/wcs/data/20030414/txt/foci-exp.txt",
                         encoding="UTF-8", header = FALSE)
foci <- utils::read.delim("https://www1.icsi.berkeley.edu/wcs/data/20021219/txt/foci.txt",
                          encoding="UTF-8", header = FALSE)

names(foci)[names(foci) == "V1"] <- "id"
names(foci)[names(foci) == "V2"] <- "speaker_id"
names(foci)[names(foci) == "V3"] <- "focus_response"
names(foci)[names(foci) == "V4"] <- "WCSC"
names(foci)[names(foci) == "V5"] <- "grid_coordinates"
foci <- foci[c("id", "speaker_id", "focus_response", "WCSC", "grid_coordinates")]
names(terms)[names(terms) == "X.LNUM"] <- "id"
names(lang)[names(lang) == "V1"] <- "id"

codes <- read.csv("/Users/kirillkonca/Desktop/workshop.csv", sep = ";")
names(codes)[names(codes) == "Index"] <- "id"
codes$ISO.639.3.Code[codes$id == 93] <- "tac"

lang <- lang %>%
  mutate_all(funs(str_replace(., "\\{\\\\x87\\}", "a"))) %>%
  mutate_all(funs(str_replace(., "\\{\\\\x96\\}", "n"))) %>%
  mutate_all(funs(str_replace(., "\\{\\\\x9C\\}", "u"))) %>%
  mutate_all(funs(str_replace(., "\\{\\\\x8B\\}", "a"))) %>%
  mutate_all(funs(str_replace(., "\\{\\\\x97\\}", "o"))) %>%
  mutate_all(funs(str_replace(., "\\{\\\\x8A\\}", "a")))

lang[lang == '*'] <- NA

for (i in 1: 110){
  uni <- unique(c(lang$V4[i], lang$V5[i], lang$V5[i]))
  lang$fieldworkers[i] <- toString(uni)}

lang$fieldworkers <- gsub("NA, Jason D. Patent", "Jason D.Patent", lang$fieldworkers)

lang <- merge(lang, codes, by="id")

lang$glottocode <- lingtypology::gltc.iso(codes$ISO.639.3.Code)

lang[lang == 'NA'] <- NA

names(lang)[names(lang) == "V2"] <- "language_original"
names(lang)[names(lang) == "Family"] <- "family"
names(lang)[names(lang) == "Country.Where"] <- "location"
names(lang)[names(lang) == "ISO.639.3.Code"] <- "iso"

lang$language <- lingtypology::lang.gltc(lang$glottocode)
lang <- lang[c("id", "language_original", "language", "family",  "iso", "glottocode", "location", "fieldworkers")]
lang$longitude <- lingtypology::long.lang(lang$language)
lang$latitude <- lingtypology::lat.lang(lang$language)

lang$glottocode[lang$id == 93] <- lingtypology::gltc.iso("tac")
lang$language[lang$id == 93] <- lingtypology::lang.iso("tac")
lang$longitude <- lingtypology::long.lang(lang$language)
lang$latitude <- lingtypology::lat.lang(lang$language)

foci <- merge(foci, terms, by=c("id", "WCSC"))

lang <- merge(lang, foci, by=c("id"))

speakers <- utils::read.delim("http://www1.icsi.berkeley.edu/wcs/data/20100912/spkr-lsas.txt",
                              encoding="UTF-8", header = FALSE)
names(speakers)[names(speakers) == "V1"] <- "id"
names(speakers)[names(speakers) == "V2"] <- "speaker_id"
names(speakers)[names(speakers) == "V3"] <- "speakers_age"
names(speakers)[names(speakers) == "V4"] <- "speakers_sex"

lang <- merge(lang, speakers, by=c("id", "speaker_id"))
names(lang)[names(lang) == "TNUM"] <- "term_id"
names(lang)[names(lang) == "WCSC"] <- "term_abbr"
names(lang)[names(lang) == "TRAN"] <- "term_transcription"

chip_range <- utils::read.delim("http://www1.icsi.berkeley.edu/wcs/data/20021219/txt/term.txt",
                               encoding="UTF-8", header = FALSE)
names(chip_range)[names(chip_range) == "V1"] <- "id"
names(chip_range)[names(chip_range) == "V2"] <- "speaker_id"
names(chip_range)[names(chip_range) == "V3"] <- "chip_range"
names(chip_range)[names(chip_range) == "V4"] <- "term_abbr"

lang <- merge(lang, chip_range, by=c("id", "speaker_id", "term_abbr"))
id <- c(1:20)

language_original <- c("Arabic", "Bahasa Indonesia", "Bulgarian", "Cantonese", "Catalan",
"English (American)", "Hebrew", "Hungarian", "Ibibo", "Japanese", "Korean", "Mandarin",
"Mexican Spanish", "Pomo", "Swahili", "Tagalog", "Thai", "Tzeltal", "Urdu", "Vietnamese")
iso <- c("arb", "ind", "bul", "yue", "cat", "eng", "heb", "hun", "ibb",
            "jpn", "kor", "cmn", "spa", "pmm", "swh", "tgl", "tha", "tzh", "urd",
            "vie")

bk_langs <- data.frame(id, language_original, iso)
bk_langs$glottocode <- lingtypology::gltc.iso(bk_langs$iso)
bk_langs$language <- lingtypology::lang.gltc(bk_langs$glottocode)
bk_langs$longitude <- lingtypology::long.lang(bk_langs$language)
bk_langs$latitude <- lingtypology::lat.lang(bk_langs$language)
bk_langs$longitude[bk_langs$language_original == "English (American)"] <-
  39.10210731519252
bk_langs$latitude[bk_langs$language_original == "English (American)"] <-
  -102.09603054800091
bk_langs$longitude[bk_langs$language_original == "Mexican Spanish"] <-
  26.43076396738642
bk_langs$latitude[bk_langs$language_original == "Mexican Spanish"] <-
  -104.80470289339866
bk_terms <- utils::read.delim("http://www1.icsi.berkeley.edu/wcs/data/berlin-kay/BK-term.txt",
                           encoding="UTF-8", header = FALSE)

names(bk_terms)[names(bk_terms) == "V1"] <- "id"
names(bk_terms)[names(bk_terms) == "V2"] <- "speaker_id"
names(bk_terms)[names(bk_terms) == "V3"] <- "chip_range"
names(bk_terms)[names(bk_terms) == "V4"] <- "term_abbr"

bk_terms <- bk_terms[c("id", "speaker_id", "term_abbr")]
bk_langs <- merge(bk_langs, bk_terms, by = "id")

bk_dict <- utils::read.delim("http://www1.icsi.berkeley.edu/wcs/data/berlin-kay/BK-dict.txt",
                             encoding="UTF-8")

names(bk_dict)[names(bk_dict) == "X.lnum"] <- "id"
names(bk_dict)[names(bk_dict) == "tnum"] <- "term_id"
names(bk_dict)[names(bk_dict) == "abbr"] <- "term_abbr"
names(bk_dict)[names(bk_dict) == "term"] <- "term_transcription"

bk_langs <- merge(bk_langs, bk_dict, by = c("id", "term_abbr"))

bk_foci <- utils::read.delim("http://www1.icsi.berkeley.edu/wcs/data/berlin-kay/BK-foci.txt",
                             encoding="UTF-8", header=TRUE)

names(bk_foci)[names(bk_foci) == "X1"] <- "id"
names(bk_foci)[names(bk_foci) == "X1.1"] <- "speaker_id"
names(bk_foci)[names(bk_foci) == "X1.2"] <- "focus_response"
names(bk_foci)[names(bk_foci) == "J0"] <- "grid_coordinates"

bk_langs <- merge(bk_langs, bk_foci, by=c("id", "speaker_id"))

wcs <- lang
wcs_bk <- bk_langs

save(wcs, file="/Users/kirillkonca/lingtypology/data/wcs.RData", compress= 'xz')
save(wcs_bk, file="/Users/kirillkonca/lingtypology/data/wcs_bk.RData", compress= 'xz')
