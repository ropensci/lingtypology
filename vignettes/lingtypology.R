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

## ------------------------------------------------------------------------
is.glottolog(c("Tabasaran", "Tabassaran"), glottolog.source = "original")

## ------------------------------------------------------------------------
is.glottolog(c("Tabasaran", "Tabassaran"), glottolog.source = "modified")

## ------------------------------------------------------------------------
is.glottolog(c("Tabasaran", "Tabassaran"), g = "o")

## ------------------------------------------------------------------------
is.glottolog(c("Tabasaran", "Tabassaran"), g = "m")

## ---- fig.width=6.2------------------------------------------------------
map.feature(c("Adyghe", "Kabardian", "Polish", "Russian", "Bulgarian"))

## ------------------------------------------------------------------------
df <- data.frame(language = c("Adyghe", "Kabardian", "Polish", "Russian", "Bulgarian"),
                 features = c("polysynthetic", "polysynthetic", "fusional", "fusional", "fusional"))
df

## ---- fig.width=6.2------------------------------------------------------
map.feature(languages = df$language, features = df$features)

## ---- fig.width=6.2------------------------------------------------------
set.seed(42)
map.feature(languages = df$language, features = df$features)

## ---- fig.width=6.2------------------------------------------------------
set.seed(42)
map.feature(df$language, df$features)

## ---- fig.width=6.2------------------------------------------------------
df$popup <- aff.lang(df$language)

## ---- fig.width=6.2------------------------------------------------------
set.seed(42)
map.feature(languages = df$language, features = df$features, popup = df$popup)

## ---- fig.width=6.2------------------------------------------------------
set.seed(42)
map.feature(df$language, df$features, df$popup)

## ---- fig.width=6.2------------------------------------------------------
# change a df$popup vector
df$popup <- c ("sɐ s-ɐ-k'ʷɐ<br> 1sg 1sg.abs-dyn-go<br>'I go'",
               "sɐ s-o-k'ʷɐ<br> 1sg 1sg.abs-dyn-go<br>'I go'",
               "id-ę<br> go-1sg.npst<br> 'I go'",
               "ya id-u<br> 1sg go-1sg.npst <br> 'I go'",
               "id-a<br> go-1sg.prs<br> 'I go'")
# create a map
set.seed(42)
map.feature(df$language, df$features, df$popup)

## ---- fig.width=6.2------------------------------------------------------
set.seed(42)
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
set.seed(42)
map.feature(languages = df$language,
            features = df$features,
            control = TRUE)

## ---- fig.width=6.2------------------------------------------------------
set.seed(42)
map.feature(circassian$language,
            features = circassian$languoid,
            stroke.features = circassian$language,
            latitude = circassian$latitude,
            longitude = circassian$longitude)

## ---- message= F, fig.width=6.2------------------------------------------
# create newfeature variable
newfeature <- circassian[,c(5,6)]
# set language feature of the Baksan villages to NA and reduce newfeature from dataframe to vector
newfeature <-  replace(newfeature$language, newfeature$languoid == "Baksan", NA)
# create a map
set.seed(42)
map.feature(circassian$language,
            features = circassian$languoid,
            latitude = circassian$latitude,
            longitude = circassian$longitude,
            stroke.features = newfeature)

## ---- fig.width=6.2------------------------------------------------------
set.seed(42)
map.feature(circassian$language,
            features = circassian$languoid,
            stroke.features = circassian$language,
            latitude = circassian$latitude,
            longitude = circassian$longitude,
            radius = 7, stroke.radius = 13)

set.seed(42)
map.feature(circassian$language,
            features = circassian$languoid,
            stroke.features = circassian$language,
            latitude = circassian$latitude,
            longitude = circassian$longitude,
            opacity = 0.7, stroke.opacity = 0.6)

## ---- fig.width=6.2------------------------------------------------------
set.seed(42)
map.feature(circassian$language,
            features = circassian$languoid,
            stroke.features = circassian$language,
            latitude = circassian$latitude,
            longitude = circassian$longitude,
            legend = FALSE, stroke.legend = TRUE)

set.seed(42)
map.feature(circassian$language,
            features = circassian$languoid,
            stroke.features = circassian$language,
            latitude = circassian$latitude,
            longitude = circassian$longitude,
            title = "Circassian dialects", stroke.title = "Languages")

## ---- fig.width=6.2------------------------------------------------------
df <- data.frame(lang = c("Adyghe", "Kabardian", "Polish", "Russian", "Bulgarian"),
   feature = c("polysynthetic", "polysynthetic", "fusion", "fusion", "fusion"),
   popup = c("Adyghe", "Adyghe", "Slavic", "Slavic", "Slavic"))
set.seed(42)
map.feature(df$lang, df$feature, df$popup,
            tile = "Thunderforest.OpenCycleMap")

## ---- fig.width=6.2------------------------------------------------------
df <- data.frame(lang = c("Adyghe", "Kabardian", "Polish", "Russian", "Bulgarian"),
   feature = c("polysynthetic", "polysynthetic", "fusion", "fusion", "fusion"),
   popup = c("Adyghe", "Adyghe", "Slavic", "Slavic", "Slavic"))
set.seed(42)
map.feature(df$lang, df$feature, df$popup,
            tile = c("OpenStreetMap.BlackAndWhite", "Thunderforest.OpenCycleMap"))

## ---- fig.width=6.2------------------------------------------------------
df <- data.frame(lang = c("Adyghe", "Kabardian", "Polish", "Russian", "Bulgarian"),
   feature = c("polysynthetic", "polysynthetic", "fusion", "fusion", "fusion"),
   popup = c("Adyghe", "Adyghe", "Slavic", "Slavic", "Slavic"))
set.seed(42)
map.feature(df$lang, df$feature, df$popup,
            tile = c("OpenStreetMap.BlackAndWhite", "Thunderforest.OpenCycleMap"),
            tile.name = c("b & w", "colored"))

## ---- fig.width=6.2------------------------------------------------------
df <- data.frame(lang = c("Adyghe", "Kabardian", "Polish", "Russian", "Bulgarian"),
   feature = c("polysynthetic", "polysynthetic", "fusion", "fusion", "fusion"),
   popup = c("Adyghe", "Adyghe", "Slavic", "Slavic", "Slavic"))
set.seed(42)
map.feature(df$lang, df$feature, df$popup,
            tile = c("OpenStreetMap.BlackAndWhite", "Thunderforest.OpenCycleMap"),
            control = TRUE)

## ---- fig.width=6.2------------------------------------------------------
df <- data.frame(lang = c("Russian", "Russian"),
                 lat  = c(55.75, 59.95),
                 long = c(37.616667, 30.3),
# I use here URL shortener by Google
                 urls = c("https://goo.gl/5OUv1E",
                          "https://goo.gl/UWmvDw"))
map.feature(languages = df$lang,
            latitude = df$lat,
            longitude = df$long,
            image.url = df$urls)

## ---- fig.width=6.2------------------------------------------------------
df <- data.frame(lang = c("Russian", "Russian"),
                 lat  = c(55.75, 59.95),
                 long = c(37.616667, 30.3),
# I use here URL shorter by Google
                 urls = c("https://goo.gl/5OUv1E",
                          "https://goo.gl/UWmvDw"))
map.feature(languages = df$lang,
            latitude = df$lat,
            longitude = df$long,
            image.url = df$urls,
            image.width = 200,
            image.height = 200)

## ---- fig.width=6.2------------------------------------------------------
df <- data.frame(lang = c("Russian", "Russian"),
                 lat  = c(55.75, 59.95),
                 long = c(37.616667, 30.3),
# I use here URL shorter by Google
                 urls = c("https://goo.gl/5OUv1E",
                          "https://goo.gl/UWmvDw"))
map.feature(languages = df$lang,
            latitude = df$lat,
            longitude = df$long,
            image.url = df$urls,
            image.width = 150,
            image.height = 150,
            image.X.shift = 10,
            image.Y.shift = 0)

## ------------------------------------------------------------------------
citation("lingtypology")

