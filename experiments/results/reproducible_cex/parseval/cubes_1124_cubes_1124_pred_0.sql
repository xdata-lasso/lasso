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

INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('son_56e3a1', 'g_name_1', 'art_2440df', 'art_c0de8b');

-- Inserting into table: files --
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (165.344793, 'artist_name_1', 'fil_2dd0e2', 'fil_2d04a5', 'fil_460987');

-- Inserting into table: song --
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_1', 'g_name_1', 165.344793, 'son_56e3a1', 'son_f78e17', 345.329712, 'son_8e3784', '2022-12-08', 38.668834);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_2', 'g_name_1', 165.344793, 'son_56e3a1', 'son_f78e17', 572.766956, 'son_8e3784', '2022-04-27', 868.436572);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_3', 'g_name_1', 165.344793, 'son_56e3a1', 'son_f78e17', 249.706432, 'son_8e3784', '2021-02-11', 688.4027);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_4', 'g_name_1', 165.344793, 'son_56e3a1', 'son_f78e17', 906.21648, 'son_8e3784', '2025-06-04', 779.409124);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_5', 'g_name_1', 165.344793, 'son_56e3a1', 'son_f78e17', 134.487977, 'son_8e3784', '2020-01-20', 795.366812);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_6', 'g_name_1', 165.344793, 'son_56e3a1', 'son_f78e17', 718.397869, 'son_8e3784', '2023-08-23', 882.963176);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_7', 'g_name_1', 165.344793, 'son_56e3a1', 'son_f78e17', 663.049759, NULL, '2023-11-30', 944.247544);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_8', 'g_name_1', 165.344793, 'son_56e3a1', 'son_f78e17', 503.083789, NULL, '2023-08-07', 737.440743);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_9', 'g_name_1', 165.344793, 'son_56e3a1', 'son_f78e17', 179.378884, NULL, '2023-05-30', 125.12763);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_10', 'g_name_1', 165.344793, 'artist_name_1', 'son_f78e17', 787.938887, 'son_8e3784', '2022-02-26', 666.330692);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_11', 'g_name_1', 165.344793, 'artist_name_1', 'son_f78e17', 619.836822, 'son_8e3784', '2023-03-17', 133.007885);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_12', 'g_name_1', 165.344793, 'son_56e3a1', 'son_f78e17', 933.422701, 'son_8e3784', '2023-11-17', 992.733505);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_13', 'g_name_1', 165.344793, 'son_56e3a1', 'son_f78e17', 83.204633, 'son_8e3784', '2020-01-23', 587.783596);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_14', 'g_name_1', 165.344793, 'son_56e3a1', 'son_f78e17', 801.414196, 'son_8e3784', '2024-09-18', 963.351729);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_15', 'g_name_1', 165.344793, 'son_56e3a1', 'son_f78e17', 663.001988, 'son_8e3784', '2020-11-01', 950.466571);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_16', 'g_name_1', 165.344793, 'son_56e3a1', 'son_f78e17', 734.586266, 'son_8e3784', '2021-03-18', 44.682291);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_17', 'g_name_1', 165.344793, 'son_56e3a1', 'son_f78e17', 517.275698, 'son_8e3784', '2025-08-22', 769.021654);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_18', 'g_name_1', 165.344793, 'son_56e3a1', 'son_f78e17', 191.847248, 'son_8e3784', '2025-06-20', 452.706544);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_19', 'g_name_1', 165.344793, 'son_56e3a1', 'son_f78e17', 676.357279, 'son_8e3784', '2022-07-11', 478.908865);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_20', 'g_name_1', 165.344793, 'son_56e3a1', 'son_f78e17', 979.158161, 'son_8e3784', '2022-10-25', 597.420508);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_21', 'g_name_1', 165.344793, 'son_56e3a1', 'son_f78e17', 586.906897, 'son_8e3784', '2024-05-15', 242.260296);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_22', 'g_name_1', 165.344793, 'son_56e3a1', 'son_f78e17', 718.756092, 'son_8e3784', '2020-03-14', 22.720462);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_23', 'g_name_1', 165.344793, 'son_56e3a1', 'son_f78e17', 673.065986, 'son_8e3784', '2020-11-05', 325.080047);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_24', 'g_name_1', 165.344793, 'son_56e3a1', 'son_f78e17', 889.661694, 'son_8e3784', '2020-01-28', 427.383654);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_25', 'g_name_1', 165.344793, 'son_56e3a1', 'son_f78e17', 997.73177, 'son_8e3784', '2024-03-26', 300.875654);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_26', 'g_name_1', 165.344793, 'son_56e3a1', 'son_f78e17', 882.985782, 'son_8e3784', '2022-07-25', 552.838162);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_27', 'g_name_1', 165.344793, 'son_56e3a1', 'son_f78e17', 958.92567, 'son_8e3784', '2021-11-06', 176.308171);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_28', 'g_name_1', 165.344793, 'son_56e3a1', 'son_f78e17', 482.572691, 'son_8e3784', '2021-06-29', 598.409165);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_29', 'g_name_1', 165.344793, 'son_56e3a1', 'son_f78e17', 612.02959, 'son_8e3784', '2023-07-07', 712.264292);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_30', 'g_name_1', 165.344793, 'son_56e3a1', 'son_f78e17', 845.831524, 'son_8e3784', '2024-04-09', 278.010437);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_31', 'g_name_1', 165.344793, 'son_56e3a1', 'son_f78e17', 998.887019, 'son_8e3784', '2024-03-19', 326.912005);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_32', 'g_name_1', 165.344793, 'son_56e3a1', 'son_f78e17', 182.777264, 'son_8e3784', '2023-03-31', 180.527064);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_33', 'g_name_1', 165.344793, 'son_56e3a1', 'son_f78e17', 884.000446, 'son_8e3784', '2022-09-10', 495.297639);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT languages FROM (SELECT * FROM (SELECT * FROM (SELECT artist_name, languages, COUNT(*) AS n FROM song GROUP BY artist_name, languages) ORDER BY artist_name DESC) LIMIT 1);

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT languages FROM song GROUP BY languages ORDER BY COUNT(*) DESC, languages NULLS LAST LIMIT 1;

/*
Prediction Result:
('son_8e3784',)
*/