-- Schema DDL
CREATE TABLE "genre" ("g_name" TEXT(20) PRIMARY KEY, "rating" TEXT(10), "most_popular_in" TEXT(50));

CREATE TABLE "artist" ("artist_name" TEXT(50) PRIMARY KEY, "preferred_genre" TEXT(50), "country" TEXT(20), "gender" TEXT(20), FOREIGN KEY ("preferred_genre") REFERENCES "genre" ("g_name"));

CREATE TABLE "files" ("f_id" REAL(10) PRIMARY KEY, "artist_name" TEXT(50), "file_size" TEXT(20), "duration" TEXT(20), "formats" TEXT(20), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

CREATE TABLE "song" ("song_name" TEXT(50) PRIMARY KEY, "genre_is" TEXT(20), "f_id" REAL(10), "artist_name" TEXT(50), "country" TEXT(20), "rating" REAL(10), "languages" TEXT(20), "releasedate" DATE, "resolution" REAL(10), FOREIGN KEY ("genre_is") REFERENCES "genre" ("g_name"), FOREIGN KEY ("f_id") REFERENCES "files" ("f_id"), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: genre --
INSERT INTO "genre" ("g_name", "rating", "most_popular_in") VALUES ('g_name_1', 'gen_df42ba', 'gen_145444');

INSERT INTO "genre" ("g_name", "rating", "most_popular_in") VALUES ('rhs_75a1a6', 'gen_df42ba', 'gen_145444');

INSERT INTO "genre" ("g_name", "rating", "most_popular_in") VALUES ('rhs_eafabb', 'gen_df42ba', 'gen_145444');

-- Inserting into table: artist --
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('lhs_b7fcd3', 'g_name_1', 'art_2440df', 'art_c0de8b');

INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('lhs_cd825b', 'rhs_75a1a6', 'art_2440df', 'art_c0de8b');

-- Inserting into table: files --
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (1.0, 'lhs_b7fcd3', 'lhs_c9aa51', 'lhs_3c1277', 'A');

INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (486.033807, 'lhs_cd825b', 'lhs_59df5f', 'lhs_4305fe', 'A');

-- Inserting into table: song --
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('rhs_79f9bc', 'rhs_75a1a6', 1.0, 'lhs_b7fcd3', 'rhs_0f5f00', 1.0, 'rhs_2b0bb8', '2024-06-15', 1000.0);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('rhs_8380e9', 'rhs_eafabb', 1.0, 'lhs_b7fcd3', 'rhs_86297f', 1.0, 'rhs_a04083', '2024-06-15', 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "song_name" FROM (SELECT "LHS"."f_id" AS "f_id", "LHS"."artist_name" AS "artist_name", "LHS"."file_size" AS "file_size", "LHS"."duration" AS "duration", "LHS"."formats" AS "formats", "RHS"."song_name" AS "song_name", "RHS"."country" AS "country", "RHS"."genre_is" AS "genre_is", "RHS"."rating" AS "rating", "RHS"."languages" AS "languages", "RHS"."releasedate" AS "releasedate", "RHS"."resolution" AS "resolution" FROM "files" AS "LHS" INNER JOIN "song" AS "RHS" ON ("LHS"."artist_name" = "RHS"."artist_name" AND "LHS"."f_id" = "RHS"."f_id")) WHERE ("formats" = 'mp3' OR resolution = 1000.0) ORDER BY song_name, "song_name" NULLS LAST;

/*
Gold Result:
('rhs_79f9bc',)
*/

-- Prediction Query
SELECT T2.song_name FROM files AS T1 JOIN song AS T2 ON T1.f_id = T2.f_id WHERE T1.formats = 'mp3' INTERSECT SELECT song_name FROM song WHERE resolution < 1000;

/*
Prediction Result:
*/