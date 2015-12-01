-- -----------------------------------------------------------------------------
-- Barcelona Graduate School of Economics
-- Master's Degree in Data Science
-- -----------------------------------------------------------------------------
-- Project  : Computing Lab
-- Script   : results_framework.sql
-- -----------------------------------------------------------------------------
-- Author   : Miquel Torrens, 2015.11.25
-- Modified : Miquel Torrens, 2015.12.01
-- -----------------------------------------------------------------------------

USE omsong;

-- Create table with recommender results
DROP TABLE IF EXISTS results_recommender;
CREATE TABLE results_recommender (
  song_recom_id VARCHAR(37),
  song_id VARCHAR(18),
  artist_id VARCHAR(18),
  title TEXT,
  artist_name TEXT,
  release_name TEXT,
  recom_song_id VARCHAR(18),
  recom_artist_id VARCHAR(18),
  recom_title TEXT,
  recom_artist_name TEXT,
  recom_release_name TEXT,
  rank TINYINT(1),
  PRIMARY KEY (song_id)
);

DROP TABLE IF EXISTS world_production;
CREATE TABLE world_production (
  country VARCHAR(32),
  fifties DECIMAL(4, 2),
  sixties DECIMAL(4, 2),
  seventies DECIMAL(4, 2),
  eighties DECIMAL(4, 2),
  nineties DECIMAL(4, 2),
  zeroes DECIMAL(4, 2),
  tens DECIMAL(4, 2),
  PRIMARY KEY (country)
);

-- Create indexes
-- Song ID
CREATE INDEX idxr1_song_id ON results_recommender (song_id);

-- Artist ID
CREATE INDEX idxr1_artist_id ON results_recommender (artist_id);

-- Rest of IDs
CREATE INDEX idxr_song_recom_id ON results_recommender (song_recom_id);
CREATE INDEX idx_country ON world_production (country);
-- END OF SCRIPT
