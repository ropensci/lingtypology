# lingtypology

[![Project Status: Active - The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)
[![R build status](https://github.com/ropensci/lingtypology/workflows/R-CMD-check/badge.svg)](https://github.com/ropensci/lingtypology/actions)
[![Coverage Status](https://img.shields.io/codecov/c/github/ropensci/lingtypology/master.svg)](https://codecov.io/github/ropensci/lingtypology?branch=master)

[![CRAN
version](http://www.r-pkg.org/badges/version/lingtypology)](https://cran.r-project.org/package=lingtypology)
[![](http://cranlogs.r-pkg.org/badges/grand-total/lingtypology)](https://CRAN.R-project.org/package=lingtypology)
[![](https://badges.ropensci.org/95_status.svg)](https://github.com/ropensci/onboarding/issues/95)
[![Research software impact](http://depsy.org/api/package/cran/lingtypology/badge.svg)](http://depsy.org/package/r/lingtypology)
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.815028.svg)](https://doi.org/10.5281/zenodo.815028)


`lingtypology` package connects R with the [Glottolog database (v. 4.4)](https://glottolog.org/) and provides additional functionality for linguistic mapping. The Glottolog database contains the catalogue of the world's languages. This package helps researchers to make linguistic maps, using philosophy of [the Cross-Linguistic Linked Data project](https://clld.org/), which uniform access to the data across publications. This package is based on [`leaflet` package](https://rstudio.github.io/leaflet/), so `lingtypology` package is a package for linguistic interactive mapping. You also might be interested in looking into some alternatives to lingtypology:

* [lingtypology](https://pypi.org/project/lingtypology/) in Python by Michael Voronov
* [glottospace](https://github.com/SietzeN/glottospace) -- R package for the geospatial analysis based on Glottolog by Sietze Norder et al.

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

For a detailed tutorial see [GitHub pages](https://docs.ropensci.org/lingtypology/).

You can contribute to `lingtypology`, but look through [contribution info](https://github.com/ropensci/lingtypology/blob/master/CONTRIBUTING.md) before.

---

[![](http://ropensci.org/public_images/github_footer.png)](http://ropensci.org)
