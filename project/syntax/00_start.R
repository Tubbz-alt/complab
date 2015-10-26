################################################################################
# Barcelona Graduate School of Economics
# Master's Degree in Data Science
################################################################################
# Project  : Computing Lab
# Script   : 00_start.R
################################################################################
# Author   : Miquel Torrens, 2015.10.18
# Modified : -
################################################################################
# source('/Users/miquel/Desktop/bgse/projects/complab/syntax/00_start.R')
################################################################################

################################################################################
# Root path
PATH <- '/Users/miquel/Desktop/bgse/projects/complab/'

# Project Name
PROJECT <- 'DS16T1.CL_PROJECT'
################################################################################

################################################################################
# Define relative Paths
DOCDIR <- paste(PATH, 'doc/', sep = '')
DATADIR <- paste(PATH, 'data/', sep = '')
TEMPDIR <- paste(PATH, 'temp/', sep = '')
INPUTDIR <- paste(PATH, 'input/', sep = '')
OUTPUTDIR <- paste(PATH, 'output/', sep = '')
SYNTAXDIR <- paste(PATH, 'syntax/', sep = '')
SCRIPTSDIR <- paste(SYNTAXDIR, 'scripts/', sep = '')

# Create them
try(dir.create(PATH, showWarnings = FALSE))
try(dir.create(DOCDIR, showWarnings = FALSE))
try(dir.create(DATADIR, showWarnings = FALSE))
try(dir.create(TEMPDIR, showWarnings = FALSE))
try(dir.create(INPUTDIR, showWarnings = FALSE))
try(dir.create(OUTPUTDIR, showWarnings = FALSE))
try(dir.create(SYNTAXDIR, showWarnings = FALSE))
try(dir.create(SCRIPTSDIR, showWarnings = FALSE))

# Project Index
source(paste(SYNTAXDIR, '00_index.R', sep = ''))
################################################################################

################################################################################
# Settings
# Check R version
check.version(dev.R = '3.2.1 x86_64')

# Print starting time
bs <- begin.script(script = paste('[', PROJECT, '] 00_start.R', sep = ''))

# Packages needed
load.packages(pkgs = c())

# Stone parameters
today <- format(Sys.time(), '%Y%m%d')

# Record
end.script(begin = bs, end = Sys.time()); rm(bs)
################################################################################
# END OF SCRIPT
