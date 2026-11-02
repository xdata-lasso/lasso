-- Schema DDL
CREATE TABLE "genre" ("g_name" TEXT(20) PRIMARY KEY, "rating" TEXT(10), "most_popular_in" TEXT(50));

CREATE TABLE "artist" ("artist_name" TEXT(50) PRIMARY KEY, "preferred_genre" TEXT(50), "country" TEXT(20), "gender" TEXT(20), FOREIGN KEY ("preferred_genre") REFERENCES "genre" ("g_name"));

CREATE TABLE "files" ("f_id" REAL(10) PRIMARY KEY, "artist_name" TEXT(50), "file_size" TEXT(20), "duration" TEXT(20), "formats" TEXT(20), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

CREATE TABLE "song" ("song_name" TEXT(50) PRIMARY KEY, "genre_is" TEXT(20), "f_id" REAL(10), "artist_name" TEXT(50), "country" TEXT(20), "rating" REAL(10), "languages" TEXT(20), "releasedate" DATE, "resolution" REAL(10), FOREIGN KEY ("genre_is") REFERENCES "genre" ("g_name"), FOREIGN KEY ("f_id") REFERENCES "files" ("f_id"), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "genre" ("g_name", "rating", "most_popular_in") VALUES ('Allison Hill', 'all', 'early');
INSERT INTO "genre" ("g_name", "rating", "most_popular_in") VALUES ('Noah Rhodes', 'better', 'mouth');
INSERT INTO "genre" ("g_name", "rating", "most_popular_in") VALUES ('Angie Henderson', 'discover', 'play');
INSERT INTO "genre" ("g_name", "rating", "most_popular_in") VALUES ('Shannon Ray', 'discover', 'play');
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('Cristian Santos', 'Allison Hill', 'Qatar', 'knowledge');
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('Connie Lawrence', 'Allison Hill', 'Qatar', 'grow');
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('Abigail Shaffer', 'Allison Hill', 'Qatar', 'fall');
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('Amber Perez', 'Allison Hill', NULL, 'fall');
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (1001.5, 'Cristian Santos', 'clearly', 'great', 'husband');
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (1002.5, 'Cristian Santos', 'dinner', 'blue', 'bill');
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (1003.5, 'Cristian Santos', 'source', 'best', 'her');
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (1010.5, 'Cristian Santos', 'source', 'best', 'her');
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Lindsey Roman', 'Allison Hill', 1001.5, 'Cristian Santos', 'Qatar', 1004.5, 'english', '1970-01-01', 1007.5);
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Kimberly Dudley', 'Allison Hill', 1001.5, 'Cristian Santos', 'Qatar', 1017.5, 'english', '1970-01-02', 1026.5);
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Juan Calderon', 'Allison Hill', 1001.5, 'Cristian Santos', 'Qatar', 1030.5, 'english', '1970-01-03', 1045.5);
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Bobby Hall', 'Allison Hill', 1001.5, 'Cristian Santos', NULL, 1030.5, 'english', '1970-01-03', 1045.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "artist_name", "n" AS "count___" FROM (SELECT "LHS"."country" AS "country", "LHS"."languages" AS "languages", "LHS"."n" AS "n", "RHS"."artist_name" AS "artist_name", "RHS"."gender" AS "gender", "RHS"."preferred_genre" AS "preferred_genre" FROM (SELECT * FROM (SELECT "country", "languages", COUNT(*) AS "n" FROM "song" GROUP BY "country", "languages") WHERE ("languages" = 'english' OR n < 1)) AS LHS LEFT JOIN artist AS RHS ON (LHS.country = RHS.country)) ORDER BY artist_name, "artist_name" NULLS LAST, count___ NULLS LAST;

/*
Gold Result:
(None, 1)
('Abigail Shaffer', 3)
('Connie Lawrence', 3)
('Cristian Santos', 3)
*/

-- Prediction Query
SELECT T1.artist_name, COUNT(*) FROM artist AS T1 JOIN song AS T2 ON T1.artist_name = T2.artist_name WHERE T2.languages = 'english' GROUP BY T2.artist_name HAVING COUNT(*) >= 1;

/*
Prediction Result:
('Cristian Santos', 4)
*/