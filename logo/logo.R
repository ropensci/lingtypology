autotype_data <- autotyp.feature('Numeral classifiers')
wals_data <- wals.feature('21a')
w_a_data <- inner_join(wals_data, autotype_data)
map.feature(w_a_data$language,
                features = w_a_data$`21a`,
                stroke.features = w_a_data$NumClass.Presence,
                legend = FALSE,
                stroke.legend = FALSE,
                label = paste(w_a_data$language, w_a_data$`21a`),
                graticule = 40,
                line.lng = c(60, 130, 150),
                line.lat = c(10, 43, 27),
                line.color = "green",
                tile = "Hydda.Base")

