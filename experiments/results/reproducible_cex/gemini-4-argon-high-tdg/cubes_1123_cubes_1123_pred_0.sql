-- Schema DDL
CREATE TABLE "genre" ("g_name" TEXT(20) PRIMARY KEY, "rating" TEXT(10), "most_popular_in" TEXT(50));

CREATE TABLE "artist" ("artist_name" TEXT(50) PRIMARY KEY, "preferred_genre" TEXT(50), "country" TEXT(20), "gender" TEXT(20), FOREIGN KEY ("preferred_genre") REFERENCES "genre" ("g_name"));

CREATE TABLE "files" ("f_id" REAL(10) PRIMARY KEY, "artist_name" TEXT(50), "file_size" TEXT(20), "duration" TEXT(20), "formats" TEXT(20), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

CREATE TABLE "song" ("song_name" TEXT(50) PRIMARY KEY, "genre_is" TEXT(20), "f_id" REAL(10), "artist_name" TEXT(50), "country" TEXT(20), "rating" REAL(10), "languages" TEXT(20), "releasedate" DATE, "resolution" REAL(10), FOREIGN KEY ("genre_is") REFERENCES "genre" ("g_name"), FOREIGN KEY ("f_id") REFERENCES "files" ("f_id"), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO genre (g_name, rating, most_popular_in) VALUES ('Pop', '8.0', 'USA');
INSERT INTO genre (g_name, rating, most_popular_in) VALUES ('Rock', '9.5', 'Canada');
INSERT INTO artist (artist_name, preferred_genre, country, gender) VALUES ('Charlie', 'Rock', 'Canada', 'Male');
INSERT INTO artist (artist_name, preferred_genre, country, gender) VALUES ('Alice', 'Pop', 'USA', 'Female');
INSERT INTO artist (artist_name, preferred_genre, country, gender) VALUES ('Bob', 'Pop', 'Brazil', 'Male');
INSERT INTO artist (artist_name, preferred_genre, country, gender) VALUES ('Diana', 'Rock', 'Denmark', 'Female');
INSERT INTO artist (artist_name, preferred_genre, country, gender) VALUES ('Evan', 'Pop', 'Egypt', 'Male');
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (1.0, 'Charlie', '4MB', '3:30', 'MP3');
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (2.0, 'Alice', '5MB', '4:00', 'FLAC');
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (3.0, 'Bob', '3MB', '2:50', 'MP3');
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (4.0, 'Diana', '4MB', '3:10', 'WAV');
INSERT INTO song (song_name, genre_is, f_id, artist_name, country, rating, languages, releasedate, resolution) VALUES ('Song_Boundary_Exact', 'Rock', 1.0, 'Charlie', 'Canada', 9.0, 'English', '2021-05-10', 320.0);
INSERT INTO song (song_name, genre_is, f_id, artist_name, country, rating, languages, releasedate, resolution) VALUES ('Song_Above_Boundary', 'Pop', 2.0, 'Alice', 'USA', 9.5, 'English', '2022-01-15', 320.0);
INSERT INTO song (song_name, genre_is, f_id, artist_name, country, rating, languages, releasedate, resolution) VALUES ('Song_Below_Boundary', 'Pop', 3.0, 'Bob', 'Brazil', 8.99, 'Portuguese', '2020-11-20', 256.0);
INSERT INTO song (song_name, genre_is, f_id, artist_name, country, rating, languages, releasedate, resolution) VALUES ('Song_Null_Rating', 'Rock', 4.0, 'Diana', 'Denmark', NULL, 'Danish', '2023-03-01', 192.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT artist_name, country FROM (SELECT * FROM artist AS LHS WHERE EXISTS(SELECT 1 FROM (SELECT * FROM song WHERE (rating >= 9.0)) AS RHS WHERE (LHS.artist_name = RHS.artist_name AND LHS.country = RHS.country))) ORDER BY artist_name, country NULLS LAST;

/*
Gold Result:
('Alice', 'USA')
('Charlie', 'Canada')
*/

-- Prediction Query
SELECT DISTINCT T1.artist_name, T1.country FROM artist AS T1 JOIN song AS T2 ON T1.artist_name = T2.artist_name WHERE T2.rating > 9;

/*
Prediction Result:
('Alice', 'USA')
*/