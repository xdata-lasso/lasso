-- Schema DDL
CREATE TABLE "genre" ("g_name" TEXT(20) PRIMARY KEY, "rating" TEXT(10), "most_popular_in" TEXT(50));

CREATE TABLE "artist" ("artist_name" TEXT(50) PRIMARY KEY, "preferred_genre" TEXT(50), "country" TEXT(20), "gender" TEXT(20), FOREIGN KEY ("preferred_genre") REFERENCES "genre" ("g_name"));

CREATE TABLE "files" ("f_id" REAL(10) PRIMARY KEY, "artist_name" TEXT(50), "file_size" TEXT(20), "duration" TEXT(20), "formats" TEXT(20), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

CREATE TABLE "song" ("song_name" TEXT(50) PRIMARY KEY, "genre_is" TEXT(20), "f_id" REAL(10), "artist_name" TEXT(50), "country" TEXT(20), "rating" REAL(10), "languages" TEXT(20), "releasedate" DATE, "resolution" REAL(10), FOREIGN KEY ("genre_is") REFERENCES "genre" ("g_name"), FOREIGN KEY ("f_id") REFERENCES "files" ("f_id"), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: genre --
INSERT INTO "genre" ("g_name", "rating", "most_popular_in") VALUES ('g_name_1', 'gen_df42ba', 'gen_145444');

INSERT INTO "genre" ("g_name", "rating", "most_popular_in") VALUES ('rhs_0da3c9', 'gen_df42ba', 'gen_145444');

INSERT INTO "genre" ("g_name", "rating", "most_popular_in") VALUES ('lhs_18c9e8', 'gen_df42ba', 'gen_145444');

INSERT INTO "genre" ("g_name", "rating", "most_popular_in") VALUES ('rhs_e825da', 'gen_df42ba', 'gen_145444');

INSERT INTO "genre" ("g_name", "rating", "most_popular_in") VALUES ('lhs_28042f', 'gen_df42ba', 'gen_145444');

-- Inserting into table: artist --
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('art_e93e1f', 'g_name_1', 'art_774c73', 'art_c0de8b');

INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('lhs_0b9bf6', 'rhs_0da3c9', 'rhs_474237', 'rhs_a3e327');

INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('art_321a79', 'rhs_0da3c9', 'art_d7cac2', 'art_c0de8b');

INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('rhs_9b1bbe', 'rhs_0da3c9', 'rhs_474237', 'rhs_a3e327');

INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('artist_name_3', 'rhs_e825da', 'rhs_8c5755', 'rhs_222178');

INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('lhs_514c2f', 'lhs_18c9e8', 'art_2440df', 'art_c0de8b');

INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('C', 'rhs_0da3c9', 'rhs_474237', 'rhs_a3e327');

INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('A', 'lhs_18c9e8', 'art_2440df', 'art_c0de8b');

INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('Q', 'g_name_1', 'art_2440df', 'art_c0de8b');

INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('O', 'lhs_18c9e8', 'art_2440df', 'art_c0de8b');

INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('@', 'rhs_e825da', 'art_2440df', 'art_c0de8b');

INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('artist_name_12', 'g_name_1', 'art_2440df', 'Female');

-- Inserting into table: files --
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (1.0, 'lhs_0b9bf6', 'fil_2dd0e2', 'fil_2d04a5', 'fil_460987');

-- Inserting into table: song --
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('lhs_88b96c', 'lhs_18c9e8', 1.0, 'lhs_0b9bf6', 'lhs_99d2c0', 1.0, 'lhs_542c4c', '2024-06-15', 1.0);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('lhs_7a6c88', 'lhs_28042f', 1.0, 'lhs_514c2f', 'lhs_98484a', 1.0, 'lhs_f3e3ba', '2024-06-15', 1.0);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('A', 'lhs_18c9e8', 1.0, '@', 'son_f78e17', 711.020062, 'son_40bca8', '2020-05-06', 994.117864);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "meanrating" AS "avg_t2_rating_" FROM (SELECT "gender", "languages", AVG("rating") AS "meanrating" FROM (SELECT "LHS"."song_name" AS "song_name", "LHS"."artist_name" AS "artist_name", "LHS"."country" AS "country", "LHS"."f_id" AS "f_id", "LHS"."genre_is" AS "genre_is", "LHS"."rating" AS "rating", "LHS"."languages" AS "languages", "LHS"."releasedate" AS "releasedate", "LHS"."resolution" AS "resolution", "RHS"."country" AS "country_other", "RHS"."gender" AS "gender", "RHS"."preferred_genre" AS "preferred_genre" FROM "song" AS "LHS" INNER JOIN "artist" AS "RHS" ON ("LHS"."artist_name" = "RHS"."artist_name")) GROUP BY "gender", "languages") WHERE ("gender" = 'Female') ORDER BY avg_t2_rating_;

/*
Gold Result:
*/

-- Prediction Query
SELECT AVG(T2.rating) FROM artist AS T1 JOIN song AS T2 ON T1.artist_name = T2.artist_name WHERE T1.gender = 'Female';

/*
Prediction Result:
(None,)
*/