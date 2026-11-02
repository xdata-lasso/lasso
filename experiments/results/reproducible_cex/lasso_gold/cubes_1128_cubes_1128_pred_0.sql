-- Schema DDL
CREATE TABLE "genre" ("g_name" TEXT(20) PRIMARY KEY, "rating" TEXT(10), "most_popular_in" TEXT(50));

CREATE TABLE "artist" ("artist_name" TEXT(50) PRIMARY KEY, "preferred_genre" TEXT(50), "country" TEXT(20), "gender" TEXT(20), FOREIGN KEY ("preferred_genre") REFERENCES "genre" ("g_name"));

CREATE TABLE "files" ("f_id" REAL(10) PRIMARY KEY, "artist_name" TEXT(50), "file_size" TEXT(20), "duration" TEXT(20), "formats" TEXT(20), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

CREATE TABLE "song" ("song_name" TEXT(50) PRIMARY KEY, "genre_is" TEXT(20), "f_id" REAL(10), "artist_name" TEXT(50), "country" TEXT(20), "rating" REAL(10), "languages" TEXT(20), "releasedate" DATE, "resolution" REAL(10), FOREIGN KEY ("genre_is") REFERENCES "genre" ("g_name"), FOREIGN KEY ("f_id") REFERENCES "files" ("f_id"), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "genre" ("g_name", "rating", "most_popular_in") VALUES ('Amber Kidd', 'think', 'administration');
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('Tammy Allison', 'Amber Kidd', 'Chad', 'investment');
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (1030.5, 'Tammy Allison', 'mention', 'medical', 'different');
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Stephanie Martin', 'Amber Kidd', 1030.5, 'Tammy Allison', 'Afghanistan', 8.0, 'english', '1985-05-16', 1031.5);
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Mrs. Rachel Gibson', 'Amber Kidd', 1030.5, 'Tammy Allison', 'Afghanistan', 8.0, 'english', '1985-05-16', 1031.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "artist_name" FROM "song" WHERE ("languages" = 'english' AND rating <= 8.0) ORDER BY artist_name, song.song_name NULLS LAST;

/*
Gold Result:
('Tammy Allison',)
('Tammy Allison',)
*/

-- Prediction Query
SELECT DISTINCT artist_name FROM song WHERE languages = 'english' EXCEPT SELECT DISTINCT artist_name FROM song WHERE rating > 8;

/*
Prediction Result:
('Tammy Allison',)
*/