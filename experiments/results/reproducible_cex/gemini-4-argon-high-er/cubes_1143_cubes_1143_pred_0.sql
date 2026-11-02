-- Schema DDL
CREATE TABLE "genre" ("g_name" TEXT(20) PRIMARY KEY, "rating" TEXT(10), "most_popular_in" TEXT(50));

CREATE TABLE "artist" ("artist_name" TEXT(50) PRIMARY KEY, "preferred_genre" TEXT(50), "country" TEXT(20), "gender" TEXT(20), FOREIGN KEY ("preferred_genre") REFERENCES "genre" ("g_name"));

CREATE TABLE "files" ("f_id" REAL(10) PRIMARY KEY, "artist_name" TEXT(50), "file_size" TEXT(20), "duration" TEXT(20), "formats" TEXT(20), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

CREATE TABLE "song" ("song_name" TEXT(50) PRIMARY KEY, "genre_is" TEXT(20), "f_id" REAL(10), "artist_name" TEXT(50), "country" TEXT(20), "rating" REAL(10), "languages" TEXT(20), "releasedate" DATE, "resolution" REAL(10), FOREIGN KEY ("genre_is") REFERENCES "genre" ("g_name"), FOREIGN KEY ("f_id") REFERENCES "files" ("f_id"), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "genre" ("g_name", "rating", "most_popular_in") VALUES ('Pop', '10', 'USA');
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('A1', 'Pop', 'USA', 'Female');
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (1.0, 'A1', '10MB', '3:00', 'mp3');
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('S1', 'Pop', 1.0, 'A1', 'USA', 5.0, 'English', '2020-01-01', 320.0);
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('S2', 'Pop', 1.0, 'A1', 'USA', 10.0, 'Spanish', '2020-01-02', 320.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "meanrating" AS "avg_t2_rating_" FROM (SELECT "gender", "languages", AVG("rating") AS "meanrating" FROM (SELECT "LHS"."song_name" AS "song_name", "LHS"."artist_name" AS "artist_name", "LHS"."country" AS "country", "LHS"."f_id" AS "f_id", "LHS"."genre_is" AS "genre_is", "LHS"."rating" AS "rating", "LHS"."languages" AS "languages", "LHS"."releasedate" AS "releasedate", "LHS"."resolution" AS "resolution", "RHS"."country" AS "country_other", "RHS"."gender" AS "gender", "RHS"."preferred_genre" AS "preferred_genre" FROM "song" AS "LHS" INNER JOIN "artist" AS "RHS" ON ("LHS"."artist_name" = "RHS"."artist_name")) GROUP BY "gender", "languages") WHERE ("gender" = 'Female') ORDER BY avg_t2_rating_;

/*
Gold Result:
(5.0,)
(10.0,)
*/

-- Prediction Query
SELECT AVG(T2.rating) FROM artist AS T1 JOIN song AS T2 ON T1.artist_name = T2.artist_name WHERE T1.gender = 'Female';

/*
Prediction Result:
(7.5,)
*/