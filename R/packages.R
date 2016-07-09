#' Package Loading
#'
#' This function loads specified R packages, after having made sure they are installed.
#' @param packages A string or string vector with the names of the packages to load..
#' @keywords packages
#' @export
#' @examples
#' packages(packages = "lme4")

packages <- function(packages) {
  # check packages is a string or a string vector
  if (!is.character(packages)) {
    stop("packages must be a string or a string vector")
  }

  # check specified packages are available from http://cran.us.r-project.org
  if (length(unavailable <-
             packages[!(packages %in% available.packages(repos = 'https://cloud.r-project.org/')[, "Package"])])) {
    # install, from http://cran.us.r-project.org, whatever packages were found not to be installed on the host machine
    if (length(unavailable) == length(packages)) {
      stop("The specified packages are not correct/available on CRAN")
    } else {
      userinput <-
        as.character(unlist(strsplit(
          userinput <-
            readline(
              "Not all the packages correct/available on CRAN.\nInstall remaining ones?\n(y = yes or n = no)"
            ),
          ","
        )))
      if (userinput == "y") {
        packages <- packages[!(packages %in% unavailable)]
      } else if (userinput == "n") {
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
