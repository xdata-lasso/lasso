-- Schema DDL
CREATE TABLE "genre" ("g_name" TEXT(20) PRIMARY KEY, "rating" TEXT(10), "most_popular_in" TEXT(50));

CREATE TABLE "artist" ("artist_name" TEXT(50) PRIMARY KEY, "preferred_genre" TEXT(50), "country" TEXT(20), "gender" TEXT(20), FOREIGN KEY ("preferred_genre") REFERENCES "genre" ("g_name"));

CREATE TABLE "files" ("f_id" REAL(10) PRIMARY KEY, "artist_name" TEXT(50), "file_size" TEXT(20), "duration" TEXT(20), "formats" TEXT(20), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

CREATE TABLE "song" ("song_name" TEXT(50) PRIMARY KEY, "genre_is" TEXT(20), "f_id" REAL(10), "artist_name" TEXT(50), "country" TEXT(20), "rating" REAL(10), "languages" TEXT(20), "releasedate" DATE, "resolution" REAL(10), FOREIGN KEY ("genre_is") REFERENCES "genre" ("g_name"), FOREIGN KEY ("f_id") REFERENCES "files" ("f_id"), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO genre (g_name, rating, most_popular_in) VALUES ('Jazz', '10', 'France');
INSERT INTO artist (artist_name, preferred_genre, country, gender) VALUES ('Dup_Artist', 'Jazz', 'France', 'F');
INSERT INTO artist (artist_name, preferred_genre, country, gender) VALUES ('Mixed_Artist', 'Jazz', 'Canada', 'M');
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (10.0, 'Dup_Artist', '4MB', '2:30', 'flac');
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (20.0, 'Mixed_Artist', '7MB', '5:00', 'mp3');
INSERT INTO song (song_name, genre_is, f_id, artist_name, country, rating, languages, releasedate, resolution) VALUES ('Dup_Song_1', 'Jazz', 10.0, 'Dup_Artist', 'France', 9.0, 'French', '2021-03-01', 950.0);
INSERT INTO song (song_name, genre_is, f_id, artist_name, country, rating, languages, releasedate, resolution) VALUES ('Dup_Song_2', 'Jazz', 10.0, 'Dup_Artist', 'France', 8.0, 'French', '2021-03-02', 1080.0);
INSERT INTO song (song_name, genre_is, f_id, artist_name, country, rating, languages, releasedate, resolution) VALUES ('Dup_Song_3', 'Jazz', 10.0, 'Dup_Artist', 'France', 7.0, 'French', '2021-03-03', 1200.0);
INSERT INTO song (song_name, genre_is, f_id, artist_name, country, rating, languages, releasedate, resolution) VALUES ('Mixed_High', 'Jazz', 20.0, 'Mixed_Artist', 'Canada', 8.5, 'English', '2021-04-01', 910.0);
INSERT INTO song (song_name, genre_is, f_id, artist_name, country, rating, languages, releasedate, resolution) VALUES ('Mixed_Low', 'Jazz', 20.0, 'Mixed_Artist', 'Canada', 6.5, 'English', '2021-04-02', 480.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT artist_name, country FROM (SELECT song_name, artist_name, country, f_id, genre_is, rating, languages, releasedate, resolution, COUNT(*) OVER () AS n FROM (SELECT * FROM song AS LHS WHERE EXISTS(SELECT 1 FROM artist AS RHS WHERE (LHS.artist_name = RHS.artist_name AND LHS.country = RHS.country)))) WHERE (resolution > 900.0 OR n < 1) ORDER BY artist_name, country NULLS LAST;

/*
Gold Result:
('Dup_Artist', 'France')
('Dup_Artist', 'France')
('Dup_Artist', 'France')
('Mixed_Artist', 'Canada')
*/

-- Prediction Query
SELECT T1.artist_name, T1.country FROM artist AS T1 JOIN song AS T2 ON T1.artist_name = T2.artist_name WHERE T2.resolution > 900 GROUP BY T2.artist_name HAVING COUNT(*) >= 1;

/*
Prediction Result:
('Dup_Artist', 'France')
('Mixed_Artist', 'Canada')
*/