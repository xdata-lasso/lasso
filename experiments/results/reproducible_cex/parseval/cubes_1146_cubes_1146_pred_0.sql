-- Schema DDL
CREATE TABLE "genre" ("g_name" TEXT(20) PRIMARY KEY, "rating" TEXT(10), "most_popular_in" TEXT(50));

CREATE TABLE "artist" ("artist_name" TEXT(50) PRIMARY KEY, "preferred_genre" TEXT(50), "country" TEXT(20), "gender" TEXT(20), FOREIGN KEY ("preferred_genre") REFERENCES "genre" ("g_name"));

CREATE TABLE "files" ("f_id" REAL(10) PRIMARY KEY, "artist_name" TEXT(50), "file_size" TEXT(20), "duration" TEXT(20), "formats" TEXT(20), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

CREATE TABLE "song" ("song_name" TEXT(50) PRIMARY KEY, "genre_is" TEXT(20), "f_id" REAL(10), "artist_name" TEXT(50), "country" TEXT(20), "rating" REAL(10), "languages" TEXT(20), "releasedate" DATE, "resolution" REAL(10), FOREIGN KEY ("genre_is") REFERENCES "genre" ("g_name"), FOREIGN KEY ("f_id") REFERENCES "files" ("f_id"), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: genre --
INSERT INTO "genre" ("g_name", "rating", "most_popular_in") VALUES ('g_name_1', 'gen_df42ba', 'gen_145444');

INSERT INTO "genre" ("g_name", "rating", "most_popular_in") VALUES ('son_80bec1', 'gen_df42ba', 'gen_145444');

INSERT INTO "genre" ("g_name", "rating", "most_popular_in") VALUES ('son_40a48d', 'gen_df42ba', 'gen_145444');

-- Inserting into table: artist --
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('artist_name_1', 'g_name_1', 'art_2440df', 'art_c0de8b');

INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('son_9f2bf5', 'g_name_1', 'art_2440df', 'art_c0de8b');

INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('son_1e7d16', 'g_name_1', 'art_2440df', 'art_c0de8b');

-- Inserting into table: files --
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (1.0, 'artist_name_1', 'fil_2dd0e2', 'fil_2d04a5', 'fil_460987');

INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (165.344793, 'artist_name_1', 'fil_2dd0e2', 'fil_2d04a5', 'fil_460987');

INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (285.529132, 'son_9f2bf5', 'rhs_8a65bb', 'rhs_b29d91', 'rhs_ad5965');

INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (357.862717, 'son_9f2bf5', 'rhs_48d5dc', 'rhs_749394', 'rhs_8ae99f');

-- Inserting into table: song --
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('son_7a9016', 'son_80bec1', 1.0, 'son_9f2bf5', 'son_25dd0d', 1.0, 'son_c1b8e5', '2024-06-15', 799.99);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('son_4ee9b2', 'son_40a48d', 1.0, 'son_1e7d16', 'son_67b040', 1.0, 'son_b46b56', '2024-06-15', 799.99);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT file_size, formats FROM (SELECT LHS.song_name AS song_name, LHS.artist_name AS artist_name, LHS.country AS country, LHS.f_id AS f_id, LHS.genre_is AS genre_is, LHS.rating AS rating, LHS.languages AS languages, LHS.releasedate AS releasedate, LHS.resolution AS resolution, RHS.f_id AS f_id_other, RHS.file_size AS file_size, RHS.duration AS duration, RHS.formats AS formats FROM (SELECT * FROM song WHERE (resolution < 800.0)) AS LHS INNER JOIN files AS RHS ON (LHS.artist_name = RHS.artist_name)) ORDER BY file_size, formats NULLS LAST;

/*
Gold Result:
('rhs_48d5dc', 'rhs_8ae99f')
('rhs_8a65bb', 'rhs_ad5965')
*/

-- Prediction Query
SELECT DISTINCT T1.file_size, T1.formats FROM files AS T1 JOIN song AS T2 ON T1.f_id = T2.f_id WHERE T2.resolution < 800;

/*
Prediction Result:
('fil_2dd0e2', 'fil_460987')
*/