#' Download SOUNDCOMPARISONS data
#'
#' This function downloads data from SOUNDCOMPARISONS (\url{https://soundcomparisons.com/}) and changes language names to the names from lingtypology database. You need the internet connection.
#'
#' @param word A character vector that define with a feature ids from SOUNDCOMPARISONS (e. g. "one", "sharp_fem", "near_neut", "on_the_left", "	I_will_give", "write_ipv_sg", "your_pl_pl").
#' @seealso \code{\link{abvd.feature}}, \code{\link{afbo.feature}}, \code{\link{autotyp.feature}}, \code{\link{oto_mangueanIC.feature}}, \code{\link{phoible.feature}}, \code{\link{sails.feature}}, \code{\link{uralex.feature}}, \code{\link{valpal.feature}}, \code{\link{vanuatu.feature}},  \code{\link{eurasianphonology.feature}}, \code{\link{eurasianphonology.feature}}
#' @seealso \code{\link{abvd.feature}}, \code{\link{afbo.feature}}, \code{\link{autotyp.feature}}, \code{\link{bivaltyp.feature}}, \code{\link{eurasianphonology.feature}}, \code{\link{oto_mangueanIC.feature}}, \code{\link{phoible.feature}}, \code{\link{sails.feature}}, \code{\link{uralex.feature}}, \code{\link{valpal.feature}}, \code{\link{vanuatu.feature}}, \code{\link{wals.feature}}
#' @examples
#' # soundcomparisons.feature(c("sun", "house"))
#' @export
#'
#' @importFrom utils read.csv
#'


soundcomparisons.feature <- function(word) {
    message(paste0("Don't forget to cite a source (modify in case of using individual chapters):

Heggarty, Paul and Shimelman, Aviva and Abete, Giovanni and Anderson, Cormac and Sadowsky, Scott and Paschen, Ludger and Maguire, Warren and Jocz, Lechoslaw and Aninao, Maria Jose and Wagerle, Laura and Dermaku-Appelganz, Darja and Silva, Ariel Pheula do Couto e and Lawyer, Lewis C. and Michalsky, Jan and Cabral, Ana Suelly Arruda Camara and Walworth, Mary and Koile, Ezequiel and Runge, Jakob and Bibiko, Hans-Jorg (eds.) 2019. New online database and resource for researching phonetic diversity.
(Available online at https://soundcomparisons.com/, Accessed on ",
                   Sys.Date(),
                   ".)


@misc{heggarty_sound_2019,
	title = {Sound {Comparisons}:  {Exploring} {Diversity} in {Phonetics} across {Language} {Families}},
	url = {https://soundcomparisons.com},
	journal = {Sound Comparisons:  Exploring Diversity in Phonetics across Language Families},
	author = {Heggarty, Paul and Shimelman, Aviva and Abete, Giovanni and Anderson, Cormac and Sadowsky, Scott and Paschen, Ludger and Maguire, Warren and Jocz, Lechoslaw and Aninao, Maria Jose and Wagerle, Laura and Dermaku-Appelganz, Darja and Silva, Ariel Pheula do Couto e and Lawyer, Lewis C. and Michalsky, Jan and Cabral, Ana Suelly Arruda Camara and Walworth, Mary and Koile, Ezequiel and Runge, Jakob and Bibiko, Hans-Jorg},
	year = {2019},
	keywords = {Dialects, Phonetics, Recordings, Sound Comparisons, Transcriptions}
}

@inproceedings{heggarty_sound_2019,
	address = {Canberra, Australia},
	title = {Sound {Comparisons}: {A} new online database and resource for researching phonetic diversity},
	isbn = {978-0-646-80069-1},
	url = {https://icphs2019.org/icphs2019-fullpapers/pdf/full-paper_490.pdf},
	booktitle = {Proceedings of the 19th {International} {Congress} of {Phonetic} {Sciences}},
	publisher = {Australasian Speech Science and Technology Association},
	author = {Heggarty, Paul and Shimelman, Aviva and Abete, Giovanni and Anderson, Cormac and Sadowsky, Scott and Paschen, Ludger and Maguire, Warren and Jocz, Lechoslaw and Aninao, Maria Jose and Wagerle, Laura and Dermaku-Appelganz, Darja and Silva, Ariel Pheula do Couto e and Lawyer, Lewis C. and Michalsky, Jan and Cabral, Ana Suelly Arruda Camara and Walworth, Mary and Koile, Ezequiel and Runge, Jakob and Bibiko, Hans-Jorg},
	month = aug,
	year = {2019},
	keywords = {Dialects, Phonetics, Recordings, Sound Comparisons, Transcriptions},
	pages = {280--284}
}"))
    rom_words <- read.csv("https://soundcomparisons.com/export/csv?study=Romance&languages=12231572409&words=10,20,30,40,50,60,70,80,90,100,110,200,210,7820,1620,1810,7000,7040,7320,7390,7840,7510,7980,7960,6200,7330,7650,7710,7540,7610,7910,7920,2010,2110,2130,2140,2230,2240,2250,2310,2340,2360,2510,2610,2620,2640,2660,2840,4310,4320,4410,4370,4520,4100,3020,3140,3160,3170,3180,3190,3310,3420,3810,3820,3900,5120,5130,5150,5210,5240,5510,5520,6410,5610,6260,6310,6320,5900,5890,5850,5870,6040,6020,6070,6140,8391,8390,6520,6530,6550,6860,6940,6840,8000,8020,8050,8170,8430,8510,8530,8410,8480,8490,8611,8610,8630,8640,8650,8930,9040,9041,9070,710,720,730,740,1120,1240,1260,1410,7340,5040,5020,5090,5070,5080,510,4710", encoding = "UTF-8")
    ger_words <- read.csv("https://soundcomparisons.com/export/csv?study=Germanic&languages=11171246109&words=10,20,30,40,50,60,70,80,90,100,200,7820,7020,7030,7040,7210,7410,7840,7510,7980,7670,7660,7710,7910,7920,7560,7680,7700,810,2010,2110,2130,2210,2230,2240,2310,2510,2530,2540,2610,2620,2640,2810,2840,4310,4320,4410,4330,4100,4110,3120,3150,3230,3310,3320,3340,3240,3820,3900,5120,5260,5510,5430,5520,6260,6270,6290,5810,5910,5920,5820,5830,5850,6000,6050,6150,6040,6070,6510,6560,6540,6550,6570,6580,6600,6630,6640,8000,8310,8330,8320,8510,8520,9620,8120,8720,8990,1010,1210,1410,1430,1460,1470,5010,5020,510", encoding = "UTF-8")
    eng_words <- read.csv("https://soundcomparisons.com/export/csv?study=Englishes&languages=11111230301&words=10,20,30,40,50,60,70,80,90,100,200,7820,7020,7030,7040,7210,7410,7840,7510,7980,7670,7650,7660,7710,7910,7920,7560,7680,7700,810,2010,2110,2130,2140,2210,2230,2240,2310,2510,2530,2540,2610,2620,2640,2810,2840,4310,4320,4410,4330,4100,4110,3120,3150,3230,3310,3320,3340,3240,3820,3900,5120,5260,5510,5430,5520,6260,6270,6290,5810,5910,5920,5820,5830,5850,6000,6050,6150,6040,6070,6510,6560,6540,6550,6570,6580,6600,1440,6630,6640,8000,8310,8330,8320,8510,8520,9620,8120,8720,8940,8990,1010,1210,1410,1430,1460,1470,5010,5020,510", encoding = "UTF-8")
    slav_words <- read.csv("https://soundcomparisons.com/export/csv?study=Slavic&languages=13111210507&words=10,20,30,40,50,60,70,80,90,100,200,7010,7020,7040,7050,7210,7360,7380,7410,7420,7510,7980,7520,7650,7660,7670,7680,7710,7740,7840,7880,7890,7910,7930,7940,7960,7970,820,2010,2120,2130,2140,2230,2240,2250,2310,2530,2610,2810,4330,4332,4100,4110,3120,3140,3150,3240,3310,3350,3810,3820,3840,3850,3900,5010,5012,5020,5110,5120,5150,4150,5210,5220,5230,5232,5240,5410,5420,5510,5520,5430,5540,5610,6230,6240,6270,6290,6310,6410,5820,5830,5850,5920,6020,6030,6040,6150,6070,6200,6590,6630,6840,6860,6942,6940,8000,8010,8130,8140,8320,8410,8420,8430,8480,8530,8580,8620,8740,8850,8890,8950,8970,8980,9010,9100,1010,710,1030,1040,720,740,1080,780,1230,1330,1410,1350,1120,5060,5080,5052,5050", encoding = "UTF-8")
    celt_words <- read.csv("https://soundcomparisons.com/export/csv?study=Celtic&languages=14111238609&words=10,20,30,40,50,60,70,80,90,100,110,200,7810,1830,7010,7020,7060,7040,7110,7170,7120,7360,7390,7400,7460,7480,7840,7520,7510,7580,7570,7590,7650,7660,7710,7720,7740,7760,810,2140,2230,2320,2530,2630,2640,2670,2600,2740,2840,4010,4020,4420,4470,3120,3190,3200,3330,3840,3910,6420,5110,5140,5240,6460,5430,5620,5630,6470,6340,6360,6310,6320,5900,5850,6010,6950,6150,6040,6070,6300,6820,8040,8070,8300,9090,8480,9070,1010,1040,1080,1090,1490,4610,4620,4910,4930,6190,6191,6192,4100,4101,4102,6450,6451,6452,3300,3301,3302,5410,5411,5412,6510,6511,6512,3110,3111,3112,2810,2811,2812,2010,2011,2012,5520,5521,5522,510,511,512,2370,2371,2372,3280,3281,3282,5100,5101,5102,3950,3951,3952,6990,6991,6992", encoding = "UTF-8")
    ands_words <- read.csv("https://soundcomparisons.com/export/csv?study=Andes&languages=21222210001&words=11,10,20,30,40,50,60,70,80,90,100,200,7011,7010,7020,7110,7120,7840,7860,7880,7510,7980,7960,7710,7750,7970,7971,7910,7930,2010,2050,2110,2111,2120,2130,2210,2230,2240,2310,2410,2510,2611,2610,2620,2630,2640,2710,2811,2810,4010,4030,4101,4100,3120,3430,3820,3830,5110,5120,5140,5170,5210,5230,5410,5510,5430,5520,6410,6220,5850,6030,6060,6040,6020,6120,6510,6520,6810,8021,8020,8030,8050,8110,8311,8310,8370,8420,8421,8430,8440,8510,8550,8580,8590,8410,8411,8270,8600,8610,8620,8740,8910,8940,9040,1011,1010,1020,1040,1060,1070,1120,1210,1220,1230,1260,1310,1320,1360,1910,5010,5020,510,520", encoding = "UTF-8")
    map_words <- read.csv("https://soundcomparisons.com/export/csv?study=Mapudungun&languages=28141005109&words=10,20,30,40,50,60,70,80,90,100,200,210,7010,7020,7030,7050,7110,7840,7860,7880,7980,7960,7710,7750,7910,7930,7170,20680,20690,7720,20790,2010,2050,2110,2120,2130,2210,2230,2240,10560,2410,2310,2510,2530,2610,2620,2630,2640,2710,2810,2840,10050,3010,4010,4030,4100,20170,10370,10620,20240,10740,4320,20190,10790,31180,21410,21400,20090,3120,20070,20030,20910,10200,3210,20010,20020,3420,3430,20100,3820,3830,3810,5110,5120,5130,5140,10230,20980,5170,10710,5210,5220,5230,5240,5410,5510,5430,10120,5520,6410,10760,20480,6220,6210,6240,6260,20130,5850,5810,5840,10810,21530,21520,6030,6060,6040,6020,6120,10730,20550,20610,30380,6510,6520,30500,20700,20660,10720,20890,20670,6810,8020,8030,8050,8110,8310,8370,8420,8430,8440,8550,8580,8590,8410,21450,31390,10550,8270,21510,21440,8510,21090,8600,8610,8620,8740,8830,8910,8940,9040,1010,1040,1060,1023,1070,1024,1210,1220,1230,1260,1360,1910,20830,10450,21050,5010,5020,510,20560,21000,20620,10770,20630,10800,10540,10650,7520,10350,10340,10490,10480,10040,10030,10640,10630,6320,10430,10290,10280,10100,10090,10130,10140,10260,10270,10300,10310,10010,10020,10460,10470,10500,10510,10400,10410,10670,10680,10700,10380,21100,10070,10080,10590,10600", encoding = "UTF-8")
    braz_words <- read.csv("https://soundcomparisons.com/export/csv?study=Brazil&languages=31111102309&words=10,20,30,40,50,7820,7830,1610,1620,7010,7020,7030,7040,7050,7110,7170,7210,7220,7310,7320,7350,7360,7370,7380,7410,7420,7470,7450,7840,7860,820,810,7890,7880,7520,7980,7960,7430,7710,7720,7770,7800,7910,7920,7930,7940,7990,6060,2010,2050,2110,2120,2130,2210,2230,2240,2310,2340,2410,2510,2520,2530,2550,2610,2620,2630,2640,2710,2720,2730,2740,2810,2840,4010,4020,4030,4050,4310,4350,4360,4100,3010,3120,3210,3410,3420,3430,3500,3240,3810,3820,3830,3840,3850,4320,5850,6080,6090,5110,5120,5130,5150,5170,5210,5220,5230,5240,5310,5410,5420,5510,5540,5430,5530,5520,6810,6210,6220,6230,6240,6260,6280,6310,6320,5810,5830,5860,8980,6030,6040,6510,6620,8010,8020,8030,8040,8050,8060,8250,8260,8210,8220,8110,8130,8140,8150,8310,8330,8320,8340,8370,8420,8430,8440,8510,8520,8540,8560,8550,8580,8590,8410,8270,8600,8610,8620,8120,8670,8680,8690,8700,8720,8740,8810,8830,8840,8850,8870,8880,8890,8920,8930,8940,8950,8960,8970,9000,9010,9020,9030,9040,9050,9060,9070,1010,1020,1040,1050,1060,1070,1120,1210,1220,1230,1250,1310,1320,1330,1340,1360,1410,1350,2420,5010,5020,5050", encoding = "UTF-8")
    pap_words <- read.csv("https://soundcomparisons.com/export/csv?study=WestPapua&languages=53121400009&words=10,20,30,40,50,60,70,80,90,100,110,150,200,210,7010,7020,7030,7040,7050,810,820,7110,7170,7210,7220,7350,7360,7370,7380,7410,7420,7490,7520,7630,7710,7720,7730,7770,7800,7820,7860,7880,7890,7910,7920,7930,7940,7980,7990,2010,2050,2110,2120,2130,2210,2230,2240,2310,2330,2410,2420,2520,2610,2620,2630,2710,2720,2740,2840,4010,4020,4030,4050,4100,4310,4320,4350,4360,3120,3210,3240,3410,3420,3430,3450,3490,3520,3810,3830,3840,3850,5120,5130,5150,5210,6220,5230,5240,6240,6250,6260,6280,6310,6320,5410,5420,5430,5510,5520,5530,5540,5810,5840,5850,5860,5920,5930,6030,6040,6060,6090,6330,6510,6620,6630,6810,8020,8030,8090,8110,8120,8130,8140,8150,8180,8210,8220,8260,8270,8290,8310,8320,8330,8340,8360,8370,8400,8410,8420,8430,8440,8510,8520,8540,8550,8560,8580,8590,8670,8680,8690,8740,8800,8810,8870,8880,8890,8920,8930,8950,8960,8970,9000,9010,9020,9030,9040,9050,9060,9120,9130,9150,9180,9220,9400,9500,9620,1010,1023,1020,1021,1022,1040,1050,1052,1060,1070,1072,1120,1210,1220,1230,1240,1250,1310,1320,1340,1380,1390,1410,1480,1710,5010,5020,510", encoding = "UTF-8")
    mix_words <- read.csv("https://soundcomparisons.com/export/csv?study=MixeZoque&languages=61051523409&words=10,20,30,40,7010,7020,7030,7040,7050,810,820,7110,7170,7210,7220,7350,7360,7370,7380,7410,7420,7490,7520,7630,7710,7720,7730,7770,7800,7820,7860,7880,7890,7910,7920,7930,7940,7980,7990,2010,2050,2110,2120,2130,2210,2230,2240,2310,2330,2410,2420,2520,2610,2620,2630,2710,2720,2740,2840,4010,4020,4030,4050,4100,4310,4320,4350,4360,3120,3210,3240,3410,3420,3430,3450,3490,3520,3810,3830,3840,3850,5120,5130,5150,5210,6220,5230,5240,6240,6250,6260,6280,6310,6320,5410,5420,5430,5510,5520,5530,5540,5810,5840,5850,5860,5920,5930,6030,6040,6060,6090,6330,6510,6620,6630,6810,8020,8030,8090,8110,8120,8130,8140,8150,8180,8210,8220,8260,8270,8290,8310,8320,8330,8340,8360,8370,8400,8410,8420,8430,8440,8510,8520,8540,8550,8560,8580,8590,8670,8680,8690,8740,8800,8810,8870,8880,8890,8920,8930,8950,8960,8970,9000,9010,9020,9030,9040,9050,9060,9120,9130,9150,9180,9220,9400,9500,9620,1010,1023,1020,1040,1060,1070,1120,1210,1220,1230,1240,1250,1310,1320,1340,1380,1390,1410,1480,5010,5020,510", encoding = "UTF-8")
    words <- rbind(rom_words, ger_words, eng_words, slav_words, celt_words,
                   ands_words, map_words, braz_words, pap_words, mix_words)
    words <- words[!duplicated(words$WordModernName1), ]
    words <- words[,c("WordId", "WordModernName1", "WordModernName2")]
    word_set <- c(words$WordModernName1)
    word_set_2 <- c(words$WordModernName2)
    my_data <- lapply(word, function(x) {
      if ((x %in% word_set)|(x %in% word_set_2)){
        z <- (words[words$WordModernName1 == x,])
        y <- (words[words$WordModernName2 == x,])
        new <- rbind(z,y)
        new <- new[rowSums(is.na(new)) != ncol(new),]
        word_id <- new$WordId[1]
        families <- c("Romance", "Germanic", "Englishes", "Slavic", "Celtic",
                    "Andes", "Mapudungun", "Brazil", "WestPapua", "MixeZoque")
        links_set <- c()
        langs <- paste(lingtypology::soundcomparisons$LanguageId, collapse=",")
        myword <- words[which(words$WordModernName1 == x), ]
        my_links <- lapply(families, function(link) {
          links <- paste0("https://soundcomparisons.com/export/csv?study="
                          ,link,"&languages=", langs,"&words=", word_id)
          links_set <- append(links_set, links)}) ##получили ссылки, по которым скачали данные
        data <-lapply(my_links, function(l) {
          datalist <- read.csv(l, encoding = "UTF-8")
          datalist <- datalist[c("LanguageId", "LanguageName", "Latitude",
                                  "Longitude", "WordId", "WordModernName1",
                                  "WordProtoName1", "Phonetic")]
          })
        final_df <- Reduce(function(first, second) {
          merge(
            first,
            second,
            all = TRUE,
            by = c(
              "LanguageId",
              "LanguageName",
              "Latitude",
              "Longitude",
              "WordId",
              "WordModernName1",
              "WordProtoName1",
              "Phonetic"
            )
          )
        }, data)
        } else {
          stop(paste(
            "There is no features",
            paste0("'", x, "'", collapse = ", "),
            "in soundcomparisons database."
          ))}})
    my_df <- do.call("rbind", my_data)
    my_df <- merge(my_df, lingtypology::soundcomparisons, by = "LanguageId")
    my_df$LanguageName.y <- NULL
    #my_df <- subset(my_df, select = -c(LanguageName.y))
    colnames(my_df) <- c("lang_id", "language", "latitude", "longitude",
                         "word_id", "word", "proto_word", "phonetic",
                         "glottocode")
  return(my_df)
}
