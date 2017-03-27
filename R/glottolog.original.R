#' Catalogue of languages of the world
#'
#' A dataset containes the original catalogue of languages of the world
#' involving genealogical affiliation, macro-area, country, iso code,
#' and coordinates.
#'
#' Glottolog 2.7. Hammarstrom, Harald & Forkel, Robert & Haspelmath, Martin &
#' Bank, Sebastian. 2016.
#' Max Planck Institute for the Science of Human History.
#' Accessed on 2016-06-15.
#'
#' @format A data frame with 8566 rows and 7 variables:
#' \describe{
#'   \item{iso}{code based on ISO 639--3 \url{http://www-01.sil.org/iso639-3/}}
#'   \item{language}{name of the language}
#'   \item{affiliation}{genealogical affiliation}
#'   \item{area}{have six values Africa, Australia, Eurasia, North America, Papunesia, South America}
#'   \item{country}{list of countries, where the language is spoken}
#'   \item{latitude}{latitude}
#'   \item{longitude}{longitude}
#'   \item{glottocode}{languoid code from Glottolog 2.7}
#'   \item{alternate_names}{alternative language names}
#'   \item{affiliation-HH}{some additional source for affiliation}
#'   \item{dialects}{dialects of language}
#'   \item{language_development}{language development}
#'   \item{language_status}{language status. In glottolog.modified comments are removed. In glottolog.original they are reserved. Have 14 categories: 1 (Natioanl); 2 (Provincial); 3 (Wider communication); 4 (Educational); 5 (Developing);  6a (Vigorous); 6b (Threatened); 7 (Shifting); 8a (Moribund); 8b (Nearly extinct); 8b (Reintroduced); 9 (Dormant); 9 (Second language only);  10 (Extinct)}
#'   \item{language_use}{language use}
#'   \item{location}{location}
#'   \item{other_comments}{other_comments}
#'   \item{population}{population and its source}
#'   \item{population_numeric}{pure population info}
#'   \item{timespan}{some historical information}
#'   \item{typology}{some information form WALS}
#'   \item{writing}{information about writing system}
#' }
#' @source \url{http://glottolog.org/}
#'

"glottolog.original"

