-- Schema DDL
CREATE TABLE "genre" ("g_name" TEXT(20) PRIMARY KEY, "rating" TEXT(10), "most_popular_in" TEXT(50));

CREATE TABLE "artist" ("artist_name" TEXT(50) PRIMARY KEY, "preferred_genre" TEXT(50), "country" TEXT(20), "gender" TEXT(20), FOREIGN KEY ("preferred_genre") REFERENCES "genre" ("g_name"));

CREATE TABLE "files" ("f_id" REAL(10) PRIMARY KEY, "artist_name" TEXT(50), "file_size" TEXT(20), "duration" TEXT(20), "formats" TEXT(20), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

CREATE TABLE "song" ("song_name" TEXT(50) PRIMARY KEY, "genre_is" TEXT(20), "f_id" REAL(10), "artist_name" TEXT(50), "country" TEXT(20), "rating" REAL(10), "languages" TEXT(20), "releasedate" DATE, "resolution" REAL(10), FOREIGN KEY ("genre_is") REFERENCES "genre" ("g_name"), FOREIGN KEY ("f_id") REFERENCES "files" ("f_id"), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO genre (g_name, rating, most_popular_in) VALUES ('Rock', '9', 'USA');
INSERT INTO genre (g_name, rating, most_popular_in) VALUES ('Jazz', '8', 'UK');
INSERT INTO genre (g_name, rating, most_popular_in) VALUES ('Pop', '7', 'Canada');
INSERT INTO artist (artist_name, preferred_genre, country, gender) VALUES ('Mike', 'Rock', 'UK', 'Male');
INSERT INTO artist (artist_name, preferred_genre, country, gender) VALUES ('Zack', 'Jazz', 'UK', 'Male');
INSERT INTO artist (artist_name, preferred_genre, country, gender) VALUES ('Aaron', 'Pop', 'UK', 'Male');
INSERT INTO artist (artist_name, preferred_genre, country, gender) VALUES ('Alice', 'Jazz', 'UK', 'Female');
INSERT INTO artist (artist_name, preferred_genre, country, gender) VALUES ('Bob', 'Jazz', 'USA', 'Male');
INSERT INTO artist (artist_name, preferred_genre, country, gender) VALUES ('Carol', 'Pop', 'USA', 'Female');
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (1.0, 'Mike', '5MB', '3:30', 'mp3');
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (2.0, 'Mike', '6MB', '4:00', 'wav');
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (3.0, 'Zack', '4MB', '2:45', 'mp3');
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (4.0, 'Bob', '5MB', '3:15', 'mp3');
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (5.0, 'Alice', '4MB', '3:00', 'mp3');
INSERT INTO song (song_name, genre_is, f_id, artist_name, country, rating, languages, releasedate, resolution) VALUES ('Track M1', 'Rock', 1.0, 'Mike', 'UK', 4.5, 'English', '2020-01-10', 320.0);
INSERT INTO song (song_name, genre_is, f_id, artist_name, country, rating, languages, releasedate, resolution) VALUES ('Track M2', 'Rock', 2.0, 'Mike', 'UK', 4.8, 'English', '2021-05-12', 320.0);
INSERT INTO song (song_name, genre_is, f_id, artist_name, country, rating, languages, releasedate, resolution) VALUES ('Track Z1', 'Jazz', 3.0, 'Zack', 'USA', 4.2, 'English', '2019-11-01', 256.0);
INSERT INTO song (song_name, genre_is, f_id, artist_name, country, rating, languages, releasedate, resolution) VALUES ('Track B1', 'Jazz', 4.0, 'Bob', 'UK', 4.0, 'English', '2022-03-15', 192.0);
INSERT INTO song (song_name, genre_is, f_id, artist_name, country, rating, languages, releasedate, resolution) VALUES ('Track A1', 'Jazz', 5.0, 'Alice', 'UK', 4.6, 'English', '2021-08-20', 320.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "artist_name" FROM "artist" WHERE ("country" = 'UK' AND "gender" = 'Male') ORDER BY artist_name;

/*
Gold Result:
('Aaron',)
('Mike',)
('Zack',)
*/

-- Prediction Query
SELECT artist_name FROM artist WHERE country = 'UK' AND gender = 'Male';

/*
Prediction Result:
('Mike',)
('Zack',)
('Aaron',)
*/