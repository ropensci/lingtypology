## ---- include=FALSE------------------------------------------------------
library(lingtypology)
knitr::opts_chunk$set(message= FALSE, eval=FALSE)

## ------------------------------------------------------------------------
#  new_data <- read.csv("https://goo.gl/GgscBE")
#  tail(new_data)

## ---- message= FALSE-----------------------------------------------------
#  library(dplyr)
#  new_data %>%
#    mutate(Language.name = gsub(pattern = " ", replacement = "", Language.name)) %>%
#    filter(is.glottolog(Language.name) == TRUE) %>%
#    filter(area.lang(Language.name) == "Africa") %>%
#    select(Language.name) %>%
#    map.feature()

## ---- message= FALSE-----------------------------------------------------
#  new_data %>%
#    mutate(Language.name = gsub(pattern = " ", replacement = "", Language.name)) %>%
#    filter(is.glottolog(Language.name) == TRUE) %>%
#    filter(area.lang(Language.name) == "Africa") %>%
#    select(Language.name) %>%
#    map.feature(., minimap = TRUE)

## ------------------------------------------------------------------------
#  library(leaflet)
#  map.feature(c("French", "Occitan")) %>%
#    fitBounds(0, 40, 10, 50) %>%
#    addPopups(2, 48, "Great day!")

## ------------------------------------------------------------------------
#  leaflet() %>%
#    fitBounds(0, 40, 10, 50) %>%
#    addPopups(2, 48, "Great day!") %>%
#    map.feature(c("French", "Occitan"), pipe.data = .)

## ------------------------------------------------------------------------
#  m <- leaflet() %>%
#    fitBounds(0, 40, 10, 50) %>%
#    addPopups(2, 48, "Great day!")
#  
#  map.feature(c("French", "Occitan"), pipe.data = m)

## ------------------------------------------------------------------------
#  leaflet()  %>%
#    addProviderTiles("OpenStreetMap.BlackAndWhite") %>%
#    fitBounds(0, 40, 10, 50) %>%
#    addPopups(2, 48, "Great day!") %>%
#    map.feature(c("French", "Occitan"), pipe.data = ., tile = "none")

