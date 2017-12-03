## ---- include=FALSE------------------------------------------------------
library(lingtypology)

## ---- eval=FALSE---------------------------------------------------------
#  df <- wals.feature(c("1a", "20a"))
#  head(df)
#  map.feature(df$language,
#              features = df$`1a`,
#              latitude = df$latitude,
#              longitude = df$longitude,
#              label = df$language,
#              title = "Consonant Inventories")

## ---- eval=FALSE---------------------------------------------------------
#  df <- autotyp.feature(c('Gender', 'Numeral classifiers'))
#  head(df)
#  map.feature(df$language,
#              features = df$NumClass.Presence,
#              label = df$language,
#              title = "Presence of Numeral Classifiers")

## ---- eval=FALSE---------------------------------------------------------
#  df <- phoible.feature(source = "UPSID")
#  head(df)
#  map.feature(df$language,
#              features = df$phonemes,
#              label = df$language,
#              title = "Number of Phonemes")

## ---- eval=FALSE---------------------------------------------------------
#  df <- afbo.feature(c("adjectivizer", "adverbializer"))
#  head(df)
#  map.feature(df$Recipient.name,
#              features = df$adjectivizer,
#              label = df$Recipient.name,
#              title = "Borrowed adjectivizer affixes")

## ---- eval=FALSE---------------------------------------------------------
#  df <- sails.feature(features = "ics10")
#  head(df)
#  map.feature(df$language,
#              features = df$ics10_description,
#              longitude = df$longitude,
#              latitude = df$latitude,
#              label = df$language,
#              title = "Are there numeral classifiers?")

## ---- eval=FALSE---------------------------------------------------------
#  df <- abvd.feature(50:55)
#  head(df)
#  new_df <- df[df$word == "hand",]
#  map.feature(new_df$language,
#              features = new_df$item,
#              label = new_df$language)

