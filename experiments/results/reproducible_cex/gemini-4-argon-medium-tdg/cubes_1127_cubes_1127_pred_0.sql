-- Schema DDL
CREATE TABLE "genre" ("g_name" TEXT(20) PRIMARY KEY, "rating" TEXT(10), "most_popular_in" TEXT(50));

CREATE TABLE "artist" ("artist_name" TEXT(50) PRIMARY KEY, "preferred_genre" TEXT(50), "country" TEXT(20), "gender" TEXT(20), FOREIGN KEY ("preferred_genre") REFERENCES "genre" ("g_name"));

CREATE TABLE "files" ("f_id" REAL(10) PRIMARY KEY, "artist_name" TEXT(50), "file_size" TEXT(20), "duration" TEXT(20), "formats" TEXT(20), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

CREATE TABLE "song" ("song_name" TEXT(50) PRIMARY KEY, "genre_is" TEXT(20), "f_id" REAL(10), "artist_name" TEXT(50), "country" TEXT(20), "rating" REAL(10), "languages" TEXT(20), "releasedate" DATE, "resolution" REAL(10), FOREIGN KEY ("genre_is") REFERENCES "genre" ("g_name"), FOREIGN KEY ("f_id") REFERENCES "files" ("f_id"), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic logical OR truth table (TT, TF, FT, FF) and reverse insertion order to verify ORDER BY song_name ASC.
INSERT INTO "genre" ("g_name", "rating", "most_popular_in") VALUES ('modern', '10', 'US');
INSERT INTO "genre" ("g_name", "rating", "most_popular_in") VALUES ('rock', '8', 'UK');
INSERT INTO "genre" ("g_name", "rating", "most_popular_in") VALUES ('jazz', '9', 'FR');
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('ArtistA', 'modern', 'US', 'F');
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (1.0, 'ArtistA', '5MB', '3:00', 'mp3');
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Zebra', 'modern', 1.0, 'ArtistA', 'US', 5.0, 'spanish', '2022-01-01', 320.0);
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Mango', 'rock', 1.0, 'ArtistA', 'UK', 4.0, 'english', '2021-06-15', 256.0);
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Apple', 'modern', 1.0, 'ArtistA', 'CA', 4.5, 'english', '2023-03-10', 128.0);
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Banana', 'jazz', 1.0, 'ArtistA', 'FR', 3.0, 'french', '2020-11-20', 320.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "song_name" FROM "song" WHERE ("genre_is" = 'modern' OR "languages" = 'english') ORDER BY song_name;

/*
Gold Result:
('Apple',)
('Mango',)
('Zebra',)
*/

-- Prediction Query
SELECT song_name FROM song WHERE genre_is = 'modern' OR languages = 'english';

/*
Prediction Result:
('Zebra',)
('Mango',)
('Apple',)
*/