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
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('t1__0a9586', 'g_name_1', 't1__3d362e', 'art_c0de8b');

INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('A', 'g_name_1', 't1__3d362e', 'art_c0de8b');

INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('@', 'g_name_1', 'art_2440df', 'art_c0de8b');

-- Inserting into table: files --
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (285.529132, 't1__0a9586', 'fil_2dd0e2', 'fil_2d04a5', 'fil_460987');

-- Inserting into table: song --
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_1', 'g_name_1', 285.529132, 't1__0a9586', 'son_f78e17', 9.01, 'son_40bca8', '2024-01-05', 833.684115);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_2', 'g_name_1', 285.529132, 't1__0a9586', 'son_f78e17', 9.01, 'son_40bca8', '2021-02-05', 292.730571);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_3', 'g_name_1', 285.529132, '@', 'son_f78e17', 9.01, 'son_40bca8', '2023-07-13', 520.784135);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_4', 'g_name_1', 285.529132, '@', 'son_f78e17', 9.01, 'son_40bca8', '2025-06-04', 779.409124);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_5', 'g_name_1', 285.529132, '@', 'son_f78e17', 9.01, 'son_40bca8', '2024-12-12', 378.476082);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_6', 'g_name_1', 285.529132, '@', 'son_f78e17', 9.01, 'son_40bca8', '2024-06-23', 841.297061);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_7', 'g_name_1', 285.529132, '@', 'son_f78e17', 9.01, 'son_40bca8', '2020-03-30', 749.826493);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_8', 'g_name_1', 285.529132, '@', 'son_f78e17', 9.01, 'son_40bca8', '2021-04-10', 334.878198);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('O', 'g_name_1', 285.529132, 't1__0a9586', 'son_f78e17', 9.01, 'son_40bca8', '2021-05-27', 182.319045);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('A', 'g_name_1', 285.529132, 't1__0a9586', 'son_f78e17', 9.01, 'son_40bca8', '2023-01-01', 986.066566);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('?', 'g_name_1', 285.529132, 't1__0a9586', 'son_f78e17', 9.01, 'son_40bca8', '2021-06-28', 126.856521);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('_', 'g_name_1', 285.529132, 't1__0a9586', 'son_f78e17', 9.01, 'son_40bca8', '2020-12-06', 741.842896);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_13', 'g_name_1', 285.529132, 't1__0a9586', 'son_f78e17', 9.0, 'son_40bca8', '2025-04-12', 587.103196);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_14', 'g_name_1', 285.529132, 't1__0a9586', 'son_f78e17', 9.0, 'son_40bca8', '2021-03-18', 44.682291);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_15', 'g_name_1', 285.529132, 't1__0a9586', 'son_f78e17', 9.01, 'son_40bca8', '2023-08-15', 191.847248);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_16', 'g_name_1', 285.529132, 't1__0a9586', 'son_f78e17', 9.01, 'son_40bca8', '2024-06-13', 21.917736);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT artist_name, country FROM (SELECT * FROM artist AS LHS WHERE EXISTS(SELECT 1 FROM (SELECT * FROM song WHERE (rating >= 9.0)) AS RHS WHERE (LHS.artist_name = RHS.artist_name AND LHS.country = RHS.country))) ORDER BY artist_name, country NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT T1.artist_name, T1.country FROM artist AS T1 JOIN song AS T2 ON T1.artist_name = T2.artist_name WHERE T2.rating > 9;

/*
Prediction Result:
('t1__0a9586', 't1__3d362e')
('@', 'art_2440df')
*/