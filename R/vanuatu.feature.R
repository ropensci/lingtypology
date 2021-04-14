#' Download Vanuatu Voices data
#'
#' This function downloads data from Vanuatu Voices (\url{https://vanuatuvoices.clld.org/}). You need the internet connection.
#'
#' @param features A vector with parameters from Concepts (\url{https://vanuatuvoices.clld.org/parameters}))
#' @param na.rm Logical. If TRUE function removes all languages not available in lingtypology database. By default is TRUE.
#' @seealso \code{\link{abvd.feature}}, \code{\link{afbo.feature}}, \code{\link{autotyp.feature}}, \code{\link{bivaltyp.feature}}, \code{\link{eurasianphonology.feature}}, \code{\link{oto_mangueanIC.feature}}, \code{\link{phoible.feature}}, \code{\link{sails.feature}}, \code{\link{soundcomparisons.feature}}, \code{\link{uralex.feature}}, \code{\link{valpal.feature}}, \code{\link{wals.feature}}
#' @author Mikhail Leonov
#' @export
#' @importFrom  utils read.csv
#' @importFrom jsonlite fromJSON


vanuatu.feature <-function(features,na.rm = TRUE) {

  message(paste0("Don't forget to cite a source (modify in case of using individual chapters):

Aviva Shimelman, Mary Walworth, Lana Takau, Tom Ennever, Iveth Rodriguez, Tom Fitzpatrick, Marie-France Duhamel, Giovanni Abete, Daria D\uebrmaku, Laura W\ue4gerle, Heidi Colleran, Paul Heggarty, Kaitip W. Kami, Hans-J\uf6rg Bibiko and Russell Gray. (2020). Vanuatu Voices (Version v1.0)
[Data set]. Zenodo. http://doi.org/10.5281/zenodo.4309141 , Accessed on ",Sys.Date(),".)"))
  id_list<-utils::read.csv('https://vanuatuvoices.clld.org/parameters.csv?sEcho=1&iSortingCols=1&iSortCol_0=0&sSortDir_0=asc')$id
  feature_list<-lapply(as.character(id_list),function(x) {unlist(strsplit(x, '_'))[2]})

  not_features <- features[which(!features %in% feature_list)]
  if (length(not_features)==length(features)){
    stop('None of the parameters are in the vanuatu database.')
  }
  if (length(not_features)!=0){
    warning(paste(
      "There is no features",
      paste0("'", not_features, "'", collapse = ", "),
      "in vanuatu database."
    ))
  }
  e_features<-as.character(match.arg(features, feature_list,several.ok = TRUE))
  e_features<-as.character(match.arg(features, feature_list,several.ok = TRUE))
  e_ids<-id_list[match(e_features,feature_list)]
  add_param<-function(x){
    parameter_json <- jsonlite::fromJSON(paste0('https://vanuatuvoices.clld.org/parameters/', x, '.geojson'),flatten = TRUE)
    parameters<-parameter_json$features

    words<-lapply(parameters$properties.values,function(x){
      if (nrow(x)>1){
        word_forms<-paste(x$name[!is.na(x$name)],collapse = ', ')
        return(word_forms)
      }
      else{
        return(x$name)
      }
    })

    audios<-lapply(parameters$properties.values,function(x){
      if (nrow(x)>1){
        aud_var<-paste(x$jsondata.audio[!is.na(x$jsondata.audio)],collapse = ', ')
        return(aud_var)
      }
      else{
        return(x$jsondata.audio)
      }
    })

    parameters['word']<-unlist(words)
    parameters['audio']<-unlist(audios)
    parameters['feature']<-c(rep(x,length(words)))
    parameters<-parameters[,c('feature','word','audio','properties.language.name','properties.language.description','properties.language.island','properties.language.latitude','properties.language.longitude','properties.language.glottocode')]
    names(parameters)<-c('feature','word','audio','language_name','language_description','island','latitude','longitude','glottocode')
    return(parameters)
  }
  final_df_list<-lapply(as.vector(e_ids),add_param)
  final_df<-do.call(rbind, final_df_list)
  if (na.rm){
    final_df<-final_df[!is.na(final_df['glottocode']),]
    final_df$language <-lingtypology::lang.gltc(final_df$glottocode)
    final_df<-final_df[!is.na(final_df['language']),]

  }
  return(final_df)
}
