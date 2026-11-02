-- Schema DDL
CREATE TABLE "genre" ("g_name" TEXT(20) PRIMARY KEY, "rating" TEXT(10), "most_popular_in" TEXT(50));

CREATE TABLE "artist" ("artist_name" TEXT(50) PRIMARY KEY, "preferred_genre" TEXT(50), "country" TEXT(20), "gender" TEXT(20), FOREIGN KEY ("preferred_genre") REFERENCES "genre" ("g_name"));

CREATE TABLE "files" ("f_id" REAL(10) PRIMARY KEY, "artist_name" TEXT(50), "file_size" TEXT(20), "duration" TEXT(20), "formats" TEXT(20), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

CREATE TABLE "song" ("song_name" TEXT(50) PRIMARY KEY, "genre_is" TEXT(20), "f_id" REAL(10), "artist_name" TEXT(50), "country" TEXT(20), "rating" REAL(10), "languages" TEXT(20), "releasedate" DATE, "resolution" REAL(10), FOREIGN KEY ("genre_is") REFERENCES "genre" ("g_name"), FOREIGN KEY ("f_id") REFERENCES "files" ("f_id"), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO genre (g_name, rating, most_popular_in) VALUES ('Rock', '8', 'USA');
INSERT INTO genre (g_name, rating, most_popular_in) VALUES ('Jazz', '9', 'France');
INSERT INTO genre (g_name, rating, most_popular_in) VALUES ('Pop', '7', 'UK');
INSERT INTO genre (g_name, rating, most_popular_in) VALUES ('Blues', '10', 'Canada');
INSERT INTO artist (artist_name, preferred_genre, country, gender) VALUES ('Artist D', 'Rock', 'USA', 'Male');
INSERT INTO artist (artist_name, preferred_genre, country, gender) VALUES ('Artist A', 'Jazz', 'France', 'Female');
INSERT INTO artist (artist_name, preferred_genre, country, gender) VALUES ('Artist C', 'Pop', 'UK', 'Male');
INSERT INTO artist (artist_name, preferred_genre, country, gender) VALUES ('Artist B', 'Blues', 'Canada', 'Female');
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (30.0, 'Artist A', '4MB', '3:30', 'mp3');
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (10.0, 'Artist B', '5MB', '4:10', 'wav');
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (40.0, 'Artist C', '3MB', '2:50', 'flac');
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (20.0, 'Artist D', '6MB', '5:00', 'aac');
INSERT INTO song (song_name, genre_is, f_id, artist_name, country, rating, languages, releasedate, resolution) VALUES ('Echo', 'Pop', 20.0, 'Artist B', 'UK', 7.5, 'English', '2021-05-10', 320.0);
INSERT INTO song (song_name, genre_is, f_id, artist_name, country, rating, languages, releasedate, resolution) VALUES ('Alpha', 'Rock', 30.0, 'Artist C', 'USA', 9.0, 'Spanish', '2022-01-15', 192.0);
INSERT INTO song (song_name, genre_is, f_id, artist_name, country, rating, languages, releasedate, resolution) VALUES ('Delta', 'Blues', 10.0, 'Artist A', 'Canada', 6.0, 'French', '2019-11-20', 256.0);
INSERT INTO song (song_name, genre_is, f_id, artist_name, country, rating, languages, releasedate, resolution) VALUES ('Bravo', 'Jazz', 40.0, 'Artist D', 'France', 8.5, 'German', '2020-08-05', 128.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT song_name FROM song ORDER BY song_name;

/*
Gold Result:
('Alpha',)
('Bravo',)
('Delta',)
('Echo',)
*/

-- Prediction Query
SELECT song_name FROM song ORDER BY resolution, song.song_name NULLS LAST;

/*
Prediction Result:
('Bravo',)
('Alpha',)
('Delta',)
('Echo',)
*/