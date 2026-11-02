-- Schema DDL
CREATE TABLE "genre" ("g_name" TEXT(20) PRIMARY KEY, "rating" TEXT(10), "most_popular_in" TEXT(50));

CREATE TABLE "artist" ("artist_name" TEXT(50) PRIMARY KEY, "preferred_genre" TEXT(50), "country" TEXT(20), "gender" TEXT(20), FOREIGN KEY ("preferred_genre") REFERENCES "genre" ("g_name"));

CREATE TABLE "files" ("f_id" REAL(10) PRIMARY KEY, "artist_name" TEXT(50), "file_size" TEXT(20), "duration" TEXT(20), "formats" TEXT(20), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

CREATE TABLE "song" ("song_name" TEXT(50) PRIMARY KEY, "genre_is" TEXT(20), "f_id" REAL(10), "artist_name" TEXT(50), "country" TEXT(20), "rating" REAL(10), "languages" TEXT(20), "releasedate" DATE, "resolution" REAL(10), FOREIGN KEY ("genre_is") REFERENCES "genre" ("g_name"), FOREIGN KEY ("f_id") REFERENCES "files" ("f_id"), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: genre --
INSERT INTO "genre" ("g_name", "rating", "most_popular_in") VALUES ('son_8039d6', 'gen_df42ba', 'gen_145444');

INSERT INTO "genre" ("g_name", "rating", "most_popular_in") VALUES ('son_680a10', 'gen_df42ba', 'gen_145444');

-- Inserting into table: artist --
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('artist_name_1', 'son_8039d6', 'art_2440df', 'art_c0de8b');

INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('son_99601c', 'son_8039d6', 'art_2440df', 'art_c0de8b');

INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('son_83d637', 'son_680a10', 'art_2440df', 'art_c0de8b');

-- Inserting into table: files --
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (1.0, 'artist_name_1', 'fil_2dd0e2', 'fil_2d04a5', 'fil_460987');

-- Inserting into table: song --
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('son_505635', 'son_8039d6', 1.0, 'son_99601c', 'son_7dc094', 1.0, 'son_8f7ee9', '2024-06-15', 1.0);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('son_a45647', 'son_680a10', 1.0, 'son_83d637', 'son_bf6ba0', 1.0, 'son_2faa8d', '2024-06-15', 1.0);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_3', 'son_680a10', 1.0, 'son_99601c', 'son_f78e17', NULL, 'son_40bca8', '2022-12-08', 38.668834);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "song_name" FROM (SELECT "song_name", "artist_name", "country", "f_id", "genre_is", "rating", "languages", "releasedate", "resolution", MIN("rating") OVER () AS "minrating" FROM "song") WHERE ("languages" <> 'english' AND minrating = rating) ORDER BY song_name, "song_name" NULLS LAST;

/*
Gold Result:
('son_505635',)
('son_a45647',)
*/

-- Prediction Query
SELECT song_name FROM song WHERE rating < (SELECT MIN(rating) FROM song WHERE languages = 'english');

/*
Prediction Result:
*/