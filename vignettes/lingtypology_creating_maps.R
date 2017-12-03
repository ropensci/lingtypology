## ---- include=FALSE------------------------------------------------------
library(lingtypology)

## ---- eval=FALSE---------------------------------------------------------
#  map.feature(c("Adyghe", "Kabardian", "Polish", "Russian", "Bulgarian"))

## ---- eval = FALSE-------------------------------------------------------
#  m <- map.feature(c("Adyghe", "Korean"))
#  # install.packages("htmlwidgets")
#  library(htmlwidgets)
#  saveWidget(m, file="TYPE_FILE_PATH/m.html")

## ------------------------------------------------------------------------
df <- data.frame(language = c("Adyghe", "Kabardian", "Polish", "Russian", "Bulgarian"),
                 features = c("polysynthetic", "polysynthetic", "fusional", "fusional", "fusional"))
df

## ---- eval=FALSE---------------------------------------------------------
#  map.feature(languages = df$language,
#              features = df$features)

## ---- eval=FALSE---------------------------------------------------------
#  df$features <- factor(df$features, levels = c("polysynthetic", "fusional"))
#  map.feature(languages = df$language, features = df$features)

## ---- eval=FALSE---------------------------------------------------------
#  map.feature(df$language, df$features)

## ---- eval=FALSE---------------------------------------------------------
#  map.feature(ejective_and_n_consonants$language,
#              ejective_and_n_consonants$ejectives) # categorical
#  map.feature(ejective_and_n_consonants$language,
#              ejective_and_n_consonants$consonants) # numeric

## ---- eval=FALSE---------------------------------------------------------
#  map.feature(ejective_and_n_consonants$language,
#              ejective_and_n_consonants$consonants,
#              map.orientation = "Atlantic")

## ---- eval=FALSE---------------------------------------------------------
#  df$popup <- aff.lang(df$language)

## ---- eval=FALSE---------------------------------------------------------
#  
#  map.feature(languages = df$language, features = df$features, popup = df$popup)

## ---- eval=FALSE---------------------------------------------------------
#  # change a df$popup vector
#  df$popup <- c ("sɐ s-ɐ-k'ʷɐ<br> 1sg 1sg.abs-dyn-go<br>'I go'",
#                 "sɐ s-o-k'ʷɐ<br> 1sg 1sg.abs-dyn-go<br>'I go'",
#                 "id-ę<br> go-1sg.npst<br> 'I go'",
#                 "ya id-u<br> 1sg go-1sg.npst <br> 'I go'",
#                 "id-a<br> go-1sg.prs<br> 'I go'")
#  # create a map
#  
#  map.feature(df$language,
#              features = df$features,
#              popup = df$popup)

## ---- eval=FALSE---------------------------------------------------------
#  # Create a dataframe with links to video
#  sign_df <- data.frame(languages = c("American Sign Language", "Russian Sign Language", "French Sign Language"),
#                   popup = c("https://media.spreadthesign.com/video/mp4/13/48600.mp4", "https://media.spreadthesign.com/video/mp4/12/17639.mp4", "https://media.spreadthesign.com/video/mp4/10/17638.mp4"))
#  
#  # Change popup to an HTML code
#  sign_df$popup <- paste("<video width='200' height='150' controls> <source src='",
#                    as.character(sign_df$popup),
#                    "' type='video/mp4'></video>", sep = "")
#  # create a map
#  map.feature(languages = sign_df$languages, popup = sign_df$popup)

## ---- eval=FALSE---------------------------------------------------------
#  map.feature(df$language, df$features,
#              label = df$language)

## ---- eval=FALSE---------------------------------------------------------
#  map.feature(df$language, df$features,
#              label = df$language,
#              label.fsize = 20,
#              label.position = "left",
#              label.hide = FALSE)

## ---- eval=FALSE---------------------------------------------------------
#  map.feature(df$language, df$features,
#              label = df$language,
#              label.fsize = 20,
#              label.position = "left",
#              label.hide = FALSE,
#              label.emphasize = list(2:4, "red"))

## ---- eval=FALSE---------------------------------------------------------
#  map.feature(languages = circassian$language,
#              features = circassian$dialect,
#              popup = circassian$village,
#              latitude = circassian$latitude,
#              longitude = circassian$longitude)

## ---- eval=FALSE---------------------------------------------------------
#  df <- data.frame(language = c("Adyghe", "Kabardian", "Polish", "Russian", "Bulgarian"),
#                   features = c("polysynthetic", "polysynthetic", "fusional", "fusional", "fusional"))
#  map.feature(languages = df$language,
#              features = df$features,
#              color = c("yellowgreen", "navy"))

## ---- eval=FALSE---------------------------------------------------------
#  map.feature(ejective_and_n_consonants$language,
#              ejective_and_n_consonants$consonants,
#              color = "magma")

## ---- eval=FALSE---------------------------------------------------------
#  
#  map.feature(languages = df$language,
#              features = df$features,
#              control = TRUE)

## ---- eval=FALSE---------------------------------------------------------
#  
#  map.feature(circassian$language,
#              features = circassian$dialect,
#              stroke.features = circassian$language,
#              latitude = circassian$latitude,
#              longitude = circassian$longitude)

## ---- message= F, eval=FALSE---------------------------------------------
#  # create newfeature variable
#  newfeature <- circassian[,c(5,6)]
#  # set language feature of the Baksan villages to NA and reduce newfeature from dataframe to vector
#  newfeature <-  replace(newfeature$language, newfeature$language == "Baksan", NA)
#  # create a map
#  
#  map.feature(circassian$language,
#              features = circassian$dialect,
#              latitude = circassian$latitude,
#              longitude = circassian$longitude,
#              stroke.features = newfeature)

## ---- eval=FALSE---------------------------------------------------------
#  
#  map.feature(circassian$language,
#              features = circassian$dialect,
#              stroke.features = circassian$language,
#              latitude = circassian$latitude,
#              longitude = circassian$longitude,
#              width = 7, stroke.radius = 13)
#  
#  
#  map.feature(circassian$language,
#              features = circassian$dialect,
#              stroke.features = circassian$language,
#              latitude = circassian$latitude,
#              longitude = circassian$longitude,
#              opacity = 0.7, stroke.opacity = 0.6)

## ---- eval=FALSE---------------------------------------------------------
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

## ---- eval=FALSE---------------------------------------------------------
#  map.feature(c("Adyghe", "Polish", "Kabardian", "Russian"),
#              scale.bar = TRUE,
#              scale.bar.position = "topright")

## ---- eval=FALSE---------------------------------------------------------
#  df <- data.frame(lang = c("Adyghe", "Kabardian", "Polish", "Russian", "Bulgarian"),
#     feature = c("polysynthetic", "polysynthetic", "fusion", "fusion", "fusion"),
#     popup = c("Adyghe", "Adyghe", "Slavic", "Slavic", "Slavic"))
#  
#  map.feature(df$lang, df$feature, df$popup,
#              tile = "Thunderforest.OpenCycleMap")

## ---- eval=FALSE---------------------------------------------------------
#  df <- data.frame(lang = c("Adyghe", "Kabardian", "Polish", "Russian", "Bulgarian"),
#                   feature = c("polysynthetic", "polysynthetic", "fusion", "fusion", "fusion"),
#                   popup = c("Adyghe", "Adyghe", "Slavic", "Slavic", "Slavic"))
#  
#  map.feature(df$lang, df$feature, df$popup,
#              tile = c("OpenStreetMap.BlackAndWhite", "Thunderforest.OpenCycleMap"))

## ---- eval=FALSE---------------------------------------------------------
#  df <- data.frame(lang = c("Adyghe", "Kabardian", "Polish", "Russian", "Bulgarian"),
#                   feature = c("polysynthetic", "polysynthetic", "fusion", "fusion", "fusion"),
#                   popup = c("Adyghe", "Adyghe", "Slavic", "Slavic", "Slavic"))
#  
#  map.feature(df$lang, df$feature, df$popup,
#              tile = c("OpenStreetMap.BlackAndWhite", "Thunderforest.OpenCycleMap"),
#              tile.name = c("b & w", "colored"))

## ---- eval=FALSE---------------------------------------------------------
#  df <- data.frame(lang = c("Adyghe", "Kabardian", "Polish", "Russian", "Bulgarian"),
#                   feature = c("polysynthetic", "polysynthetic", "fusion", "fusion", "fusion"),
#                   popup = c("Adyghe", "Adyghe", "Slavic", "Slavic", "Slavic"))
#  
#  map.feature(df$lang, df$feature, df$popup,
#              tile = c("OpenStreetMap.BlackAndWhite", "Thunderforest.OpenCycleMap"),
#              control = TRUE)

## ---- eval=FALSE---------------------------------------------------------
#  map.feature(c("Adyghe", "Polish", "Kabardian", "Russian"),
#              minimap = TRUE)

## ---- eval=FALSE---------------------------------------------------------
#  
#  map.feature(c("Adyghe", "Polish", "Kabardian", "Russian"),
#              minimap = TRUE,
#              minimap.position = "topright",
#              minimap.height = 100,
#              minimap.width = 100)

## ---- eval=FALSE---------------------------------------------------------
#  map.feature(languages = ejective_and_n_consonants$language,
#              minichart.data = ejective_and_n_consonants[, c("vowels", "consonants")],
#              minichart = "bar")

## ---- eval=FALSE---------------------------------------------------------
#  map.feature(languages = ejective_and_n_consonants$language,
#              minichart.data = ejective_and_n_consonants[, c("vowels", "consonants")],
#              minichart = "pie")

## ---- eval=FALSE---------------------------------------------------------
#  map.feature(languages = ejective_and_n_consonants$language,
#              minichart.data = ejective_and_n_consonants[, c("vowels", "consonants")],
#              minichart = "bar",
#              color = c("yellowgreen", "navy"),
#              opacity = 0.7,
#              label = ejective_and_n_consonants$language,
#              legend.position = "topleft")

## ---- eval=FALSE---------------------------------------------------------
#  map.feature(languages = ejective_and_n_consonants$language,
#              minichart.data = ejective_and_n_consonants[, c("vowels", "consonants")],
#              minichart = "pie",
#              minichart.labels = TRUE)

## ---- eval=FALSE---------------------------------------------------------
#  map.feature(circassian$language,
#              circassian$language,
#              longitude = circassian$longitude,
#              latitude = circassian$latitude,
#              rectangle.lng = c(42.7, 45),
#              rectangle.lat = c(42.7, 44.4),
#              rectangle.color = "green")

## ---- eval=FALSE---------------------------------------------------------
#  map.feature(circassian$language,
#              longitude = circassian$longitude,
#              latitude = circassian$latitude,
#              density.estimation = circassian$language)

## ---- eval=FALSE---------------------------------------------------------
#  map.feature(circassian$language,
#              features = circassian$dialect,
#              longitude = circassian$longitude,
#              latitude = circassian$latitude,
#              density.estimation = circassian$language)

## ---- eval=FALSE---------------------------------------------------------
#  map.feature(circassian$language,
#              longitude = circassian$longitude,
#              latitude = circassian$latitude,
#              density.estimation = circassian$language,
#              density.points = FALSE)

## ---- eval=FALSE---------------------------------------------------------
#  map.feature(circassian$language,
#              longitude = circassian$longitude,
#              latitude = circassian$latitude,
#              density.estimation = circassian$language,
#              density.estimation.opacity = 0.9)

## ---- eval=FALSE---------------------------------------------------------
#  map.feature(circassian$language,
#              features = circassian$language,
#              longitude = circassian$longitude,
#              latitude = circassian$latitude,
#              density.estimation = "Circassian",
#              density.longitude.width = 0.3,
#              density.latitude.width = 0.3,
#              color = c("darkgreen", "blue"))

## ---- eval=FALSE---------------------------------------------------------
#  map.feature(circassian$language,
#              features = circassian$language,
#              longitude = circassian$longitude,
#              latitude = circassian$latitude,
#              density.estimation = "Circassian",
#              density.longitude.width = 0.7,
#              density.latitude.width = 0.7,
#              color = c("darkgreen", "blue"))

## ---- eval=FALSE---------------------------------------------------------
#  map.feature(circassian$language,
#              features = circassian$language,
#              longitude = circassian$longitude,
#              latitude = circassian$latitude,
#              density.estimation = "Circassian",
#              density.longitude.width = 1.3,
#              density.latitude.width = 0.9,
#              color = c("darkgreen", "blue"))
