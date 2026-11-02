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
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('artist_name_1', 'g_name_1', 'art_2440df', 'art_c0de8b');

-- Inserting into table: files --
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (1.0, 'artist_name_1', 'fil_2dd0e2', 'fil_2d04a5', 'mp4');

INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (357.862717, 'artist_name_1', 'fil_2dd0e2', 'fil_2d04a5', 'mp4');

-- Inserting into table: song --
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_1', 'g_name_1', 1.0, 'artist_name_1', 'son_f78e17', 486.033807, 'son_40bca8', '2023-11-15', 720.01);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Q', 'g_name_1', 1.0, 'artist_name_1', 'son_f78e17', 171.746906, 'son_40bca8', '2022-04-27', 720.01);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('A', 'g_name_1', 1.0, 'artist_name_1', 'son_f78e17', 249.706432, 'son_40bca8', '2021-02-11', 720.01);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_4', 'g_name_1', 1.0, 'artist_name_1', 'son_f78e17', 906.21648, 'son_40bca8', '2025-06-04', 720.01);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_5', 'g_name_1', 1.0, 'artist_name_1', 'son_f78e17', 710.998147, 'son_40bca8', '2020-01-20', 720.0);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_6', 'g_name_1', 1.0, 'artist_name_1', 'son_f78e17', 882.963176, 'son_40bca8', '2021-03-30', 720.01);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('C', 'g_name_1', 1.0, 'artist_name_1', 'son_f78e17', 285.529132, 'son_40bca8', '2024-01-05', NULL);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('@', 'g_name_1', 1.0, 'artist_name_1', 'son_f78e17', 285.529132, 'son_40bca8', '2024-01-05', 720.01);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "f_id" FROM (SELECT "LHS"."f_id" AS "f_id", "LHS"."artist_name" AS "artist_name", "LHS"."file_size" AS "file_size", "LHS"."duration" AS "duration", "LHS"."formats" AS "formats", "RHS"."song_name" AS "song_name", "RHS"."country" AS "country", "RHS"."genre_is" AS "genre_is", "RHS"."rating" AS "rating", "RHS"."languages" AS "languages", "RHS"."releasedate" AS "releasedate", "RHS"."resolution" AS "resolution" FROM "files" AS "LHS" INNER JOIN "song" AS "RHS" ON ("LHS"."artist_name" = "RHS"."artist_name" AND "LHS"."f_id" = "RHS"."f_id")) WHERE ("formats" = 'mp4' OR resolution > 720.0) ORDER BY f_id, "f_id" NULLS LAST;

/*
Gold Result:
(1.0,)
(1.0,)
(1.0,)
(1.0,)
(1.0,)
(1.0,)
(1.0,)
(1.0,)
*/

-- Prediction Query
SELECT f_id FROM files WHERE formats = 'mp4' UNION SELECT f_id FROM song WHERE resolution > 720;

/*
Prediction Result:
(1.0,)
(357.862717,)
*/