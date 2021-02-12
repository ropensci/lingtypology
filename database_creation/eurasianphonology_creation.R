library(jsonlite)
json_data <- fromJSON(txt = "https://github.com/macleginn/eurasian-phonologies/raw/master/src/dbase/phono_dbase.json")
json_data <- lapply(json_data, function(x) {
  x[sapply(x, is.null)] <- NA
  unlist(x)
})


lapply(seq_along(json_data), function(i){
  data.frame(names = names(json_data[[i]]),
             value = json_data[[i]],
             id = names(json_data[i]))
}) ->
  res

df <- as.data.frame(do.call("rbind", res))

library(tidyverse)

df %>%
  pivot_wider(names_from = names, values_from = value) %>%
  pivot_longer(names_to = "segment_type", values_to = "segments",
               cols = -c(id, code, type, name, coords1, coords2, gen1,
                         gen2, tones, syllab, cluster, finals, source, comment,
                         contr)) %>%
  filter(!is.na(segments),
         !str_detect(segment_type, "inv")) %>%
  mutate(segment_type = ifelse(str_detect(segment_type, "cons"), "consonant",
                               "vowel")) ->
  result

result$glottocode <- lingtypology::gltc.iso(result$code)
result$glottocode[result$id == 'Darkhat#16'] <- 'dark1243'
result$glottocode[result$id == 'Northwestern Pashto#52'] <- 'nort2646'
result$glottocode[result$id == 'Japhug#72'] <- 'japh1234'
result$glottocode[result$id == 'Zuberoan Basque#86'] <- 'basq1248'
result$glottocode[result$id == 'Beserman (Šamardan)#91'] <- 'bese1243'
result$glottocode[result$id == 'Yodzyak Komi#92'] <- 'komi1267'
result$glottocode[result$id == 'Forest Nenets#100'] <- 'fore1274'
result$glottocode[result$id == 'Solon#132'] <- 'even1259'
result$glottocode[result$id == 'Eastern Khanty (Vakh)#143'] <- 'east2774'
result$glottocode[result$id == 'Eastern Mari#150'] <- 'east2774'
result$glottocode[result$id == 'Dolakha Newar#172'] <- 'newa1246'
result$glottocode[result$id == 'Digor Ossetic#222'] <- 'digo1242'
result$glottocode[result$id == 'South Mustang Tibetan (Jharkhot)#352'] <-
  'lowa1242'
result$glottocode[result$id == 'Tamang (Dhankuta)#360'] <- 'east2347'
result$glottocode[result$id == 'Lizu#362'] <- 'lizu1234'
result$glottocode[result$id == 'Puxi#363'] <- 'sout2728'
result$glottocode[result$id == 'Kurtoep#364'] <- 'kurt1248'
result$glottocode[result$id == 'Sangdam Tibetan#369'] <- 'kham1299'
result$glottocode[result$id == 'Myeik Burmese#370'] <- 'merg1238'
result$glottocode[result$id == 'Elfdalian#377'] <- 'elfd1234'
result$glottocode[result$id == 'Lemi Chin#403'] <- 'east2779'
result$glottocode[result$id == 'Amədya Neo-Aramaic#420'] <- 'east2779'
result$glottocode[result$id == 'Arbel Neo-Aramaic#421'] <- 'lish1245'
result$glottocode[result$id == 'Barwar Neo-Aramaic#423'] <- 'assy1241'
result$glottocode[result$id == 'Rushani#428'] <- 'rush1239'
result$glottocode[result$id == 'Khufi#429'] <- 'khuf1238'

result$code <- lingtypology::iso.gltc(result$glottocode)

for (i in 1:length(result$id)){
  result$id[i] <- unlist(strsplit(result$id[i],split="#"))[2]
}

for (i in 1:length(result$contr)){
  contr <- result$contr[i]
  last_name <- word(contr, 2)
  last_name_last_chr <- str_sub(last_name, -1)
  if (last_name_last_chr != ','){
    new_last_name <- paste(last_name, ',', sep = '')
  }else{
    if (last_name == 'Nikolayev,'){
      new_last_name <- 'Nikolaev,'
    }else{
      new_last_name <- last_name
    }
  }
  mail <- word(contr, 3)
  mail_first_chr <- str_sub(mail, -1)
  if (mail_first_chr == ')'){
    new_mail <- substr(mail, start = 2, stop = nchar(mail) -1)
  }else{
    new_mail <- mail
  }
  new_str <- paste(word(contr,1), new_last_name, sep = ' ')
  new_str <- paste(new_str, new_mail, sep = ' ')
  result$contr[i] <- new_str
}

save(result, file = 'data/eurasianphonology.Rdata')
