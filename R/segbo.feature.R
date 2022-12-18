#' Download SegBo data
#'
#' This function downloads data from SegBo (\url{https://github.com/segbo-db/segbo}). You need the internet connection.
#'
#' @param languages vector of Glotocodes. Use 'all' to download all data.
#' @author Ekaterina Zalivina <zalivina01@mail.ru>
#' @seealso \code{\link{abvd.feature}}, \code{\link{afbo.feature}}, \code{\link{bivaltyp.feature}}, \code{\link{eurasianphonology.feature}}, \code{\link{oto_mangueanIC.feature}}, \code{\link{phoible.feature}}, \code{\link{sails.feature}}, \code{\link{soundcomparisons.feature}}, \code{\link{uralex.feature}}, \code{\link{valpal.feature}}, \code{\link{vanuatu.feature}}, \code{\link{wals.feature}}
#' @seealso \code{\link{oto_mangueanIC.feature}}, \code{\link{phoible.feature}}, \code{\link{sails.feature}}, \code{\link{uralex.feature}}, \code{\link{valpal.feature}}, \code{\link{wals.feature}}
#' @examples
#' # segbo.feature('abau1245')
#' # segbo.feature('abui1241', 'aleu1260')
#' # segbo.feature('all')
#' @export
#'
#' @importFrom utils read.table
#'

segbo.feature <- function(languages) {
  message(
    "Don't forget to cite a source:
    Grossman, Eitan, Elad Eisen, Dmitry Nikolaev and Steven Moran. 2020. SegBo: A Database of Borrowed Sounds in the World\u2019s Languages. In Proceedings of the Twelfth International Conference on Language Resources and Evaluation (LREC 2020). Online: http://www.lrec-conf.org/proceedings/lrec2020/pdf/2020.lrec-1.654.pdf.
   ")

  url_phonemes <- 'https://raw.githubusercontent.com/segbo-db/segbo/master/data/SegBo%20database%20-%20Phonemes.csv'
  phonemes_table <- utils::read.table(url_phonemes, header = TRUE, quote = "\"", sep = ',')
  url_metadata <- 'https://raw.githubusercontent.com/segbo-db/segbo/master/data/SegBo%20database%20-%20Metadata.csv'
  metadata_table <- utils::read.table(url_metadata, header = TRUE, quote = "\"", sep = ',')
  df_all <- (merge(phonemes_table, metadata_table, by = 'InventoryID'))
  if ('all' %in% languages){
    return(df_all)
  } else {
    df <- df_all[df_all$BorrowingLanguageGlottocode %in% languages, ]
    return(df)
  }

}
