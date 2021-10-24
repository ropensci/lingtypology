#' Download Vanuatu Voices data
#'
#' This function downloads data from Vanuatu Voices (\url{https://vanuatuvoices.clld.org/}). You need the internet connection.
#'
#' @param features A vector with parameters from Concepts (\url{https://vanuatuvoices.clld.org/parameters}))
#' @param na.rm Logical. If TRUE function removes all languages not available in lingtypology database. By default is TRUE.
#' @seealso \code{\link{abvd.feature}}, \code{\link{afbo.feature}}, \code{\link{autotyp.feature}}, \code{\link{bivaltyp.feature}}, \code{\link{eurasianphonology.feature}}, \code{\link{oto_mangueanIC.feature}}, \code{\link{phoible.feature}}, \code{\link{sails.feature}}, \code{\link{soundcomparisons.feature}}, \code{\link{uralex.feature}}, \code{\link{valpal.feature}}, \code{\link{wals.feature}}
#' @author Mikhail Leonov
#' @export
#' @importFrom utils read.csv
#' @importFrom jsonlite fromJSON


vanuatu.feature <-function(features, na.rm = TRUE) {

  message(paste0("Don't forget to cite a source (modify in case of using individual chapters):

Aviva Shimelman, Mary Walworth, Lana Takau, Tom Ennever, Iveth Rodriguez, Tom Fitzpatrick, Marie-France Duhamel, Giovanni Abete, Daria D\uebrmaku, Laura W\ue4gerle, Heidi Colleran, Paul Heggarty, Kaitip W. Kami, Hans-J\uf6rg Bibiko and Russell Gray. (2020). Vanuatu Voices (Version v1.0)
[Data set]. Zenodo. http://doi.org/10.5281/zenodo.4309141 , Accessed on ",Sys.Date(),".)"))

  # # in order to update run:
  # id_list <- utils::read.csv('https://vanuatuvoices.clld.org/parameters.csv?sEcho=1&iSortingCols=1&iSortCol_0=0&sSortDir_0=asc')$id
  # cat(paste0('"', id_list, '",'))
  id_list <- c("37_above", "91_ash", "51_back", "127_bad", "56_belly",
               "38_below", "119_big", "61_bird", "114_black", "53_blood",
               "165_blow", "122_bluntdull", "54_bone", "105_branch",
               "58_breast", "177_breathe", "166_burn", "185_buy", "75_child",
               "146_climb", "97_cloud", "134_cold", "139_come", "188_cook",
               "128_correcttrue", "176_count", "164_cry", "170_cut", "81_day",
               "158_die", "172_dig", "129_dirty", "60_dog", "155_dream",
               "152_drink", "135_dry", "94_dust", "44_ear", "93_earthsoil",
               "151_eat", "69_egg", "8_eight", "42_eye", "143_fall", "132_far",
               "78_father", "175_fear", "72_feather", "12_fifty", "89_fire",
               "62_fish", "5_five", "109_flower", "148_flyverb", "4_four",
               "102_fruit", "126_good", "108_grass", "117_green", "41_hair",
               "48_hand", "40_head", "161_hear", "131_heavy", "26_heshe",
               "150_hide", "169_hit", "174_hold", "111_house", "34_how",
               "173_hunt", "79_husband", "18_i", "39_ininside", "57_intestines",
               "159_kill", "87_lake", "163_laugh", "106_leaf", "17_left",
               "52_leg", "144_liedown", "100_lightning", "157_live", "59_liver",
               "65_louse", "73_man", "101_meatflesh", "83_moon", "68_mosquito",
               "77_mother", "45_mouth", "76_name", "133_near", "50_neck",
               "137_new", "82_night", "9_nine", "29_nonot", "43_nose",
               "124_old", "1_one", "13_onehundred", "14_onethousand",
               "191_open", "138_other", "125_painfulsick", "187_plant",
               "168_pound", "96_rain", "66_rat", "116_red", "16_right",
               "113_roadpath", "104_root", "112_rope", "130_rotten", "95_sand",
               "182_say", "183_scratch", "88_sea", "160_see", "7_seven",
               "167_sew", "121_sharp", "189_shoot", "49_shoulder",
               "123_shyashamed", "142_sit", "6_six", "55_skin", "85_sky",
               "156_sleep", "120_small", "90_smoke", "63_snake",
               "162_sniffsmell", "67_spider", "154_spit", "171_split",
               "180_squeeze", "184_stab", "141_stand", "84_star",
               "186_steal", "92_stone", "181_swell", "147_swim", "70_tail",
               "10_ten", "36_that", "110_thatchroof", "27_theyall",
               "28_theyboth", "35_this", "23_thou", "3_three", "149_throw",
               "99_thunder", "179_tieup", "46_tongue", "47_tooth", "145_turn",
               "11_twenty", "2_two", "178_vomit", "140_walk", "86_water",
               "19_weallexcl", "22_weallincl", "21_webothexcl", "20_webothincl",
               "136_wet", "30_what", "33_when", "32_where", "115_white",
               "31_who", "80_wife", "98_wind", "71_wing", "74_woman", "107_wood",
               "103_woodsforest", "190_work", "64_worm", "153_yawn", "15_year",
               "118_yellow", "25_youall", "24_youboth")

  feature_list <- unname(unlist(data.frame(strsplit(id_list, '_'))[2,]))

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
    parameter_json <- jsonlite::fromJSON(
      paste0('https://vanuatuvoices.clld.org/parameters/',
             x,
             '.geojson'),
      flatten = TRUE)

    parameters<-parameter_json$features

    words<-lapply(parameters$properties.values,function(x){
      if (nrow(x)>1){
        word_forms<-paste(x$name[!is.na(x$name)],collapse = ', ')
        return(word_forms)
      }
      else{return(x$name)}
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
    parameters<-parameters[,c('feature','word','audio',
                              'properties.language.name',
                              'properties.language.description',
                              'properties.language.island',
                              'properties.language.latitude',
                              'properties.language.longitude',
                              'properties.language.glottocode')]
    names(parameters)<-c('feature', 'word', 'audio', 'language_name',
                         'language_description', 'island', 'latitude',
                         'longitude', 'glottocode')
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
