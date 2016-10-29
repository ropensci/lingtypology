# lingtypology

`lingtypology` package connects R with the [Glottolog database (v. 2.7)](http://glottolog.org/) and provides additional functionality for linguistic typology. The Glottolog database contains the catalogue of the world's languages. This package helps researchers to make linguistic maps, using philosophy of [the Cross-Linguistic Linked Data project](http://clld.org/), which uniform access to the data across publications. This package is based on [`leaflet` package](https://rstudio.github.io/leaflet/), so `lingtypology` package is a package for linguistic interactive cartography.

## Installation

Get the released version from GitHub:

```R
install.packages("devtools")
devtools::install_github("agricolamz/lingtypology", dependencies = TRUE)
```

Load a library:
```R
library(lingtypology)
```

For a detailed tutorial see [GitHub wiki](https://github.com/agricolamz/lingtypology/wiki).
