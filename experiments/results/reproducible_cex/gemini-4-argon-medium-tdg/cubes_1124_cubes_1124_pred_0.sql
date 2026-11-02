-- Schema DDL
CREATE TABLE "genre" ("g_name" TEXT(20) PRIMARY KEY, "rating" TEXT(10), "most_popular_in" TEXT(50));

CREATE TABLE "artist" ("artist_name" TEXT(50) PRIMARY KEY, "preferred_genre" TEXT(50), "country" TEXT(20), "gender" TEXT(20), FOREIGN KEY ("preferred_genre") REFERENCES "genre" ("g_name"));

CREATE TABLE "files" ("f_id" REAL(10) PRIMARY KEY, "artist_name" TEXT(50), "file_size" TEXT(20), "duration" TEXT(20), "formats" TEXT(20), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

CREATE TABLE "song" ("song_name" TEXT(50) PRIMARY KEY, "genre_is" TEXT(20), "f_id" REAL(10), "artist_name" TEXT(50), "country" TEXT(20), "rating" REAL(10), "languages" TEXT(20), "releasedate" DATE, "resolution" REAL(10), FOREIGN KEY ("genre_is") REFERENCES "genre" ("g_name"), FOREIGN KEY ("f_id") REFERENCES "files" ("f_id"), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests standard ordering and distinguishes ORDER BY artist_name DESC from ORDER BY n DESC or ASC, ORDER BY languages, and missing LIMIT 1.
-- Top artist ('Zack') has 1 song in 'Spanish'.
-- Middle artist ('Mike') has 3 songs in 'French' (highest count per group).
-- Bottom artist ('Alice') has 2 songs in 'English' and 2 songs in 'German' (highest total songs per artist = 4).
-- Unreferenced artist ('Zorro') exists in artist/files table to kill mutants that incorrectly JOIN on artist or files.
INSERT INTO genre (g_name, rating, most_popular_in) VALUES ('Pop', '8', 'USA');
INSERT INTO artist (artist_name, preferred_genre, country, gender) VALUES ('Alice', 'Pop', 'USA', 'F');
INSERT INTO artist (artist_name, preferred_genre, country, gender) VALUES ('Mike', 'Pop', 'UK', 'M');
INSERT INTO artist (artist_name, preferred_genre, country, gender) VALUES ('Zack', 'Pop', 'Canada', 'M');
INSERT INTO artist (artist_name, preferred_genre, country, gender) VALUES ('Zorro', 'Pop', 'Mexico', 'M');
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (1.0, 'Alice', '3MB', '3:00', 'mp3');
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (2.0, 'Mike', '4MB', '4:00', 'mp3');
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (3.0, 'Zack', '5MB', '5:00', 'mp3');
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (4.0, 'Zorro', '6MB', '6:00', 'mp3');
INSERT INTO song (song_name, genre_is, f_id, artist_name, country, rating, languages, releasedate, resolution) VALUES ('S1', 'Pop', 1.0, 'Alice', 'USA', 5.0, 'English', '2020-01-01', 320.0);
INSERT INTO song (song_name, genre_is, f_id, artist_name, country, rating, languages, releasedate, resolution) VALUES ('S2', 'Pop', 1.0, 'Alice', 'USA', 5.0, 'English', '2020-01-02', 320.0);
INSERT INTO song (song_name, genre_is, f_id, artist_name, country, rating, languages, releasedate, resolution) VALUES ('S3', 'Pop', 1.0, 'Alice', 'USA', 5.0, 'German', '2020-01-03', 320.0);
INSERT INTO song (song_name, genre_is, f_id, artist_name, country, rating, languages, releasedate, resolution) VALUES ('S4', 'Pop', 1.0, 'Alice', 'USA', 5.0, 'German', '2020-01-04', 320.0);
INSERT INTO song (song_name, genre_is, f_id, artist_name, country, rating, languages, releasedate, resolution) VALUES ('S5', 'Pop', 2.0, 'Mike', 'UK', 4.0, 'French', '2020-01-05', 320.0);
INSERT INTO song (song_name, genre_is, f_id, artist_name, country, rating, languages, releasedate, resolution) VALUES ('S6', 'Pop', 2.0, 'Mike', 'UK', 4.0, 'French', '2020-01-06', 320.0);
INSERT INTO song (song_name, genre_is, f_id, artist_name, country, rating, languages, releasedate, resolution) VALUES ('S7', 'Pop', 2.0, 'Mike', 'UK', 4.0, 'French', '2020-01-07', 320.0);
INSERT INTO song (song_name, genre_is, f_id, artist_name, country, rating, languages, releasedate, resolution) VALUES ('S8', 'Pop', 3.0, 'Zack', 'Canada', 3.0, 'Spanish', '2020-01-08', 320.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT languages FROM (SELECT * FROM (SELECT * FROM (SELECT artist_name, languages, COUNT(*) AS n FROM song GROUP BY artist_name, languages) ORDER BY artist_name DESC) LIMIT 1);

/*
Gold Result:
('Spanish',)
*/

-- Prediction Query
SELECT languages FROM song GROUP BY languages ORDER BY COUNT(*) DESC, languages NULLS LAST LIMIT 1;

/*
Prediction Result:
('French',)
*/