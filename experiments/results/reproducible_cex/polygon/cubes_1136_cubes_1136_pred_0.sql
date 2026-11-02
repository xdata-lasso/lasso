-- Schema DDL
CREATE TABLE "genre" ("g_name" TEXT(20) PRIMARY KEY, "rating" TEXT(10), "most_popular_in" TEXT(50));

CREATE TABLE "artist" ("artist_name" TEXT(50) PRIMARY KEY, "preferred_genre" TEXT(50), "country" TEXT(20), "gender" TEXT(20), FOREIGN KEY ("preferred_genre") REFERENCES "genre" ("g_name"));

CREATE TABLE "files" ("f_id" REAL(10) PRIMARY KEY, "artist_name" TEXT(50), "file_size" TEXT(20), "duration" TEXT(20), "formats" TEXT(20), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

CREATE TABLE "song" ("song_name" TEXT(50) PRIMARY KEY, "genre_is" TEXT(20), "f_id" REAL(10), "artist_name" TEXT(50), "country" TEXT(20), "rating" REAL(10), "languages" TEXT(20), "releasedate" DATE, "resolution" REAL(10), FOREIGN KEY ("genre_is") REFERENCES "genre" ("g_name"), FOREIGN KEY ("f_id") REFERENCES "files" ("f_id"), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "genre" ("g_name", "rating", "most_popular_in") VALUES ('english13', NULL, NULL);
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('english14', 'english13', NULL, NULL);
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (16, 'english14', NULL, NULL, NULL);
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (15, 'english14', NULL, NULL, NULL);
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('english32', NULL, NULL, NULL, NULL, -900, 'english26', NULL, NULL);
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('english17', NULL, NULL, NULL, NULL, -900, 'english', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "song_name" FROM (SELECT "song_name", "artist_name", "country", "f_id", "genre_is", "rating", "languages", "releasedate", "resolution", MIN("rating") OVER () AS "minrating" FROM "song") WHERE ("languages" <> 'english' AND minrating = rating) ORDER BY song_name, "song_name" NULLS LAST;

/*
Gold Result:
('english32',)
*/

-- Prediction Query
SELECT song_name FROM song WHERE rating < (SELECT MIN(rating) FROM song WHERE languages = 'english');

/*
Prediction Result:
*/