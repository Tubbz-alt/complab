################################################################################
# Barcelona Graduate School of Economics
# Master's Degree in Data Science
################################################################################
# Project  : Computing Lab
# Script   : 00_index.R
################################################################################
# Author   : Miquel Torrens, 2015.10.18
# Modified : Miquel Torrens, 2015.11.15
################################################################################
# source('/Users/miquel/Desktop/bgse/projects/complab/syntax/00_start.R')
################################################################################

################################################################################
# Generic
source(paste(SCRIPTSDIR, 'functions_generic.R', sep = ''))
################################################################################

################################################################################
# Load full scripts
# Read raw data
source(paste(SYNTAXDIR, '01_01_load_raw.R', sep = ''))
source(paste(SYNTAXDIR, '01_02_load_usage.R', sep = ''))
source(paste(SYNTAXDIR, '01_03_organize.R', sep = ''))

# SQL Data upload
source(paste(SYNTAXDIR, '02_upload_sql.R', sep = ''))

# Perform analytics
source(paste(SYNTAXDIR, '03_01_perform_genre.R', sep = ''))
source(paste(SYNTAXDIR, '03_02_perform_evolution.R', sep = ''))
source(paste(SYNTAXDIR, '03_03_perform_lyrics.R', sep = ''))
source(paste(SYNTAXDIR, '03_04_perform_popularity.R', sep = ''))
source(paste(SYNTAXDIR, '03_05_perform_origin.R', sep = ''))
source(paste(SYNTAXDIR, '03_06_perform_recommender.R', sep = ''))

# SQL Results upload
source(paste(SYNTAXDIR, '04_upload_results.R', sep = ''))

# Read results from app
source(paste(SYNTAXDIR, '05_read_results.R', sep = ''))
################################################################################

################################################################################
# Execute if necessary
if (length(args) == 1) { args <- c(args, 'empty') }
if (length(args) == 2) { args <- c(args, 'empty') }
f0101a <- paste(DATADIR, 'song_database.RData', sep = '')
f0102a <- paste(DATADIR, 'lyrics_data.RData', sep = '')
f0102b <- paste(DATADIR, 'usage_data.RData', sep = '')
f0103a <- paste(DATADIR, 'song_metadata.RData', sep = '')
f0103b <- paste(DATADIR, 'song_analysis.RData', sep = '')
f0103c <- paste(DATADIR, 'song_guide.RData', sep = '')

if (args[2] == 'install') {
  if (args[3] == 'force' || ! file.exists(f0101a)) { main.01.01() }
  if (args[3] == 'force' || ! file.exists(f0102a)) { main.01.02() }
  if (args[3] == 'force' || ! file.exists(f0103a)) { main.01.03() }
  if (args[3] == 'force') { main.02() }
} else if (args[2] == 'analysis') {
  main.03.01()
  main.03.02()
  main.03.03()
  main.03.04()
  main.03.05()
  main.03.06()
  main.04()
} else if (args[2] == 'run') {
  main.05()
}
################################################################################
# END OF SCRIPT
