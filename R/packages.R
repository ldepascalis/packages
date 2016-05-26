# Some useful keyboard shortcuts for package authoring:
#
#   Build and Reload Package:  'Ctrl + Shift + B'
#   Check Package:             'Ctrl + Shift + E'
#   Test Package:              'Ctrl + Shift + T'

#' Package Loading
#'
#' This function loads specified R packages, after having made sure they are installed.
#' @param packages A string or string vector with the names of the packages to load..
#' @keywords packages
#' @export
#' @examples
#' packages()

packages <- function(packages) {
  # check packages is a string or a string vector
  if (!is.character(packages)) {
    stop("packages must be a string or a string vector")
  }

  # check specified packages are available from http://cran.us.r-project.org
  if (length(unavailable <-
             packages[!(packages %in% available.packages(repos = 'http://cran.us.r-project.org')[, "Packages"])])) {
    # install, from http://cran.us.r-project.org, whatever packages were found not to be installed on the host machine
    if (length(unavailable) == length(packages)) {
      stop("The specified packages are not available on CRAN or have been spelt incorrectly")
    } else {
      userinput <-
        as.character(unlist(strsplit(
          x <-
            readline(
              "Some of the specified packages are not available on CRAN, or they names were spelt incorrectly. Should the remaining packages be installed regardless? (y = yes or n = no)"
            ),
          ","
        )))
      if (userinput == "y") {
        packages <- packages[!(packages %in% unavailable)]
      } else if (userinput = "n") {
        stop()
      } else {
        stop("Command not found. Aborting package loading.")
      }
    }
  }


  # check if any of the specified packages are not installed on the host machine
  if (length(new <-
             packages[!(packages %in% installed.packages()[, "Package"])])) {
    # install, from http://cran.us.r-project.org, whatever packages were found not to be installed on the host machine
    install.packages(new, repos =
                       'http://cran.us.r-project.org')
  }

  # load specified packages and output status of package loading
  sapply(packages, require, character.only = T)
}
