#' Catalogue of languages of the world
#'
#' A dataset containes the original catalogue of languages of the world
#' involving genealogical affiliation, macro-area, country, iso code,
#' and coordinates.
#'
#' Hammarstrom, Harald and Forkel, Robert and Haspelmath, Martin and Bank, Sebastian. 2026.
#' Glottolog 5.3
#' Leipzig: Max Planck Institute for Evolutionary Anthropology.
#' https://doi.org/10.5281/zenodo.18840935
#' (Available online at http://glottolog.org, Accessed on 2026-03-02.)
#'
#' @format A data frame with 27177 rows and 10 variables:
#' \describe{
#'   \item{glottocode}{languoid code from Glottolog 5.3}
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

