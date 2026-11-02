-- Schema DDL
CREATE TABLE "genre" ("g_name" TEXT(20) PRIMARY KEY, "rating" TEXT(10), "most_popular_in" TEXT(50));

CREATE TABLE "artist" ("artist_name" TEXT(50) PRIMARY KEY, "preferred_genre" TEXT(50), "country" TEXT(20), "gender" TEXT(20), FOREIGN KEY ("preferred_genre") REFERENCES "genre" ("g_name"));

CREATE TABLE "files" ("f_id" REAL(10) PRIMARY KEY, "artist_name" TEXT(50), "file_size" TEXT(20), "duration" TEXT(20), "formats" TEXT(20), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

CREATE TABLE "song" ("song_name" TEXT(50) PRIMARY KEY, "genre_is" TEXT(20), "f_id" REAL(10), "artist_name" TEXT(50), "country" TEXT(20), "rating" REAL(10), "languages" TEXT(20), "releasedate" DATE, "resolution" REAL(10), FOREIGN KEY ("genre_is") REFERENCES "genre" ("g_name"), FOREIGN KEY ("f_id") REFERENCES "files" ("f_id"), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO genre (g_name, rating, most_popular_in) VALUES ('Pop', 'High', 'USA');
INSERT INTO genre (g_name, rating, most_popular_in) VALUES ('Rock', 'Medium', 'UK');
INSERT INTO artist (artist_name, preferred_genre, country, gender) VALUES ('Artist_A', 'Pop', 'USA', 'M');
INSERT INTO artist (artist_name, preferred_genre, country, gender) VALUES ('Artist_B', 'Rock', 'UK', 'F');
INSERT INTO artist (artist_name, preferred_genre, country, gender) VALUES ('Artist_C', 'Pop', 'Canada', 'M');
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (1.0, 'Artist_A', '5MB', '3:00', 'mp3');
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (2.0, 'Artist_B', '6MB', '4:00', 'wav');
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (3.0, 'Artist_C', '7MB', '3:30', 'flac');
INSERT INTO song (song_name, genre_is, f_id, artist_name, country, rating, languages, releasedate, resolution) VALUES ('Song_1', 'Pop', 1.0, 'Artist_A', 'USA', 950.0, 'English', '2020-01-01', 900.0);
INSERT INTO song (song_name, genre_is, f_id, artist_name, country, rating, languages, releasedate, resolution) VALUES ('Song_2', 'Pop', 1.0, 'Artist_A', 'USA', 800.0, 'English', '2020-01-02', 900.1);
INSERT INTO song (song_name, genre_is, f_id, artist_name, country, rating, languages, releasedate, resolution) VALUES ('Song_3', 'Pop', 1.0, 'Artist_A', 'USA', 850.0, 'English', '2020-01-03', 1080.0);
INSERT INTO song (song_name, genre_is, f_id, artist_name, country, rating, languages, releasedate, resolution) VALUES ('Song_4', 'Rock', 2.0, 'Artist_B', 'UK', 920.0, 'English', '2020-01-04', 720.0);
INSERT INTO song (song_name, genre_is, f_id, artist_name, country, rating, languages, releasedate, resolution) VALUES ('Song_5', 'Pop', 3.0, 'Artist_C', 'USA', 950.0, 'English', '2020-01-05', 1080.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT artist_name, country FROM (SELECT song_name, artist_name, country, f_id, genre_is, rating, languages, releasedate, resolution, COUNT(*) OVER () AS n FROM (SELECT * FROM song AS LHS WHERE EXISTS(SELECT 1 FROM artist AS RHS WHERE (LHS.artist_name = RHS.artist_name AND LHS.country = RHS.country)))) WHERE (resolution > 900.0 OR n < 1) ORDER BY artist_name, country NULLS LAST;

/*
Gold Result:
('Artist_A', 'USA')
('Artist_A', 'USA')
*/

-- Prediction Query
SELECT T1.artist_name, T1.country FROM artist AS T1 JOIN song AS T2 ON T1.artist_name = T2.artist_name WHERE T2.resolution > 900 GROUP BY T2.artist_name HAVING COUNT(*) >= 1;

/*
Prediction Result:
('Artist_A', 'USA')
('Artist_C', 'Canada')
*/