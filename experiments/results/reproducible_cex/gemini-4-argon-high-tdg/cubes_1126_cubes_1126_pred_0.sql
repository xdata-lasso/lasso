-- Schema DDL
CREATE TABLE "genre" ("g_name" TEXT(20) PRIMARY KEY, "rating" TEXT(10), "most_popular_in" TEXT(50));

CREATE TABLE "artist" ("artist_name" TEXT(50) PRIMARY KEY, "preferred_genre" TEXT(50), "country" TEXT(20), "gender" TEXT(20), FOREIGN KEY ("preferred_genre") REFERENCES "genre" ("g_name"));

CREATE TABLE "files" ("f_id" REAL(10) PRIMARY KEY, "artist_name" TEXT(50), "file_size" TEXT(20), "duration" TEXT(20), "formats" TEXT(20), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

CREATE TABLE "song" ("song_name" TEXT(50) PRIMARY KEY, "genre_is" TEXT(20), "f_id" REAL(10), "artist_name" TEXT(50), "country" TEXT(20), "rating" REAL(10), "languages" TEXT(20), "releasedate" DATE, "resolution" REAL(10), FOREIGN KEY ("genre_is") REFERENCES "genre" ("g_name"), FOREIGN KEY ("f_id") REFERENCES "files" ("f_id"), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO genre (g_name, rating, most_popular_in) VALUES ('Jazz', '9', 'FR');
INSERT INTO artist (artist_name, preferred_genre, country, gender) VALUES ('Charlie', 'Jazz', 'FR', 'Male');
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (1, 'Charlie', '10MB', '5:00', 'ogg');
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (2, 'Charlie', '11MB', '5:10', 'ogg');
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (3, 'Charlie', '12MB', '5:20', 'ogg');
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (4, 'Charlie', '8MB', '4:00', 'aac');
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (5, 'Charlie', '9MB', '4:10', 'aac');
INSERT INTO files (f_id, artist_name, file_size, duration, formats) VALUES (6, 'Charlie', '20MB', '3:30', 'flac');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT formats FROM (SELECT LHS.formats AS formats, LHS.n AS n, RHS.formats AS formats_other, RHS.n AS n_other FROM (SELECT formats, COUNT(*) AS n FROM files GROUP BY formats) AS LHS CROSS JOIN (SELECT formats, COUNT(*) AS n FROM files GROUP BY formats) AS RHS) WHERE (n > n_other) ORDER BY formats;

/*
Gold Result:
('aac',)
('ogg',)
('ogg',)
*/

-- Prediction Query
SELECT formats FROM files GROUP BY formats ORDER BY COUNT(*) DESC, formats NULLS LAST LIMIT 1;

/*
Prediction Result:
('ogg',)
*/