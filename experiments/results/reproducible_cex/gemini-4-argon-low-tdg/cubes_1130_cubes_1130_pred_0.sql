-- Schema DDL
CREATE TABLE "genre" ("g_name" TEXT(20) PRIMARY KEY, "rating" TEXT(10), "most_popular_in" TEXT(50));

CREATE TABLE "artist" ("artist_name" TEXT(50) PRIMARY KEY, "preferred_genre" TEXT(50), "country" TEXT(20), "gender" TEXT(20), FOREIGN KEY ("preferred_genre") REFERENCES "genre" ("g_name"));

CREATE TABLE "files" ("f_id" REAL(10) PRIMARY KEY, "artist_name" TEXT(50), "file_size" TEXT(20), "duration" TEXT(20), "formats" TEXT(20), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

CREATE TABLE "song" ("song_name" TEXT(50) PRIMARY KEY, "genre_is" TEXT(20), "f_id" REAL(10), "artist_name" TEXT(50), "country" TEXT(20), "rating" REAL(10), "languages" TEXT(20), "releasedate" DATE, "resolution" REAL(10), FOREIGN KEY ("genre_is") REFERENCES "genre" ("g_name"), FOREIGN KEY ("f_id") REFERENCES "files" ("f_id"), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic WHERE filtering ('english' vs other values, NULL, case sensitivity, substrings) and ORDER BY song_name (inserted out of alphabetical order, whereas other columns like rating/f_id are ordered differently to catch wrong ORDER BY column or direction).
INSERT INTO "genre" ("g_name", "rating", "most_popular_in") VALUES ('Pop', '8', 'USA');
INSERT INTO "genre" ("g_name", "rating", "most_popular_in") VALUES ('Rock', '9', 'UK');
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('ArtistA', 'Pop', 'USA', 'Female');
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('ArtistB', 'Rock', 'UK', 'Male');
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (1.0, 'ArtistA', '3MB', '3:00', 'mp3');
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (2.0, 'ArtistB', '4MB', '4:00', 'wav');
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (3.0, 'ArtistA', '5MB', '5:00', 'flac');
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Zebra', 'Pop', 1.0, 'ArtistA', 'USA', 10.0, 'english', '2020-01-01', 320.0);
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Apple', 'Rock', 3.0, 'ArtistB', 'UK', 5.0, 'english', '2022-01-01', 128.0);
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Mango', 'Pop', 2.0, 'ArtistA', 'Canada', 8.0, 'english', '2021-01-01', 256.0);
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Banana', 'Rock', 1.0, 'ArtistB', 'Spain', 9.0, 'spanish', '2019-01-01', 320.0);
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Cherry', 'Pop', 2.0, 'ArtistA', 'USA', 7.0, 'English', '2020-05-05', 192.0);
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Date', 'Rock', 3.0, 'ArtistB', 'UK', 6.0, NULL, '2018-03-03', 256.0);
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Elderberry', 'Pop', 1.0, 'ArtistA', 'USA', 4.0, 'english_us', '2023-01-01', 320.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "song_name" FROM "song" WHERE ("languages" = 'english') ORDER BY song_name;

/*
Gold Result:
('Apple',)
('Mango',)
('Zebra',)
*/

-- Prediction Query
SELECT song_name FROM song WHERE languages = 'english';

/*
Prediction Result:
('Zebra',)
('Apple',)
('Mango',)
*/