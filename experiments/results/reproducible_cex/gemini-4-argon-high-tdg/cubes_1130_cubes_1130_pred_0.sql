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
INSERT INTO genre (g_name, rating, most_popular_in) VALUES ('jazz', '7', 'France');
INSERT INTO artist (artist_name, preferred_genre, country, gender) VALUES ('Artist_One', 'rock', 'USA', 'Male');
INSERT INTO artist (artist_name, preferred_genre, country, gender) VALUES ('Artist_Two', 'pop', 'Canada', 'Female');
INSERT INTO artist (artist_name, preferred_genre, country, gender) VALUES ('Artist_Three', 'jazz', 'France', 'Male');
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (10.0, 'Artist_One', '4MB', '3:30', 'mp3');
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (20.0, 'Artist_One', '5MB', '4:10', 'wav');
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (30.0, 'Artist_Two', '3MB', '2:50', 'mp4');
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (40.0, 'Artist_Three', '6MB', '5:00', 'mp3');
INSERT INTO song (song_name, genre_is, f_id, artist_name, country, rating, languages, releasedate, resolution) VALUES ('Song_B', 'pop', 30.0, 'Artist_Two', 'UK', 9.5, 'english', '2021-05-10', 1080.0);
INSERT INTO song (song_name, genre_is, f_id, artist_name, country, rating, languages, releasedate, resolution) VALUES ('Song_C', 'rock', 10.0, 'Artist_One', 'USA', 6.0, 'english', '2019-01-15', 720.0);
INSERT INTO song (song_name, genre_is, f_id, artist_name, country, rating, languages, releasedate, resolution) VALUES ('Song_A', 'jazz', 20.0, 'Artist_One', 'Australia', 8.0, 'english', '2020-08-20', 480.0);
INSERT INTO song (song_name, genre_is, f_id, artist_name, country, rating, languages, releasedate, resolution) VALUES ('Song_D', 'rock', 40.0, 'Artist_Three', 'France', 7.5, 'french', '2018-11-01', 1080.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "song_name" FROM "song" WHERE ("languages" = 'english') ORDER BY song_name;

/*
Gold Result:
('Song_A',)
('Song_B',)
('Song_C',)
*/

-- Prediction Query
SELECT song_name FROM song WHERE languages = 'english';

/*
Prediction Result:
('Song_B',)
('Song_C',)
('Song_A',)
*/