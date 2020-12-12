#' Download SAILS data
#'
#' This function downloads data from SAILS (\url{https://sails.clld.org/}) and changes language names to the names from lingtypology database. You need the internet connection.
#' @author

#' @seealso \code{\link{abvd.feature}}, \code{\link{afbo.feature}}, \code{\link{autotyp.feature}}, \code{\link{oto_mangueanIC.feature}}, \code{\link{phoible.feature}}, \code{\link{uralex.feature}}, \code{\link{valpal.feature}}, \code{\link{wals.feature}}
#' @examples
#' # sails.feature()
#' @export
#'
#' @importFrom utils read.csv
#'

values<-read.csv('https://raw.githubusercontent.com/cldf-datasets/sails/master/cldf/values.csv')
values<-values[,c('ID','Language_ID','Code_ID','Source','Contributor')]

langs<-read.csv('https://raw.githubusercontent.com/cldf-datasets/sails/master/cldf/languages.csv')
langs<-langs[,c("ID","Name","Latitude","Longitude","Glottocode")]
langs$language_for_lingtypology <- lingtypology::lang.gltc(langs$Glottocode)
codes<-read.csv('https://raw.githubusercontent.com/cldf-datasets/sails/master/cldf/codes.csv')

m1<-merge(values,langs,by.x = 'Language_ID', by.y = 'ID')
m1 %>% View()

final_df<- merge(m1,codes, by.x='Code_ID',by.y = 'ID')
final_df<-final_df[,c('ID','Name.x',"Latitude","Longitude","language_for_lingtypology","Parameter_ID","Name.y","Description")]

names(final_df)[names(final_df) == "Name.x"] <- "lang_name"
names(final_df)[names(final_df) == "Name.y"] <- "Value"
final_df %>% View
