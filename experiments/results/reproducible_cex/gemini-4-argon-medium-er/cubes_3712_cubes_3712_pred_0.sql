-- Schema DDL
CREATE TABLE "genre" ("g_name" TEXT(20) PRIMARY KEY, "rating" TEXT(10), "most_popular_in" TEXT(50));

CREATE TABLE "artist" ("artist_name" TEXT(50) PRIMARY KEY, "preferred_genre" TEXT(50), "country" TEXT(20), "gender" TEXT(20), FOREIGN KEY ("preferred_genre") REFERENCES "genre" ("g_name"));

CREATE TABLE "files" ("f_id" REAL(10) PRIMARY KEY, "artist_name" TEXT(50), "file_size" TEXT(20), "duration" TEXT(20), "formats" TEXT(20), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

CREATE TABLE "song" ("song_name" TEXT(50) PRIMARY KEY, "genre_is" TEXT(20), "f_id" REAL(10), "artist_name" TEXT(50), "country" TEXT(20), "rating" REAL(10), "languages" TEXT(20), "releasedate" DATE, "resolution" REAL(10), FOREIGN KEY ("genre_is") REFERENCES "genre" ("g_name"), FOREIGN KEY ("f_id") REFERENCES "files" ("f_id"), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO genre (g_name, rating, most_popular_in) VALUES ('Pop', '5', 'US');
INSERT INTO artist (artist_name, preferred_genre, country, gender) VALUES ('A1', 'Pop', 'US', 'F');
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (1, 'A1', '10MB', '100', 'mp3');
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (2, 'A1', '20MB', '100', 'mp3');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT f_id FROM (SELECT LHS.f_id AS f_id, LHS.artist_name AS artist_name, LHS.file_size AS file_size, LHS.duration AS duration, LHS.formats AS formats, LHS.maxduration AS maxduration, RHS.f_id AS f_id_other, RHS.artist_name AS artist_name_other, RHS.formats AS formats_other FROM (SELECT f_id, artist_name, file_size, duration, formats, MAX(duration) OVER () AS maxduration FROM files) AS LHS INNER JOIN files AS RHS ON (LHS.file_size = RHS.file_size AND LHS.maxduration = RHS.duration)) ORDER BY f_id;

/*
Gold Result:
(1.0,)
(2.0,)
*/

-- Prediction Query
SELECT f_id FROM files ORDER BY duration DESC, files.f_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(1.0,)
*/