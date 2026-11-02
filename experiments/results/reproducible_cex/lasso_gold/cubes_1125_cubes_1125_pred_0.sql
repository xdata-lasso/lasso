-- Schema DDL
CREATE TABLE "genre" ("g_name" TEXT(20) PRIMARY KEY, "rating" TEXT(10), "most_popular_in" TEXT(50));

CREATE TABLE "artist" ("artist_name" TEXT(50) PRIMARY KEY, "preferred_genre" TEXT(50), "country" TEXT(20), "gender" TEXT(20), FOREIGN KEY ("preferred_genre") REFERENCES "genre" ("g_name"));

CREATE TABLE "files" ("f_id" REAL(10) PRIMARY KEY, "artist_name" TEXT(50), "file_size" TEXT(20), "duration" TEXT(20), "formats" TEXT(20), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

CREATE TABLE "song" ("song_name" TEXT(50) PRIMARY KEY, "genre_is" TEXT(20), "f_id" REAL(10), "artist_name" TEXT(50), "country" TEXT(20), "rating" REAL(10), "languages" TEXT(20), "releasedate" DATE, "resolution" REAL(10), FOREIGN KEY ("genre_is") REFERENCES "genre" ("g_name"), FOREIGN KEY ("f_id") REFERENCES "files" ("f_id"), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "genre" ("g_name", "rating", "most_popular_in") VALUES ('Jesse Mckay', 'type', 'serve');
INSERT INTO "genre" ("g_name", "rating", "most_popular_in") VALUES ('Mark Lynch', 'claim', 'hour');
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('Jonathan White', 'Jesse Mckay', 'United States Minor Outlying Islands', 'born');
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('Kimberly Osborne', 'Mark Lynch', 'Marshall Islands', 'why');
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (1014.5, 'Jonathan White', 'a', 'place', 'mp3');
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (1013.5, 'Kimberly Osborne', 'truth', 'process', 'mp3');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "f_id" FROM "files" WHERE ("formats" = 'mp3') ORDER BY f_id;

/*
Gold Result:
(1013.5,)
(1014.5,)
*/

-- Prediction Query
SELECT f_id FROM files WHERE formats = 'mp3';

/*
Prediction Result:
(1014.5,)
(1013.5,)
*/