#' Create an atlas
#'
#' This function creates an rmarkdown based atlas from data provided by users. This function creates the template, after it should be rendered by rmarkdown package. The DT package is required during the rendering.
#'
#' @param languages character vector of languages (can be written in lower case)
#' @param features dataframe where each column is a feature set
#' @param latitude numeric vector of latitudes (optional)
#' @param longitude numeric vector of longitudes (optional)
#' @param atlas_name string with an atlas name
#' @param author string with the authors list
#'
#' @export
#'
#' @importFrom utils write.csv

atlas.database <- function(languages,
                           latitude,
                           longitude,
                           features,
                           atlas_name = "",
                           author = "") {
  # create a folder and change working directory ----------------------------
  subfolder <- paste("atlas", gsub(" ", "_", atlas_name), sep = "_")
  dir.create(file.path(getwd(), subfolder))

  # save a database file ----------------------------------------------------
  db <- cbind(data.frame(languages, latitude, longitude,
                         stringsAsFactors = FALSE),
              features)
  utils::write.csv(db, paste0("./", subfolder, "/database.csv"), row.names = FALSE)

  # create _site.yml --------------------------------------------------------
  names <- names(features)
  menu_names <- paste0(seq_along(names), ". ", names)
  rmd_names <- paste0(seq_along(names), "._", gsub(" ", "_", names))

  site.yml <- c(
    paste0("name: '", atlas_name, "'"),
    "navbar:",
    "  left:",
    "  - text: 'Home'",
    "    icon: fa-home",
    "    href: index.html",
    "  - text: features",
    "    menu:",
    "output_dir: docs",
    "output:",
    "  html_document:",
    "    lib_dir: site_libs",
    "    self_contained: no",
    "    theme: spacelab",
    "    highlight: pygments",
    "    df_print: paged",
    "    include:",
    "      after_body: footer.html"
  )
  lapply(seq_along(names), function(i) {
    site.yml <<- append(site.yml,
                        paste0("      href: ", rmd_names[i], ".html"),
                        after = 8 + 2 * (i - 1))
    site.yml <<- append(site.yml,
                        paste0("    - text: ", menu_names[i]),
                        after = 8 + 2 * (i - 1))
  })
  writeLines(site.yml, paste0("./", subfolder, "/_site.yml"), sep = "\n")

  # create a footer ---------------------------------------------------------
  footer.html <- paste0(
    "<br><br><p><center> &copy; ",
    author,
    ", created with <a href='https://github.com/ropensci/lingtypology'>lingtypology</a> </center> </p>"
  )
  writeLines(footer.html, paste0("./", subfolder, "/footer.html"))

  # create rmd files --------------------------------------------------------
  lapply(seq_along(names), function(j) {
    rmd <- c(
      "```{r setup, include=FALSE}",
      "knitr::opts_chunk$set(echo = FALSE, message = FALSE)",
      "library(lingtypology)",
      "library(DT)",
      "```",
      "",
      paste0("##", names(features)[j]),
      "",
      "```{r}",
      "df <- read.csv('database.csv', stringsAsFactors = FALSE, check.names = FALSE)",
      paste0("column <- which(names(df) %in% '", names(features)[j], "')"),
      "df <- df[!is.na(df[,column]),c(1:3, column)]",
      "lingtypology::map.feature(languages = df$languages,",
      "                          features = df[,4],",
      "                          label = df$languages,",
      "                          longitude = df$longitude,",
      "                          latitude = df$latitude)",
      "df[1] <- lingtypology::url.lang(df$languages)",
      "DT::datatable(df[,c(1, 4)], escape = FALSE,",
      "              options = list(pageLength = 15, dom = 'ftip'))",
      "```"
    )
    writeLines(rmd, paste0("./", subfolder, "/", paste0(rmd_names[j], ".Rmd")), sep = "\n")
  })

  # create an index file ----------------------------------------------------
  index <- c(
    paste0("##", atlas_name),
    "Here will be a nice text about the atlas...",
    "Don't forget to put some information about, how to cite your work."
  )
  writeLines(index, paste0("./", subfolder, "/index.Rmd"), sep = "\n")
}
