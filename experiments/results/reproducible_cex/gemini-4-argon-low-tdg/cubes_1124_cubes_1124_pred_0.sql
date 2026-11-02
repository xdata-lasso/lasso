-- Schema DDL
CREATE TABLE "genre" ("g_name" TEXT(20) PRIMARY KEY, "rating" TEXT(10), "most_popular_in" TEXT(50));

CREATE TABLE "artist" ("artist_name" TEXT(50) PRIMARY KEY, "preferred_genre" TEXT(50), "country" TEXT(20), "gender" TEXT(20), FOREIGN KEY ("preferred_genre") REFERENCES "genre" ("g_name"));

CREATE TABLE "files" ("f_id" REAL(10) PRIMARY KEY, "artist_name" TEXT(50), "file_size" TEXT(20), "duration" TEXT(20), "formats" TEXT(20), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

CREATE TABLE "song" ("song_name" TEXT(50) PRIMARY KEY, "genre_is" TEXT(20), "f_id" REAL(10), "artist_name" TEXT(50), "country" TEXT(20), "rating" REAL(10), "languages" TEXT(20), "releasedate" DATE, "resolution" REAL(10), FOREIGN KEY ("genre_is") REFERENCES "genre" ("g_name"), FOREIGN KEY ("f_id") REFERENCES "files" ("f_id"), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering by artist_name DESC vs ordering by count (n) DESC or ASC, or artist_name ASC.
-- Also tests extraneous INNER JOINs with artist/genre/files by keeping their foreign keys NULL in song,
-- while populating those parent tables with dummy rows.
INSERT INTO "genre" ("g_name", "rating", "most_popular_in") VALUES ('Rock', '10', 'US');
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('OrphanArtist', 'Rock', 'US', 'M');
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (99.0, 'OrphanArtist', '10MB', '3:00', 'MP3');
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('ArtistA', NULL, 'UK', 'F');
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('ArtistB', NULL, 'CA', 'M');
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('ArtistZ', NULL, 'FR', 'F');
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('S1', NULL, NULL, 'ArtistA', 'UK', 5.0, 'English', '2020-01-01', 320.0);
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('S2', NULL, NULL, 'ArtistA', 'UK', 5.0, 'English', '2020-01-02', 320.0);
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('S3', NULL, NULL, 'ArtistA', 'UK', 5.0, 'English', '2020-01-03', 320.0);
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('S4', NULL, NULL, 'ArtistB', 'CA', 4.0, 'Spanish', '2020-01-04', 256.0);
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('S5', NULL, NULL, 'ArtistB', 'CA', 4.0, 'Spanish', '2020-01-05', 256.0);
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('S6', NULL, NULL, 'ArtistZ', 'FR', 3.0, 'French', '2020-01-06', 128.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT languages FROM (SELECT * FROM (SELECT * FROM (SELECT artist_name, languages, COUNT(*) AS n FROM song GROUP BY artist_name, languages) ORDER BY artist_name DESC) LIMIT 1);

/*
Gold Result:
('French',)
*/

-- Prediction Query
SELECT languages FROM song GROUP BY languages ORDER BY COUNT(*) DESC, languages NULLS LAST LIMIT 1;

/*
Prediction Result:
('English',)
*/