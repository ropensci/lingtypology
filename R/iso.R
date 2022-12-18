#' ISO 639-3 is a set of codes that defines three-letter identifiers for all known human languages.
#'
#' ISO 639 provides three language code sets: one is a two-letter code (ISO 639-1) and two others are
#' three-letter codes (ISO 639-2 and ISO 639-3) for the representation of names of languages.
#' ISO 639-1 was devised primarily for use in terminology, lexicography and linguistics.
#' ISO 639-2 was devised primarily for use in terminology and bibliography.
#' ISO 639-3 was devised to provide a comprehensive set of identifiers for all languages for use in
#' a wide range of applications, including linguistics, lexicography and internationalization
#' of information systems. It attempts to represent all known full languages.
#'
#' (Available online at https://iso639-3.sil.org/, Accessed on 2022-05-23.)
#'
#' @format A data frame with 188 rows and 5 variables:
#' \describe{
#'   \item{ISO_639_3}{The three-letter 639-3 identifier}
#'   \item{ISO_639_2_B}{Equivalent 639-2 identifier of the bibliographic applications code set}
#'   \item{ISO_639_2_T}{Equivalent 639-2 identifier of the terminology applications code set}
#'   \item{ISO_639_1}{Equivalent 639-1 identifier}
#'   \item{Ref_Name}{Reference language name}
#' }
#' @source \url{https://iso639-3.sil.org/}
#'

"iso_639"
