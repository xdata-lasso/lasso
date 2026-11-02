-- Schema DDL
CREATE TABLE "genre" ("g_name" TEXT(20) PRIMARY KEY, "rating" TEXT(10), "most_popular_in" TEXT(50));

CREATE TABLE "artist" ("artist_name" TEXT(50) PRIMARY KEY, "preferred_genre" TEXT(50), "country" TEXT(20), "gender" TEXT(20), FOREIGN KEY ("preferred_genre") REFERENCES "genre" ("g_name"));

CREATE TABLE "files" ("f_id" REAL(10) PRIMARY KEY, "artist_name" TEXT(50), "file_size" TEXT(20), "duration" TEXT(20), "formats" TEXT(20), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

CREATE TABLE "song" ("song_name" TEXT(50) PRIMARY KEY, "genre_is" TEXT(20), "f_id" REAL(10), "artist_name" TEXT(50), "country" TEXT(20), "rating" REAL(10), "languages" TEXT(20), "releasedate" DATE, "resolution" REAL(10), FOREIGN KEY ("genre_is") REFERENCES "genre" ("g_name"), FOREIGN KEY ("f_id") REFERENCES "files" ("f_id"), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "genre" ("g_name", "rating", "most_popular_in") VALUES ('pop', '1', 'France');
INSERT INTO "genre" ("g_name", "rating", "most_popular_in") VALUES ('rock', '5', 'UK');
INSERT INTO "genre" ("g_name", "rating", "most_popular_in") VALUES ('latin', '9', 'Spain');
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('Artist1', 'pop', 'France', 'Female');
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('Artist2', 'rock', 'UK', 'Male');
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('Artist3', 'latin', 'Spain', 'Female');
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (1.0, 'Artist1', '3MB', '3:00', 'mp3');
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (2.0, 'Artist2', '4MB', '3:30', 'wav');
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (3.0, 'Artist3', '5MB', '4:00', 'flac');
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('A_Chanson', 'pop', 1.0, 'Artist1', 'France', 10.0, 'french', '2020-01-01', 100.0);
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('M_Anthem', 'rock', 2.0, 'Artist2', 'UK', 2.5, 'english', '2021-01-01', 500.0);
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Z_Cancion', 'latin', 3.0, 'Artist3', 'Spain', 2.5, 'spanish', '2022-01-01', 1000.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "song_name" FROM (SELECT "song_name", "artist_name", "country", "f_id", "genre_is", "rating", "languages", "releasedate", "resolution", MIN("rating") OVER () AS "minrating" FROM "song") WHERE ("languages" <> 'english' AND minrating = rating) ORDER BY song_name, "song_name" NULLS LAST;

/*
Gold Result:
('Z_Cancion',)
*/

-- Prediction Query
SELECT song_name FROM song WHERE rating < (SELECT MIN(rating) FROM song WHERE languages = 'english');

/*
Prediction Result:
*/