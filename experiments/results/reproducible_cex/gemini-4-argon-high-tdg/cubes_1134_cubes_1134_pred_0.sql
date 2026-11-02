-- Schema DDL
CREATE TABLE "genre" ("g_name" TEXT(20) PRIMARY KEY, "rating" TEXT(10), "most_popular_in" TEXT(50));

CREATE TABLE "artist" ("artist_name" TEXT(50) PRIMARY KEY, "preferred_genre" TEXT(50), "country" TEXT(20), "gender" TEXT(20), FOREIGN KEY ("preferred_genre") REFERENCES "genre" ("g_name"));

CREATE TABLE "files" ("f_id" REAL(10) PRIMARY KEY, "artist_name" TEXT(50), "file_size" TEXT(20), "duration" TEXT(20), "formats" TEXT(20), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

CREATE TABLE "song" ("song_name" TEXT(50) PRIMARY KEY, "genre_is" TEXT(20), "f_id" REAL(10), "artist_name" TEXT(50), "country" TEXT(20), "rating" REAL(10), "languages" TEXT(20), "releasedate" DATE, "resolution" REAL(10), FOREIGN KEY ("genre_is") REFERENCES "genre" ("g_name"), FOREIGN KEY ("f_id") REFERENCES "files" ("f_id"), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO genre (g_name, rating, most_popular_in) VALUES ('Rock', '9', 'USA');
INSERT INTO genre (g_name, rating, most_popular_in) VALUES ('Pop', '8', 'UK');
INSERT INTO artist (artist_name, preferred_genre, country, gender) VALUES ('ArtistA', 'Rock', 'USA', 'M');
INSERT INTO artist (artist_name, preferred_genre, country, gender) VALUES ('ArtistB', 'Pop', 'UK', 'F');
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (101.0, 'ArtistA', '5MB', '3:30', 'MP3');
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (102.0, 'ArtistB', '6MB', '4:00', 'WAV');
INSERT INTO song (song_name, genre_is, f_id, artist_name, country, rating, languages, releasedate, resolution) VALUES ('Song1', 'Rock', 101.0, 'ArtistA', 'USA', 4.0, 'English', '2020-01-01', 320.0);
INSERT INTO song (song_name, genre_is, f_id, artist_name, country, rating, languages, releasedate, resolution) VALUES ('Song2', 'Rock', 101.0, 'ArtistA', 'USA', 4.0, 'English', '2020-01-01', 256.0);
INSERT INTO song (song_name, genre_is, f_id, artist_name, country, rating, languages, releasedate, resolution) VALUES ('Song3', 'Pop', 102.0, 'ArtistB', 'UK', 10.0, 'English', '2020-01-01', 128.0);
INSERT INTO song (song_name, genre_is, f_id, artist_name, country, rating, languages, releasedate, resolution) VALUES ('Song4', 'Pop', 102.0, 'ArtistB', 'UK', 9.0, 'English', '2021-06-15', 320.0);
INSERT INTO song (song_name, genre_is, f_id, artist_name, country, rating, languages, releasedate, resolution) VALUES ('Song5', 'Rock', 101.0, 'ArtistA', 'Spain', 2.0, 'Spanish', '2020-01-01', 192.0);
INSERT INTO song (song_name, genre_is, f_id, artist_name, country, rating, languages, releasedate, resolution) VALUES ('Song6', 'Pop', 102.0, 'ArtistB', 'Germany', 8.0, 'German', '2019-03-10', 320.0);
INSERT INTO song (song_name, genre_is, f_id, artist_name, country, rating, languages, releasedate, resolution) VALUES ('Song7', 'Rock', 101.0, 'ArtistA', 'France', 8.0, 'French', '2018-11-20', 256.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT meanrating AS avg_rating_, languages FROM (SELECT languages, releasedate, AVG(rating) AS meanrating FROM song GROUP BY languages, releasedate) ORDER BY avg_rating_, languages NULLS LAST;

/*
Gold Result:
(2.0, 'Spanish')
(6.0, 'English')
(8.0, 'French')
(8.0, 'German')
(9.0, 'English')
*/

-- Prediction Query
SELECT AVG(rating), languages FROM song GROUP BY languages;

/*
Prediction Result:
(6.75, 'English')
(8.0, 'French')
(8.0, 'German')
(2.0, 'Spanish')
*/