-- Schema DDL
CREATE TABLE "genre" ("g_name" TEXT(20) PRIMARY KEY, "rating" TEXT(10), "most_popular_in" TEXT(50));

CREATE TABLE "artist" ("artist_name" TEXT(50) PRIMARY KEY, "preferred_genre" TEXT(50), "country" TEXT(20), "gender" TEXT(20), FOREIGN KEY ("preferred_genre") REFERENCES "genre" ("g_name"));

CREATE TABLE "files" ("f_id" REAL(10) PRIMARY KEY, "artist_name" TEXT(50), "file_size" TEXT(20), "duration" TEXT(20), "formats" TEXT(20), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

CREATE TABLE "song" ("song_name" TEXT(50) PRIMARY KEY, "genre_is" TEXT(20), "f_id" REAL(10), "artist_name" TEXT(50), "country" TEXT(20), "rating" REAL(10), "languages" TEXT(20), "releasedate" DATE, "resolution" REAL(10), FOREIGN KEY ("genre_is") REFERENCES "genre" ("g_name"), FOREIGN KEY ("f_id") REFERENCES "files" ("f_id"), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests ties for global minimum rating across multiple non-english songs, order by song_name, and non-matching higher ratings.
-- Refutes mutants using LIMIT 1, wrong ordering (DESC or ordering by rating/f_id), MAX instead of MIN, or wrong comparison operators.
INSERT INTO "genre" ("g_name", "rating", "most_popular_in") VALUES ('rock', '9', 'UK');
INSERT INTO "genre" ("g_name", "rating", "most_popular_in") VALUES ('jazz', '7', 'FR');
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('Artist1', 'rock', 'UK', 'M');
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('Artist2', 'jazz', 'FR', 'F');
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (10.0, 'Artist1', '5MB', '3:30', 'wav');
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (20.0, 'Artist2', '6MB', '4:10', 'flac');
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Zeta_Song', 'rock', 10.0, 'Artist1', 'ES', 2.5, 'spanish', '2021-05-01', 128.0);
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Alpha_Song', 'jazz', 20.0, 'Artist2', 'DE', 2.5, 'german', '2019-03-15', 256.0);
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Beta_English', 'rock', 10.0, 'Artist1', 'UK', 2.5, 'english', '2020-07-20', 320.0);
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Gamma_High', 'jazz', 20.0, 'Artist2', 'IT', 8.0, 'italian', '2022-01-10', 320.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "song_name" FROM (SELECT "song_name", "artist_name", "country", "f_id", "genre_is", "rating", "languages", "releasedate", "resolution", MIN("rating") OVER () AS "minrating" FROM "song") WHERE ("languages" <> 'english' AND minrating = rating) ORDER BY song_name, "song_name" NULLS LAST;

/*
Gold Result:
('Alpha_Song',)
('Zeta_Song',)
*/

-- Prediction Query
SELECT song_name FROM song WHERE rating < (SELECT MIN(rating) FROM song WHERE languages = 'english');

/*
Prediction Result:
*/