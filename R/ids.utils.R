#' Util fuctions for ids function
#'
#' @author Mikhail Leonov
#' @importFrom  utils read.csv
#' @NoRd
lang_check <- function(lang_name,
                       lang_csv,
                       choose_var,
                       not_languages) {
  cand <- c()
  if (lang_name %in% lang_csv$Name) {
    cand <- c(lang_name)
  }
  if (choose_var) {
    add_cand <- c(grep(paste0('^', lang_name, ' '),
                       lang_csv$Name))
    cand <- c(cand, lang_csv[unique(add_cand), ]$Name)
  }
  if (length(cand) == 0)
    not_languages<<-c(not_languages,lang_name)
    # assign(not_languages, c(not_languages, lang_name), envir = .GlobalEnv)
  cand
}

add_param <-
  function(x,
           langs,
           feat_sourse,
           id_list,
           lang_csv,
           conc_csv,
           e_languages) {
    if (feat_sourse) {
      id <- as.character(id_list[id_list$concepticon_gloss == x, ]$id)
      parameters <-
        read.csv(
          paste0(
            'https://ids.clld.org/values.csv?parameter=',
            id,
            '&sEcho=1&iSortingCols=2&iSortCol_0=2&sSortDir_0=asc&iSortCol_1=1&sSortDir_1=asc'
          ),
          encoding = 'UTF-8'
        )
      parameters['feature'] <- c(rep(x, nrow(parameters)))
    }
    else{
      lang <- as.character(lang_csv[lang_csv$Name == x, ]$ID)
      parameters <-
        read.csv(
          paste0(
            'https://ids.clld.org/values.csv?contribution=',
            lang,
            '&sEcho=1&iSortingCols=1&iSortCol_0=0&sSortDir_0=asc'
          ),
          encoding = 'UTF-8'
        )
      parameters['f_id'] <-
        unlist(lapply(parameters$id, function(x) {
          paste0(strsplit(x, '-')[[1]][1], '-', strsplit(x, '-')[[1]][2])
        }))
      parameters <-
        merge(
          parameters,
          id_list,
          by.x = "f_id",
          by.y = 'id',
          all.x = TRUE
        )
      colnames(parameters)[15] <- 'feature'
    }
    parameters['lang_id'] <-
      unlist(lapply(parameters$id, function(x) {
        strsplit(x, '-')[[1]][3]
      }))
    parameters <-
      merge(
        parameters,
        lang_csv,
        by.x = "lang_id",
        by.y = 'ID',
        all.x = TRUE
      )
    parameters <-
      merge(parameters, conc_csv, by.x = "feature", by.y = 'concepticon_gloss')
    parameters <-
      parameters[, c('feature',
                     'name',
                     'description',
                     'Name',
                     'Glottocode',
                     'conc_chapter')]
    names(parameters) <-
      c('feature',
        'word',
        'word_desc',
        'language_name',
        'glottocode',
        'conc_chapter')
    if (feat_sourse && length(e_languages) != 0) {
      parameters <- parameters[parameters$language_name %in% e_languages, ]
    }
    parameters
  }
