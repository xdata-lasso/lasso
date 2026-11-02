-- Schema DDL
CREATE TABLE "genre" ("g_name" TEXT(20) PRIMARY KEY, "rating" TEXT(10), "most_popular_in" TEXT(50));

CREATE TABLE "artist" ("artist_name" TEXT(50) PRIMARY KEY, "preferred_genre" TEXT(50), "country" TEXT(20), "gender" TEXT(20), FOREIGN KEY ("preferred_genre") REFERENCES "genre" ("g_name"));

CREATE TABLE "files" ("f_id" REAL(10) PRIMARY KEY, "artist_name" TEXT(50), "file_size" TEXT(20), "duration" TEXT(20), "formats" TEXT(20), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

CREATE TABLE "song" ("song_name" TEXT(50) PRIMARY KEY, "genre_is" TEXT(20), "f_id" REAL(10), "artist_name" TEXT(50), "country" TEXT(20), "rating" REAL(10), "languages" TEXT(20), "releasedate" DATE, "resolution" REAL(10), FOREIGN KEY ("genre_is") REFERENCES "genre" ("g_name"), FOREIGN KEY ("f_id") REFERENCES "files" ("f_id"), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "genre" ("g_name", "rating", "most_popular_in") VALUES ('George Chapman', 'drug', 'per');
INSERT INTO "genre" ("g_name", "rating", "most_popular_in") VALUES ('Carlos Walls', 'own', 'part');
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('Benjamin Welch', 'George Chapman', 'Denmark', 'author');
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('Richard Aguirre', 'Carlos Walls', 'Comoros', 'between');
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (1037.5, 'Benjamin Welch', 'western', 'almost', 'trade');
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (1040.5, 'Richard Aguirre', 'bill', 'reason', 'lawyer');
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Jose Ramirez', 'George Chapman', 1037.5, 'Benjamin Welch', 'Austria', 1038.5, 'english', '1982-02-13', 1039.5);
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Jason Shields', 'Carlos Walls', 1040.5, 'Richard Aguirre', 'Libyan Arab Jamahiriya', 1041.5, 'english', '1983-03-14', 1042.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "song_name" FROM "song" WHERE ("languages" = 'english') ORDER BY song_name;

/*
Gold Result:
('Jason Shields',)
('Jose Ramirez',)
*/

-- Prediction Query
SELECT song_name FROM song WHERE languages = 'english';

/*
Prediction Result:
('Jose Ramirez',)
('Jason Shields',)
*/