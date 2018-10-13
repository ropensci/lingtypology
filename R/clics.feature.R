#' Download CLICS data
#'
#' This function downloads data from CLICS (https://clics.clld.org/) and changes language names to the names from lingtypology database. You need the internet connection.

clics.feature <- function(){
  message("Don't forget to cite a source:

List, Johann-Mattis & Greenhill, Simon & Anderson, Cormac & Mayer, Thomas & Tresoldi, Tiago & Forkel, Robert (eds.) 2018.
Database of Cross-Linguistic Colexifications.
Jena: Max Planck Institute for the Science of Human History.
(Available online at http://clics.clld.org, Accessed on 2018-10-13.)

@book{clics,
  address   = {Jena},
  editor    = {Johann-Mattis List and Simon Greenhill and Cormac Anderson and Thomas Mayer and Tiago Tresoldi and Robert Forkel},
  publisher = {Max Planck Institute for the Science of Human History},
  title     = {CLICS2},
  url       = {https://clics.clld.org/},
  year      = {2018}
}
")
}
