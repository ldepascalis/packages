# Some useful keyboard shortcuts for package authoring:
#
#   Build and Reload Package:  'Ctrl + Shift + B'
#   Check Package:             'Ctrl + Shift + E'
#   Test Package:              'Ctrl + Shift + T'

packages <- function(packages) {
  if (length(new <-
             packages[!(packages %in% installed.packages()[, "Package"])])) {
    install.packages(new[!(new %in% installed.packages()[, "Package"])])
  }
  sapply(packages, require, character.only = T)
}
