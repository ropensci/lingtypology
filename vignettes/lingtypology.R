## ---- eval=FALSE---------------------------------------------------------
#  install.packages("lingtypology")

## ---- eval= F------------------------------------------------------------
#  install.packages("devtools")
#  devtools::install_github("agricolamz/lingtypology", dependencies = TRUE)

## ------------------------------------------------------------------------
library(lingtypology)

## ------------------------------------------------------------------------
iso.lang("Adyghe")
lang.iso("ady")
country.lang("Adyghe")
lang.aff("Abkhaz-Adyge")

## ------------------------------------------------------------------------
area.lang(c("Adyghe", "Aduge"))
lang <- c("Adyghe", "Russian")
aff.lang(lang)

## ------------------------------------------------------------------------
iso.lang(lang.aff("East Slavic"))

## ------------------------------------------------------------------------
country.lang(c("Udi", "Laz"))
country.lang(c("Udi", "Laz"), intersection = TRUE)

## ------------------------------------------------------------------------
lang.country("Cape Verde")
lang.country("Cabo Verde")
head(lang.country("UK"))

## ------------------------------------------------------------------------
aff.lang("Adyge")

## ---- fig.width=6.2------------------------------------------------------
map.feature(c("Adyghe", "Kabardian", "Polish", "Russian", "Bulgarian"))

## ------------------------------------------------------------------------
df <- data.frame(language = c("Adyghe", "Kabardian", "Polish", "Russian", "Bulgarian"),
                 features = c("polysynthetic", "polysynthetic", "fusional", "fusional", "fusional"))
df

## ---- fig.width=6.2------------------------------------------------------
map.feature(languages = df$language, features = df$features)

## ---- fig.width=6.2------------------------------------------------------
set.seed(40)
map.feature(languages = df$language, features = df$features)

## ---- fig.width=6.2------------------------------------------------------
set.seed(40)
map.feature(df$language, df$features)

## ---- fig.width=6.2------------------------------------------------------
set.seed(40)
map.feature(df$language, df$features, title = "morphological type")

## ---- fig.width=6.2------------------------------------------------------
df$popup <- aff.lang(df$language)

## ---- fig.width=6.2------------------------------------------------------
set.seed(40)
map.feature(languages = df$language, features = df$features, popup = df$popup)

## ---- fig.width=6.2------------------------------------------------------
set.seed(40)
map.feature(df$language, df$features, df$popup)

## ---- fig.width=6.2------------------------------------------------------
# change a df$popup vector
df$popup <- c ("sɐ s-ɐ-k'ʷɐ<br> 1sg 1sg.abs-dyn-go<br>'I go'",
               "sɐ s-o-k'ʷɐ<br> 1sg 1sg.abs-dyn-go<br>'I go'",
               "id-ę<br> go-1sg.npst<br> 'I go'",
               "ya id-u<br> 1sg go-1sg.npst <br> 'I go'",
               "id-a<br> go-1sg.prs<br> 'I go'")
# create a map
set.seed(40)
map.feature(df$language, df$features, df$popup)

## ---- fig.width=6.2------------------------------------------------------
set.seed(7)
map.feature(languages = circassian$language,
            features = circassian$languoid,
            popup = circassian$village,
            latitude = circassian$latitude,
            longitude = circassian$longitude)

## ---- fig.width=6.2------------------------------------------------------
df <- data.frame(language = c("Adyghe", "Kabardian", "Polish", "Russian", "Bulgarian"),
                 features = c("polysynthetic", "polysynthetic", "fusional", "fusional", "fusional"))
map.feature(languages = df$language,
            features = df$features,
            color = c("yellowgreen", "navy"))

## ---- fig.width=6.2------------------------------------------------------
map.feature(lang.aff("Sign Language"), control = FALSE)

## ---- fig.width=6.2------------------------------------------------------
set.seed(7)
map.feature(circassian$language,
            features = circassian$languoid,
            stroke.features = circassian$language,
            latitude = circassian$latitude,
            longitude = circassian$longitude)

## ---- message= F, fig.width=6.2------------------------------------------
library(dplyr)
# create newfeature variable
newfeature <- circassian
# set language feature of the Baksan villages to NA and reduce newfeature from dataframe to vector
newfeature %>% 
  mutate(language = replace(language, languoid == "Baksan", NA)) %>% 
  select(language) %>% 
  unlist() ->
  newfeature
# create a map
set.seed(7)
map.feature(circassian$language,
            features = circassian$languoid, 
            latitude = circassian$latitude,
            longitude = circassian$longitude,
            stroke.features = newfeature)

## ---- fig.width=6.2------------------------------------------------------
set.seed(7)
map.feature(circassian$language,
            features = circassian$languoid,
            stroke.features = circassian$language,
            latitude = circassian$latitude,
            longitude = circassian$longitude,
            radius = 7, stroke.radius = 13)

set.seed(7)
map.feature(circassian$language,
            features = circassian$languoid,
            stroke.features = circassian$language,
            latitude = circassian$latitude,
            longitude = circassian$longitude,
            opacity = 0.7, stroke.opacity = 0.6)

## ---- fig.width=6.2------------------------------------------------------
library(leaflet) # for correct work of %>% operator
df <- data.frame(lang = c("Adyghe", "Kabardian", "Polish", "Russian", "Bulgarian"),
   feature = c("polysynthetic", "polysynthetic", "fusion", "fusion", "fusion"),
   popup = c("Adyghe", "Adyghe", "Slavic", "Slavic", "Slavic"))
set.seed(7)
map.feature(df$lang, df$feature, df$popup) %>% 
addProviderTiles("Stamen.Toner")

