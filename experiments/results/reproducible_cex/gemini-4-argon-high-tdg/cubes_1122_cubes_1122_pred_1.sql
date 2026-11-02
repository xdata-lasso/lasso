-- Schema DDL
CREATE TABLE "genre" ("g_name" TEXT(20) PRIMARY KEY, "rating" TEXT(10), "most_popular_in" TEXT(50));

CREATE TABLE "artist" ("artist_name" TEXT(50) PRIMARY KEY, "preferred_genre" TEXT(50), "country" TEXT(20), "gender" TEXT(20), FOREIGN KEY ("preferred_genre") REFERENCES "genre" ("g_name"));

CREATE TABLE "files" ("f_id" REAL(10) PRIMARY KEY, "artist_name" TEXT(50), "file_size" TEXT(20), "duration" TEXT(20), "formats" TEXT(20), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

CREATE TABLE "song" ("song_name" TEXT(50) PRIMARY KEY, "genre_is" TEXT(20), "f_id" REAL(10), "artist_name" TEXT(50), "country" TEXT(20), "rating" REAL(10), "languages" TEXT(20), "releasedate" DATE, "resolution" REAL(10), FOREIGN KEY ("genre_is") REFERENCES "genre" ("g_name"), FOREIGN KEY ("f_id") REFERENCES "files" ("f_id"), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO genre (g_name, rating, most_popular_in) VALUES ('Rock', '9', 'UK');
INSERT INTO genre (g_name, rating, most_popular_in) VALUES ('Pop', '8', 'USA');
INSERT INTO artist (artist_name, preferred_genre, country, gender) VALUES ('Zara', 'Pop', 'USA', 'Female');
INSERT INTO artist (artist_name, preferred_genre, country, gender) VALUES ('Adele', 'Pop', 'UK', 'Female');
INSERT INTO artist (artist_name, preferred_genre, country, gender) VALUES ('Coldplay', 'Rock', 'UK', 'Male');
INSERT INTO artist (artist_name, preferred_genre, country, gender) VALUES ('Daft', 'Pop', 'France', 'Male');
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (1.0, 'Zara', '4MB', '3:20', 'mp3');
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (2.0, 'Adele', '5MB', '4:10', 'mp3');
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (3.0, 'Coldplay', '6MB', '3:50', 'wav');
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (4.0, 'Daft', '4MB', '3:00', 'mp3');
INSERT INTO song (song_name, genre_is, f_id, artist_name, country, rating, languages, releasedate, resolution) VALUES ('Song_Z1', 'Pop', 1.0, 'Zara', 'UK', 8.5, 'english', '2020-01-10', 320.0);
INSERT INTO song (song_name, genre_is, f_id, artist_name, country, rating, languages, releasedate, resolution) VALUES ('Song_Z2', 'Pop', 1.0, 'Zara', 'UK', 9.0, 'english', '2021-05-15', 320.0);
INSERT INTO song (song_name, genre_is, f_id, artist_name, country, rating, languages, releasedate, resolution) VALUES ('Song_A1', 'Pop', 2.0, 'Adele', 'UK', 9.5, 'english', '2019-11-20', 320.0);
INSERT INTO song (song_name, genre_is, f_id, artist_name, country, rating, languages, releasedate, resolution) VALUES ('Song_C1', 'Rock', 3.0, 'Coldplay', 'UK', 7.5, 'french', '2018-03-01', 256.0);
INSERT INTO song (song_name, genre_is, f_id, artist_name, country, rating, languages, releasedate, resolution) VALUES ('Song_D1', 'Pop', 4.0, 'Daft', 'USA', 8.0, 'english', '2017-07-07', 256.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "artist_name" FROM (SELECT "LHS"."song_name" AS "song_name", "LHS"."artist_name" AS "artist_name", "LHS"."country" AS "country", "LHS"."f_id" AS "f_id", "LHS"."genre_is" AS "genre_is", "LHS"."rating" AS "rating", "LHS"."languages" AS "languages", "LHS"."releasedate" AS "releasedate", "LHS"."resolution" AS "resolution", "RHS"."artist_name" AS "artist_name_other", "RHS"."country" AS "country_other", "RHS"."gender" AS "gender", "RHS"."preferred_genre" AS "preferred_genre" FROM (SELECT * FROM "song" WHERE ("country" = 'UK' AND "languages" = 'english')) AS LHS CROSS JOIN artist AS RHS) WHERE (country <> country_other OR languages <> country_other) ORDER BY artist_name, "artist_name" NULLS LAST;

/*
Gold Result:
('Adele',)
('Zara',)
*/

-- Prediction Query
SELECT artist_name FROM artist WHERE country = 'UK' INTERSECT SELECT T1.artist_name FROM artist AS T1 JOIN song AS T2 ON T1.artist_name = T2.artist_name WHERE T2.languages = 'english';

/*
Prediction Result:
('Adele',)
*/