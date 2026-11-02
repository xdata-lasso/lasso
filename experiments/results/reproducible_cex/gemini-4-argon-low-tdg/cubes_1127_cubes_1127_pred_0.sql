-- Schema DDL
CREATE TABLE "genre" ("g_name" TEXT(20) PRIMARY KEY, "rating" TEXT(10), "most_popular_in" TEXT(50));

CREATE TABLE "artist" ("artist_name" TEXT(50) PRIMARY KEY, "preferred_genre" TEXT(50), "country" TEXT(20), "gender" TEXT(20), FOREIGN KEY ("preferred_genre") REFERENCES "genre" ("g_name"));

CREATE TABLE "files" ("f_id" REAL(10) PRIMARY KEY, "artist_name" TEXT(50), "file_size" TEXT(20), "duration" TEXT(20), "formats" TEXT(20), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

CREATE TABLE "song" ("song_name" TEXT(50) PRIMARY KEY, "genre_is" TEXT(20), "f_id" REAL(10), "artist_name" TEXT(50), "country" TEXT(20), "rating" REAL(10), "languages" TEXT(20), "releasedate" DATE, "resolution" REAL(10), FOREIGN KEY ("genre_is") REFERENCES "genre" ("g_name"), FOREIGN KEY ("f_id") REFERENCES "files" ("f_id"), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "genre" ("g_name", "rating", "most_popular_in") VALUES ('modern', '10', 'US');
INSERT INTO "genre" ("g_name", "rating", "most_popular_in") VALUES ('classic', '8', 'UK');
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('Art1', 'modern', 'US', 'M');
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (1.0, 'Art1', '10MB', '3:00', 'mp3');
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Song_Z', 'modern', 1.0, 'Art1', 'US', 5.0, 'spanish', '2020-01-01', 320.0);
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Song_A', 'classic', 1.0, 'Art1', 'US', 4.0, 'english', '2020-01-02', 320.0);
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Song_M', 'modern', 1.0, 'Art1', 'US', 3.0, 'english', '2020-01-03', 320.0);
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Song_X', 'classic', 1.0, 'Art1', 'US', 2.0, 'spanish', '2020-01-04', 320.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "song_name" FROM "song" WHERE ("genre_is" = 'modern' OR "languages" = 'english') ORDER BY song_name;

/*
Gold Result:
('Song_A',)
('Song_M',)
('Song_Z',)
*/

-- Prediction Query
SELECT song_name FROM song WHERE genre_is = 'modern' OR languages = 'english';

/*
Prediction Result:
('Song_Z',)
('Song_A',)
('Song_M',)
*/