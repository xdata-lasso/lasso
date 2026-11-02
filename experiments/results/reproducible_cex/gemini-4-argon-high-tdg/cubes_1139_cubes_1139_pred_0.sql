-- Schema DDL
CREATE TABLE "genre" ("g_name" TEXT(20) PRIMARY KEY, "rating" TEXT(10), "most_popular_in" TEXT(50));

CREATE TABLE "artist" ("artist_name" TEXT(50) PRIMARY KEY, "preferred_genre" TEXT(50), "country" TEXT(20), "gender" TEXT(20), FOREIGN KEY ("preferred_genre") REFERENCES "genre" ("g_name"));

CREATE TABLE "files" ("f_id" REAL(10) PRIMARY KEY, "artist_name" TEXT(50), "file_size" TEXT(20), "duration" TEXT(20), "formats" TEXT(20), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

CREATE TABLE "song" ("song_name" TEXT(50) PRIMARY KEY, "genre_is" TEXT(20), "f_id" REAL(10), "artist_name" TEXT(50), "country" TEXT(20), "rating" REAL(10), "languages" TEXT(20), "releasedate" DATE, "resolution" REAL(10), FOREIGN KEY ("genre_is") REFERENCES "genre" ("g_name"), FOREIGN KEY ("f_id") REFERENCES "files" ("f_id"), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO genre (g_name, rating, most_popular_in) VALUES ('Jazz', '7', 'France');
INSERT INTO artist (artist_name, preferred_genre, country, gender) VALUES ('Charlie', 'Jazz', 'France', 'Male');
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (10.0, NULL, NULL, NULL, NULL);
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (20.0, 'Charlie', '6MB', '2:45', 'wav');
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (30.0, NULL, NULL, NULL, 'mp3');
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (40.0, 'Charlie', '4MB', '1:50', 'aac');
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (50.0, NULL, '4MB', '1:50', 'aac');
INSERT INTO song (song_name, genre_is, f_id, artist_name, country, rating, languages, releasedate, resolution) VALUES ('JazzTune', 'Jazz', 20.0, 'Charlie', 'France', 8.0, 'French', '2019-05-10', 256.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, formats FROM (SELECT formats, COUNT(*) AS n FROM files GROUP BY formats) ORDER BY count___, formats NULLS LAST;

/*
Gold Result:
(1, 'mp3')
(1, 'wav')
(1, None)
(2, 'aac')
*/

-- Prediction Query
SELECT COUNT(*), formats FROM files GROUP BY formats;

/*
Prediction Result:
(1, None)
(2, 'aac')
(1, 'mp3')
(1, 'wav')
*/