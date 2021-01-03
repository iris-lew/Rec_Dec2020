# Make sure using correct working directory
getwd()
#Desired Working Directory if incorrect
###setwd("")

#Have all the packages listed at the top
####Plan is to eventually use the RLinkedIn package,
####but it doesn't seem to be able to take the recommendations from the profile now.

packages <- c("Rlinkedin","dplyr","tm", "tidytext","tau","tidyr")
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

#in.auth <- inOAuth() ##Not necessary right now because not using Rlinkedin API yet...

#Load in the raw data
rawdata <- read_excel("Recs.xlsx")

#list of common English stopwords
stop <- tm::stopwords("english")

#Remove the Stop Words
removed <- remove_stopwords(rawdata[,1],stop, lines=TRUE)
