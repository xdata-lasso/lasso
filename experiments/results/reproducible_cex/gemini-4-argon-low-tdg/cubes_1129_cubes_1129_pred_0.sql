-- Schema DDL
CREATE TABLE "genre" ("g_name" TEXT(20) PRIMARY KEY, "rating" TEXT(10), "most_popular_in" TEXT(50));

CREATE TABLE "artist" ("artist_name" TEXT(50) PRIMARY KEY, "preferred_genre" TEXT(50), "country" TEXT(20), "gender" TEXT(20), FOREIGN KEY ("preferred_genre") REFERENCES "genre" ("g_name"));

CREATE TABLE "files" ("f_id" REAL(10) PRIMARY KEY, "artist_name" TEXT(50), "file_size" TEXT(20), "duration" TEXT(20), "formats" TEXT(20), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

CREATE TABLE "song" ("song_name" TEXT(50) PRIMARY KEY, "genre_is" TEXT(20), "f_id" REAL(10), "artist_name" TEXT(50), "country" TEXT(20), "rating" REAL(10), "languages" TEXT(20), "releasedate" DATE, "resolution" REAL(10), FOREIGN KEY ("genre_is") REFERENCES "genre" ("g_name"), FOREIGN KEY ("f_id") REFERENCES "files" ("f_id"), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. Distinguish song.country vs artist.country (country_other)
-- 2. Join condition: song.genre_is = artist.preferred_genre (vs omitting it)
-- 3. WHERE condition: gender = 'Female' AND languages = 'bangla'
-- 4. Duplicate elimination (SELECT vs SELECT DISTINCT)
-- 5. ORDER BY country ASC NULLS LAST
INSERT INTO "genre" ("g_name", "rating", "most_popular_in") VALUES ('Pop', '8', 'USA');
INSERT INTO "genre" ("g_name", "rating", "most_popular_in") VALUES ('Rock', '9', 'UK');
INSERT INTO "genre" ("g_name", "rating", "most_popular_in") VALUES ('Folk', '10', 'Bangladesh');
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('Artist_A', 'Folk', 'India', 'Female');
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('Artist_B', 'Pop', 'UK', 'Female');
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('Artist_C', 'Rock', 'USA', 'Male');
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (1.0, 'Artist_A', '5MB', '3:00', 'mp3');
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (2.0, 'Artist_B', '4MB', '2:30', 'wav');
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (3.0, 'Artist_C', '6MB', '4:00', 'mp3');
-- Matches everything: country is 'Bangladesh' (while artist.country is 'India')
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Song_1', 'Folk', 1.0, 'Artist_A', 'Bangladesh', 9.5, 'bangla', '2020-01-01', 320.0);
-- Matches everything, duplicate country 'Bangladesh' to test SELECT vs SELECT DISTINCT
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Song_2', 'Folk', 1.0, 'Artist_A', 'Bangladesh', 8.0, 'bangla', '2021-01-01', 320.0);
-- Matches everything, country is 'Canada' to test sorting ('Bangladesh' before 'Canada')
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Song_3', 'Pop', 2.0, 'Artist_B', 'Canada', 7.5, 'bangla', '2019-05-05', 256.0);
-- Matches everything, country is NULL to test NULLS LAST
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Song_4', 'Folk', 1.0, 'Artist_A', NULL, 8.5, 'bangla', '2022-03-03', 128.0);
-- Fails genre_is = preferred_genre ('Rock' != 'Folk')
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Song_5', 'Rock', 1.0, 'Artist_A', 'Australia', 6.0, 'bangla', '2020-02-02', 320.0);
-- Fails gender = 'Female' ('Male')
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Song_6', 'Rock', 3.0, 'Artist_C', 'Denmark', 9.0, 'bangla', '2018-08-08', 320.0);
-- Fails languages = 'bangla' ('english')
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Song_7', 'Folk', 1.0, 'Artist_A', 'Egypt', 7.0, 'english', '2017-07-07', 320.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "country" FROM (SELECT "song_name", "artist_name", "country", "f_id", "genre_is", "rating", "languages", "releasedate", "resolution", "country_other", "gender", "genre_is" AS "preferred_genre" FROM (SELECT "LHS"."song_name" AS "song_name", "LHS"."artist_name" AS "artist_name", "LHS"."country" AS "country", "LHS"."f_id" AS "f_id", "LHS"."genre_is" AS "genre_is", "LHS"."rating" AS "rating", "LHS"."languages" AS "languages", "LHS"."releasedate" AS "releasedate", "LHS"."resolution" AS "resolution", "RHS"."country" AS "country_other", "RHS"."gender" AS "gender" FROM "song" AS "LHS" INNER JOIN "artist" AS "RHS" ON ("LHS"."artist_name" = "RHS"."artist_name" AND "LHS"."genre_is" = "RHS"."preferred_genre"))) WHERE ("gender" = 'Female' AND "languages" = 'bangla') ORDER BY country, "country" NULLS LAST;

/*
Gold Result:
(None,)
('Bangladesh',)
('Bangladesh',)
('Canada',)
*/

-- Prediction Query
SELECT T1.country FROM artist AS T1 JOIN song AS T2 ON T1.artist_name = T2.artist_name WHERE T1.gender = 'Female' AND T2.languages = 'bangla';

/*
Prediction Result:
('India',)
('India',)
('UK',)
('India',)
('India',)
*/