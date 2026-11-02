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

-- Inserting into table: files --
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (582.588439, 'artist_name_1', 'fil_2dd0e2', 'fil_2d04a5', 'fil_1bb658');

INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (165.344793, 'artist_name_1', 'fil_2dd0e2', 'fil_2d04a5', 'fil_1bb658');

INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (345.329712, 'artist_name_1', 'fil_2dd0e2', 'fil_2d04a5', 'fil_1bb658');

INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (38.668834, 'artist_name_1', 'fil_2dd0e2', 'fil_2d04a5', 'fil_c765f7');

INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (171.746906, 'artist_name_1', 'fil_2dd0e2', 'fil_2d04a5', 'fil_c765f7');

INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (868.436572, 'artist_name_1', 'fil_2dd0e2', 'fil_2d04a5', 'fil_c765f7');

INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (537.136345, 'artist_name_1', 'fil_2dd0e2', 'fil_2d04a5', 'fil_1bb658');

INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (38.937207, 'artist_name_1', 'fil_2dd0e2', 'fil_2d04a5', 'fil_1bb658');

INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (249.706432, 'artist_name_1', 'fil_2dd0e2', 'fil_2d04a5', 'fil_1bb658');

INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (99.523333, 'artist_name_1', 'fil_2dd0e2', 'fil_2d04a5', 'fil_c765f7');

INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (314.813297, 'artist_name_1', 'fil_2dd0e2', 'fil_2d04a5', 'fil_c765f7');

INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (328.996339, 'artist_name_1', 'fil_2dd0e2', 'fil_2d04a5', 'fil_c765f7');

INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (378.476082, 'artist_name_1', 'fil_2dd0e2', 'fil_2d04a5', 'fil_1bb658');

INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (718.397869, 'artist_name_1', 'fil_2dd0e2', 'fil_2d04a5', 'fil_1bb658');

INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (882.963176, 'artist_name_1', 'fil_2dd0e2', 'fil_2d04a5', 'fil_1bb658');

INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (294.861575, 'artist_name_1', 'fil_2dd0e2', 'fil_2d04a5', 'fil_c765f7');

INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (711.020062, 'artist_name_1', 'fil_2dd0e2', 'fil_2d04a5', 'fil_c765f7');

INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (994.117864, 'artist_name_1', 'fil_2dd0e2', 'fil_2d04a5', 'fil_c765f7');

INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (503.083789, 'artist_name_1', 'fil_2dd0e2', 'fil_2d04a5', NULL);

INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (737.440743, 'artist_name_1', 'fil_2dd0e2', 'fil_2d04a5', NULL);

INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (855.355181, 'artist_name_1', 'fil_2dd0e2', 'fil_2d04a5', NULL);

INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (303.05704, 'artist_name_1', 'fil_2dd0e2', 'fil_2d04a5', NULL);

INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (182.319045, 'artist_name_1', 'fil_2dd0e2', 'fil_2d04a5', NULL);

INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (240.969194, 'artist_name_1', 'fil_2dd0e2', 'fil_2d04a5', NULL);

INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (986.066566, 'artist_name_1', 'fil_2dd0e2', 'fil_2d04a5', 'fil_1bb658');

INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (792.223623, 'artist_name_1', 'fil_2dd0e2', 'fil_2d04a5', 'fil_1bb658');

INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (227.766936, 'artist_name_1', 'fil_2dd0e2', 'fil_2d04a5', 'fil_1bb658');

INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (133.007885, 'artist_name_1', 'fil_2dd0e2', 'fil_2d04a5', 'fil_c765f7');

INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (489.397796, 'artist_name_1', 'fil_2dd0e2', 'fil_2d04a5', 'fil_c765f7');

INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (345.718563, 'artist_name_1', 'fil_2dd0e2', 'fil_2d04a5', 'fil_c765f7');

INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (768.216462, 'artist_name_1', 'fil_2dd0e2', 'fil_2d04a5', 'fil_1bb658');

INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (741.842896, 'artist_name_1', 'fil_2dd0e2', 'fil_2d04a5', 'fil_1bb658');

INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (627.258639, 'artist_name_1', 'fil_2dd0e2', 'fil_2d04a5', 'fil_1bb658');

INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (963.351729, 'artist_name_1', 'fil_2dd0e2', 'fil_2d04a5', 'fil_c765f7');

INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (983.124993, 'artist_name_1', 'fil_2dd0e2', 'fil_2d04a5', 'fil_c765f7');

INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (663.001988, 'artist_name_1', 'fil_2dd0e2', 'fil_2d04a5', 'fil_c765f7');

INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (950.466571, 'artist_name_1', 'fil_2dd0e2', 'fil_2d04a5', 'fil_1bb658');

INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (128.76421, 'artist_name_1', 'fil_2dd0e2', 'fil_2d04a5', 'fil_1bb658');

INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (44.682291, 'artist_name_1', 'fil_2dd0e2', 'fil_2d04a5', 'fil_1bb658');

INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (467.07027, 'artist_name_1', 'fil_2dd0e2', 'fil_2d04a5', 'fil_c765f7');

INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (805.746877, 'artist_name_1', 'fil_2dd0e2', 'fil_2d04a5', 'fil_c765f7');

INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (191.847248, 'artist_name_1', 'fil_2dd0e2', 'fil_2d04a5', 'fil_c765f7');

INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (452.706544, 'artist_name_1', 'fil_2dd0e2', 'fil_2d04a5', 'fil_1bb658');

INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (21.917736, 'artist_name_1', 'fil_2dd0e2', 'fil_2d04a5', 'fil_1bb658');

INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (225.300904, 'artist_name_1', 'fil_2dd0e2', 'fil_2d04a5', 'fil_1bb658');

INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (590.639932, 'artist_name_1', 'fil_2dd0e2', 'fil_2d04a5', 'fil_c765f7');

INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (979.158161, 'artist_name_1', 'fil_2dd0e2', 'fil_2d04a5', 'fil_c765f7');

INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (597.420508, 'artist_name_1', 'fil_2dd0e2', 'fil_2d04a5', 'fil_c765f7');

INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (680.514642, 'artist_name_1', 'fil_2dd0e2', 'fil_2d04a5', 'fil_1bb658');

INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (389.878901, 'artist_name_1', 'fil_2dd0e2', 'fil_2d04a5', 'fil_1bb658');

INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (938.694822, 'artist_name_1', 'fil_2dd0e2', 'fil_2d04a5', 'fil_1bb658');

INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (718.756092, 'artist_name_1', 'fil_2dd0e2', 'fil_2d04a5', 'fil_c765f7');

INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (22.720462, 'artist_name_1', 'fil_2dd0e2', 'fil_2d04a5', 'fil_c765f7');

INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (705.580387, 'artist_name_1', 'fil_2dd0e2', 'fil_2d04a5', 'fil_c765f7');

INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (825.231787, 'artist_name_1', 'fil_2dd0e2', 'fil_2d04a5', 'fil_1bb658');

INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (325.080047, 'artist_name_1', 'fil_2dd0e2', 'fil_2d04a5', 'fil_1bb658');

INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (138.017996, 'artist_name_1', 'fil_2dd0e2', 'fil_2d04a5', 'fil_1bb658');

INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (6.833035, 'artist_name_1', 'fil_2dd0e2', 'fil_2d04a5', 'fil_c765f7');

INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (274.580687, 'artist_name_1', 'fil_2dd0e2', 'fil_2d04a5', 'fil_c765f7');

INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (881.232072, 'artist_name_1', 'fil_2dd0e2', 'fil_2d04a5', 'fil_c765f7');

INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (300.875654, 'artist_name_1', 'fil_2dd0e2', 'fil_2d04a5', 'fil_1bb658');

INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (937.856955, 'artist_name_1', 'fil_2dd0e2', 'fil_2d04a5', 'fil_1bb658');

INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (882.985782, 'artist_name_1', 'fil_2dd0e2', 'fil_2d04a5', 'fil_1bb658');

INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (552.838162, 'artist_name_1', 'fil_2dd0e2', 'fil_2d04a5', 'fil_c765f7');

INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (731.301441, 'artist_name_1', 'fil_2dd0e2', 'fil_2d04a5', 'fil_c765f7');

INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (958.92567, 'artist_name_1', 'fil_2dd0e2', 'fil_2d04a5', 'fil_c765f7');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT formats FROM (SELECT LHS.formats AS formats, LHS.n AS n, RHS.formats AS formats_other, RHS.n AS n_other FROM (SELECT formats, COUNT(*) AS n FROM files GROUP BY formats) AS LHS CROSS JOIN (SELECT formats, COUNT(*) AS n FROM files GROUP BY formats) AS RHS) WHERE (n > n_other) ORDER BY formats;

/*
Gold Result:
('fil_1bb658',)
('fil_c765f7',)
*/

-- Prediction Query
SELECT formats FROM files GROUP BY formats ORDER BY COUNT(*) DESC, formats NULLS LAST LIMIT 1;

/*
Prediction Result:
('fil_1bb658',)
*/