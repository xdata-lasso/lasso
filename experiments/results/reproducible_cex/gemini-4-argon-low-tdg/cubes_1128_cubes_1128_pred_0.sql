-- Schema DDL
CREATE TABLE "genre" ("g_name" TEXT(20) PRIMARY KEY, "rating" TEXT(10), "most_popular_in" TEXT(50));

CREATE TABLE "artist" ("artist_name" TEXT(50) PRIMARY KEY, "preferred_genre" TEXT(50), "country" TEXT(20), "gender" TEXT(20), FOREIGN KEY ("preferred_genre") REFERENCES "genre" ("g_name"));

CREATE TABLE "files" ("f_id" REAL(10) PRIMARY KEY, "artist_name" TEXT(50), "file_size" TEXT(20), "duration" TEXT(20), "formats" TEXT(20), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

CREATE TABLE "song" ("song_name" TEXT(50) PRIMARY KEY, "genre_is" TEXT(20), "f_id" REAL(10), "artist_name" TEXT(50), "country" TEXT(20), "rating" REAL(10), "languages" TEXT(20), "releasedate" DATE, "resolution" REAL(10), FOREIGN KEY ("genre_is") REFERENCES "genre" ("g_name"), FOREIGN KEY ("f_id") REFERENCES "files" ("f_id"), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "genre" ("g_name", "rating", "most_popular_in") VALUES ('Pop', '8.0', 'USA');
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('Zebra', 'Pop', 'USA', 'F');
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('Alpha', 'Pop', 'UK', 'M');
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('Beta', 'Pop', 'CAN', 'M');
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (1.0, 'Zebra', '5MB', '3:00', 'mp3');
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('S_Zebra_Boundary', 'Pop', 1.0, 'Zebra', 'USA', 8.0, 'english', '2020-01-01', 320.0);
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('S_Alpha_Low_1', 'Pop', 1.0, 'Alpha', 'UK', 7.5, 'english', '2020-01-02', 320.0);
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('S_Alpha_Low_2', 'Pop', 1.0, 'Alpha', 'UK', 5.0, 'english', '2020-01-03', 320.0);
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('S_Beta_High', 'Pop', 1.0, 'Beta', 'CAN', 8.1, 'english', '2020-01-04', 320.0);
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('S_Beta_French', 'Pop', 1.0, 'Beta', 'CAN', 6.0, 'french', '2020-01-05', 320.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "artist_name" FROM "song" WHERE ("languages" = 'english' AND rating <= 8.0) ORDER BY artist_name, song.song_name NULLS LAST;

/*
Gold Result:
('Alpha',)
('Alpha',)
('Zebra',)
*/

-- Prediction Query
SELECT DISTINCT artist_name FROM song WHERE languages = 'english' EXCEPT SELECT DISTINCT artist_name FROM song WHERE rating > 8;

/*
Prediction Result:
('Alpha',)
('Zebra',)
*/