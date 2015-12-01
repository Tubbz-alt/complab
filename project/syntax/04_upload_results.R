################################################################################
# Barcelona Graduate School of Economics
# Master's Degree in Data Science
################################################################################
# Project  : Computing Lab
# Script   : 04_upload_results.R
################################################################################
# Author   : Miquel Torrens, 2015.11.25
# Modified : Miquel Torrens, 2015.12.01
################################################################################
# source('/Users/miquel/Desktop/bgse/projects/complab/syntax/00_start.R')
# source(paste(SYNTAXDIR, '04_upload_results.R', sep = ''))
################################################################################

################################################################################
main.04 <- function() {
################################################################################
  # Print starting time
  bs <- begin.script(paste('[', PROJECT, '] 04_upload_results.R', sep = ''))

  # Read MySQL configuration file
  conf.file <- paste(INPUTDIR, 'mysql_conn.conf', sep = '')
  cat('MySQL configuration read from:', conf.file, '\n')
  conf <- readLines(conf.file, warn = FALSE)
  conf <- trim(strsplit(conf, ':'))
  user <- conf[[1]][2]
  pass <- conf[[2]][2]
  host <- conf[[3]][2]

  ##############################################################################
  # Get connection
  conn <- dbConnect(MySQL(), user, pass, dbname = 'omsong', host)
  cat('Connected to DB: omsong\n')
  ##############################################################################

  ##############################################################################
  # 5. Origin
  file <- paste(DATADIR, 'worldwide_prediction.RData', sep = '')
  production <- get(load(file = file)); cat('Loaded file:', file, '\n')

  # Little cleaning
  rownames(production) <- NULL
  colnames(production) <- c('country', 'fifties', 'sixties', 'seventies',
                            'eighties', 'nineties', 'zeroes', 'tens')

  # Write table on MySQL
  cat('Writing table: world_production... ')
  dbWriteTable(conn = conn,
               name = 'world_production',
               value = production,
               row.names = FALSE,
               #overwrite = TRUE)
               append = TRUE)
  ##############################################################################

  ##############################################################################
  # 6. Recommendations
  # Load the recommendations
  file <- paste(DATADIR, 'results_recommender.RData', sep = '')
  recom <- get(load(file = file)); cat('Loaded file:', file, '\n')

  # Add ID for the MySQL table
  ids <- paste(recom[, 'song_id'], recom[, 'recom_song_id'], sep = '_')
  cols <- c('song_recom_id', colnames(recom))
  recom <- cbind(ids, recom)
  colnames(recom) <- cols
  rownames(recom) <- NULL

  # Write tables on MySQL
  cat('Writing table: results_recommender... ')
  dbWriteTable(conn = conn,
               name = 'results_recommender',
               value = recom,
               row.names = FALSE,
               #overwrite = TRUE)
               append = TRUE)
  ##############################################################################

  ##############################################################################
  # End connection
  dbDisconnect(conn)
  cat('Disconnected from DB: omsong\n')
  ##############################################################################

  # End script
  end.script(begin = bs, end = Sys.time())
}
# END OF SCRIPT
