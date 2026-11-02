-- Schema DDL
CREATE TABLE "genre" ("g_name" TEXT(20) PRIMARY KEY, "rating" TEXT(10), "most_popular_in" TEXT(50));

CREATE TABLE "artist" ("artist_name" TEXT(50) PRIMARY KEY, "preferred_genre" TEXT(50), "country" TEXT(20), "gender" TEXT(20), FOREIGN KEY ("preferred_genre") REFERENCES "genre" ("g_name"));

CREATE TABLE "files" ("f_id" REAL(10) PRIMARY KEY, "artist_name" TEXT(50), "file_size" TEXT(20), "duration" TEXT(20), "formats" TEXT(20), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

CREATE TABLE "song" ("song_name" TEXT(50) PRIMARY KEY, "genre_is" TEXT(20), "f_id" REAL(10), "artist_name" TEXT(50), "country" TEXT(20), "rating" REAL(10), "languages" TEXT(20), "releasedate" DATE, "resolution" REAL(10), FOREIGN KEY ("genre_is") REFERENCES "genre" ("g_name"), FOREIGN KEY ("f_id") REFERENCES "files" ("f_id"), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO genre (g_name, rating, most_popular_in) VALUES ('Pop', '5', 'US');
INSERT INTO artist (artist_name, preferred_genre, country, gender) VALUES ('Artist1', 'Pop', 'US', 'F');
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (1.0, 'Artist1', '5MB', '3:00', 'mp3');
INSERT INTO song (song_name, genre_is, f_id, artist_name, country, rating, languages, releasedate, resolution) VALUES ('Song1', 'Pop', 1.0, 'Artist1', 'US', 4.0, 'English', '2020-01-01', 320.0);
INSERT INTO song (song_name, genre_is, f_id, artist_name, country, rating, languages, releasedate, resolution) VALUES ('Song2', 'Pop', 1.0, 'Artist1', 'US', 2.0, 'English', '2020-01-02', 320.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT meanrating AS avg_rating_, languages FROM (SELECT languages, releasedate, AVG(rating) AS meanrating FROM song GROUP BY languages, releasedate) ORDER BY avg_rating_, languages NULLS LAST;

/*
Gold Result:
(2.0, 'English')
(4.0, 'English')
*/

-- Prediction Query
SELECT AVG(rating), languages FROM song GROUP BY languages;

/*
Prediction Result:
(3.0, 'English')
*/