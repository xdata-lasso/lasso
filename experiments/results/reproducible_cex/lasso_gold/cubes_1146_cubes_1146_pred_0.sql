-- Schema DDL
CREATE TABLE "genre" ("g_name" TEXT(20) PRIMARY KEY, "rating" TEXT(10), "most_popular_in" TEXT(50));

CREATE TABLE "artist" ("artist_name" TEXT(50) PRIMARY KEY, "preferred_genre" TEXT(50), "country" TEXT(20), "gender" TEXT(20), FOREIGN KEY ("preferred_genre") REFERENCES "genre" ("g_name"));

CREATE TABLE "files" ("f_id" REAL(10) PRIMARY KEY, "artist_name" TEXT(50), "file_size" TEXT(20), "duration" TEXT(20), "formats" TEXT(20), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

CREATE TABLE "song" ("song_name" TEXT(50) PRIMARY KEY, "genre_is" TEXT(20), "f_id" REAL(10), "artist_name" TEXT(50), "country" TEXT(20), "rating" REAL(10), "languages" TEXT(20), "releasedate" DATE, "resolution" REAL(10), FOREIGN KEY ("genre_is") REFERENCES "genre" ("g_name"), FOREIGN KEY ("f_id") REFERENCES "files" ("f_id"), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "genre" ("g_name", "rating", "most_popular_in") VALUES ('Valerie Gill', 'movement', 'while');
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('Mario Skinner', 'Valerie Gill', 'Madagascar', 'politics');
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('Fred Smith', NULL, NULL, NULL);
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (1016.5, 'Mario Skinner', 'decide', 'claim', 'hour');
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (1018.5, 'Fred Smith', 'decide', 'claim', 'hour');
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Kimberly Osborne', 'Valerie Gill', 1016.5, 'Mario Skinner', 'Marshall Islands', 1017.5, 'why', '1978-09-09', 799.0);
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Sherry Decker', 'Valerie Gill', 1016.5, 'Fred Smith', 'Marshall Islands', 1017.5, 'why', '1978-09-09', 799.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT file_size, formats FROM (SELECT LHS.song_name AS song_name, LHS.artist_name AS artist_name, LHS.country AS country, LHS.f_id AS f_id, LHS.genre_is AS genre_is, LHS.rating AS rating, LHS.languages AS languages, LHS.releasedate AS releasedate, LHS.resolution AS resolution, RHS.f_id AS f_id_other, RHS.file_size AS file_size, RHS.duration AS duration, RHS.formats AS formats FROM (SELECT * FROM song WHERE (resolution < 800.0)) AS LHS INNER JOIN files AS RHS ON (LHS.artist_name = RHS.artist_name)) ORDER BY file_size, formats NULLS LAST;

/*
Gold Result:
('decide', 'hour')
('decide', 'hour')
*/

-- Prediction Query
SELECT DISTINCT T1.file_size, T1.formats FROM files AS T1 JOIN song AS T2 ON T1.f_id = T2.f_id WHERE T2.resolution < 800;

/*
Prediction Result:
('decide', 'hour')
*/