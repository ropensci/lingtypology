#' Download frequency list
#'
#' This function downloads frequency list from OpenSubtitles2018 (\url{https://opus.nlpl.eu/OpenSubtitles2018.php}). You need the internet connection.
#'
#' @param language ISO 639-1 language code. Possible values: 'af', 'ar', 'bg', 'bn', 'br', 'bs', 'ca', 'cs', 'da', 'de', 'el', 'en', 'eo', 'es', 'et', 'eu', 'fa', 'fi', 'fr', 'gl', 'he', 'hi', 'hr', 'hu', 'hy', 'id', 'is', 'it', 'ja', 'ka', 'kk', 'ko', 'lt', 'lv', 'mk', 'ml', 'ms', 'nl', 'no', 'pl', 'pt', 'pt_br', 'ro', 'ru', 'si', 'sk', 'sl', 'sq', 'sr', 'sv', 'ta', 'te', 'tl', 'tr', 'uk', 'ur', 'vi', 'ze_en', 'ze_zh', 'zh_cn', 'zh_tw'.
#' @param list_type Type of frequency list. Possible values: 'full', '50k', 'ignored'. By default is full.
#' @author Ekaterina Zalivina <zalivina01@mail.ru>
#' @seealso \code{\link{abvd.feature}}, \code{\link{afbo.feature}}, \code{\link{bivaltyp.feature}}, \code{\link{eurasianphonology.feature}}, \code{\link{oto_mangueanIC.feature}}, \code{\link{phoible.feature}}, \code{\link{sails.feature}}, \code{\link{soundcomparisons.feature}}, \code{\link{uralex.feature}}, \code{\link{valpal.feature}}, \code{\link{vanuatu.feature}}, \code{\link{wals.feature}}
#' @seealso \code{\link{abvd.feature}}, \code{\link{afbo.feature}}, \code{\link{oto_mangueanIC.feature}}, \code{\link{phoible.feature}}, \code{\link{sails.feature}}, \code{\link{uralex.feature}}, \code{\link{valpal.feature}}, \code{\link{wals.feature}}
#' @examples
#' # frequency_list.feature('ro')
#' # frequency_list.feature('en', '50k')
#' @export
#'


frequency_list.feature <- function(language, list_type = 'full') {
  language <- tolower(language)
  list_type <- tolower(list_type)
  message(
    "Don't forget to cite a source:
P. Lison and J. Tiedemann, 2016, OpenSubtitles2016: Extracting Large Parallel Corpora from Movie and TV Subtitles. In Proceedings of the 10th International Conference on Language Resources and Evaluation (LREC 2016)"
  )
  list_lang <- paste0(language, '_', list_type)
  url <- paste0('https://raw.githubusercontent.com/hermitdave/FrequencyWords/master/content/2018/', language, '/', list_lang, '.txt')
  df <- tryCatch(
    {
      read.delim(url, header = FALSE, quote = '', sep = ' ')
    },
    error=function(cond) {
      message("Language code does not seem to exist or there is no small word list (50,000 tokens) because full list contains less then 50,000 tokens.")
      message("Please check language code or try to get full word list.")
      return(NA)
    },
    warning=function(cond) {
      if (language == 'th'){
        message("For this language try to download 50k list")
        return(NULL)
      }
      else if ((language == 'af' || language == 'br' || language == 'eo' ||
                language == 'hi' || language == 'hy' || language == 'si' ||
                language == 'ta' || language ==  'te' || language == 'ur') &&
               list_type == '50k'){
        message('Small word list does not exist for this language, try to get full word list')
        return(NULL)
      }
      else {
        message("Please check language code")
        return(NULL)}
    },
    finally={
      message(paste("Processed language:", language))
      message(paste("Processed type of list:", list_type))
    }
  )
  if (!(is.null(df) || is.na(df))) {
    if (is.numeric(df$V2)) {
      colnames(df) <- c('word', 'count')
      return(df)
    }
    else {
      colnames(df) <- c('count', 'word')
      return(df)
    }
  }
}


