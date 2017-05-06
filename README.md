# lingtypology

[![Project Status: Active - The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)
[![Build Status](https://travis-ci.org/ropensci/lingtypology.svg?branch=master)](https://travis-ci.org/ropensci/lingtypology)
[![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/ih3r5ubdndb34iap?svg=true)](https://ci.appveyor.com/project/agricolamz/lingtypology-p2nmi)
[![Coverage Status](https://img.shields.io/codecov/c/github/ropensci/lingtypology/master.svg)](https://codecov.io/github/ropensci/lingtypology?branch=master)
[![CRAN
version](http://www.r-pkg.org/badges/version/lingtypology)](https://cran.r-project.org/package=lingtypology)
[![](http://cranlogs.r-pkg.org/badges/grand-total/lingtypology)](https://CRAN.R-project.org/package=lingtypology)
[![Research software impact](http://depsy.org/api/package/cran/lingtypology/badge.svg)](http://depsy.org/package/r/lingtypology)

`lingtypology` package connects R with the [Glottolog database (v. 2.7)](http://glottolog.org/) and provides additional functionality for linguistic mapping. The Glottolog database contains the catalogue of the world's languages. This package helps researchers to make linguistic maps, using philosophy of [the Cross-Linguistic Linked Data project](http://clld.org/), which uniform access to the data across publications. This package is based on [`leaflet` package](https://rstudio.github.io/leaflet/), so `lingtypology` package is a package for linguistic interactive mapping.

## Installation

Get the stable version from CRAN:
```R
install.packages("lingtypology")
```
… or get the development version from GitHub:
```R
install.packages("devtools")
devtools::install_github("ropensci/lingtypology")
```

Sometimes installation failed because of the absence of the package `crosstalk`. Just install it using command `install.packages("crosstalk")`.

Load a library:
```R
library(lingtypology)
```

For a detailed tutorial see [GitHub pages](https://ropensci.github.io/lingtypology/).

You can contribute to `lingtypology` by

* creating an issue
* then opening a Pull Request

---

[![](http://ropensci.org/public_images/github_footer.png)](http://ropensci.org)
