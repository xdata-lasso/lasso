-- Schema DDL
CREATE TABLE "genre" ("g_name" TEXT(20) PRIMARY KEY, "rating" TEXT(10), "most_popular_in" TEXT(50));

CREATE TABLE "artist" ("artist_name" TEXT(50) PRIMARY KEY, "preferred_genre" TEXT(50), "country" TEXT(20), "gender" TEXT(20), FOREIGN KEY ("preferred_genre") REFERENCES "genre" ("g_name"));

CREATE TABLE "files" ("f_id" REAL(10) PRIMARY KEY, "artist_name" TEXT(50), "file_size" TEXT(20), "duration" TEXT(20), "formats" TEXT(20), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

CREATE TABLE "song" ("song_name" TEXT(50) PRIMARY KEY, "genre_is" TEXT(20), "f_id" REAL(10), "artist_name" TEXT(50), "country" TEXT(20), "rating" REAL(10), "languages" TEXT(20), "releasedate" DATE, "resolution" REAL(10), FOREIGN KEY ("genre_is") REFERENCES "genre" ("g_name"), FOREIGN KEY ("f_id") REFERENCES "files" ("f_id"), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "genre" ("g_name", "rating", "most_popular_in") VALUES ('Laura Kennedy', 'still', 'material');
INSERT INTO "genre" ("g_name", "rating", "most_popular_in") VALUES ('James Morgan', 'training', 'boy');
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('Cheryl Davis', 'Laura Kennedy', 'Jersey', 'health');
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('Connor West', 'James Morgan', 'Jamaica', 'cover');
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (1041.5, 'Cheryl Davis', 'land', 'item', 'manage');
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (1040.5, 'Connor West', 'family', 'maintain', 'enjoy');
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Amy Valdez', 'Laura Kennedy', 1041.5, 'Cheryl Davis', 'Oman', 1041.5, 'english', '1983-03-14', 1042.5);
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Angela Morton', 'James Morgan', 1040.5, 'Connor West', 'Togo', 1044.5, 'english', '1984-04-15', 1045.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "f_id", "genre_is", "artist_name" FROM "song" WHERE ("languages" = 'english') ORDER BY f_id, song.song_name NULLS LAST;

/*
Gold Result:
(1040.5, 'James Morgan', 'Connor West')
(1041.5, 'Laura Kennedy', 'Cheryl Davis')
*/

-- Prediction Query
SELECT f_id, genre_is, artist_name FROM song WHERE languages = 'english' ORDER BY rating, song.song_name NULLS LAST;

/*
Prediction Result:
(1041.5, 'Laura Kennedy', 'Cheryl Davis')
(1040.5, 'James Morgan', 'Connor West')
*/