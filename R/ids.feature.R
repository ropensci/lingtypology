#' Download data from The Intercontinental Dictionary Series
#'
#' This function downloads data from The Intercontinental Dictionary Series (\url{https://ids.clld.org/}). You need the internet connection.
#'
#' @param features A vector with parameters from conepts (\url{https://ids.clld.org/parameters}))
#' @param languages A vector with language names from the database.If features not selected, downloads full dictionaries for chosen languages.
#' @param choose_var Logical. If TRUE looks for all of the variants of each language. By default is TRUE.
#' @param na.rm Logical. If TRUE function removes all languages not available in the glottolog database available in lingtypology. By default is TRUE.
#' @author Mikhail Leonov
#' @export
#' @importFrom  utils read.csv


ids.feature <-function(features = c(),languages = c(),choose_var = TRUE,na.rm = TRUE) {
  message(paste0("Don't forget to cite a source (modify in case of using individual chapters):

Key, Mary Ritchie & Comrie, Bernard (eds.) 2015.
The Intercontinental Dictionary Series.
Leipzig: Max Planck Institute for Evolutionary Anthropology.
(Available online at http://ids.clld.org, Accessed on ",Sys.Date(),".)"))
  lang_csv<-utils::read.csv('https://raw.githubusercontent.com/intercontinental-dictionary-series/ids/v4.0/cldf/languages.csv',encoding = 'UTF-8')[,c('ID','Name','Glottocode')]
  id_list<-utils::read.csv('https://ids.clld.org/parameters.csv?sEcho=1&iSortingCols=1&iSortCol_0=0&sSortDir_0=asc')
  conc_csv<-utils::read.csv('https://ids.clld.org/chapters.csv?sEcho=1&iSortingCols=1&iSortCol_0=0&sSortDir_0=asc')[,c('id','name')]
  conc_csv<-merge(id_list,conc_csv,by.x = 'chapter_pk',by.y = 'id')[,c('concepticon_gloss','name.y')]
  names(conc_csv)<-c('concepticon_gloss','conc_chapter')
  id_list<-id_list[,c('concepticon_gloss','id')]
  feature_list<-id_list$concepticon_gloss
  not_features <- features[which(!features %in% feature_list)]
  if (length(not_features)==length(features) && length(features)!=0){
    warning('None of the parameters are in the IDS database.')
  }
  not_languages<-c()
  languages_found<-unlist(sapply(languages, lang_check,lang_csv = lang_csv,choose_var=choose_var,not_languages=not_languages))
  if (length(not_languages)==length(languages) && length(languages)!=0){
    warning('None of the languages are in the IDS database.')
  }

  if (length(not_features)!=0){
    warning(paste(
      "There are no features",
      paste0("'", not_features, "'", collapse = ", "),
      "in IDS database."
    ))
  }

  if (length(not_languages)!=0){
    warning(paste(
      "There are no languages",
      paste0("'", not_languages, "'", collapse = ", "),
      "in IDS database."
    ))
  }
  e_features<-as.character(id_list[id_list$concepticon_gloss %in% features,]$concepticon_gloss)
  e_languages<-languages_found
  feat_sourse<- TRUE
  if (length(e_features) == 0){
    if (length(e_languages)==0)
      stop('None of the parameters and/or languages are in the ids database.')
    else
      feat_sourse<-FALSE

  }

  if(feat_sourse){
    final_df_list<-lapply(as.vector(e_features),add_param,langs= langs,feat_sourse =feat_sourse,id_list=id_list,lang_csv=lang_csv,conc_csv = conc_csv,e_languages=e_languages)
  }else{
    final_df_list<-lapply(as.vector(languages_found),add_param,langs= langs,feat_sourse =feat_sourse,id_list=id_list,lang_csv=lang_csv,conc_csv=conc_csv
                          ,e_languages=e_languages)
  }

  final_df<-do.call(rbind, final_df_list)
  if (na.rm){
    final_df<-final_df[!is.na(final_df['glottocode']),]
    final_df['language'] <-lingtypology::lang.gltc(final_df$glottocode)
    final_df<-final_df[!is.na(final_df['language']),]
  }
  return(final_df)
}
