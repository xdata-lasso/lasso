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
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('t1__23856e', 'g_name_1', 'art_2440df', 'art_c0de8b');

INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('@', 'g_name_1', 'art_2440df', 'art_c0de8b');

INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('A', 'g_name_1', 'art_2440df', 'art_c0de8b');

INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('t2__f6fcd2', 'g_name_1', 'art_2440df', 'art_c0de8b');

-- Inserting into table: files --
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (486.033807, 't1__23856e', 'fil_2dd0e2', 'fil_2d04a5', 'fil_460987');

-- Inserting into table: song --
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_1', 'g_name_1', 486.033807, 't1__23856e', 'son_f78e17', 345.329712, 'english', '2022-12-08', 38.668834);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_2', 'g_name_1', 486.033807, 't1__23856e', 'son_f78e17', 572.766956, 'english', '2022-04-27', 868.436572);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_3', 'g_name_1', 486.033807, 't1__23856e', 'son_f78e17', 249.706432, 'english', '2021-02-11', 688.4027);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_4', 'g_name_1', 486.033807, 'A', 'son_f78e17', 779.409124, 'english', '2021-05-05', 268.82475);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_5', 'g_name_1', 486.033807, 'A', 'son_f78e17', 378.476082, 'english', '2022-09-17', 718.397869);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_6', 'g_name_1', 486.033807, 'A', 'son_f78e17', 841.297061, 'english', '2023-04-22', 663.049759);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_7', 'g_name_1', 486.033807, 'A', 'son_f78e17', 749.826493, 'english', '2025-08-22', 185.86457);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_8', 'g_name_1', 486.033807, 'A', 'son_f78e17', 855.355181, 'english', '2022-01-04', 303.05704);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_9', 'g_name_1', 486.033807, 'A', 'son_f78e17', 22.535764, 'english', '2022-04-29', 240.969194);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_10', 'g_name_1', 486.033807, 'A', 'son_f78e17', 792.223623, 'english', '2022-08-20', 227.766936);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_11', 'g_name_1', 486.033807, 'A', 'son_f78e17', 126.856521, 'english', '2025-06-27', 327.753528);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_12', 'g_name_1', 486.033807, 'A', 'son_f78e17', 992.733505, 'english', '2021-10-25', 768.216462);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_13', 'g_name_1', 486.033807, 'A', 'son_f78e17', 627.258639, 'english', '2024-09-18', 963.351729);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_14', 'g_name_1', 486.033807, 'A', 'son_f78e17', 663.001988, 'english', '2020-11-01', 950.466571);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_15', 'g_name_1', 486.033807, 'A', 'son_f78e17', 734.586266, 'english', '2021-03-18', 44.682291);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_16', 'g_name_1', 486.033807, 'A', 'son_f78e17', 805.746877, 'english', '2023-08-15', 191.847248);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_17', 'g_name_1', 486.033807, 'A', 'son_f78e17', 816.814398, 'english', '2024-06-13', 21.917736);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_18', 'g_name_1', 486.033807, 'A', 'son_f78e17', 478.908865, 'english', '2022-04-13', 590.639932);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Q', 'g_name_1', 486.033807, 't2__f6fcd2', 'son_f78e17', 220.906948, 'english', '2020-12-02', 586.906897);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('A', 'g_name_1', 486.033807, 't2__f6fcd2', 'son_f78e17', 488.977171, 'english', '2023-03-15', 499.570479);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_19', 'g_name_1', 486.033807, 't2__f6fcd2', 'son_f78e17', 797.364011, 'english', '2022-08-27', 705.580387);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('O', 'g_name_1', 486.033807, 't2__f6fcd2', 'son_f78e17', 297.722676, 'english', '2021-07-19', 889.661694);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_22', 'g_name_1', 486.033807, 't2__f6fcd2', 'son_f78e17', 997.73177, 'english', '2024-03-26', 300.875654);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('G', 'g_name_1', 486.033807, 't2__f6fcd2', 'son_f78e17', 228.583847, 'english', '2021-04-03', 187.343342);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_24', 'g_name_1', 486.033807, 't2__f6fcd2', 'son_f78e17', 763.856372, 'english', '2024-03-14', 913.303855);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_26', 'g_name_1', 486.033807, 't2__f6fcd2', 'son_f78e17', 712.264292, 'english', '2024-12-25', 920.013763);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_27', 'g_name_1', 486.033807, 't2__f6fcd2', 'son_f78e17', 998.887019, 'english', '2024-03-19', 326.912005);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_28', 'g_name_1', 486.033807, 't1__23856e', 'son_f78e17', 145.402595, 't2__68dd27', '2023-03-31', 180.527064);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_29', 'g_name_1', 486.033807, 't1__23856e', 'son_f78e17', 884.000446, 't2__dc1e3c', '2022-09-10', 495.297639);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_30', 'g_name_1', 486.033807, 't1__23856e', 'son_f78e17', 447.109657, 't2__d6cadb', '2021-11-05', 811.601922);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_31', 'g_name_1', 486.033807, 't1__23856e', 'son_f78e17', 860.770887, 'english', '2025-06-26', 541.393553);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_32', 'g_name_1', 486.033807, 't1__23856e', 'son_f78e17', 410.133844, 'english', '2020-12-28', 707.476301);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_33', 'g_name_1', 486.033807, 't1__23856e', 'son_f78e17', 755.698226, 'english', '2021-02-03', 712.084197);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_34', 'g_name_1', 486.033807, 't1__23856e', 'son_f78e17', 390.34832, 'english', '2023-07-16', 367.405851);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_35', 'g_name_1', 486.033807, 't1__23856e', 'son_f78e17', 124.573829, 'english', '2020-04-02', 50.647649);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_36', 'g_name_1', 486.033807, 't1__23856e', 'son_f78e17', 705.754562, 'english', '2021-04-26', 439.200238);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "artist_name", "n" AS "count___" FROM (SELECT "LHS"."country" AS "country", "LHS"."languages" AS "languages", "LHS"."n" AS "n", "RHS"."artist_name" AS "artist_name", "RHS"."gender" AS "gender", "RHS"."preferred_genre" AS "preferred_genre" FROM (SELECT * FROM (SELECT "country", "languages", COUNT(*) AS "n" FROM "song" GROUP BY "country", "languages") WHERE ("languages" = 'english' OR n < 1)) AS LHS LEFT JOIN artist AS RHS ON (LHS.country = RHS.country)) ORDER BY artist_name, "artist_name" NULLS LAST, count___ NULLS LAST;

/*
Gold Result:
(None, 33)
*/

-- Prediction Query
SELECT T1.artist_name, COUNT(*) FROM artist AS T1 JOIN song AS T2 ON T1.artist_name = T2.artist_name WHERE T2.languages = 'english' GROUP BY T2.artist_name HAVING COUNT(*) >= 1;

/*
Prediction Result:
('A', 15)
('t1__23856e', 9)
('t2__f6fcd2', 9)
*/