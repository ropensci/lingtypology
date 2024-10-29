#' Message when the package is loaded
#'
#' @author George Moroz <agricolamz@gmail.com>
#' @noRd

.onAttach <- function(libname = find.package("lingtypology"),
                    pkgname = "lingtypology") {
  packageStartupMessage("Based on the Glottolog v. 5.1")
}
