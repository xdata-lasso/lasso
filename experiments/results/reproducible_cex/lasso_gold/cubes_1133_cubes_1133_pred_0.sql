-- Schema DDL
CREATE TABLE "genre" ("g_name" TEXT(20) PRIMARY KEY, "rating" TEXT(10), "most_popular_in" TEXT(50));

CREATE TABLE "artist" ("artist_name" TEXT(50) PRIMARY KEY, "preferred_genre" TEXT(50), "country" TEXT(20), "gender" TEXT(20), FOREIGN KEY ("preferred_genre") REFERENCES "genre" ("g_name"));

CREATE TABLE "files" ("f_id" REAL(10) PRIMARY KEY, "artist_name" TEXT(50), "file_size" TEXT(20), "duration" TEXT(20), "formats" TEXT(20), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

CREATE TABLE "song" ("song_name" TEXT(50) PRIMARY KEY, "genre_is" TEXT(20), "f_id" REAL(10), "artist_name" TEXT(50), "country" TEXT(20), "rating" REAL(10), "languages" TEXT(20), "releasedate" DATE, "resolution" REAL(10), FOREIGN KEY ("genre_is") REFERENCES "genre" ("g_name"), FOREIGN KEY ("f_id") REFERENCES "files" ("f_id"), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "genre" ("g_name", "rating", "most_popular_in") VALUES ('blues', 'purpose', 'brother');
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('Donald Walker', 'blues', 'Saint Pierre and Miquelon', 'blue');
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (1001.5, 'Donald Walker', 'require', 'sit', 'wait');
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Leslie Johnson', 'blues', 1001.5, 'Donald Walker', 'Bermuda', 1002.5, 'discover', '1970-01-01', 1003.5);
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Lance Hoffman', 'blues', 1001.5, 'Donald Walker', 'Saint Barthelemy', 1004.5, 'rate', '1971-02-02', 1005.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "song_name_other" AS "song_name" FROM (SELECT * FROM (SELECT "LHS"."song_name" AS "song_name", "LHS"."artist_name" AS "artist_name", "LHS"."country" AS "country", "LHS"."f_id" AS "f_id", "LHS"."genre_is" AS "genre_is", "LHS"."rating" AS "rating", "LHS"."languages" AS "languages", "LHS"."releasedate" AS "releasedate", "LHS"."resolution" AS "resolution", "RHS"."song_name" AS "song_name_other", "RHS"."artist_name" AS "artist_name_other", "RHS"."country" AS "country_other", "RHS"."f_id" AS "f_id_other", "RHS"."genre_is" AS "genre_is_other", "RHS"."rating" AS "rating_other", "RHS"."languages" AS "languages_other", "RHS"."releasedate" AS "releasedate_other", "RHS"."resolution" AS "resolution_other" FROM "song" AS "LHS" CROSS JOIN "song" AS "RHS") WHERE ("genre_is" <> "genre_is_other" AND "rating" >= "rating_other")) WHERE ("genre_is" = 'blues') ORDER BY song_name;

/*
Gold Result:
*/

-- Prediction Query
SELECT song_name FROM song WHERE rating < (SELECT MAX(rating) FROM song WHERE genre_is = 'blues');

/*
Prediction Result:
('Leslie Johnson',)
*/