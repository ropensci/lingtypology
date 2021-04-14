setwd("/home/agricolamz/work/packages/lingtypology/lingtypology/")
library(tidyverse)
files <- list.files("R/", pattern = ".feature.R")
files <- files[!(files %in% list.files("R/", pattern = "map.feature.R"))]

map(files, function(i){
  code <- read_lines(str_c("R/", i))
  files %>%
    .[!(. %in% list.files("R/", pattern = i))] %>%
    str_remove("\\.R$") %>%
    str_c("\\code{\\link{", ., "}}", collapse = ", ") %>%
    str_c("#' @seealso ", .) ->
    change
  code[str_which(read_lines("R/abvd.feature.R"), "#' @seealso")] <- change
  write_lines(code, str_c("R/", i))
})
