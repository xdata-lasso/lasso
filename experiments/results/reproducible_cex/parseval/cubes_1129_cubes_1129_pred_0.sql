-- Schema DDL
CREATE TABLE "genre" ("g_name" TEXT(20) PRIMARY KEY, "rating" TEXT(10), "most_popular_in" TEXT(50));

CREATE TABLE "artist" ("artist_name" TEXT(50) PRIMARY KEY, "preferred_genre" TEXT(50), "country" TEXT(20), "gender" TEXT(20), FOREIGN KEY ("preferred_genre") REFERENCES "genre" ("g_name"));

CREATE TABLE "files" ("f_id" REAL(10) PRIMARY KEY, "artist_name" TEXT(50), "file_size" TEXT(20), "duration" TEXT(20), "formats" TEXT(20), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

CREATE TABLE "song" ("song_name" TEXT(50) PRIMARY KEY, "genre_is" TEXT(20), "f_id" REAL(10), "artist_name" TEXT(50), "country" TEXT(20), "rating" REAL(10), "languages" TEXT(20), "releasedate" DATE, "resolution" REAL(10), FOREIGN KEY ("genre_is") REFERENCES "genre" ("g_name"), FOREIGN KEY ("f_id") REFERENCES "files" ("f_id"), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: genre --
INSERT INTO "genre" ("g_name", "rating", "most_popular_in") VALUES ('g_name_1', 'gen_df42ba', 'gen_145444');

-- Inserting into table: artist --
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('t1__4d14cd', 'g_name_1', 't1__834723', 'Female');

INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('_', 'g_name_1', 't1__834723', 'Female');

INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('A', 'g_name_1', 't1__834723', 'Female');

INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('Q', 'g_name_1', 'art_2440df', 'art_c0de8b');

INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('O', 'g_name_1', 'art_2440df', 'art_c0de8b');

INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('t2__e7be62', 'g_name_1', 't1__834723', 'Female');

-- Inserting into table: files --
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (486.033807, 't1__4d14cd', 'fil_2dd0e2', 'fil_2d04a5', 'fil_460987');

-- Inserting into table: song --
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_1', 'g_name_1', 486.033807, 't1__4d14cd', 'son_f78e17', 345.329712, 'bangla', '2022-12-08', 38.668834);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_2', 'g_name_1', 486.033807, '_', 'son_f78e17', 475.173408, 'bangla', '2021-02-11', 688.4027);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_3', 'g_name_1', 486.033807, '_', 'son_f78e17', 906.21648, 'bangla', '2025-06-04', 779.409124);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_4', 'g_name_1', 486.033807, 'Q', 'son_f78e17', 795.366812, 'bangla', '2024-03-30', 797.015047);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_5', 'g_name_1', 486.033807, 'O', 'son_f78e17', 294.861575, 'bangla', '2023-01-03', 711.020062);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_6', 'g_name_1', 486.033807, '_', 'son_f78e17', 503.083789, 'bangla', '2023-08-07', 737.440743);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('O', 'g_name_1', 486.033807, 't2__e7be62', 'son_f78e17', 303.05704, 'bangla', '2021-05-27', 182.319045);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('A', 'g_name_1', 486.033807, 't2__e7be62', 'son_f78e17', 787.938887, 'bangla', '2022-02-26', 666.330692);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('_', 'g_name_1', 486.033807, 't2__e7be62', 'son_f78e17', 619.836822, 'bangla', '2023-03-17', 133.007885);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_10', 'g_name_1', 486.033807, 't1__4d14cd', 'son_f78e17', 627.258639, 'bangla', '2024-09-18', 963.351729);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_11', 'g_name_1', 486.033807, 't1__4d14cd', 'son_f78e17', 587.103196, 't2__3ba7b7', '2020-06-23', 128.76421);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_12', 'g_name_1', 486.033807, 't1__4d14cd', 'son_f78e17', 467.07027, 'bangla', '2025-08-22', 769.021654);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "country" FROM (SELECT "song_name", "artist_name", "country", "f_id", "genre_is", "rating", "languages", "releasedate", "resolution", "country_other", "gender", "genre_is" AS "preferred_genre" FROM (SELECT "LHS"."song_name" AS "song_name", "LHS"."artist_name" AS "artist_name", "LHS"."country" AS "country", "LHS"."f_id" AS "f_id", "LHS"."genre_is" AS "genre_is", "LHS"."rating" AS "rating", "LHS"."languages" AS "languages", "LHS"."releasedate" AS "releasedate", "LHS"."resolution" AS "resolution", "RHS"."country" AS "country_other", "RHS"."gender" AS "gender" FROM "song" AS "LHS" INNER JOIN "artist" AS "RHS" ON ("LHS"."artist_name" = "RHS"."artist_name" AND "LHS"."genre_is" = "RHS"."preferred_genre"))) WHERE ("gender" = 'Female' AND "languages" = 'bangla') ORDER BY country, "country" NULLS LAST;

/*
Gold Result:
('son_f78e17',)
('son_f78e17',)
('son_f78e17',)
('son_f78e17',)
('son_f78e17',)
('son_f78e17',)
('son_f78e17',)
('son_f78e17',)
('son_f78e17',)
*/

-- Prediction Query
SELECT T1.country FROM artist AS T1 JOIN song AS T2 ON T1.artist_name = T2.artist_name WHERE T1.gender = 'Female' AND T2.languages = 'bangla';

/*
Prediction Result:
('t1__834723',)
('t1__834723',)
('t1__834723',)
('t1__834723',)
('t1__834723',)
('t1__834723',)
('t1__834723',)
('t1__834723',)
('t1__834723',)
*/