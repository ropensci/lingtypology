#' Download Grambank data
#'
#' This function downloads data from Grambank (\url{https://grambank.clld.org/}) and changes language names to the names from lingtypology database. You need the internet connection.
#'
#' @param features A character vector that define with a feature ids from Grambank (e. g. "gb026", "gb042").
#' @param na.rm Logical. If TRUE function removes all languages not available in lingtypology database. By default is TRUE.
#' @seealso \code{\link{abvd.feature}}, \code{\link{afbo.feature}}, \code{\link{autotyp.feature}}, \code{\link{bivaltyp.feature}}, \code{\link{eurasianphonology.feature}}, \code{\link{oto_mangueanIC.feature}}, \code{\link{phoible.feature}}, \code{\link{sails.feature}}, \code{\link{soundcomparisons.feature}}, \code{\link{uralex.feature}}, \code{\link{valpal.feature}}, \code{\link{vanuatu.feature}}, \code{\link{wals.feature}}
#' @author George Moroz <agricolamz@gmail.com>
#' @examples
#' # grambank.feature(c("gb026", "gb042"))
#' @export
#'
#' @importFrom utils read.csv
#'

grambank.feature <-
 function(features,
          na.rm = TRUE) {
  features_set <-
   c(
    "GB020",
    "GB021",
    "GB022",
    "GB023",
    "GB024",
    "GB025",
    "GB026",
    "GB027",
    "GB028",
    "GB030",
    "GB031",
    "GB035",
    "GB036",
    "GB037",
    "GB038",
    "GB039",
    "GB041",
    "GB042",
    "GB043",
    "GB044",
    "GB046",
    "GB047",
    "GB048",
    "GB049",
    "GB051",
    "GB052",
    "GB053",
    "GB054",
    "GB057",
    "GB058",
    "GB059",
    "GB065",
    "GB068",
    "GB069",
    "GB070",
    "GB071",
    "GB072",
    "GB073",
    "GB074",
    "GB075",
    "GB079",
    "GB080",
    "GB081",
    "GB082",
    "GB083",
    "GB084",
    "GB086",
    "GB089",
    "GB090",
    "GB091",
    "GB092",
    "GB093",
    "GB094",
    "GB095",
    "GB096",
    "GB098",
    "GB099",
    "GB103",
    "GB104",
    "GB105",
    "GB107",
    "GB108",
    "GB109",
    "GB110",
    "GB111",
    "GB113",
    "GB114",
    "GB115",
    "GB116",
    "GB117",
    "GB118",
    "GB119",
    "GB120",
    "GB121",
    "GB122",
    "GB123",
    "GB124",
    "GB126",
    "GB127",
    "GB129",
    "GB130",
    "GB131",
    "GB132",
    "GB133",
    "GB134",
    "GB135",
    "GB136",
    "GB137",
    "GB138",
    "GB139",
    "GB140",
    "GB146",
    "GB147",
    "GB148",
    "GB149",
    "GB150",
    "GB151",
    "GB152",
    "GB155",
    "GB156",
    "GB158",
    "GB159",
    "GB160",
    "GB165",
    "GB166",
    "GB167",
    "GB170",
    "GB171",
    "GB172",
    "GB177",
    "GB184",
    "GB185",
    "GB186",
    "GB187",
    "GB188",
    "GB192",
    "GB193",
    "GB196",
    "GB197",
    "GB198",
    "GB203",
    "GB204",
    "GB250",
    "GB252",
    "GB253",
    "GB254",
    "GB256",
    "GB257",
    "GB260",
    "GB262",
    "GB263",
    "GB264",
    "GB265",
    "GB266",
    "GB270",
    "GB273",
    "GB275",
    "GB276",
    "GB285",
    "GB286",
    "GB291",
    "GB296",
    "GB297",
    "GB298",
    "GB299",
    "GB300",
    "GB301",
    "GB302",
    "GB303",
    "GB304",
    "GB305",
    "GB306",
    "GB309",
    "GB312",
    "GB313",
    "GB314",
    "GB315",
    "GB316",
    "GB317",
    "GB318",
    "GB319",
    "GB320",
    "GB321",
    "GB322",
    "GB323",
    "GB324",
    "GB325",
    "GB326",
    "GB327",
    "GB328",
    "GB329",
    "GB330",
    "GB331",
    "GB333",
    "GB334",
    "GB335",
    "GB336",
    "GB400",
    "GB401",
    "GB402",
    "GB403",
    "GB408",
    "GB409",
    "GB410",
    "GB415",
    "GB421",
    "GB422",
    "GB430",
    "GB431",
    "GB432",
    "GB433",
    "GB519",
    "GB520",
    "GB521",
    "GB522"
    )
  message(paste0("Grambank v.1.0.3

Don't forget to cite the source (modify in case of using individual chapters):

Hedvig Skirg\r{a}rd et al., Grambank reveals the importance of genealogical
constraints on linguistic diversity and highlights the impact of language
loss.Sci. Adv.9, eadg6175(2023). DOI:10.1126/sciadv.adg6175


@article{
doi:10.1126/sciadv.adg6175,
author = {Hedvig Skirg\u00E5rd and Hannah J. Haynie and Dami\u00E1n E. Blasi and Harald Hammarstr\u00F6m and Jeremy Collins and Jay J. Latarche and Jakob Lesage and Tobias Weber and Alena Witzlack-Makarevich and Sam Passmore and Angela Chira and Luke Maurits and Russell Dinnage and Michael Dunn and Ger Reesink and Ruth Singer and Claire Bowern and Patience Epps and Jane Hill and Outi Vesakoski and Martine Robbeets and Noor Karolin Abbas and Daniel Auer and Nancy A. Bakker and Giulia Barbos and Robert D. Borges and Swintha Danielsen and Luise Dorenbusch and Ella Dorn and John Elliott and Giada Falcone and Jana Fischer and Yustinus Ghanggo Ate and Hannah Gibson and Hans-Philipp G\u00F6bel and Jemima A. Goodall and Victoria Gruner and Andrew Harvey and Rebekah Hayes and Leonard Heer and Roberto E. Herrera Miranda and Nataliia H\u00FCbler and Biu Huntington-Rainey and Jessica K. Ivani and Marilen Johns and Erika Just and Eri Kashima and Carolina Kipf and Janina V. Klingenberg and Nikita K\u00F6nig and Aikaterina Koti and Richard G. A. Kowalik and Olga Krasnoukhova and Nora L. M. Lindvall and Mandy Lorenzen and Hannah Lutzenberger and T\u00E2nia R. A. Martins and Celia Mata German and Suzanne van der Meer and Jaime Montoya Samam\u00E9 and Michael M\u00FCller and Saliha Muradoglu and Kelsey Neely and Johanna Nickel and Miina Norvik and Cheryl Akinyi Oluoch and Jesse Peacock and India O. C. Pearey and Naomi Peck and Stephanie Petit and S\u00F6ren Pieper and Mariana Poblete and Daniel Prestipino and Linda Raabe and Amna Raja and Janis Reimringer and Sydney C. Rey and Julia Rizaew and Eloisa Ruppert and Kim K. Salmon and Jill Sammet and Rhiannon Schembri and Lars Schlabbach and Frederick W. P. Schmidt and Amalia Skilton and Wikaliler Daniel Smith and Hil\u00E1rio de Sousa and Kristin Sverredal and Daniel Valle and Javier Vera and Judith Vo\u00DF and Tim Witte and Henry Wu and Stephanie Yam and Jingting Ye and Maisie Yong and Tessa Yuditha and Roberto Zariquiey and Robert Forkel and Nicholas Evans and Stephen C. Levinson and Martin Haspelmath and Simon J. Greenhill and Quentin D. Atkinson and Russell D. Gray},
title = {Grambank reveals the importance of genealogical constraints on linguistic diversity and highlights the impact of language loss},
journal = {Science Advances},
volume = {9},
number = {16},
pages = {eadg6175},
year = {2023},
doi = {10.1126/sciadv.adg6175},
URL = {https://www.science.org/doi/abs/10.1126/sciadv.adg6175},
eprint = {https://www.science.org/doi/pdf/10.1126/sciadv.adg6175}}

"))

  if (sum(!toupper(features) %in% features_set) < 1){
   l <- utils::read.csv("https://raw.githubusercontent.com/grambank/grambank/master/cldf/languages.csv")
   v <- utils::read.csv("https://raw.githubusercontent.com/grambank/grambank/master/cldf/values.csv")
   merged_df <- merge(l, v, by.x = "ID", by.y = "Language_ID")
   merged_df <- merged_df[merged_df$Parameter_ID %in% toupper(features),
               c("Name", "Glottocode", "Latitude", "Longitude",
                "level", "Parameter_ID", "Value")]

   if(na.rm == TRUE){
    merged_df$language <- lingtypology::lang.gltc(merged_df$Glottocode)
    merged_df <- merged_df[!is.na(merged_df$language),]
    colnames(merged_df) <- c("grambank.name", "glottocode", "latitude",
                 "longitude", "level", "feature_id", "value",
                 "language")
   } else {
    colnames(merged_df) <- c("grambank.name", "glottocode", "latitude",
                 "longitude", "level", "feature_id", "value")
   }

   datasets <- lapply(toupper(features), function(i){
    df <- merged_df[merged_df$feature_id == i, -6]
    colnames(df)[6] <- i
    return(df)
   })
   final_df <- Reduce(merge, datasets)
   } else {
    not_features <- features[which(!features %in% features_set)]
    stop(paste(
     "There is no features",
     paste0("'", not_features, "'", collapse = ", "),
     "in Grambank database."
    ))
   }
  return(final_df)
 }
