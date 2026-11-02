-- Schema DDL
CREATE TABLE "genre" ("g_name" TEXT(20) PRIMARY KEY, "rating" TEXT(10), "most_popular_in" TEXT(50));

CREATE TABLE "artist" ("artist_name" TEXT(50) PRIMARY KEY, "preferred_genre" TEXT(50), "country" TEXT(20), "gender" TEXT(20), FOREIGN KEY ("preferred_genre") REFERENCES "genre" ("g_name"));

CREATE TABLE "files" ("f_id" REAL(10) PRIMARY KEY, "artist_name" TEXT(50), "file_size" TEXT(20), "duration" TEXT(20), "formats" TEXT(20), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

CREATE TABLE "song" ("song_name" TEXT(50) PRIMARY KEY, "genre_is" TEXT(20), "f_id" REAL(10), "artist_name" TEXT(50), "country" TEXT(20), "rating" REAL(10), "languages" TEXT(20), "releasedate" DATE, "resolution" REAL(10), FOREIGN KEY ("genre_is") REFERENCES "genre" ("g_name"), FOREIGN KEY ("f_id") REFERENCES "files" ("f_id"), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests composite INNER JOIN conditions: ensures both f_id AND artist_name must match.
-- Also tests outer join mutations (dangling rows in files and song).
INSERT INTO "genre" ("g_name", "rating", "most_popular_in") VALUES ('Rock', 'Med', 'UK');
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('Artist1', 'Rock', 'UK', 'M');
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('Artist2', 'Rock', 'UK', 'F');
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (1.0, 'Artist1', '5MB', '2:00', 'mp4');
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (2.0, 'Artist1', '6MB', '2:30', 'mp4');
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (3.0, 'Artist1', '7MB', '3:00', 'mp4');
-- Matches f_id=1.0, but artist_name mismatches ('Artist2' vs 'Artist1')
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('MismatchArtistSong', 'Rock', 1.0, 'Artist2', 'UK', 3.0, 'EN', '2021-01-01', 1080.0);
-- Matches artist_name='Artist1', but f_id is NULL
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('NullFidSong', 'Rock', NULL, 'Artist1', 'UK', 3.5, 'EN', '2021-01-02', 1080.0);
-- Valid match for both f_id and artist_name
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('ValidMatchSong', 'Rock', 2.0, 'Artist1', 'UK', 4.0, 'EN', '2021-01-03', 480.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "f_id" FROM (SELECT "LHS"."f_id" AS "f_id", "LHS"."artist_name" AS "artist_name", "LHS"."file_size" AS "file_size", "LHS"."duration" AS "duration", "LHS"."formats" AS "formats", "RHS"."song_name" AS "song_name", "RHS"."country" AS "country", "RHS"."genre_is" AS "genre_is", "RHS"."rating" AS "rating", "RHS"."languages" AS "languages", "RHS"."releasedate" AS "releasedate", "RHS"."resolution" AS "resolution" FROM "files" AS "LHS" INNER JOIN "song" AS "RHS" ON ("LHS"."artist_name" = "RHS"."artist_name" AND "LHS"."f_id" = "RHS"."f_id")) WHERE ("formats" = 'mp4' OR resolution > 720.0) ORDER BY f_id, "f_id" NULLS LAST;

/*
Gold Result:
(2.0,)
*/

-- Prediction Query
SELECT f_id FROM files WHERE formats = 'mp4' UNION SELECT f_id FROM song WHERE resolution > 720;

/*
Prediction Result:
(None,)
(1.0,)
(2.0,)
(3.0,)
*/