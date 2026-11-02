-- Schema DDL
CREATE TABLE "genre" ("g_name" TEXT(20) PRIMARY KEY, "rating" TEXT(10), "most_popular_in" TEXT(50));

CREATE TABLE "artist" ("artist_name" TEXT(50) PRIMARY KEY, "preferred_genre" TEXT(50), "country" TEXT(20), "gender" TEXT(20), FOREIGN KEY ("preferred_genre") REFERENCES "genre" ("g_name"));

CREATE TABLE "files" ("f_id" REAL(10) PRIMARY KEY, "artist_name" TEXT(50), "file_size" TEXT(20), "duration" TEXT(20), "formats" TEXT(20), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

CREATE TABLE "song" ("song_name" TEXT(50) PRIMARY KEY, "genre_is" TEXT(20), "f_id" REAL(10), "artist_name" TEXT(50), "country" TEXT(20), "rating" REAL(10), "languages" TEXT(20), "releasedate" DATE, "resolution" REAL(10), FOREIGN KEY ("genre_is") REFERENCES "genre" ("g_name"), FOREIGN KEY ("f_id") REFERENCES "files" ("f_id"), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO genre (g_name, rating, most_popular_in) VALUES ('Pop', 'High', 'USA');
INSERT INTO artist (artist_name, preferred_genre, country, gender) VALUES ('Artist1', 'Pop', 'USA', 'F');
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (1.0, 'Artist1', '5MB', '3:00', 'MP3');
INSERT INTO song (song_name, genre_is, f_id, artist_name, country, rating, languages, releasedate, resolution) VALUES ('Song1', 'Pop', 1.0, 'Artist1', 'USA', 9.0, 'English', '2020-01-01', 320.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT artist_name, country FROM (SELECT * FROM artist AS LHS WHERE EXISTS(SELECT 1 FROM (SELECT * FROM song WHERE (rating >= 9.0)) AS RHS WHERE (LHS.artist_name = RHS.artist_name AND LHS.country = RHS.country))) ORDER BY artist_name, country NULLS LAST;

/*
Gold Result:
('Artist1', 'USA')
*/

-- Prediction Query
SELECT DISTINCT T1.artist_name, T1.country FROM artist AS T1 JOIN song AS T2 ON T1.artist_name = T2.artist_name WHERE T2.rating > 9;

/*
Prediction Result:
*/