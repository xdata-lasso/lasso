-- Schema DDL
CREATE TABLE "genre" ("g_name" TEXT(20) PRIMARY KEY, "rating" TEXT(10), "most_popular_in" TEXT(50));

CREATE TABLE "artist" ("artist_name" TEXT(50) PRIMARY KEY, "preferred_genre" TEXT(50), "country" TEXT(20), "gender" TEXT(20), FOREIGN KEY ("preferred_genre") REFERENCES "genre" ("g_name"));

CREATE TABLE "files" ("f_id" REAL(10) PRIMARY KEY, "artist_name" TEXT(50), "file_size" TEXT(20), "duration" TEXT(20), "formats" TEXT(20), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

CREATE TABLE "song" ("song_name" TEXT(50) PRIMARY KEY, "genre_is" TEXT(20), "f_id" REAL(10), "artist_name" TEXT(50), "country" TEXT(20), "rating" REAL(10), "languages" TEXT(20), "releasedate" DATE, "resolution" REAL(10), FOREIGN KEY ("genre_is") REFERENCES "genre" ("g_name"), FOREIGN KEY ("f_id") REFERENCES "files" ("f_id"), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO genre (g_name, rating, most_popular_in) VALUES ('pop', '8', 'USA');
INSERT INTO genre (g_name, rating, most_popular_in) VALUES ('rock', '9', 'UK');
INSERT INTO artist (artist_name, preferred_genre, country, gender) VALUES ('Bob', 'pop', 'USA', 'Male');
INSERT INTO artist (artist_name, preferred_genre, country, gender) VALUES ('Alice', 'pop', 'USA', 'Female');
INSERT INTO artist (artist_name, preferred_genre, country, gender) VALUES ('Charlie', 'rock', 'UK', 'Male');
INSERT INTO artist (artist_name, preferred_genre, country, gender) VALUES ('Ken', 'pop', 'Japan', 'Male');
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (1.0, 'Alice', '4MB', '3:00', 'mp3');
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (2.0, 'Alice', '5MB', '3:30', 'mp3');
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (3.0, 'Alice', '4MB', '2:50', 'mp3');
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (4.0, 'Charlie', '6MB', '4:00', 'wav');
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (5.0, 'Charlie', '5MB', '3:20', 'wav');
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (6.0, 'Charlie', '5MB', '3:10', 'wav');
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (7.0, 'Ken', '4MB', '3:00', 'mp3');
INSERT INTO song (song_name, genre_is, f_id, artist_name, country, rating, languages, releasedate, resolution) VALUES ('USA Eng 1', 'pop', 1.0, 'Alice', 'USA', 8.0, 'english', '2020-01-01', 320.0);
INSERT INTO song (song_name, genre_is, f_id, artist_name, country, rating, languages, releasedate, resolution) VALUES ('USA Eng 2', 'pop', 2.0, 'Alice', 'USA', 9.0, 'english', '2020-01-02', 320.0);
INSERT INTO song (song_name, genre_is, f_id, artist_name, country, rating, languages, releasedate, resolution) VALUES ('USA Spa 1', 'pop', 3.0, 'Alice', 'USA', 7.0, 'spanish', '2020-01-03', 320.0);
INSERT INTO song (song_name, genre_is, f_id, artist_name, country, rating, languages, releasedate, resolution) VALUES ('UK Eng 1', 'rock', 4.0, 'Charlie', 'UK', 8.5, 'english', '2020-02-01', 320.0);
INSERT INTO song (song_name, genre_is, f_id, artist_name, country, rating, languages, releasedate, resolution) VALUES ('UK Fre 1', 'rock', 5.0, 'Charlie', 'UK', 7.5, 'french', '2020-02-02', 320.0);
INSERT INTO song (song_name, genre_is, f_id, artist_name, country, rating, languages, releasedate, resolution) VALUES ('UK Fre 2', 'rock', 6.0, 'Charlie', 'UK', 7.0, 'french', '2020-02-03', 320.0);
INSERT INTO song (song_name, genre_is, f_id, artist_name, country, rating, languages, releasedate, resolution) VALUES ('Can Eng 1', 'pop', 1.0, 'Alice', 'Canada', 8.0, 'english', '2020-03-01', 320.0);
INSERT INTO song (song_name, genre_is, f_id, artist_name, country, rating, languages, releasedate, resolution) VALUES ('Can Eng 2', 'pop', 2.0, 'Alice', 'Canada', 8.0, 'english', '2020-03-02', 320.0);
INSERT INTO song (song_name, genre_is, f_id, artist_name, country, rating, languages, releasedate, resolution) VALUES ('Can Eng 3', 'pop', 3.0, 'Alice', 'Canada', 8.0, 'english', '2020-03-03', 320.0);
INSERT INTO song (song_name, genre_is, f_id, artist_name, country, rating, languages, releasedate, resolution) VALUES ('Aus Eng 1', 'rock', 4.0, 'Charlie', 'Australia', 9.0, 'english', '2020-04-01', 320.0);
INSERT INTO song (song_name, genre_is, f_id, artist_name, country, rating, languages, releasedate, resolution) VALUES ('Jpn Jpn 1', 'pop', 7.0, 'Ken', 'Japan', 8.0, 'japanese', '2020-05-01', 320.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "artist_name", "n" AS "count___" FROM (SELECT "LHS"."country" AS "country", "LHS"."languages" AS "languages", "LHS"."n" AS "n", "RHS"."artist_name" AS "artist_name", "RHS"."gender" AS "gender", "RHS"."preferred_genre" AS "preferred_genre" FROM (SELECT * FROM (SELECT "country", "languages", COUNT(*) AS "n" FROM "song" GROUP BY "country", "languages") WHERE ("languages" = 'english' OR n < 1)) AS LHS LEFT JOIN artist AS RHS ON (LHS.country = RHS.country)) ORDER BY artist_name, "artist_name" NULLS LAST, count___ NULLS LAST;

/*
Gold Result:
(None, 1)
(None, 3)
('Alice', 2)
('Bob', 2)
('Charlie', 1)
*/

-- Prediction Query
SELECT T1.artist_name, COUNT(*) FROM artist AS T1 JOIN song AS T2 ON T1.artist_name = T2.artist_name WHERE T2.languages = 'english' GROUP BY T2.artist_name HAVING COUNT(*) >= 1;

/*
Prediction Result:
('Alice', 5)
('Charlie', 2)
*/