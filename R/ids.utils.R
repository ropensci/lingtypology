#' Util fuctions for ids function
#'
#' @author Mikhail Leonov
#' @importFrom  utils read.csv
#' @NoRd

add_param <-
  function(x,
           langs,
           id_list,
           lang_csv,
           conc_csv) {
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
    parameters
  }
