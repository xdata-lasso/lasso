-- Schema DDL
CREATE TABLE "genre" ("g_name" TEXT(20) PRIMARY KEY, "rating" TEXT(10), "most_popular_in" TEXT(50));

CREATE TABLE "artist" ("artist_name" TEXT(50) PRIMARY KEY, "preferred_genre" TEXT(50), "country" TEXT(20), "gender" TEXT(20), FOREIGN KEY ("preferred_genre") REFERENCES "genre" ("g_name"));

CREATE TABLE "files" ("f_id" REAL(10) PRIMARY KEY, "artist_name" TEXT(50), "file_size" TEXT(20), "duration" TEXT(20), "formats" TEXT(20), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

CREATE TABLE "song" ("song_name" TEXT(50) PRIMARY KEY, "genre_is" TEXT(20), "f_id" REAL(10), "artist_name" TEXT(50), "country" TEXT(20), "rating" REAL(10), "languages" TEXT(20), "releasedate" DATE, "resolution" REAL(10), FOREIGN KEY ("genre_is") REFERENCES "genre" ("g_name"), FOREIGN KEY ("f_id") REFERENCES "files" ("f_id"), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "genre" ("g_name", "rating", "most_popular_in") VALUES ('rock', '8', 'US');
INSERT INTO "genre" ("g_name", "rating", "most_popular_in") VALUES ('pop', '9', 'UK');
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('ArtistA', 'rock', 'US', 'M');
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('ArtistB', 'pop', 'UK', 'F');
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (1.0, 'ArtistA', '3MB', '3:00', 'mp3');
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (2.0, 'ArtistB', '4MB', '4:00', 'wav');
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Song_Z', 'rock', 2.0, 'ArtistA', 'UK', 4.5, 'english', '2020-01-01', 320.0);
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Song_A', 'pop', 2.0, 'ArtistB', 'US', 3.5, 'english', '2021-01-01', 128.0);
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Song_M', 'rock', 1.0, 'ArtistB', 'CA', 5.0, 'english', '2019-05-05', 256.0);
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Song_F', 'pop', 1.0, 'ArtistA', 'FR', 4.0, 'french', '2022-03-03', 320.0);
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Song_E', 'rock', 1.0, 'ArtistA', 'US', 4.2, 'English', '2022-04-04', 320.0);
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Song_N', 'pop', 1.0, 'ArtistB', 'US', 4.1, NULL, '2022-05-05', 320.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "f_id", "genre_is", "artist_name" FROM "song" WHERE ("languages" = 'english') ORDER BY f_id, song.song_name NULLS LAST;

/*
Gold Result:
(1.0, 'rock', 'ArtistB')
(2.0, 'pop', 'ArtistB')
(2.0, 'rock', 'ArtistA')
*/

-- Prediction Query
SELECT f_id, genre_is, artist_name FROM song WHERE languages = 'english' ORDER BY rating, song.song_name NULLS LAST;

/*
Prediction Result:
(2.0, 'pop', 'ArtistB')
(2.0, 'rock', 'ArtistA')
(1.0, 'rock', 'ArtistB')
*/