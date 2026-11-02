-- Schema DDL
CREATE TABLE "genre" ("g_name" TEXT(20) PRIMARY KEY, "rating" TEXT(10), "most_popular_in" TEXT(50));

CREATE TABLE "artist" ("artist_name" TEXT(50) PRIMARY KEY, "preferred_genre" TEXT(50), "country" TEXT(20), "gender" TEXT(20), FOREIGN KEY ("preferred_genre") REFERENCES "genre" ("g_name"));

CREATE TABLE "files" ("f_id" REAL(10) PRIMARY KEY, "artist_name" TEXT(50), "file_size" TEXT(20), "duration" TEXT(20), "formats" TEXT(20), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

CREATE TABLE "song" ("song_name" TEXT(50) PRIMARY KEY, "genre_is" TEXT(20), "f_id" REAL(10), "artist_name" TEXT(50), "country" TEXT(20), "rating" REAL(10), "languages" TEXT(20), "releasedate" DATE, "resolution" REAL(10), FOREIGN KEY ("genre_is") REFERENCES "genre" ("g_name"), FOREIGN KEY ("f_id") REFERENCES "files" ("f_id"), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO genre (g_name, rating, most_popular_in) VALUES ('modern', '8', 'USA');
INSERT INTO genre (g_name, rating, most_popular_in) VALUES ('classical', '9', 'Austria');
INSERT INTO artist (artist_name, preferred_genre, country, gender) VALUES ('Artist_1', 'modern', 'USA', 'Female');
INSERT INTO artist (artist_name, preferred_genre, country, gender) VALUES ('Artist_2', 'classical', 'UK', 'Male');
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (1.0, 'Artist_1', '5MB', '3:30', 'mp3');
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (2.0, 'Artist_1', '4MB', '2:45', 'wav');
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (3.0, 'Artist_2', '6MB', '4:10', 'flac');
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (4.0, 'Artist_2', '7MB', '5:00', 'mp3');
INSERT INTO song (song_name, genre_is, f_id, artist_name, country, rating, languages, releasedate, resolution) VALUES ('Song_C', 'modern', 1.0, 'Artist_1', 'USA', 7.0, 'english', '2021-05-10', 480.0);
INSERT INTO song (song_name, genre_is, f_id, artist_name, country, rating, languages, releasedate, resolution) VALUES ('Song_A', 'modern', 2.0, 'Artist_2', 'France', 9.0, 'french', '2022-01-15', 720.0);
INSERT INTO song (song_name, genre_is, f_id, artist_name, country, rating, languages, releasedate, resolution) VALUES ('Song_B', 'classical', 3.0, 'Artist_1', 'UK', 5.0, 'english', '2020-08-20', 1080.0);
INSERT INTO song (song_name, genre_is, f_id, artist_name, country, rating, languages, releasedate, resolution) VALUES ('Song_D', 'classical', 4.0, 'Artist_2', 'France', 8.0, 'french', '2019-03-01', 360.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "song_name" FROM "song" WHERE ("genre_is" = 'modern' OR "languages" = 'english') ORDER BY song_name;

/*
Gold Result:
('Song_A',)
('Song_B',)
('Song_C',)
*/

-- Prediction Query
SELECT song_name FROM song WHERE genre_is = 'modern' OR languages = 'english';

/*
Prediction Result:
('Song_C',)
('Song_A',)
('Song_B',)
*/