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
vanuatu.feature <-function(features,na.rm = TRUE) {
  id_list<-utils::read.csv('https://vanuatuvoices.clld.org/parameters.csv?sEcho=1&iSortingCols=1&iSortCol_0=0&sSortDir_0=asc')$id
  feature_list<-lapply(as.character(id_list),function(x) unlist(strsplit(x, '_'))[2])
  e_features<-as.character(match.arg(features, feature_list,several.ok = TRUE))
  not_features <- features[which(!features %in% feature_list)]
  if (length(not_features)!=0){
    warning(paste(
      "There is no features",
      paste0("'", not_features, "'", collapse = ", "),
      "in vanuatu database."
    ))
  }


  e_ids<-id_list[match(e_features,feature_list)]
  message(paste0("Don't forget to cite a source (modify in case of using individual chapters):

Aviva Shimelman, Mary Walworth, Lana Takau, Tom Ennever, Iveth Rodriguez, Tom Fitzpatrick, Marie-France Duhamel, Giovanni Abete, Daria Dërmaku, Laura Wägerle, Heidi Colleran, Paul Heggarty, Kaitip W. Kami, Hans-Jörg Bibiko and Russell Gray. (2020). Vanuatu Voices (Version v1.0)
[Data set]. Zenodo. http://doi.org/10.5281/zenodo.4309141 , Accessed on ",Sys.Date(),".)"))

  final_df = data.frame()
  for (p in e_ids){
    parameter_json <- jsonlite::fromJSON(paste0('https://vanuatuvoices.clld.org/parameters/', p, '.geojson'),flatten = TRUE)
    parameters<-parameter_json$features
    words<-vector()
    audios<-vector()
    for (feature in parameters$properties.values){
      if (nrow(feature)>1){
        word_forms<-paste(feature$name[!is.na(feature$name)],collapse = ', ')
        aud_var<-paste(feature$jsondata.audio[!is.na(feature$jsondata.audio)],collapse = ', ')
        words<-c(words,word_forms)
        audios<-c(audios,aud_var)
      }
      else{
        words<-c(words,feature$name)
        audios<-c(audios,feature$jsondata.audio)
      }
    }
    parameters['word']<-words
    parameters['audio']<-audios
    parameters['feature']<-c(rep(p,length(words)))
    parameters<-parameters[,c('feature','word','audio','properties.language.name','properties.language.description','properties.language.island','properties.language.latitude','properties.language.longitude','properties.language.glottocode')]
    names(parameters)<-c('feature','word','audio','language_name','language_description','island','latitude','longitude','glottocode')
    final_df<- rbind(final_df,parameters)

  }
  if (na.rm){
    final_df<-final_df[!is.na(final_df['glottocode']),]
    final_df$language <-
      lingtypology::lang.gltc(final_df$glottocode)
    final_df<-final_df[!is.na(final_df['language']),]

  }
  return(final_df)
}
