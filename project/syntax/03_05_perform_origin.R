################################################################################
# Barcelona Graduate School of Economics
# Master's Degree in Data Science
################################################################################
# Project  : Computing Lab
# Script   : 03_05_perform_origin.R
################################################################################
# Author   : Name Surname, 2015.xx.xx
# Modified : -
################################################################################
# source('/Users/miquel/Desktop/bgse/projects/complab/syntax/00_start.R')
# source(paste(SYNTAXDIR, '03_05_perform_origin.R', sep = ''))
################################################################################

################################################################################
main.03.05 <- function() {
################################################################################
  # Print starting time
  bs <- begin.script(paste('[', PROJECT, '] 03_05_perform_origin.R', sep = ''))

  # Define new directories
  GEODIR <- paste(DATADIR, 'geo_json/', sep = '')
  MAPDIR <- paste(INPUTDIR, 'shp/', sep = '')
  try(dir.create(GEODIR, showWarnings = FALSE))
  try(dir.create(MAPDIR, showWarnings = FALSE))

  # Load data
  aux <- load(file = paste(DATADIR, 'song_metadata.RData', sep = ''))
  song.md <- get(aux[1])
  n <- nrow(song.md)
  fn <- format(n, big.mark = ',')

  locs <- song.md[, 'artist_location']
  locs <- iconv(locs, from = 'utf8', to = 'ASCII//TRANSLIT')

  new.locs <- vector(mode = 'list', length = nrow(song.md))
  for (i in 1:n) {
    fi <- format(i, big.mark = ',')
    cat('\rGetting location data:', fi, 'of', fn)
    loc <- locs[i]
    if (! is.na(loc) && loc != '') {
      id <- song.md[i, 'song_id']
      file <- paste(GEODIR, id, '.RData', sep = '')
      if (! file.exists(file)) {
        Sys.sleep(jitter(0.8, factor = 10))
        res <- google.geolocate(text = loc)
        save(res, file = file)
      } else {
        res <- get(load(file = file))
      }

      # Elements
      if (! res[['status']] %in% c('ZERO_RESULTS')) {
      #if (! res[['status']] %in% c('ZERO_RESULTS', 'UNKNOWN_ERROR')) {
        add <- unlist(res[['results']][[1]]['formatted_address'])
        lat <- unlist(res[['results']][[1]][['geometry']][['location']][1])
        lng <- unlist(res[['results']][[1]][['geometry']][['location']][2])
        typ <- unlist(res[['results']][[1]][['geometry']][['location_type']])
        new.loc <- c(id, add, lat, lng, typ)
      } else {
        new.loc <- c(id, rep(NA, 4))
      }
    } else {
      # Empty songs
      new.loc <- c(id, rep(NA, 4))
    }

    # Add them up
    new.locs[[i]] <- as.data.frame(t(as.data.frame(new.loc)))
    if (i == n) { cat(' [Done!]\n') }
  }

  new.locs <- as.data.frame(rbindlist(new.locs))


  #map <- readRDS(paste(INPUTDIR, 'USA_adm1.rds', sep = ''))


  #library(rgdal)
  #map <- readOGR(dsn = MAPDIR, layer = 'gadm28')
  #map <- readOGR(dsn = MAPDIR, layer = 'USA_adm1')
  #plot(map)







  # Find out which files need to be loaded
  NULL

  # End script
  end.script(begin = bs, end = Sys.time())
}
# END OF SCRIPT


