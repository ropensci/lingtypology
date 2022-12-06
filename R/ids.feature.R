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
#' @importFrom  utils read.csv utils.R

lang_check<-function(lang_name,lang_csv,choose_var,not_languages){
  cand<-c()
  if (lang_name %in% lang_csv$Name){
    cand<-c(lang_name)
  }
  if (choose_var){
    add_cand<-c(grep(paste0('^',lang_name,' '),
                     lang_csv$Name))
    cand <- c(cand,lang_csv[unique(add_cand),]$Name)
  }
  if (length(cand)==0)
    #   not_languages<<-c(not_languages,lang_name)
    assign(not_languages,c(not_languages,lang_name),envir = .GlobalEnv)
  cand
}

add_param<-function(x,langs,feat_sourse,id_list,lang_csv,conc_csv,e_languages){
  if (feat_sourse){
    id<- as.character(id_list[id_list$concepticon_gloss == x,]$id)
    parameters<-read.csv(paste0('https://ids.clld.org/values.csv?parameter=', id, '&sEcho=1&iSortingCols=2&iSortCol_0=2&sSortDir_0=asc&iSortCol_1=1&sSortDir_1=asc'),encoding = 'UTF-8')
    parameters['feature']<-c(rep(x,nrow(parameters)))
  }
  else{
    lang<- as.character(lang_csv[lang_csv$Name == x,]$ID)
    parameters<-read.csv(paste0('https://ids.clld.org/values.csv?contribution=',lang,'&sEcho=1&iSortingCols=1&iSortCol_0=0&sSortDir_0=asc'),encoding = 'UTF-8')
    parameters['f_id']<-unlist(lapply(parameters$id,function(x){paste0(strsplit(x,'-')[[1]][1],'-',strsplit(x,'-')[[1]][2])}))
    parameters<-merge(parameters, id_list, by.x="f_id",by.y = 'id',all.x = TRUE)
    colnames(parameters)[15] <- 'feature'
  }
  parameters['lang_id'] <- unlist(lapply(parameters$id,function(x){strsplit(x,'-')[[1]][3]}))
  parameters<-merge(parameters, lang_csv, by.x="lang_id",by.y = 'ID',all.x = TRUE)
  parameters<-merge(parameters, conc_csv, by.x="feature",by.y = 'concepticon_gloss')
  parameters<-parameters[,c('feature','name','description','Name','Glottocode','conc_chapter')]
  names(parameters)<-c('feature','word','word_desc','language_name','glottocode','conc_chapter')
  if (feat_sourse && length(e_languages)!=0){
    parameters<-parameters[parameters$language_name %in% e_languages,]
  }
  parameters
}

ids.feature <-function(features ,languages ,choose_var = TRUE,na.rm = TRUE) {
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
