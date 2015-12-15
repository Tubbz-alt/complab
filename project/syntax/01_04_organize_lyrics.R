library(plyr)
#load in the lyrics data
load("./lyrics_data.RData")
#cut the top of the file, which is the description of the content
lyrics.head <- lyrics[1:18]
words <- unlist(strsplit(lyrics.head[18], ","))
words <- words[-1]
lyrics <- tail(lyrics, -18)

#this function takes a character vector about the lyrics of a song in a bag-of-words format
#where an element of a vector looks like this: "34:2"
#and spits out a data frame.
lyrics2df <- function(song){
  cbind(song[1], ldply(strsplit(song[-(1:2)], ":")))
}

lyrics <- sapply(lyrics, strsplit, ",") #splitting up the vectors by comma
names(lyrics) <- 1:length(lyrics) #getting rid of the ugly automaticly assigned names
song_ids <- sapply(lyrics, function(x) x[1]) #extracting track ids from the lyrics data

# #This is for unpacking the whole lyrics data set. Be careful, it is too big for a laptop!
# lyrics <- llply(lyrics, lyrics2df)
# lyrics <- do.call(rbind, lyrics)
# rownames(lyrics) <- NULL
# names(lyrics) <- c("song_id", "word_index", "word_count")

#I select the data which is 10000 sample.
load("./song_metadata.RData")
sample.index <- song_ids %in% song.md$track_id
sample.lyrics <- lyrics[sample.index]
rm(lyrics)

#Processing the the lyrics data to a nice format.
sample.lyrics <- llply(sample.lyrics, lyrics2df)
sample.lyrics <- do.call(rbind, sample.lyrics)
names(sample.lyrics) <- c("song_id", "word_index", "word_count")
sample.lyrics$word_index <- as.integer(sample.lyrics$word_index)
sample.lyrics$word_count <- as.integer(sample.lyrics$word_count)

#save the data
save(sample.lyrics, words, file="lyrics_p.RData")
