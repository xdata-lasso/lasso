-- Schema DDL
CREATE TABLE "genre" ("g_name" TEXT(20) PRIMARY KEY, "rating" TEXT(10), "most_popular_in" TEXT(50));

CREATE TABLE "artist" ("artist_name" TEXT(50) PRIMARY KEY, "preferred_genre" TEXT(50), "country" TEXT(20), "gender" TEXT(20), FOREIGN KEY ("preferred_genre") REFERENCES "genre" ("g_name"));

CREATE TABLE "files" ("f_id" REAL(10) PRIMARY KEY, "artist_name" TEXT(50), "file_size" TEXT(20), "duration" TEXT(20), "formats" TEXT(20), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

CREATE TABLE "song" ("song_name" TEXT(50) PRIMARY KEY, "genre_is" TEXT(20), "f_id" REAL(10), "artist_name" TEXT(50), "country" TEXT(20), "rating" REAL(10), "languages" TEXT(20), "releasedate" DATE, "resolution" REAL(10), FOREIGN KEY ("genre_is") REFERENCES "genre" ("g_name"), FOREIGN KEY ("f_id") REFERENCES "files" ("f_id"), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO genre (g_name, rating, most_popular_in) VALUES ('Pop', '8', 'US');
INSERT INTO artist (artist_name, preferred_genre, country, gender) VALUES ('Artist1', 'Pop', 'US', 'M');
INSERT INTO artist (artist_name, preferred_genre, country, gender) VALUES ('Artist2', 'Pop', 'UK', 'F');
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (1.0, 'Artist1', '5MB', '3:00', NULL);
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (2.0, 'Artist1', '4MB', '2:30', NULL);
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (3.0, 'Artist1', '6MB', '4:00', 'mp3');
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (4.0, 'Artist2', '7MB', '3:30', 'mp3');
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (5.0, 'Artist2', '10MB', '5:00', 'wav');
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (6.0, 'Artist2', '12MB', '4:30', 'wav');
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (7.0, 'Artist1', '15MB', '3:45', 'flac');
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (8.0, 'Artist2', '20MB', '4:10', 'aac');
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (9.0, 'Artist1', '22MB', '4:20', 'aac');
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (10.0, 'Artist2', '25MB', '4:50', 'aac');
INSERT INTO song (song_name, genre_is, f_id, artist_name, country, rating, languages, releasedate, resolution) VALUES ('Song1', 'Pop', 3.0, 'Artist1', 'US', 5.0, 'English', '2020-01-01', 320.0);
INSERT INTO song (song_name, genre_is, f_id, artist_name, country, rating, languages, releasedate, resolution) VALUES ('Song2', 'Pop', 3.0, 'Artist1', 'US', 4.0, 'English', '2020-01-02', 320.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, formats FROM (SELECT formats, COUNT(*) AS n FROM files GROUP BY formats) ORDER BY count___, formats NULLS LAST;

/*
Gold Result:
(1, 'flac')
(2, 'mp3')
(2, 'wav')
(2, None)
(3, 'aac')
*/

-- Prediction Query
SELECT COUNT(*), formats FROM files GROUP BY formats;

/*
Prediction Result:
(2, None)
(3, 'aac')
(1, 'flac')
(2, 'mp3')
(2, 'wav')
*/