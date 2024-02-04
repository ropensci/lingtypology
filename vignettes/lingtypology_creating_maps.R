## ---- include=FALSE-----------------------------------------------------------
library(lingtypology)
knitr::opts_chunk$set(eval = FALSE)

## -----------------------------------------------------------------------------
#  map.feature(c("Adyghe", "Kabardian", "Polish", "Russian", "Bulgarian"))

## ---- eval = FALSE------------------------------------------------------------
#  m <- map.feature(c("Adyghe", "Korean"))
#  # install.packages("htmlwidgets")
#  library(htmlwidgets)
#  saveWidget(m, file="TYPE_FILE_PATH/m.html")

## -----------------------------------------------------------------------------
#  df <- data.frame(language = c("Adyghe", "Kabardian", "Polish", "Russian", "Bulgarian"),
#                 features = c("polysynthetic", "polysynthetic", "fusional", "fusional", "fusional"))
#  df

## -----------------------------------------------------------------------------
#  map.feature(languages = df$language,
#              features = df$features)

## -----------------------------------------------------------------------------
#  df$features <- factor(df$features, levels = c("polysynthetic", "fusional"))
#  map.feature(languages = df$language, features = df$features)

## -----------------------------------------------------------------------------
#  map.feature(df$language, df$features)

## -----------------------------------------------------------------------------
#  map.feature(phonological_profiles$language,
#              phonological_profiles$ejectives) # categorical
#  map.feature(phonological_profiles$language,
#              phonological_profiles$consonants) # numeric

## -----------------------------------------------------------------------------
#  map.feature(phonological_profiles$language,
#              phonological_profiles$consonants,
#              map.orientation = "Atlantic")

## -----------------------------------------------------------------------------
#  m <- map.feature(languages = df$language,
#                   features = df$features)

## -----------------------------------------------------------------------------
#  library(htmltools)
#  browsable(
#    tagList(
#      list(
#        tags$head(
#          tags$style(
#            ".leaflet .legend {
#                   line-height: 20px;
#                   font-size: 20px;
#                   }",
#            ".leaflet .legend i{
#                  width: 20px;
#                  height: 20px;
#                   }"
#          )
#        ),
#        m)))

## -----------------------------------------------------------------------------
#  df$popup <- aff.lang(df$language)

## -----------------------------------------------------------------------------
#  map.feature(languages = df$language, features = df$features, popup = df$popup)

## -----------------------------------------------------------------------------
#  # change a df$popup vector
#  df$popup <- c("sɐ s-ɐ-k'ʷɐ<br> 1sg 1sg.abs-dyn-go<br>'I go'",
#                "sɐ s-o-k'ʷɐ<br> 1sg 1sg.abs-dyn-go<br>'I go'",
#                "id-ę<br> go-1sg.npst<br> 'I go'",
#                "ya id-u<br> 1sg go-1sg.npst <br> 'I go'",
#                "id-a<br> go-1sg.prs<br> 'I go'")
#  # create a map
#  
#  map.feature(df$language,
#              features = df$features,
#              popup = df$popup)

## -----------------------------------------------------------------------------
#  # Create a dataframe with links to video
#  sign_df <- data.frame(languages = c("American Sign Language", "Russian-Tajik Sign Language", "French Sign Language"),
#                        popup = c("https://media.spreadthesign.com/video/mp4/13/48600.mp4", "https://media.spreadthesign.com/video/mp4/12/17639.mp4", "https://media.spreadthesign.com/video/mp4/10/17638.mp4"))
#  
#  # Change popup to an HTML code
#  sign_df$popup <- paste("<video width='200' height='150' controls> <source src='",
#                         as.character(sign_df$popup),
#                         "' type='video/mp4'></video>", sep = "")
#  # create a map
#  map.feature(languages = sign_df$languages, popup = sign_df$popup)

## -----------------------------------------------------------------------------
#  map.feature(df$language, df$features,
#              label = df$language)

## -----------------------------------------------------------------------------
#  map.feature(df$language, df$features,
#              label = df$language,
#              label.fsize = 20,
#              label.position = "left",
#              label.hide = FALSE)

## -----------------------------------------------------------------------------
#  map.feature(df$language, df$features,
#              label = df$language,
#              label.fsize = 20,
#              label.position = "left",
#              label.hide = FALSE,
#              label.emphasize = list(2:4, "red"))

## -----------------------------------------------------------------------------
#  head(circassian)

## -----------------------------------------------------------------------------
#  map.feature(languages = circassian$language,
#              features = circassian$dialect,
#              popup = circassian$village,
#              latitude = circassian$latitude,
#              longitude = circassian$longitude)

## -----------------------------------------------------------------------------
#  map.feature(languages = circassian$language,
#              features = circassian$dialect,
#              popup = circassian$village,
#              latitude = circassian$latitude,
#              longitude = circassian$longitude,
#              point.cluster = TRUE)

## -----------------------------------------------------------------------------
#  df <- data.frame(language = c("Adyghe", "Kabardian", "Polish", "Russian", "Bulgarian"),
#                   features = c("polysynthetic", "polysynthetic", "fusional", "fusional", "fusional"))
#  map.feature(languages = df$language,
#              features = df$features,
#              color= c("yellowgreen", "navy"))

## -----------------------------------------------------------------------------
#  map.feature(phonological_profiles$language,
#              phonological_profiles$consonants,
#              color= "magma")

## -----------------------------------------------------------------------------
#  map.feature(languages = circassian$language,
#              features = circassian$language,
#              latitude = circassian$latitude,
#              longitude = circassian$longitude,
#              shape = TRUE)

## -----------------------------------------------------------------------------
#  map.feature(languages = circassian$language,
#              features = circassian$dialect,
#              latitude = circassian$latitude,
#              longitude = circassian$longitude,
#              shape = 1:10,
#              shape.size = 14)

## -----------------------------------------------------------------------------
#  map.feature(languages = df$language,
#              features = df$features,
#              control = c("a", "b", "b", "b", "a"))

## -----------------------------------------------------------------------------
#  map.feature(circassian$language,
#              features = circassian$dialect,
#              stroke.features = circassian$language,
#              latitude = circassian$latitude,
#              longitude = circassian$longitude)

## ---- message= F--------------------------------------------------------------
#  # create newfeature variable
#  newfeature <- circassian[,c(5,6)]
#  # set language feature of the Baksan villages to NA and reduce newfeature from dataframe to vector
#  newfeature <- replace(newfeature$language, newfeature$language == "Baksan", NA)
#  # create a map
#  
#  map.feature(circassian$language,
#              features = circassian$dialect,
#              latitude = circassian$latitude,
#              longitude = circassian$longitude,
#              stroke.features = newfeature)

## -----------------------------------------------------------------------------
#  map.feature(circassian$language,
#              features = circassian$dialect,
#              stroke.features = circassian$language,
#              latitude = circassian$latitude,
#              longitude = circassian$longitude,
#              width = 7, stroke.radius = 13)
#  
#  map.feature(circassian$language,
#              features = circassian$dialect,
#              stroke.features = circassian$language,
#              latitude = circassian$latitude,
#              longitude = circassian$longitude,
#              opacity = 0.7, stroke.opacity = 0.6)

## -----------------------------------------------------------------------------
#  map.feature(circassian$language,
#              features = circassian$dialect,
#              stroke.features = circassian$language,
#              latitude = circassian$latitude,
#              longitude = circassian$longitude,
#              legend = FALSE, stroke.legend = TRUE)
#  
#  map.feature(circassian$language,
#              features = circassian$dialect,
#              stroke.features = circassian$language,
#              latitude = circassian$latitude,
#              longitude = circassian$longitude,
#              title = "Circassian dialects", stroke.title = "Languages")

## -----------------------------------------------------------------------------
#  map.feature(c("Adyghe", "Polish", "Kabardian", "Russian"),
#              scale.bar= TRUE,
#              scale.bar.position = "topright")

## -----------------------------------------------------------------------------
#  df <- data.frame(lang = c("Adyghe", "Kabardian", "Polish", "Russian", "Bulgarian"),
#                   feature = c("polysynthetic", "polysynthetic", "fusion", "fusion", "fusion"),
#                   popup = c("Adyghe", "Adyghe", "Slavic", "Slavic", "Slavic"))
#  
#  map.feature(df$lang, df$feature, df$popup,
#              tile = "Esri.WorldGrayCanvas")

## -----------------------------------------------------------------------------
#  map.feature(df$lang, df$feature, df$popup,
#              tile = c("OpenStreetMap", "Esri.WorldGrayCanvas"))

## -----------------------------------------------------------------------------
#  map.feature(df$lang, df$feature, df$popup,
#              tile = c("OpenStreetMap", "Esri.WorldGrayCanvas"),
#              tile.name = c("colored", "b & w"))

## -----------------------------------------------------------------------------
#  map.feature(df$lang, df$feature, df$popup,
#              tile = c("OpenStreetMap", "Esri.WorldGrayCanvas"),
#              control = TRUE)

## -----------------------------------------------------------------------------
#  map.feature(c("Adyghe", "Polish", "Kabardian", "Russian"),
#              minimap = TRUE)

## -----------------------------------------------------------------------------
#  map.feature(c("Adyghe", "Polish", "Kabardian", "Russian"),
#              minimap = TRUE,
#              minimap.position = "topright",
#              minimap.height = 100,
#              minimap.width = 100)

## -----------------------------------------------------------------------------
#  map.feature(languages = phonological_profiles$language,
#              minichart.data = phonological_profiles[, c("vowels", "consonants")])

## -----------------------------------------------------------------------------
#  map.feature(languages = phonological_profiles$language,
#              minichart.data = phonological_profiles[, c("vowels", "consonants")],
#              minichart = "pie")

## -----------------------------------------------------------------------------
#  map.feature(languages = phonological_profiles$language,
#              minichart.data = phonological_profiles[, c("vowels", "consonants")],
#              color= c("yellowgreen", "navy"),
#              opacity = 0.7,
#              label = phonological_profiles$language,
#              legend.position = "topleft")

## -----------------------------------------------------------------------------
#  map.feature(languages = phonological_profiles$language,
#              minichart.data = phonological_profiles[, c("vowels", "consonants")],
#              minichart = "pie",
#              minichart.labels = TRUE)

## -----------------------------------------------------------------------------
#  map.feature(languages = phonological_profiles$language,
#              minichart.data = phonological_profiles[, c("tone", "long_vowels", "stress", "ejectives")],
#              minichart = "pie",
#              width = 3)

## -----------------------------------------------------------------------------
#  map.feature(circassian$language,
#              circassian$language,
#              longitude = circassian$longitude,
#              latitude = circassian$latitude,
#              rectangle.lng = c(42.7, 45),
#              rectangle.lat = c(42.7, 44.4),
#              rectangle.color= "green")

## -----------------------------------------------------------------------------
#  map.feature(circassian$language,
#              longitude = circassian$longitude,
#              latitude = circassian$latitude,
#              density.estimation = circassian$language,
#              density.width = 0.15)

## -----------------------------------------------------------------------------
#  map.feature(circassian$language,
#              features = circassian$dialect,
#              longitude = circassian$longitude,
#              latitude = circassian$latitude,
#              density.estimation = circassian$language,
#              density.width = 0.15)

## -----------------------------------------------------------------------------
#  map.feature(circassian$language,
#              longitude = circassian$longitude,
#              latitude = circassian$latitude,
#              density.estimation = circassian$language,
#              density.width = 0.15,
#              density.points = FALSE)

## -----------------------------------------------------------------------------
#  map.feature(circassian$language,
#              longitude = circassian$longitude,
#              latitude = circassian$latitude,
#              density.estimation = circassian$language,
#              density.width = 0.15,
#              density.estimation.opacity = 0.2)

## -----------------------------------------------------------------------------
#  map.feature(circassian$language,
#              features = circassian$language,
#              longitude = circassian$longitude,
#              latitude = circassian$latitude,
#              density.estimation = "Circassian",
#              density.method = "kernal density estimation",
#              density.width = c(0.3, 0.3),
#              color= c("darkgreen", "blue"))

## -----------------------------------------------------------------------------
#  map.feature(circassian$language,
#              features = circassian$language,
#              longitude = circassian$longitude,
#              latitude = circassian$latitude,
#              density.estimation = "Circassian",
#              density.method = "kernal density estimation",
#              density.width = c(0.7, 0.7),
#              color= c("darkgreen", "blue"))

## -----------------------------------------------------------------------------
#  map.feature(circassian$language,
#              features = circassian$language,
#              longitude = circassian$longitude,
#              latitude = circassian$latitude,
#              density.estimation = "Circassian",
#              density.method = "kernal density estimation",
#              density.width = c(1.3, 0.9),
#              color= c("darkgreen", "blue"))

## -----------------------------------------------------------------------------
#  map.feature(languages = circassian$language,
#              latitude = circassian$latitude,
#              longitude = circassian$longitude,
#              features = circassian$dialect,
#              label = circassian$dialect,
#              legend = TRUE,
#              isogloss = as.data.frame(circassian[,"dialect"]),
#              isogloss.width = 0.15)

## -----------------------------------------------------------------------------
#  map.feature(circassian$language,
#              features = circassian$language,
#              longitude = circassian$longitude,
#              latitude = circassian$latitude,
#              line.lng = c(39, 43),
#              line.lat = c(44.5, 43))

## -----------------------------------------------------------------------------
#  map.feature(circassian$language,
#              features = circassian$language,
#              longitude = circassian$longitude,
#              latitude = circassian$latitude,
#              line.lng = c(43, 39, 38.5),
#              line.lat = c(43, 44.5, 45),
#              line.color= "green")

## -----------------------------------------------------------------------------
#  map.feature(circassian$language,
#              features = circassian$language,
#              longitude = circassian$longitude,
#              latitude = circassian$latitude,
#              line.type = "logit")

## -----------------------------------------------------------------------------
#  map.feature(c("Russian", "Adyghe"),
#              graticule = 5)

