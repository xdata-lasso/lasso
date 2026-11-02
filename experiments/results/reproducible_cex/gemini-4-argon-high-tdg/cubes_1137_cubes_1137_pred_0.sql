-- Schema DDL
CREATE TABLE "genre" ("g_name" TEXT(20) PRIMARY KEY, "rating" TEXT(10), "most_popular_in" TEXT(50));

CREATE TABLE "artist" ("artist_name" TEXT(50) PRIMARY KEY, "preferred_genre" TEXT(50), "country" TEXT(20), "gender" TEXT(20), FOREIGN KEY ("preferred_genre") REFERENCES "genre" ("g_name"));

CREATE TABLE "files" ("f_id" REAL(10) PRIMARY KEY, "artist_name" TEXT(50), "file_size" TEXT(20), "duration" TEXT(20), "formats" TEXT(20), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

CREATE TABLE "song" ("song_name" TEXT(50) PRIMARY KEY, "genre_is" TEXT(20), "f_id" REAL(10), "artist_name" TEXT(50), "country" TEXT(20), "rating" REAL(10), "languages" TEXT(20), "releasedate" DATE, "resolution" REAL(10), FOREIGN KEY ("genre_is") REFERENCES "genre" ("g_name"), FOREIGN KEY ("f_id") REFERENCES "files" ("f_id"), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO genre (g_name, rating, most_popular_in) VALUES ('Rock', '8', 'USA');
INSERT INTO genre (g_name, rating, most_popular_in) VALUES ('Pop', '9', 'UK');
INSERT INTO artist (artist_name, preferred_genre, country, gender) VALUES ('Artist_M1', 'Rock', 'USA', 'Male');
INSERT INTO artist (artist_name, preferred_genre, country, gender) VALUES ('Artist_O1', 'Pop', 'UK', 'Other');
INSERT INTO artist (artist_name, preferred_genre, country, gender) VALUES ('Artist_O2', NULL, NULL, 'Other');
INSERT INTO artist (artist_name, preferred_genre, country, gender) VALUES ('Artist_N1', 'Rock', 'USA', NULL);
INSERT INTO artist (artist_name, preferred_genre, country, gender) VALUES ('Artist_N2', NULL, 'USA', NULL);
INSERT INTO artist (artist_name, preferred_genre, country, gender) VALUES ('Artist_NB1', 'Pop', 'Canada', 'Non-binary');
INSERT INTO artist (artist_name, preferred_genre, country, gender) VALUES ('Artist_NB2', 'Pop', 'Canada', 'Non-binary');
INSERT INTO artist (artist_name, preferred_genre, country, gender) VALUES ('Artist_F1', 'Rock', 'USA', 'Female');
INSERT INTO artist (artist_name, preferred_genre, country, gender) VALUES ('Artist_F2', 'Rock', 'USA', 'Female');
INSERT INTO artist (artist_name, preferred_genre, country, gender) VALUES ('Artist_F3', NULL, NULL, 'Female');
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (1.0, 'Artist_M1', '5MB', '3:00', 'mp3');
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (2.0, 'Artist_M1', '6MB', '3:30', 'wav');
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (3.0, 'Artist_F1', '4MB', '2:45', 'mp3');
INSERT INTO song (song_name, genre_is, f_id, artist_name, country, rating, languages, releasedate, resolution) VALUES ('Song_1', 'Rock', 1.0, 'Artist_M1', 'USA', 4.5, 'English', '2020-01-01', 320.0);
INSERT INTO song (song_name, genre_is, f_id, artist_name, country, rating, languages, releasedate, resolution) VALUES ('Song_2', 'Rock', 2.0, 'Artist_M1', 'USA', 4.0, 'English', '2020-02-01', 320.0);
INSERT INTO song (song_name, genre_is, f_id, artist_name, country, rating, languages, releasedate, resolution) VALUES ('Song_3', 'Pop', 3.0, 'Artist_F1', 'USA', 5.0, 'English', '2021-01-01', 256.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, gender FROM (SELECT gender, COUNT(*) AS n FROM artist GROUP BY gender) ORDER BY count___, gender NULLS LAST;

/*
Gold Result:
(1, 'Male')
(2, 'Non-binary')
(2, 'Other')
(2, None)
(3, 'Female')
*/

-- Prediction Query
SELECT COUNT(*), gender FROM artist GROUP BY gender;

/*
Prediction Result:
(2, None)
(3, 'Female')
(1, 'Male')
(2, 'Non-binary')
(2, 'Other')
*/