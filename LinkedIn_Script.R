# Make sure using correct working directory
getwd()
#Desired Working Directory if incorrect
###setwd("")

#Have all the packages listed at the top
####Plan is to eventually use the RLinkedIn package, but necessary now.

packages <- c("Rlinkedin")
#Load and install the packages (if not already installed)
packages.check <- lapply (
  packages,
  FUN = function (x) {
    if (!require(x,character.only = TRUE)) {
      install.packages(x, dependencies = TRUE)
      require(x, character.only = TRUE)
    }
  } 
)

in.auth <- inOAuth()
