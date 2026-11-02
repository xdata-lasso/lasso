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
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (1.0, 'artist_name_1', 'fil_2dd0e2', 'fil_2d04a5', 'fil_460987');

INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (-1.0, 'artist_name_1', 'fil_2dd0e2', 'A', 'fil_460987');

INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (0.0, 'artist_name_1', 'fil_2dd0e2', '"', 'fil_460987');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT f_id FROM (SELECT LHS.f_id AS f_id, LHS.artist_name AS artist_name, LHS.file_size AS file_size, LHS.duration AS duration, LHS.formats AS formats, LHS.maxduration AS maxduration, RHS.f_id AS f_id_other, RHS.artist_name AS artist_name_other, RHS.formats AS formats_other FROM (SELECT f_id, artist_name, file_size, duration, formats, MAX(duration) OVER () AS maxduration FROM files) AS LHS INNER JOIN files AS RHS ON (LHS.file_size = RHS.file_size AND LHS.maxduration = RHS.duration)) ORDER BY f_id;

/*
Gold Result:
(-1.0,)
(0.0,)
(1.0,)
*/

-- Prediction Query
SELECT f_id FROM files ORDER BY duration DESC, files.f_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(1.0,)
*/