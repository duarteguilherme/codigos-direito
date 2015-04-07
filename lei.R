library(tm)
library(SnowballC)

setwd('Leis/')

docs <- Corpus(DirSource('./txt/'))

toSpace <- content_transformer(function(x, pattern) gsub(pattern, " ", x))

docs <- tm_map(docs, toSpace, "/|@|\\|")

docs <- tm_map(docs, content_transformer(tolower))

docs <- tm_map(docs, removeNumbers)
docs <- tm_map(docs, removePunctuation)
docs <- tm_map(docs, removeWords, stopwords("portuguese"))
docs <- tm_map(docs, removeWords, c("artigo", "inciso", "parágrafo", "§", "º",
                                    "ª", "lei", "direito", "art", "ser","emenda", "part", "iii",
                                    "sobre", "poderá", "único"))


docs <- tm_map(docs, stemDocument, language = "portuguese")

docs <- tm_map(docs, stripWhitespace)

dtm <- DocumentTermMatrix(docs)

freq <- colSums(as.matrix(dtm))

ord <- order(freq)

freq[tail(ord, 20)]

dtms <- removeSparseTerms(dtm, 0.1)


findFreqTerms(dtm, lowfreq=100)


findAssocs(dtm, "juiz", corlimit=0.95)


install.packages("topicmodels")