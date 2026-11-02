-- Schema DDL
CREATE TABLE "genre" ("g_name" TEXT(20) PRIMARY KEY, "rating" TEXT(10), "most_popular_in" TEXT(50));

CREATE TABLE "artist" ("artist_name" TEXT(50) PRIMARY KEY, "preferred_genre" TEXT(50), "country" TEXT(20), "gender" TEXT(20), FOREIGN KEY ("preferred_genre") REFERENCES "genre" ("g_name"));

CREATE TABLE "files" ("f_id" REAL(10) PRIMARY KEY, "artist_name" TEXT(50), "file_size" TEXT(20), "duration" TEXT(20), "formats" TEXT(20), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

CREATE TABLE "song" ("song_name" TEXT(50) PRIMARY KEY, "genre_is" TEXT(20), "f_id" REAL(10), "artist_name" TEXT(50), "country" TEXT(20), "rating" REAL(10), "languages" TEXT(20), "releasedate" DATE, "resolution" REAL(10), FOREIGN KEY ("genre_is") REFERENCES "genre" ("g_name"), FOREIGN KEY ("f_id") REFERENCES "files" ("f_id"), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests correlation conditions: matching artist_name ONLY, matching country ONLY, and matching BOTH
INSERT INTO "genre" ("g_name", "rating", "most_popular_in") VALUES ('Rock', 'Med', 'UK');
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('Artist_MatchBoth', 'Rock', 'USA', 'M');
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('Artist_MismatchCountry', 'Rock', 'USA', 'F');
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('Artist_NoSongMatchCountry', 'Rock', 'UK', 'M');
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (10.0, 'Artist_MatchBoth', '5MB', '3:00', 'wav');
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (20.0, 'Artist_MismatchCountry', '5MB', '3:00', 'wav');
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Song_MatchBoth', 'Rock', 10.0, 'Artist_MatchBoth', 'USA', 9.2, 'EN', '2021-05-01', 1080.0);
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Song_MismatchCountry', 'Rock', 20.0, 'Artist_MismatchCountry', 'UK', 9.8, 'EN', '2021-05-02', 1080.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT artist_name, country FROM (SELECT * FROM artist AS LHS WHERE EXISTS(SELECT 1 FROM (SELECT * FROM song WHERE (rating >= 9.0)) AS RHS WHERE (LHS.artist_name = RHS.artist_name AND LHS.country = RHS.country))) ORDER BY artist_name, country NULLS LAST;

/*
Gold Result:
('Artist_MatchBoth', 'USA')
*/

-- Prediction Query
SELECT DISTINCT T1.artist_name, T1.country FROM artist AS T1 JOIN song AS T2 ON T1.artist_name = T2.artist_name WHERE T2.rating > 9;

/*
Prediction Result:
('Artist_MatchBoth', 'USA')
('Artist_MismatchCountry', 'USA')
*/