#' Download Uratyp data
#'
#' This function downloads data from Uratyp (\url{https://uralic.clld.org}). You need the internet connection.
#'
#' @param languages language names from data. Possible values: 'Soikkola_Ingrian', 'West_Votic', 'Voro_South_Estonian', 'Livvi_Karelian', 'Courland_Livonian', 'Ludian', 'Central_Veps', 'North_Karelian', 'Tver_Karelian', 'Estonian', 'Finnish', 'Pite_Saami', 'Inari_Saami', 'Lule_Saami', 'South_Saami', 'North_Saami', 'Skolt_Saami', 'Meadow_Mari', 'Hill_Mari', 'Erzya', 'Moksha', 'Komi_Zyrian', 'Udmurt', 'Hungarian', 'East_Mansi', 'North_Mansi', 'Kazym_Khanty', 'Surgut_Khanty', 'Forest_Enets', 'Tundra_Nenets', 'South_Selkup', 'Kamas', 'Nganasan', 'Komi_Permyak', 'Ume_Saami'.
#' @param type type of list of features. Possible values: 'GB', 'UT'. By default is 'GB'. More about types (\url{https://uralic.clld.org}).
#' @author Ekaterina Zalivina <zalivina01@mail.ru>
#' @seealso \code{\link{abvd.feature}}, \code{\link{afbo.feature}}, \code{\link{bivaltyp.feature}}, \code{\link{eurasianphonology.feature}}, \code{\link{oto_mangueanIC.feature}}, \code{\link{phoible.feature}}, \code{\link{sails.feature}}, \code{\link{soundcomparisons.feature}}, \code{\link{uralex.feature}}, \code{\link{valpal.feature}}, \code{\link{vanuatu.feature}}, \code{\link{wals.feature}}
#' @seealso \code{\link{oto_mangueanIC.feature}}, \code{\link{phoible.feature}}, \code{\link{sails.feature}}, \code{\link{uralex.feature}}, \code{\link{valpal.feature}}, \code{\link{wals.feature}}
#' @examples
#' # uratyp.feature('Central_Veps')
#' # uratyp.feature('Hungarian', 'UT')
#' # uratyp.feature(c('Inari_Saami', 'Erzya'), 'UT')
#' @export
#'
#' @importFrom utils read.table
#'

uratyp.feature <- function(languages, type = 'GB') {
  message(
    "Don't forget to cite a source:
    Norvik, Miina, Yingqi Jing, Michael Dunn, Robert Forkel, Terhi Honkola, Gerson Klumpp, Richard Kowalik, Helle Metslang, Karl Pajusalu, Minerva Piha, Eva Saar, Sirkka Saarinen, & Outi Vesakoski. 2021. Uralic Typological database - UraTyp. Zenodo. https://doi.org/10.5281/zenodo.5236365
    Norvik, Miina, Yingqi Jing, Michael Dunn, Robert Forkel, Terhi Honkola, Gerson Klumpp, Richard Kowalik, Helle Metslang, Karl Pajusalu, Minerva Piha, Eva Saar, Sirkka Saarinen, & Outi Vesakoski. To appear. Uralic typology in the light of a new comprehensive dataset. Journal of Uralic Linguistics.
   ")

  url_languages <- 'https://raw.githubusercontent.com/cldf-datasets/uratyp/main/raw/Languages.csv'
  languages_table <- utils::read.table(url_languages, header = TRUE, quote = "\"", sep = ',')
  languages_select_table <- languages_table[languages_table$Name %in% languages, ]
  languages_select <- as.vector(languages_select_table['Glottocode'])

  result <- lapply(languages, function(language){
    type <- toupper(type)
    url <- paste0('https://raw.githubusercontent.com/cldf-datasets/uratyp/main/raw/', type, '/language-tables/', language,'.csv')
    df_ <- utils::read.table(url, header = TRUE, quote = "\"", sep = ',')
    df_$Language <- language
    df_$Glottocode <- languages_table[languages_table$Name == language, 'Glottocode']
    df_$Latitude <- languages_table[languages_table$Name == language, 'Latitude']
    df_$Longitude <- languages_table[languages_table$Name == language, 'Longitude']
    df_$Glottolog_Name <- lingtypology::lang.gltc(languages_table[languages_table$Name == language, 'Glottocode'])

    if (type == 'UT') {
      colnames(df_)[3] = "value_for_language"
    }
    return(df_)
  })

  df_result <- do.call('rbind', result)
}
