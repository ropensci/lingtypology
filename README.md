# lingtypology

[![Build Status](https://travis-ci.org/agricolamz/lingtypology.svg?branch=master)](https://travis-ci.org/agricolamz/lingtypology)
[![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/agricolamz/lingtypology?branch=master&svg=true)](https://ci.appveyor.com/project/agricolamz/lingtypology)
[![Coverage Status](https://img.shields.io/codecov/c/github/agricolamz/lingtypology/master.svg)](https://codecov.io/github/agricolamz/lingtypology?branch=master)
[![CRAN
version](http://www.r-pkg.org/badges/version/lingtypology)](https://cran.r-project.org/package=lingtypology)
[![](http://cranlogs.r-pkg.org/badges/grand-total/lingtypology)](https://CRAN.R-project.org/package=lingtypology)
[![Research software impact](http://depsy.org/api/package/cran/lingtypology/badge.svg)](http://depsy.org/package/r/lingtypology)

`lingtypology` package connects R with the [Glottolog database (v. 2.7)](http://glottolog.org/) and provides additional functionality for linguistic typology. The Glottolog database contains the catalogue of the world's languages. This package helps researchers to make linguistic maps, using philosophy of [the Cross-Linguistic Linked Data project](http://clld.org/), which uniform access to the data across publications. This package is based on [`leaflet` package](https://rstudio.github.io/leaflet/), so `lingtypology` package is a package for linguistic interactive cartography.

## Installation

Get the stable version from CRAN:
```R
install.packages("lingtypology")
```
… or get the development version from GitHub:
```R
install.packages("devtools")
devtools::install_github("agricolamz/lingtypology")
```

Sometimes installation failed because of the absence of the package `crosstalk`. Just install it using command `install.packages("crosstalk")`.

Load a library:
```R
library(lingtypology)
```

For a detailed tutorial see [GitHub pages](https://agricolamz.github.io/lingtypology/).

---

[![](http://ropensci.org/public_images/github_footer.png)](http://ropensci.org)
