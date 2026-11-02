-- Schema DDL
CREATE TABLE "genre" ("g_name" TEXT(20) PRIMARY KEY, "rating" TEXT(10), "most_popular_in" TEXT(50));

CREATE TABLE "artist" ("artist_name" TEXT(50) PRIMARY KEY, "preferred_genre" TEXT(50), "country" TEXT(20), "gender" TEXT(20), FOREIGN KEY ("preferred_genre") REFERENCES "genre" ("g_name"));

CREATE TABLE "files" ("f_id" REAL(10) PRIMARY KEY, "artist_name" TEXT(50), "file_size" TEXT(20), "duration" TEXT(20), "formats" TEXT(20), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

CREATE TABLE "song" ("song_name" TEXT(50) PRIMARY KEY, "genre_is" TEXT(20), "f_id" REAL(10), "artist_name" TEXT(50), "country" TEXT(20), "rating" REAL(10), "languages" TEXT(20), "releasedate" DATE, "resolution" REAL(10), FOREIGN KEY ("genre_is") REFERENCES "genre" ("g_name"), FOREIGN KEY ("f_id") REFERENCES "files" ("f_id"), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "genre" ("g_name", "rating", "most_popular_in") VALUES ('Allison Hill', 'dog', 'chair');
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('Megan Mcclain', 'Allison Hill', 'Bangladesh', 'begin');
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (1001.5, 'Megan Mcclain', 'performance', 'knowledge', 'almost');
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Daniel Wagner', 'Allison Hill', 1001.5, 'Megan Mcclain', 'Anguilla', 8.0, 'option', '1970-01-01', 1002.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "artist_name" FROM (SELECT * FROM (SELECT "LHS"."artist_name" AS "artist_name", "LHS"."country" AS "country", "LHS"."gender" AS "gender", "LHS"."preferred_genre" AS "preferred_genre", "RHS"."song_name" AS "song_name", "RHS"."artist_name" AS "artist_name_other", "RHS"."country" AS "country_other", "RHS"."f_id" AS "f_id", "RHS"."genre_is" AS "genre_is", "RHS"."rating" AS "rating", "RHS"."languages" AS "languages", "RHS"."releasedate" AS "releasedate", "RHS"."resolution" AS "resolution" FROM "artist" AS "LHS" CROSS JOIN "song" AS "RHS") WHERE ("country" <> "country_other")) WHERE ("country" = 'Bangladesh' AND rating > 7.0) ORDER BY artist_name, "artist_name" NULLS LAST;

/*
Gold Result:
('Megan Mcclain',)
*/

-- Prediction Query
SELECT DISTINCT artist_name FROM artist WHERE country = 'Bangladesh' EXCEPT SELECT DISTINCT artist_name FROM song WHERE rating > 7;

/*
Prediction Result:
*/