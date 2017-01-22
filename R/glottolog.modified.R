#' Catalogue of languages of the world
#'
#' A dataset containes the modified catalogue of languages of the world
#' involving genealogical affiliation, macro-area, country, iso code,
#' and coordinates.
#'
#' Glottolog 2.7. Hammarstrom, Harald & Forkel, Robert & Haspelmath, Martin &
#' Bank, Sebastian. 2016.
#' Max Planck Institute for the Science of Human History.
#' Accessed on 2016-06-15.
#'
#' @format A data frame with 8304 rows and 7 variables:
#' \describe{
#'   \item{iso}{code based on ISO 639--3 \url{http://www-01.sil.org/iso639-3/}}
#'   \item{languoid}{name of the languoid}
#'   \item{affiliation}{genealogical affiliation}
#'   \item{macro_area}{have six values Africa, Australia, Eurasia, North America, Papunesia, South America}
#'   \item{country}{list of countries, where the language is spoken}
#'   \item{latitude}{latitude}
#'   \item{longitude}{longitude}
#' }
#' @source \url{http://glottolog.org/}
#'

"glottolog.modified"

