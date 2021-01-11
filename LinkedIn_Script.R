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

# Create a corpus  
docs <- Corpus(VectorSource(removed))

docs <- docs %>%
  tm_map(removeNumbers) %>%
  tm_map(removePunctuation) %>%
  tm_map(stripWhitespace)

docs <- tm_map(docs, content_transformer(tolower))
docs <- tm_map(docs, removeWords, stopwords("english"))

#Taken from 
###https://www.rdocumentation.org/packages/tm/versions/0.7-8/topics/Corpus

#Create the Bag of Word Model
dtm <- DocumentTermMatrix(docs)
dtm <- removeSparseTerms(dtm, 0.999)
dataset <- as.data.frame(as.matrix(dtm))
dataset <- as.matrix(dtm)

#Turn the Bag of Words into the count of the number of times words appear
v <- sort(colSums(dataset),decreasing=TRUE)
#This will get the  unique words in the Wordcloud
myNames <- names(v)
#Table of the words and the number of times they appear
d <-  data.frame(word=myNames,freq=v)

#Function to create the wordcloud
wordcloud(d$word,scale=c(4,.3), colors=c(6,4,3,2,1,10,11,12),random.color=FALSE, d$freq, min.freq=80)
