#' Download frequency list
#'
#' This function downloads frequency list from OpenSubtitles2018 (\url{https://opus.nlpl.eu/}). You need the internet connection.
#'
#' @param languages ISO 639-1 language code and some others ('ze_en', 'ze_zh', 'zh_cn', 'zh_tw', 'pt_br'). Possible values: 'af', 'ar', 'bg', 'bn', 'br', 'bs', 'ca', 'cs', 'da', 'de', 'el', 'en', 'eo', 'es', 'et', 'eu', 'fa', 'fi', 'fr', 'gl', 'he', 'hi', 'hr', 'hu', 'hy', 'id', 'is', 'it', 'ja', 'ka', 'kk', 'ko', 'lt', 'lv', 'mk', 'ml', 'ms', 'nl', 'no', 'pl', 'pt', 'pt_br', 'ro', 'ru', 'si', 'sk', 'sl', 'sq', 'sr', 'sv', 'ta', 'te', 'tl', 'tr', 'uk', 'ur', 'vi', 'ze_en', 'ze_zh', 'zh_cn', 'zh_tw'.
#' @param list_type Type of frequency list. Possible values: 'full', '50k', 'ignored'. By default is full.
#' @author Ekaterina Zalivina <zalivina01@mail.ru>
#' @seealso \code{\link{abvd.feature}}, \code{\link{afbo.feature}}, \code{\link{bivaltyp.feature}}, \code{\link{eurasianphonology.feature}}, \code{\link{oto_mangueanIC.feature}}, \code{\link{phoible.feature}}, \code{\link{sails.feature}}, \code{\link{soundcomparisons.feature}}, \code{\link{uralex.feature}}, \code{\link{valpal.feature}}, \code{\link{vanuatu.feature}}, \code{\link{wals.feature}}
#' @seealso \code{\link{abvd.feature}}, \code{\link{afbo.feature}}, \code{\link{oto_mangueanIC.feature}}, \code{\link{phoible.feature}}, \code{\link{sails.feature}}, \code{\link{uralex.feature}}, \code{\link{valpal.feature}}, \code{\link{wals.feature}}
#' @examples
#' # frequency_list.feature('ro')
#' # frequency_list.feature('en', '50k')
#' # frequency_list.feature(c('en', 'ru'), '50k')
#' @export
#' @importFrom utils read.delim


frequency_list.feature <- function(languages, list_type = 'full') {
  message(
    "Don't forget to cite a source:
   P. Lison and J. Tiedemann, 2016, OpenSubtitles2016: Extracting Large Parallel Corpora from Movie and TV Subtitles. In Proceedings of the 10th International Conference on Language Resources and Evaluation (LREC 2016)"
  )
  result <- lapply(languages, function(language) {
    language <- tolower(language)
    list_type <- tolower(list_type)
    list_lang <- paste0(language, '_', list_type)
    url <- paste0('https://raw.githubusercontent.com/hermitdave/FrequencyWords/master/content/2018/', language, '/', list_lang, '.txt')
    df <- tryCatch(
      {
        df_ <- utils::read.delim(url, header = FALSE, quote = '', sep = ' ')
        df_$langusge <- language
        return(df_)
      },
      error=function(cond) {
        message("Language code does not seem to exist")
        message("Please check language code or try to get full word list.")
        return(NA)
      },
      warning=function(cond) {
        if (language == 'th'){
          message("Only 50k list can be downloaded for this language")
          list_type <- '50k'
          list_lang <- paste0(language, '_', list_type)
          url <- paste0('https://raw.githubusercontent.com/hermitdave/FrequencyWords/master/content/2018/', language, '/', list_lang, '.txt')
          return(read.delim(url, header = FALSE, quote = '', sep = ' '))
        }
        else if ((language == 'af' || language == 'br' || language == 'eo' ||
                  language == 'hi' || language == 'hy' || language == 'si' ||
                  language == 'ta' || language ==  'te' || language == 'ur') &&
                 list_type == '50k'){
          message('Small word list does not exist for this language, got full word list instead')
          list_type <- 'full'
          list_lang <- paste0(language, '_', list_type)
          url <- paste0('https://raw.githubusercontent.com/hermitdave/FrequencyWords/master/content/2018/', language, '/', list_lang, '.txt')
          df_ <- read.delim(url, header = FALSE, quote = '', sep = ' ')
          df_$langusge <- language
          return(df_)
        }
        else {
          message('Please check language code')
          return(NULL)}
      },
      finally={
        message(paste('Processed language:', language))
      }
    )
  })
  total_df <- do.call('rbind', result)
  colnames(total_df) <- c('word',
                       'n_occurances',
                       'language')
  return(total_df)
}
