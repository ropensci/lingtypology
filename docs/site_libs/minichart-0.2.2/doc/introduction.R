## -----------------------------------------------------------------------------
library(leaflet.minicharts)
data("eco2mix")
head(eco2mix)

## ----message=FALSE------------------------------------------------------------
library(dplyr)

prod2016 <- eco2mix %>%
  mutate(
    renewable = bioenergy + solar + wind + hydraulic,
    non_renewable = total - bioenergy - solar - wind - hydraulic
  ) %>%
  filter(grepl("2016", month) & area != "France") %>%
  select(-month) %>%
  group_by(area, lat, lng) %>%
  summarise_all(sum) %>%
  ungroup()

head(prod2016)

## ----message=FALSE, results='hide'--------------------------------------------
library(leaflet)

tilesURL <- "http://server.arcgisonline.com/ArcGIS/rest/services/Canvas/World_Light_Gray_Base/MapServer/tile/{z}/{y}/{x}"

basemap <- leaflet(width = "100%", height = "400px") %>%
  addTiles(tilesURL)

## -----------------------------------------------------------------------------
colors <- c("#4fc13c", "#cccccc")

basemap %>%
  addMinicharts(
    prod2016$lng, prod2016$lat,
    type = "pie",
    chartdata = prod2016[, c("renewable", "non_renewable")], 
    colorPalette = colors, 
    width = 60 * sqrt(prod2016$total) / sqrt(max(prod2016$total)), transitionTime = 0
  )

## -----------------------------------------------------------------------------
renewable2016 <- prod2016 %>% select(hydraulic, solar, wind)
colors <- c("#3093e5", "#fcba50", "#a0d9e8")
basemap %>%
  addMinicharts(
    prod2016$lng, prod2016$lat,
    chartdata = renewable2016,
    colorPalette = colors,
    width = 45, height = 45
  )

## -----------------------------------------------------------------------------
basemap %>%
  addMinicharts(
    prod2016$lng, prod2016$lat,
    chartdata = prod2016$load,
    showLabels = TRUE,
    width = 45
  )

## -----------------------------------------------------------------------------
prodRegions <- eco2mix %>% filter(area != "France")

## -----------------------------------------------------------------------------
basemap %>% 
  addMinicharts(
    prodRegions$lng, prodRegions$lat, 
    chartdata = prodRegions[, c("hydraulic", "solar", "wind")],
    time = prodRegions$month,
    colorPalette = colors,
    width = 45, height = 45
  )

## -----------------------------------------------------------------------------
data("eco2mixBalance")
bal <- eco2mixBalance
basemap %>%
  addFlows(
    bal$lng0, bal$lat0, bal$lng1, bal$lat1,
    flow = bal$balance,
    time = bal$month
  )

## ----eval = FALSE-------------------------------------------------------------
#  server <- function(input, output, session) {
#    # Initialize map
#    output$mymap <- renderLeaflet(
#      leaflet() %>% addTiles() %>%
#        addMinicharts(lon, lat, layerId = uniqueChartIds)
#    )
#  }

## ----eval = FALSE-------------------------------------------------------------
#  server <- function(input, output, session) {
#    # Initialize map
#    ...
#  
#    # Update map
#    observe({
#      newdata <- getData(input$myinput)
#  
#      leafletProxy("mymap") %>%
#        updateMinicharts(uniqueChartIds, chartdata = newdata, ...)
#    })
#  }

