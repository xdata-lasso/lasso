-- Schema DDL
CREATE TABLE "genre" ("g_name" TEXT(20) PRIMARY KEY, "rating" TEXT(10), "most_popular_in" TEXT(50));

CREATE TABLE "artist" ("artist_name" TEXT(50) PRIMARY KEY, "preferred_genre" TEXT(50), "country" TEXT(20), "gender" TEXT(20), FOREIGN KEY ("preferred_genre") REFERENCES "genre" ("g_name"));

CREATE TABLE "files" ("f_id" REAL(10) PRIMARY KEY, "artist_name" TEXT(50), "file_size" TEXT(20), "duration" TEXT(20), "formats" TEXT(20), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

CREATE TABLE "song" ("song_name" TEXT(50) PRIMARY KEY, "genre_is" TEXT(20), "f_id" REAL(10), "artist_name" TEXT(50), "country" TEXT(20), "rating" REAL(10), "languages" TEXT(20), "releasedate" DATE, "resolution" REAL(10), FOREIGN KEY ("genre_is") REFERENCES "genre" ("g_name"), FOREIGN KEY ("f_id") REFERENCES "files" ("f_id"), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. COUNT(*) vs COUNT(gender) vs COUNT(preferred_genre) vs COUNT(DISTINCT ...) when gender is NULL.
-- 2. Tie-breaking in ORDER BY: count___ ASC, gender ASC NULLS LAST (multiple groups with count = 2, including NULL gender).
-- 3. Unnecessary INNER JOINs with genre, files, or song (artists with NULL preferred_genre, no files/songs, or multiple files/songs).
INSERT INTO genre (g_name, rating, most_popular_in) VALUES ('Rock', '10', 'US');
INSERT INTO genre (g_name, rating, most_popular_in) VALUES ('Pop', '8', 'UK');
INSERT INTO genre (g_name, rating, most_popular_in) VALUES ('Jazz', '9', 'FR');
INSERT INTO artist (artist_name, preferred_genre, country, gender) VALUES ('A1', 'Rock', 'US', 'Male');
INSERT INTO artist (artist_name, preferred_genre, country, gender) VALUES ('A2', NULL, 'US', 'Male');
INSERT INTO artist (artist_name, preferred_genre, country, gender) VALUES ('A3', 'Pop', 'UK', 'Female');
INSERT INTO artist (artist_name, preferred_genre, country, gender) VALUES ('A4', 'Pop', 'UK', 'Female');
INSERT INTO artist (artist_name, preferred_genre, country, gender) VALUES ('A5', 'Rock', 'CA', NULL);
INSERT INTO artist (artist_name, preferred_genre, country, gender) VALUES ('A6', NULL, NULL, NULL);
INSERT INTO artist (artist_name, preferred_genre, country, gender) VALUES ('A7', 'Rock', 'AU', 'Non-Binary');
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (1.0, 'A1', '5MB', '3:00', 'mp3');
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (2.0, 'A1', '6MB', '3:30', 'wav');
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (3.0, 'A3', '4MB', '2:30', 'mp3');
INSERT INTO song (song_name, genre_is, f_id, artist_name, country, rating, languages, releasedate, resolution) VALUES ('S1', 'Rock', 1.0, 'A1', 'US', 5.0, 'EN', '2020-01-01', 320.0);
INSERT INTO song (song_name, genre_is, f_id, artist_name, country, rating, languages, releasedate, resolution) VALUES ('S2', 'Rock', 2.0, 'A1', 'US', 4.0, 'EN', '2020-01-02', 320.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, gender FROM (SELECT gender, COUNT(*) AS n FROM artist GROUP BY gender) ORDER BY count___, gender NULLS LAST;

/*
Gold Result:
(1, 'Non-Binary')
(2, 'Female')
(2, 'Male')
(2, None)
*/

-- Prediction Query
SELECT COUNT(*), gender FROM artist GROUP BY gender;

/*
Prediction Result:
(2, None)
(2, 'Female')
(2, 'Male')
(1, 'Non-Binary')
*/