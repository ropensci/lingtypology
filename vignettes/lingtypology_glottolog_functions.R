## ---- include=FALSE------------------------------------------------------
library(lingtypology)

## ------------------------------------------------------------------------
names(glottolog.original)

## ------------------------------------------------------------------------
iso.lang("Adyghe")
lang.iso("ady")
country.lang("Adyghe")
lang.aff("West Caucasian")

## ------------------------------------------------------------------------
area.lang(c("Adyghe", "Aduge"))
lang <- c("Adyghe", "Russian")
aff.lang(lang)

## ------------------------------------------------------------------------
iso.lang(lang.aff("Circassian"))

## ------------------------------------------------------------------------
country.lang(c("Udi", "Laz"))
country.lang(c("Udi", "Laz"), intersection = TRUE)

## ------------------------------------------------------------------------
lang.country("Cape Verde")
lang.country("Cabo Verde")
head(lang.country("USA"))

## ------------------------------------------------------------------------
aff.lang("Adyge")

## ------------------------------------------------------------------------
is.glottolog(c("Abkhaz", "Abkhazian"), glottolog.source = "original")

## ------------------------------------------------------------------------
is.glottolog(c("Abkhaz", "Abkhazian"), glottolog.source = "modified")

## ------------------------------------------------------------------------
is.glottolog(c("Abkhaz", "Abkhazian"), g = "o")

## ------------------------------------------------------------------------
is.glottolog(c("Abkhaz", "Abkhazian"), g = "m")

