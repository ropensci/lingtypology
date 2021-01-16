#' Download Vanuatu Voices data
#'
#' This function downloads data from Vanuatu Voices (\url{https://vanuatuvoices.clld.org/}). You need the internet connection.
#'
#' @param feature A string with a parameter from Conepts (\url{https://vanuatuvoices.clld.org/parameters}))
#' @author
#' @seealso
#' @examples
#' @export
#' @importFrom  utils read.csv
#' @importFrom jsonlite fromJSON

vanuatu.feature <-function(feature) {
  feature_list <-utils::read.csv(
    'https://vanuatuvoices.clld.org/parameters.csv?sEcho=1&iSortingCols=1&iSortCol_0=0&sSortDir_0=asc')$id
  if (feature %in% feature_list){
    parameter_json <- jsonlite::fromJSON(paste0('https://vanuatuvoices.clld.org/parameters/', feature, '.geojson'),flatten = TRUE)
    parameters<-parameter_json$features
    words<-vector()
    audios<-vector()
    for (feature in parameters$properties.values){
      words<-c(words,feature$name)
      audios<-c(audios,feature$jsondata.audio)
    }
    parameters['word']<-words
    parameters['audio']<-audios
    parameters<-parameters[,c('id','word','audio','properties.language.name','properties.language.description','properties.language.island','properties.language.latitude','properties.language.longitude','properties.language.glottocode')]
    names(parameters)<-c('id','word','audio','language_name','language_description','island','latitude','longitude','glottocode')
    return(parameters)
  }
  else print(1)
}
