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
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (165.344793, 'artist_name_1', 'fil_2dd0e2', 'fil_2d04a5', 'fil_460987');

-- Inserting into table: song --
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_1', 'g_name_1', 165.344793, 'artist_name_1', 'son_f78e17', 345.329712, 'son_1d883d', '2024-06-15', 833.684115);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_2', 'g_name_1', 165.344793, 'artist_name_1', 'son_f78e17', 292.730571, 'son_1d883d', '2024-06-15', 572.766956);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_3', 'g_name_1', 165.344793, 'artist_name_1', 'son_f78e17', 249.706432, 'son_1d883d', '2024-06-15', 99.523333);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_4', 'g_name_1', 165.344793, 'artist_name_1', 'son_f78e17', 906.21648, 'son_1d883d', '2024-06-15', 483.665643);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_5', 'g_name_1', 165.344793, 'artist_name_1', 'son_f78e17', 710.998147, 'son_1d883d', '2024-06-15', 945.642658);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_6', 'g_name_1', 165.344793, 'artist_name_1', 'son_f78e17', 718.397869, 'son_1d883d', '2024-06-15', 324.940703);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_7', 'g_name_1', 165.344793, 'artist_name_1', 'son_f78e17', 663.049759, 'son_40bca8', NULL, 711.020062);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_8', 'g_name_1', 165.344793, 'artist_name_1', 'son_f78e17', NULL, 'son_1d883d', NULL, 503.083789);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_9', 'g_name_1', 165.344793, 'artist_name_1', 'son_f78e17', NULL, 'son_1d883d', NULL, 855.355181);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_10', 'g_name_1', 165.344793, 'artist_name_1', 'son_f78e17', NULL, 'son_1d883d', NULL, 125.12763);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_11', 'g_name_1', 165.344793, 'artist_name_1', 'son_f78e17', 787.938887, NULL, '2022-02-26', 666.330692);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_12', 'g_name_1', 165.344793, 'artist_name_1', 'son_f78e17', NULL, NULL, '2024-06-15', 619.836822);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_13', 'g_name_1', 165.344793, 'artist_name_1', 'son_f78e17', NULL, NULL, '2024-06-15', 75.403642);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_14', 'g_name_1', 165.344793, 'artist_name_1', 'son_f78e17', NULL, NULL, '2024-06-15', 992.733505);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_15', 'g_name_1', 165.344793, 'artist_name_1', 'son_f78e17', NULL, 'son_1d883d', '2024-06-15', 741.842896);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_16', 'g_name_1', 165.344793, 'artist_name_1', 'son_f78e17', NULL, 'son_1d883d', '2024-06-15', 963.351729);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_17', 'g_name_1', 165.344793, 'artist_name_1', 'son_f78e17', NULL, 'son_1d883d', '2024-06-15', 587.103196);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_18', 'g_name_1', 165.344793, 'artist_name_1', 'son_f78e17', NULL, 'son_1d883d', '2024-06-15', 44.682291);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_19', 'g_name_1', 165.344793, 'artist_name_1', 'son_f78e17', NULL, 'son_1d883d', '2024-06-15', 805.746877);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_20', 'g_name_1', 165.344793, 'artist_name_1', 'son_f78e17', NULL, 'son_1d883d', '2024-06-15', 452.706544);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_21', 'g_name_1', 165.344793, 'artist_name_1', 'son_f78e17', NULL, 'son_1d883d', '2024-06-15', 225.300904);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_22', 'g_name_1', 165.344793, 'artist_name_1', 'son_f78e17', NULL, 'son_1d883d', '2024-06-15', 597.420508);

INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('song_name_23', 'g_name_1', 165.344793, 'artist_name_1', 'son_f78e17', NULL, 'son_1d883d', '2024-06-15', 389.878901);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT meanrating AS avg_rating_, languages FROM (SELECT languages, releasedate, AVG(rating) AS meanrating FROM song GROUP BY languages, releasedate) ORDER BY avg_rating_, languages NULLS LAST;

/*
Gold Result:
(None, 'son_1d883d')
(None, None)
(537.2298685, 'son_1d883d')
(663.049759, 'son_40bca8')
(787.938887, None)
*/

-- Prediction Query
SELECT AVG(rating), languages FROM song GROUP BY languages;

/*
Prediction Result:
(787.938887, None)
(537.2298685, 'son_1d883d')
(663.049759, 'son_40bca8')
*/