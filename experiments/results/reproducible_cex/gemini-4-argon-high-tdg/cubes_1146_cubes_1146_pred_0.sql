-- Schema DDL
CREATE TABLE "genre" ("g_name" TEXT(20) PRIMARY KEY, "rating" TEXT(10), "most_popular_in" TEXT(50));

CREATE TABLE "artist" ("artist_name" TEXT(50) PRIMARY KEY, "preferred_genre" TEXT(50), "country" TEXT(20), "gender" TEXT(20), FOREIGN KEY ("preferred_genre") REFERENCES "genre" ("g_name"));

CREATE TABLE "files" ("f_id" REAL(10) PRIMARY KEY, "artist_name" TEXT(50), "file_size" TEXT(20), "duration" TEXT(20), "formats" TEXT(20), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

CREATE TABLE "song" ("song_name" TEXT(50) PRIMARY KEY, "genre_is" TEXT(20), "f_id" REAL(10), "artist_name" TEXT(50), "country" TEXT(20), "rating" REAL(10), "languages" TEXT(20), "releasedate" DATE, "resolution" REAL(10), FOREIGN KEY ("genre_is") REFERENCES "genre" ("g_name"), FOREIGN KEY ("f_id") REFERENCES "files" ("f_id"), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO genre (g_name, rating, most_popular_in) VALUES ('Pop', '8', 'USA');
INSERT INTO genre (g_name, rating, most_popular_in) VALUES ('Rock', '9', 'UK');
INSERT INTO artist (artist_name, preferred_genre, country, gender) VALUES ('Alice', 'Pop', 'USA', 'Female');
INSERT INTO artist (artist_name, preferred_genre, country, gender) VALUES ('Bob', 'Rock', 'UK', 'Male');
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (1.0, 'Alice', '4MB', '3:30', 'mp3');
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (2.0, 'Alice', '12MB', '3:30', 'flac');
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (3.0, 'Bob', '8MB', '4:15', 'wav');
INSERT INTO song (song_name, genre_is, f_id, artist_name, country, rating, languages, releasedate, resolution) VALUES ('Song_A1', 'Pop', 3.0, 'Alice', 'USA', 4.5, 'English', '2021-01-10', 720.0);
INSERT INTO song (song_name, genre_is, f_id, artist_name, country, rating, languages, releasedate, resolution) VALUES ('Song_A2', 'Rock', 1.0, 'Alice', 'Canada', 4.8, 'English', '2021-06-15', 480.0);
INSERT INTO song (song_name, genre_is, f_id, artist_name, country, rating, languages, releasedate, resolution) VALUES ('Song_B1', 'Rock', 1.0, 'Bob', 'UK', 3.9, 'English', '2020-11-20', 900.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT file_size, formats FROM (SELECT LHS.song_name AS song_name, LHS.artist_name AS artist_name, LHS.country AS country, LHS.f_id AS f_id, LHS.genre_is AS genre_is, LHS.rating AS rating, LHS.languages AS languages, LHS.releasedate AS releasedate, LHS.resolution AS resolution, RHS.f_id AS f_id_other, RHS.file_size AS file_size, RHS.duration AS duration, RHS.formats AS formats FROM (SELECT * FROM song WHERE (resolution < 800.0)) AS LHS INNER JOIN files AS RHS ON (LHS.artist_name = RHS.artist_name)) ORDER BY file_size, formats NULLS LAST;

/*
Gold Result:
('12MB', 'flac')
('12MB', 'flac')
('4MB', 'mp3')
('4MB', 'mp3')
*/

-- Prediction Query
SELECT DISTINCT T1.file_size, T1.formats FROM files AS T1 JOIN song AS T2 ON T1.f_id = T2.f_id WHERE T2.resolution < 800;

/*
Prediction Result:
('8MB', 'wav')
('4MB', 'mp3')
*/