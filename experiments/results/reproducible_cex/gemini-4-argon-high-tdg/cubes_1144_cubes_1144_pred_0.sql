-- Schema DDL
CREATE TABLE "genre" ("g_name" TEXT(20) PRIMARY KEY, "rating" TEXT(10), "most_popular_in" TEXT(50));

CREATE TABLE "artist" ("artist_name" TEXT(50) PRIMARY KEY, "preferred_genre" TEXT(50), "country" TEXT(20), "gender" TEXT(20), FOREIGN KEY ("preferred_genre") REFERENCES "genre" ("g_name"));

CREATE TABLE "files" ("f_id" REAL(10) PRIMARY KEY, "artist_name" TEXT(50), "file_size" TEXT(20), "duration" TEXT(20), "formats" TEXT(20), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

CREATE TABLE "song" ("song_name" TEXT(50) PRIMARY KEY, "genre_is" TEXT(20), "f_id" REAL(10), "artist_name" TEXT(50), "country" TEXT(20), "rating" REAL(10), "languages" TEXT(20), "releasedate" DATE, "resolution" REAL(10), FOREIGN KEY ("genre_is") REFERENCES "genre" ("g_name"), FOREIGN KEY ("f_id") REFERENCES "files" ("f_id"), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "genre" ("g_name", "rating", "most_popular_in") VALUES ('pop', '9', 'UK');
INSERT INTO "genre" ("g_name", "rating", "most_popular_in") VALUES ('rock', '8', 'USA');
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('Band_X', 'pop', 'UK', 'Group');
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('Band_Y', 'rock', 'USA', 'Group');
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (5.0, 'Band_X', '8MB', '6:00', 'mp3');
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (6.0, 'Band_Y', '4MB', '3:30', 'aac');
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Dup_Track_1', 'pop', 5.0, 'Band_X', 'UK', 9.0, 'english', '2021-03-01', 320.0);
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Dup_Track_2', 'pop', 5.0, 'Band_X', 'USA', 7.0, 'english', '2022-03-01', 256.0);
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Unique_Track', 'rock', 6.0, 'Band_Y', 'USA', 8.0, 'english', '2020-03-01', 192.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "f_id", "genre_is", "artist_name" FROM "song" WHERE ("languages" = 'english') ORDER BY f_id, song.song_name NULLS LAST;

/*
Gold Result:
(5.0, 'pop', 'Band_X')
(5.0, 'pop', 'Band_X')
(6.0, 'rock', 'Band_Y')
*/

-- Prediction Query
SELECT f_id, genre_is, artist_name FROM song WHERE languages = 'english' ORDER BY rating, song.song_name NULLS LAST;

/*
Prediction Result:
(5.0, 'pop', 'Band_X')
(6.0, 'rock', 'Band_Y')
(5.0, 'pop', 'Band_X')
*/