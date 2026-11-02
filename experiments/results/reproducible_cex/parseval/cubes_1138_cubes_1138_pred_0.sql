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
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('t1__f729ae', 'g_name_1', 't1__581979', 'art_c0de8b');

INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('@', 'g_name_1', 't1__581979', 'art_c0de8b');

INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('A', 'g_name_1', 'art_2440df', 'art_c0de8b');

INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('t2__8299a1', 'g_name_1', 't1__581979', 'art_c0de8b');

-- Inserting into table: files --
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (486.033807, 't1__f729ae', 'fil_2dd0e2', 'fil_2d04a5', 'fil_460987');

-- Inserting into table: song --
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_1', 'g_name_1', 486.033807, 't1__f729ae', 'son_f78e17', 345.329712, 'son_40bca8', '2022-12-08', 900.01);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_2', 'g_name_1', 486.033807, 't1__f729ae', 'son_f78e17', 292.730571, 'son_40bca8', '2022-04-27', 900.01);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_3', 'g_name_1', 486.033807, 't1__f729ae', 'son_f78e17', 249.706432, 'son_40bca8', '2021-02-11', 900.01);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_4', 'g_name_1', 486.033807, 'A', 'son_f78e17', 483.665643, 'son_40bca8', '2021-05-05', 900.01);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_5', 'g_name_1', 486.033807, 'A', 'son_f78e17', 710.998147, 'son_40bca8', '2020-01-20', 900.01);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_6', 'g_name_1', 486.033807, 'A', 'son_f78e17', 797.015047, 'son_40bca8', '2022-09-17', 900.01);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_7', 'g_name_1', 486.033807, 'A', 'son_f78e17', 294.861575, 'son_40bca8', '2023-01-03', 900.01);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_8', 'g_name_1', 486.033807, 'A', 'son_f78e17', 994.117864, 'son_40bca8', '2022-08-24', 900.01);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_9', 'g_name_1', 486.033807, 'A', 'son_f78e17', 737.440743, 'son_40bca8', '2023-10-03', 900.01);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_10', 'g_name_1', 486.033807, 'A', 'son_f78e17', 304.02808, 'son_40bca8', '2022-01-16', 900.01);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_11', 'g_name_1', 486.033807, 'A', 'son_f78e17', 240.969194, 'son_40bca8', '2023-01-01', 900.01);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_12', 'g_name_1', 486.033807, 'A', 'son_f78e17', 792.223623, 'son_40bca8', '2022-08-20', 900.01);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_13', 'g_name_1', 486.033807, 'A', 'son_f78e17', 126.856521, 'son_40bca8', '2025-06-27', 900.01);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_14', 'g_name_1', 486.033807, 'A', 'son_f78e17', 345.718563, 'son_40bca8', '2025-09-21', 900.01);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_15', 'g_name_1', 486.033807, 'A', 'son_f78e17', 83.204633, 'son_40bca8', '2020-01-23', 900.01);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_16', 'g_name_1', 486.033807, 'A', 'son_f78e17', 963.351729, 'son_40bca8', '2025-07-01', 900.01);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_17', 'g_name_1', 486.033807, 'A', 'son_f78e17', 587.103196, 'son_40bca8', '2020-06-23', 900.01);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_18', 'g_name_1', 486.033807, 'A', 'son_f78e17', 44.682291, 'son_40bca8', '2020-10-26', 900.01);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('O', 'g_name_1', 486.033807, 't2__8299a1', 'son_f78e17', 322.782838, 'son_40bca8', '2025-06-20', 900.01);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('A', 'g_name_1', 486.033807, 't2__8299a1', 'son_f78e17', 21.917736, 'son_40bca8', '2023-08-27', 900.01);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_19', 'g_name_1', 486.033807, 't2__8299a1', 'son_f78e17', 760.580899, 'son_40bca8', '2023-02-21', 900.01);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('?', 'g_name_1', 486.033807, 't2__8299a1', 'son_f78e17', 680.514642, 'son_40bca8', '2022-11-29', 900.01);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_22', 'g_name_1', 486.033807, 't2__8299a1', 'son_f78e17', 499.570479, 'son_40bca8', '2020-03-14', 900.01);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Q', 'g_name_1', 486.033807, 't2__8299a1', 'son_f78e17', 673.065986, 'son_40bca8', '2020-11-05', 900.01);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_24', 'g_name_1', 486.033807, 't2__8299a1', 'son_f78e17', 889.661694, 'son_40bca8', '2020-01-28', 900.01);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_26', 'g_name_1', 486.033807, 't2__8299a1', 'son_f78e17', 937.856955, 'son_40bca8', '2022-08-06', 900.01);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('I', 'g_name_1', 486.033807, 't2__8299a1', 'son_f78e17', 187.343342, 'son_40bca8', '2025-11-03', 900.01);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_27', 'g_name_1', 486.033807, 't2__8299a1', 'son_f78e17', 763.856372, 'son_40bca8', '2024-03-14', 900.01);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_29', 'g_name_1', 486.033807, 't1__f729ae', 'son_f78e17', 133.223471, 'son_40bca8', '2025-11-18', 900.0);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_30', 'g_name_1', 486.033807, 't1__f729ae', 'son_f78e17', 612.02959, 'son_40bca8', '2023-07-07', 900.0);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_31', 'g_name_1', 486.033807, 't1__f729ae', 'son_f78e17', 845.831524, 'son_40bca8', '2024-04-09', 900.0);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_32', 'g_name_1', 486.033807, 't1__f729ae', 'son_f78e17', 998.887019, 'son_40bca8', '2024-03-19', 900.01);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_33', 'g_name_1', 486.033807, 't1__f729ae', 'son_f78e17', 550.03107, 'son_40bca8', '2023-01-20', 900.01);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_34', 'g_name_1', 486.033807, 't1__f729ae', 'son_f78e17', 943.791649, 'son_40bca8', '2023-03-31', 900.01);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_35', 'g_name_1', 486.033807, 't1__f729ae', 'son_f78e17', 470.165282, 'son_40bca8', '2024-04-25', 900.01);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_36', 'g_name_1', 486.033807, 't1__f729ae', 'son_f78e17', 792.401003, 'son_40bca8', '2021-07-18', 900.01);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_37', 'g_name_1', 486.033807, 't1__f729ae', 'son_f78e17', 164.583726, 'son_40bca8', '2021-01-15', 900.01);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT artist_name, country FROM (SELECT song_name, artist_name, country, f_id, genre_is, rating, languages, releasedate, resolution, COUNT(*) OVER () AS n FROM (SELECT * FROM song AS LHS WHERE EXISTS(SELECT 1 FROM artist AS RHS WHERE (LHS.artist_name = RHS.artist_name AND LHS.country = RHS.country)))) WHERE (resolution > 900.0 OR n < 1) ORDER BY artist_name, country NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
SELECT T1.artist_name, T1.country FROM artist AS T1 JOIN song AS T2 ON T1.artist_name = T2.artist_name WHERE T2.resolution > 900 GROUP BY T2.artist_name HAVING COUNT(*) >= 1;

/*
Prediction Result:
('A', 'art_2440df')
('t1__f729ae', 't1__581979')
('t2__8299a1', 't1__581979')
*/