#' Catalogue of languages of the world
#'
#' A dataset containes the original catalogue of languages of the world
#' involving genealogical affiliation, macro-area, country, iso code,
#' and coordinates.
#'
#' Hammarstr{\"o}m, Harald and Forkel, Robert and Haspelmath, Martin and Bank, Sebastian. 2023.
#' Glottolog 4.8.
#' Leipzig: Max Planck Institute for Evolutionary Anthropology.
#' https://doi.org/10.5281/zenodo.6578297
#' (Available online at http://glottolog.org, Accessed on 2023-07-13.)
#'
#' @format A data frame with 26669 rows and 10 variables:
#' \describe{
#'   \item{glottocode}{languoid code from Glottolog 4.8}
#'   \item{language}{name of the language}
#'   \item{iso}{code based on ISO 639--3 \url{https://iso639-3.sil.org/}}
#'   \item{level}{languoid type: dialect or language (possible values are dialect, language, family, bookkeeping, pseudo family, sign language, unclassifiable, pidgin, unattested, artificial language, speech register, mixed language)}
#'   \item{area}{have six values Africa, Australia, Eurasia, North America, Papunesia, South America}
#'   \item{latitude}{latitude}
#'   \item{longitude}{longitude}
#'   \item{countries}{list of countries, where the language is spoken}
#'   \item{affiliation}{genealogical affiliation}
#'   \item{subclassification}{subclassification in a Newick format}
#' }
#' @source \url{https://glottolog.org/}
#'

"glottolog"

