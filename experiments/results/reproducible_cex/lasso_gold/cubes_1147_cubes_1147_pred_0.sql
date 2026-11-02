-- Schema DDL
CREATE TABLE "genre" ("g_name" TEXT(20) PRIMARY KEY, "rating" TEXT(10), "most_popular_in" TEXT(50));

CREATE TABLE "artist" ("artist_name" TEXT(50) PRIMARY KEY, "preferred_genre" TEXT(50), "country" TEXT(20), "gender" TEXT(20), FOREIGN KEY ("preferred_genre") REFERENCES "genre" ("g_name"));

CREATE TABLE "files" ("f_id" REAL(10) PRIMARY KEY, "artist_name" TEXT(50), "file_size" TEXT(20), "duration" TEXT(20), "formats" TEXT(20), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

CREATE TABLE "song" ("song_name" TEXT(50) PRIMARY KEY, "genre_is" TEXT(20), "f_id" REAL(10), "artist_name" TEXT(50), "country" TEXT(20), "rating" REAL(10), "languages" TEXT(20), "releasedate" DATE, "resolution" REAL(10), FOREIGN KEY ("genre_is") REFERENCES "genre" ("g_name"), FOREIGN KEY ("f_id") REFERENCES "files" ("f_id"), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "genre" ("g_name", "rating", "most_popular_in") VALUES ('Meredith Barnes', 'list', 'perform');
INSERT INTO "genre" ("g_name", "rating", "most_popular_in") VALUES ('Ryan Munoz', 'surface', 'animal');
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('Sean Blake', 'Meredith Barnes', 'Cayman Islands', 'save');
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('Kimberly Dudley', 'Ryan Munoz', 'Honduras', 'bar');
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (1004.5, 'Sean Blake', 'knowledge', 'grow', 'fall');
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (1007.5, 'Kimberly Dudley', 'old', 'finally', 'themselves');
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Tyler Rogers', 'Meredith Barnes', 1004.5, 'Sean Blake', 'Bermuda', 1005.5, 'husband', '1971-02-02', 1006.5);
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Stacey Ward', 'Ryan Munoz', 1007.5, 'Kimberly Dudley', 'Congo', 1008.5, 'sea', '1972-03-03', 1009.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT song_name FROM song ORDER BY song_name;

/*
Gold Result:
('Stacey Ward',)
('Tyler Rogers',)
*/

-- Prediction Query
SELECT song_name FROM song ORDER BY resolution, song.song_name NULLS LAST;

/*
Prediction Result:
('Tyler Rogers',)
('Stacey Ward',)
*/