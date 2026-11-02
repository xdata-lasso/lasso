-- Schema DDL
CREATE TABLE "genre" ("g_name" TEXT(20) PRIMARY KEY, "rating" TEXT(10), "most_popular_in" TEXT(50));

CREATE TABLE "artist" ("artist_name" TEXT(50) PRIMARY KEY, "preferred_genre" TEXT(50), "country" TEXT(20), "gender" TEXT(20), FOREIGN KEY ("preferred_genre") REFERENCES "genre" ("g_name"));

CREATE TABLE "files" ("f_id" REAL(10) PRIMARY KEY, "artist_name" TEXT(50), "file_size" TEXT(20), "duration" TEXT(20), "formats" TEXT(20), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

CREATE TABLE "song" ("song_name" TEXT(50) PRIMARY KEY, "genre_is" TEXT(20), "f_id" REAL(10), "artist_name" TEXT(50), "country" TEXT(20), "rating" REAL(10), "languages" TEXT(20), "releasedate" DATE, "resolution" REAL(10), FOREIGN KEY ("genre_is") REFERENCES "genre" ("g_name"), FOREIGN KEY ("f_id") REFERENCES "files" ("f_id"), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO genre (g_name, rating, most_popular_in) VALUES ('Indie', '7.0', 'Sweden');
INSERT INTO artist (artist_name, preferred_genre, country, gender) VALUES ('Coldplay', 'Indie', 'UK', 'Male');
INSERT INTO artist (artist_name, preferred_genre, country, gender) VALUES ('Beatles', 'Indie', 'UK', 'Male');
INSERT INTO artist (artist_name, preferred_genre, country, gender) VALUES ('Abba', 'Indie', 'Sweden', 'Female');
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (10.0, 'Coldplay', '4MB', '4:00', 'mp3');
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (11.0, 'Beatles', '3MB', '2:30', 'mp3');
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (12.0, 'Abba', '5MB', '3:50', 'mp3');
INSERT INTO song (song_name, genre_is, f_id, artist_name, country, rating, languages, releasedate, resolution) VALUES ('Track_A', 'Indie', 10.0, 'Coldplay', 'UK', 5.0, 'english', '2015-01-01', 320.0);
INSERT INTO song (song_name, genre_is, f_id, artist_name, country, rating, languages, releasedate, resolution) VALUES ('Track_B', 'Indie', 10.0, 'Coldplay', 'UK', 8.0, 'english', '2016-01-01', 320.0);
INSERT INTO song (song_name, genre_is, f_id, artist_name, country, rating, languages, releasedate, resolution) VALUES ('Track_C', 'Indie', 10.0, 'Coldplay', 'UK', 8.5, 'english', '2017-01-01', 320.0);
INSERT INTO song (song_name, genre_is, f_id, artist_name, country, rating, languages, releasedate, resolution) VALUES ('Track_D', 'Indie', 11.0, 'Beatles', 'UK', 8.0, 'english', '1968-01-01', 256.0);
INSERT INTO song (song_name, genre_is, f_id, artist_name, country, rating, languages, releasedate, resolution) VALUES ('Track_E', 'Indie', 11.0, 'Beatles', 'UK', 6.5, 'english', '1969-01-01', 256.0);
INSERT INTO song (song_name, genre_is, f_id, artist_name, country, rating, languages, releasedate, resolution) VALUES ('Track_F', 'Indie', 12.0, 'Abba', 'Sweden', 7.2, 'english', '1976-01-01', 320.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "artist_name" FROM "song" WHERE ("languages" = 'english' AND rating <= 8.0) ORDER BY artist_name, song.song_name NULLS LAST;

/*
Gold Result:
('Abba',)
('Beatles',)
('Beatles',)
('Coldplay',)
('Coldplay',)
*/

-- Prediction Query
SELECT DISTINCT artist_name FROM song WHERE languages = 'english' EXCEPT SELECT DISTINCT artist_name FROM song WHERE rating > 8;

/*
Prediction Result:
('Abba',)
('Beatles',)
*/