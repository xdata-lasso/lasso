-- Schema DDL
CREATE TABLE "genre" ("g_name" TEXT(20) PRIMARY KEY, "rating" TEXT(10), "most_popular_in" TEXT(50));

CREATE TABLE "artist" ("artist_name" TEXT(50) PRIMARY KEY, "preferred_genre" TEXT(50), "country" TEXT(20), "gender" TEXT(20), FOREIGN KEY ("preferred_genre") REFERENCES "genre" ("g_name"));

CREATE TABLE "files" ("f_id" REAL(10) PRIMARY KEY, "artist_name" TEXT(50), "file_size" TEXT(20), "duration" TEXT(20), "formats" TEXT(20), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

CREATE TABLE "song" ("song_name" TEXT(50) PRIMARY KEY, "genre_is" TEXT(20), "f_id" REAL(10), "artist_name" TEXT(50), "country" TEXT(20), "rating" REAL(10), "languages" TEXT(20), "releasedate" DATE, "resolution" REAL(10), FOREIGN KEY ("genre_is") REFERENCES "genre" ("g_name"), FOREIGN KEY ("f_id") REFERENCES "files" ("f_id"), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests join condition: joining on artist_name vs joining on f_id, or joining on both.
INSERT INTO "genre" ("g_name", "rating", "most_popular_in") VALUES ('Pop', '4', 'UK');
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('Art1', 'Pop', 'UK', 'F');
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('Art2', 'Pop', 'USA', 'M');
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (10.0, 'Art1', '15MB', '3:10', 'MP3');
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (20.0, 'Art2', '25MB', '3:50', 'WAV');
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (30.0, 'Art1', '35MB', '4:10', 'AAC');
-- Song1 has f_id = 20.0 (which belongs to Art2), but Song1's artist_name is Art1.
-- Joining on artist_name matches files 10.0 and 30.0. Joining on f_id matches file 20.0.
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('CrossRefSong', 'Pop', 20.0, 'Art1', 'UK', 4.8, 'English', '2021-05-05', 500.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT file_size, formats FROM (SELECT LHS.song_name AS song_name, LHS.artist_name AS artist_name, LHS.country AS country, LHS.f_id AS f_id, LHS.genre_is AS genre_is, LHS.rating AS rating, LHS.languages AS languages, LHS.releasedate AS releasedate, LHS.resolution AS resolution, RHS.f_id AS f_id_other, RHS.file_size AS file_size, RHS.duration AS duration, RHS.formats AS formats FROM (SELECT * FROM song WHERE (resolution < 800.0)) AS LHS INNER JOIN files AS RHS ON (LHS.artist_name = RHS.artist_name)) ORDER BY file_size, formats NULLS LAST;

/*
Gold Result:
('15MB', 'MP3')
('35MB', 'AAC')
*/

-- Prediction Query
SELECT DISTINCT T1.file_size, T1.formats FROM files AS T1 JOIN song AS T2 ON T1.f_id = T2.f_id WHERE T2.resolution < 800;

/*
Prediction Result:
('25MB', 'WAV')
*/