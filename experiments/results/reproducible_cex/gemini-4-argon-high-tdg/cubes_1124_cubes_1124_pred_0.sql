-- Schema DDL
CREATE TABLE "genre" ("g_name" TEXT(20) PRIMARY KEY, "rating" TEXT(10), "most_popular_in" TEXT(50));

CREATE TABLE "artist" ("artist_name" TEXT(50) PRIMARY KEY, "preferred_genre" TEXT(50), "country" TEXT(20), "gender" TEXT(20), FOREIGN KEY ("preferred_genre") REFERENCES "genre" ("g_name"));

CREATE TABLE "files" ("f_id" REAL(10) PRIMARY KEY, "artist_name" TEXT(50), "file_size" TEXT(20), "duration" TEXT(20), "formats" TEXT(20), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

CREATE TABLE "song" ("song_name" TEXT(50) PRIMARY KEY, "genre_is" TEXT(20), "f_id" REAL(10), "artist_name" TEXT(50), "country" TEXT(20), "rating" REAL(10), "languages" TEXT(20), "releasedate" DATE, "resolution" REAL(10), FOREIGN KEY ("genre_is") REFERENCES "genre" ("g_name"), FOREIGN KEY ("f_id") REFERENCES "files" ("f_id"), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO genre (g_name, rating, most_popular_in) VALUES ('Blues', '8', 'USA');
INSERT INTO genre (g_name, rating, most_popular_in) VALUES ('Pop', '9', 'UK');
INSERT INTO genre (g_name, rating, most_popular_in) VALUES ('Rock', '7', 'Brazil');
INSERT INTO artist (artist_name, preferred_genre, country, gender) VALUES ('Alexander', 'Blues', 'USA', 'Male');
INSERT INTO artist (artist_name, preferred_genre, country, gender) VALUES ('Bo', 'Rock', 'Brazil', 'Male');
INSERT INTO artist (artist_name, preferred_genre, country, gender) VALUES ('Zara', 'Pop', 'India', 'Female');
INSERT INTO artist (artist_name, preferred_genre, country, gender) VALUES ('Zzz_Unused', 'Pop', 'UK', 'Female');
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (1.0, 'Alexander', '3MB', '3:00', 'mp3');
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (2.0, 'Alexander', '4MB', '3:30', 'mp3');
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (3.0, 'Alexander', '5MB', '4:00', 'wav');
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (4.0, 'Zara', '4MB', '3:15', 'aac');
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (5.0, 'Zara', '4MB', '3:20', 'aac');
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (6.0, 'Bo', '6MB', '5:00', 'flac');
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (99.0, 'Zzz_Unused', '2MB', '2:00', 'mp3');
INSERT INTO song (song_name, genre_is, f_id, artist_name, country, rating, languages, releasedate, resolution) VALUES ('A_Song1', 'Blues', 1.0, 'Alexander', 'USA', 10.0, 'Arabic', '2023-12-31', 1080.0);
INSERT INTO song (song_name, genre_is, f_id, artist_name, country, rating, languages, releasedate, resolution) VALUES ('A_Song2', 'Blues', 2.0, 'Alexander', 'USA', 9.0, 'Arabic', '2022-06-15', 1080.0);
INSERT INTO song (song_name, genre_is, f_id, artist_name, country, rating, languages, releasedate, resolution) VALUES ('A_Song3', 'Blues', 3.0, 'Alexander', 'USA', 8.0, 'Arabic', '2021-01-01', 1080.0);
INSERT INTO song (song_name, genre_is, f_id, artist_name, country, rating, languages, releasedate, resolution) VALUES ('M_Song1', 'Pop', 4.0, 'Zara', 'India', 5.0, 'French', '2020-05-05', 720.0);
INSERT INTO song (song_name, genre_is, f_id, artist_name, country, rating, languages, releasedate, resolution) VALUES ('M_Song2', 'Pop', 5.0, 'Zara', 'India', 5.0, 'French', '2020-05-06', 720.0);
INSERT INTO song (song_name, genre_is, f_id, artist_name, country, rating, languages, releasedate, resolution) VALUES ('Z_Song1', 'Rock', 6.0, 'Bo', 'Brazil', 1.0, 'Spanish', '2010-01-01', 480.0);
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
('Arabic',)
*/