-- Schema DDL
CREATE TABLE "genre" ("g_name" TEXT(20) PRIMARY KEY, "rating" TEXT(10), "most_popular_in" TEXT(50));

CREATE TABLE "artist" ("artist_name" TEXT(50) PRIMARY KEY, "preferred_genre" TEXT(50), "country" TEXT(20), "gender" TEXT(20), FOREIGN KEY ("preferred_genre") REFERENCES "genre" ("g_name"));

CREATE TABLE "files" ("f_id" REAL(10) PRIMARY KEY, "artist_name" TEXT(50), "file_size" TEXT(20), "duration" TEXT(20), "formats" TEXT(20), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

CREATE TABLE "song" ("song_name" TEXT(50) PRIMARY KEY, "genre_is" TEXT(20), "f_id" REAL(10), "artist_name" TEXT(50), "country" TEXT(20), "rating" REAL(10), "languages" TEXT(20), "releasedate" DATE, "resolution" REAL(10), FOREIGN KEY ("genre_is") REFERENCES "genre" ("g_name"), FOREIGN KEY ("f_id") REFERENCES "files" ("f_id"), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "genre" ("g_name", "rating", "most_popular_in") VALUES ('Pop', '8', 'USA');
INSERT INTO "genre" ("g_name", "rating", "most_popular_in") VALUES ('Rock', '9', 'UK');
INSERT INTO "genre" ("g_name", "rating", "most_popular_in") VALUES ('Jazz', '7', 'France');
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('Artist_US_1', 'Pop', 'USA', 'Female');
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('Artist_US_2', 'Rock', 'USA', 'Male');
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('Artist_FR', 'Jazz', 'France', 'Male');
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('Artist_DE', 'Rock', 'Germany', 'Female');
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (1.0, 'Artist_US_1', '5MB', '3:00', 'mp3');
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (2.0, 'Artist_FR', '4MB', '2:30', 'wav');
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Song_US_En_1', 'Pop', 1.0, 'Artist_DE', 'USA', 5.0, 'english', '2020-01-01', 320.0);
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Song_US_En_2', 'Pop', 1.0, 'Artist_FR', 'USA', 4.0, 'english', '2020-01-02', 320.0);
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Song_US_Es', 'Pop', 1.0, 'Artist_US_1', 'USA', 3.0, 'spanish', '2020-01-03', 320.0);
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Song_UK_En', 'Rock', 2.0, 'Artist_US_1', 'UK', 5.0, 'english', '2020-01-04', 320.0);
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Song_FR_Fr', 'Jazz', 2.0, 'Artist_FR', 'France', 4.0, 'french', '2020-01-05', 320.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "artist_name", "n" AS "count___" FROM (SELECT "LHS"."country" AS "country", "LHS"."languages" AS "languages", "LHS"."n" AS "n", "RHS"."artist_name" AS "artist_name", "RHS"."gender" AS "gender", "RHS"."preferred_genre" AS "preferred_genre" FROM (SELECT * FROM (SELECT "country", "languages", COUNT(*) AS "n" FROM "song" GROUP BY "country", "languages") WHERE ("languages" = 'english' OR n < 1)) AS LHS LEFT JOIN artist AS RHS ON (LHS.country = RHS.country)) ORDER BY artist_name, "artist_name" NULLS LAST, count___ NULLS LAST;

/*
Gold Result:
(None, 1)
('Artist_US_1', 2)
('Artist_US_2', 2)
*/

-- Prediction Query
SELECT T1.artist_name, COUNT(*) FROM artist AS T1 JOIN song AS T2 ON T1.artist_name = T2.artist_name WHERE T2.languages = 'english' GROUP BY T2.artist_name HAVING COUNT(*) >= 1;

/*
Prediction Result:
('Artist_DE', 1)
('Artist_FR', 1)
('Artist_US_1', 1)
*/