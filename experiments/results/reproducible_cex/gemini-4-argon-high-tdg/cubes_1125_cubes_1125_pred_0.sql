-- Schema DDL
CREATE TABLE "genre" ("g_name" TEXT(20) PRIMARY KEY, "rating" TEXT(10), "most_popular_in" TEXT(50));

CREATE TABLE "artist" ("artist_name" TEXT(50) PRIMARY KEY, "preferred_genre" TEXT(50), "country" TEXT(20), "gender" TEXT(20), FOREIGN KEY ("preferred_genre") REFERENCES "genre" ("g_name"));

CREATE TABLE "files" ("f_id" REAL(10) PRIMARY KEY, "artist_name" TEXT(50), "file_size" TEXT(20), "duration" TEXT(20), "formats" TEXT(20), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

CREATE TABLE "song" ("song_name" TEXT(50) PRIMARY KEY, "genre_is" TEXT(20), "f_id" REAL(10), "artist_name" TEXT(50), "country" TEXT(20), "rating" REAL(10), "languages" TEXT(20), "releasedate" DATE, "resolution" REAL(10), FOREIGN KEY ("genre_is") REFERENCES "genre" ("g_name"), FOREIGN KEY ("f_id") REFERENCES "files" ("f_id"), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO genre (g_name, rating, most_popular_in) VALUES ('rock', '8', 'USA');
INSERT INTO genre (g_name, rating, most_popular_in) VALUES ('pop', '9', 'UK');
INSERT INTO artist (artist_name, preferred_genre, country, gender) VALUES ('Artist_C', 'rock', 'USA', 'Male');
INSERT INTO artist (artist_name, preferred_genre, country, gender) VALUES ('Artist_A', 'pop', 'UK', 'Female');
INSERT INTO artist (artist_name, preferred_genre, country, gender) VALUES ('Artist_B', 'rock', 'Canada', 'Male');
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (10.0, 'Artist_A', '10MB', '02:00', 'mp3');
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (3.0, 'Artist_B', '50MB', '01:00', 'wav');
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (2.0, 'Artist_C', '30MB', '04:00', 'mp3');
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (5.5, NULL, '20MB', '05:00', 'mp3');
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (-1.0, 'Artist_B', '40MB', '03:00', 'mp3');
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (7.0, 'Artist_A', '15MB', '03:30', NULL);
INSERT INTO song (song_name, genre_is, f_id, artist_name, country, rating, languages, releasedate, resolution) VALUES ('Song_1', 'pop', 10.0, 'Artist_A', 'UK', 4.5, 'English', '2020-01-01', 320.0);
INSERT INTO song (song_name, genre_is, f_id, artist_name, country, rating, languages, releasedate, resolution) VALUES ('Song_2', 'rock', 10.0, 'Artist_A', 'UK', 4.0, 'English', '2020-02-01', 320.0);
INSERT INTO song (song_name, genre_is, f_id, artist_name, country, rating, languages, releasedate, resolution) VALUES ('Song_3', 'rock', 3.0, 'Artist_B', 'Canada', 3.5, 'English', '2021-01-01', 1411.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "f_id" FROM "files" WHERE ("formats" = 'mp3') ORDER BY f_id;

/*
Gold Result:
(-1.0,)
(2.0,)
(5.5,)
(10.0,)
*/

-- Prediction Query
SELECT f_id FROM files WHERE formats = 'mp3';

/*
Prediction Result:
(10.0,)
(2.0,)
(5.5,)
(-1.0,)
*/