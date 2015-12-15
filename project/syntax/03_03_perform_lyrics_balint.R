library(RColorBrewer)
library(wordcloud)
library(plyr)
library(tidyr)


load("lyrics_p.RData")
load("song_metadata.RData")


#joining tables
sample.lyrics$word <- words[sample.lyrics$word_index]

#removing stop words
sample.lyrics <- sample.lyrics[!(sample.lyrics$word %in% stopwords()),]
sample.lyrics <- sample.lyrics[!(sample.lyrics$word %in% stopwords("german")),]
sample.lyrics <- sample.lyrics[!(sample.lyrics$word %in% stopwords("french")),]
sample.lyrics <- sample.lyrics[!(sample.lyrics$word %in% stopwords("spanish")),]
sample.lyrics <- sample.lyrics[!(sample.lyrics$word %in% stopwords("italian")),]

#frequency list for every (remaining) word)
all <- ddply(sample.lyrics, "word", summarise, freq=sum(word_count) )
ord <- order(all$freq)
all <- all[order(all$freq),]

#making wordcloud
png("wordcloud.png", width=800,height=800)
wordcloud(all$word, all$freq,  max.words=150, scale=c(8,1), colors=brewer.pal(8,"Dark2"))
dev.off()
# #big version for background
# png("wordcloud_big.png", width=3000,height=3000)
# wordcloud(all$word, all$freq, scale=c(16,2), max.words=500, colors=rgb(0.192, 0.545,1 ,0.25))
# dev.off()