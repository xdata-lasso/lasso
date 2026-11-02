-- Schema DDL
CREATE TABLE "genre" ("g_name" TEXT(20) PRIMARY KEY, "rating" TEXT(10), "most_popular_in" TEXT(50));

CREATE TABLE "artist" ("artist_name" TEXT(50) PRIMARY KEY, "preferred_genre" TEXT(50), "country" TEXT(20), "gender" TEXT(20), FOREIGN KEY ("preferred_genre") REFERENCES "genre" ("g_name"));

CREATE TABLE "files" ("f_id" REAL(10) PRIMARY KEY, "artist_name" TEXT(50), "file_size" TEXT(20), "duration" TEXT(20), "formats" TEXT(20), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

CREATE TABLE "song" ("song_name" TEXT(50) PRIMARY KEY, "genre_is" TEXT(20), "f_id" REAL(10), "artist_name" TEXT(50), "country" TEXT(20), "rating" REAL(10), "languages" TEXT(20), "releasedate" DATE, "resolution" REAL(10), FOREIGN KEY ("genre_is") REFERENCES "genre" ("g_name"), FOREIGN KEY ("f_id") REFERENCES "files" ("f_id"), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "genre" ("g_name", "rating", "most_popular_in") VALUES ('Rock', '9', 'USA');
INSERT INTO "genre" ("g_name", "rating", "most_popular_in") VALUES ('Pop', '8', 'UK');
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('Artist Z', 'Rock', 'USA', 'Male');
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('Artist A', 'Pop', 'UK', 'Female');
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (100.0, 'Artist Z', '5MB', '3:00', 'mp3');
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (10.0, 'Artist A', '4MB', '2:30', 'wav');
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Zebra', 'Rock', 10.0, 'Artist A', 'Canada', 1.0, 'English', '2023-01-01', 128.0);
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Apple', 'Pop', 100.0, 'Artist Z', 'USA', 10.0, 'Spanish', '2020-01-01', 320.0);
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Mango', 'Rock', 10.0, 'Artist Z', 'UK', 5.0, 'French', '2021-06-15', 256.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT song_name FROM song ORDER BY song_name;

/*
Gold Result:
('Apple',)
('Mango',)
('Zebra',)
*/

-- Prediction Query
SELECT song_name FROM song ORDER BY resolution, song.song_name NULLS LAST;

/*
Prediction Result:
('Zebra',)
('Mango',)
('Apple',)
*/