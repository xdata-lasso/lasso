-- Schema DDL
CREATE TABLE "genre" ("g_name" TEXT(20) PRIMARY KEY, "rating" TEXT(10), "most_popular_in" TEXT(50));

CREATE TABLE "artist" ("artist_name" TEXT(50) PRIMARY KEY, "preferred_genre" TEXT(50), "country" TEXT(20), "gender" TEXT(20), FOREIGN KEY ("preferred_genre") REFERENCES "genre" ("g_name"));

CREATE TABLE "files" ("f_id" REAL(10) PRIMARY KEY, "artist_name" TEXT(50), "file_size" TEXT(20), "duration" TEXT(20), "formats" TEXT(20), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

CREATE TABLE "song" ("song_name" TEXT(50) PRIMARY KEY, "genre_is" TEXT(20), "f_id" REAL(10), "artist_name" TEXT(50), "country" TEXT(20), "rating" REAL(10), "languages" TEXT(20), "releasedate" DATE, "resolution" REAL(10), FOREIGN KEY ("genre_is") REFERENCES "genre" ("g_name"), FOREIGN KEY ("f_id") REFERENCES "files" ("f_id"), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests composite INNER JOIN conditions ("artist_name" AND "f_id"), outer join mutations (dangling rows), and DISTINCT vs ALL (multiplicity).
INSERT INTO "genre" ("g_name", "rating", "most_popular_in") VALUES ('Rock', '4', 'UK');
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('ArtistA', 'Rock', 'UK', 'Male');
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('ArtistB', 'Rock', 'UK', 'Female');
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (1.0, 'ArtistA', '5MB', '2:30', 'mp4');
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (2.0, 'ArtistA', '5MB', '2:30', 'mp4');
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (3.0, 'ArtistB', '5MB', '2:30', 'mp4');
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (4.0, 'ArtistA', '5MB', '2:30', 'mp4');
-- Matches f_id=1.0 on both f_id and artist_name (Duplicate songs for same file to test DISTINCT mutations)
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Song_Match1', 'Rock', 1.0, 'ArtistA', 'UK', 5.0, 'English', '2021-01-01', 1080.0);
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Song_Match2', 'Rock', 1.0, 'ArtistA', 'UK', 4.0, 'English', '2021-01-02', 1080.0);
-- Matches f_id=2.0 on f_id, but mismatches on artist_name (ArtistB instead of ArtistA)
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Song_MismatchArtist', 'Rock', 2.0, 'ArtistB', 'UK', 3.0, 'English', '2021-01-03', 1080.0);
-- Matches ArtistA on artist_name, but mismatches on f_id (3.0 belongs to ArtistB in files)
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Song_MismatchFid', 'Rock', 3.0, 'ArtistA', 'UK', 3.0, 'English', '2021-01-04', 1080.0);
-- Song with NULL f_id (dangling from song side, tests RIGHT JOIN mutations)
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Song_NullFid', 'Rock', NULL, 'ArtistA', 'UK', 3.0, 'English', '2021-01-05', 1080.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "f_id" FROM (SELECT "LHS"."f_id" AS "f_id", "LHS"."artist_name" AS "artist_name", "LHS"."file_size" AS "file_size", "LHS"."duration" AS "duration", "LHS"."formats" AS "formats", "RHS"."song_name" AS "song_name", "RHS"."country" AS "country", "RHS"."genre_is" AS "genre_is", "RHS"."rating" AS "rating", "RHS"."languages" AS "languages", "RHS"."releasedate" AS "releasedate", "RHS"."resolution" AS "resolution" FROM "files" AS "LHS" INNER JOIN "song" AS "RHS" ON ("LHS"."artist_name" = "RHS"."artist_name" AND "LHS"."f_id" = "RHS"."f_id")) WHERE ("formats" = 'mp4' OR resolution > 720.0) ORDER BY f_id, "f_id" NULLS LAST;

/*
Gold Result:
(1.0,)
(1.0,)
*/

-- Prediction Query
SELECT f_id FROM files WHERE formats = 'mp4' UNION SELECT f_id FROM song WHERE resolution > 720;

/*
Prediction Result:
(None,)
(1.0,)
(2.0,)
(3.0,)
(4.0,)
*/