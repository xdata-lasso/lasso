-- Schema DDL
CREATE TABLE "genre" ("g_name" TEXT(20) PRIMARY KEY, "rating" TEXT(10), "most_popular_in" TEXT(50));

CREATE TABLE "artist" ("artist_name" TEXT(50) PRIMARY KEY, "preferred_genre" TEXT(50), "country" TEXT(20), "gender" TEXT(20), FOREIGN KEY ("preferred_genre") REFERENCES "genre" ("g_name"));

CREATE TABLE "files" ("f_id" REAL(10) PRIMARY KEY, "artist_name" TEXT(50), "file_size" TEXT(20), "duration" TEXT(20), "formats" TEXT(20), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

CREATE TABLE "song" ("song_name" TEXT(50) PRIMARY KEY, "genre_is" TEXT(20), "f_id" REAL(10), "artist_name" TEXT(50), "country" TEXT(20), "rating" REAL(10), "languages" TEXT(20), "releasedate" DATE, "resolution" REAL(10), FOREIGN KEY ("genre_is") REFERENCES "genre" ("g_name"), FOREIGN KEY ("f_id") REFERENCES "files" ("f_id"), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: genre --
INSERT INTO "genre" ("g_name", "rating", "most_popular_in") VALUES ('g_name_1', 'gen_df42ba', 'gen_145444');

-- Inserting into table: artist --
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('artist_name_1', 'g_name_1', 'art_2440df', 'art_c0de8b');

INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('son_614e82', 'g_name_1', 'art_2440df', 'art_c0de8b');

-- Inserting into table: files --
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (165.344793, 'artist_name_1', 'fil_2dd0e2', 'fil_2d04a5', 'fil_460987');

-- Inserting into table: song --
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('son_bef9fa', 'g_name_1', 165.344793, 'son_614e82', 'son_f78e17', 8.0, 'english', '2023-11-15', 357.862717);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('A', 'g_name_1', 165.344793, 'son_614e82', 'son_f78e17', 8.0, 'english', '2021-02-05', 292.730571);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('C', 'g_name_1', 165.344793, 'son_614e82', 'son_f78e17', 8.0, 'english', '2025-04-30', 249.706432);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('@', 'g_name_1', 165.344793, 'artist_name_1', 'son_f78e17', 8.01, 'english', '2024-12-12', 378.476082);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('_', 'g_name_1', 165.344793, 'son_614e82', 'son_f78e17', NULL, 'english', '2021-03-30', 294.861575);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('!', 'g_name_1', 165.344793, 'artist_name_1', 'son_f78e17', 8.0, 'son_b5714a', '2020-03-30', 749.826493);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('D', 'g_name_1', 165.344793, 'artist_name_1', 'son_f78e17', 8.01, 'son_b5714a', '2023-10-03', 855.355181);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('E', 'g_name_1', 165.344793, 'son_614e82', 'son_f78e17', NULL, 'son_b5714a', '2021-05-27', 182.319045);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "artist_name" FROM "song" WHERE ("languages" = 'english' AND rating <= 8.0) ORDER BY artist_name, song.song_name NULLS LAST;

/*
Gold Result:
('son_614e82',)
('son_614e82',)
('son_614e82',)
*/

-- Prediction Query
SELECT DISTINCT artist_name FROM song WHERE languages = 'english' EXCEPT SELECT DISTINCT artist_name FROM song WHERE rating > 8;

/*
Prediction Result:
('son_614e82',)
*/