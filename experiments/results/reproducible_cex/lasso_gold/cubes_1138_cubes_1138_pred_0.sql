-- Schema DDL
CREATE TABLE "genre" ("g_name" TEXT(20) PRIMARY KEY, "rating" TEXT(10), "most_popular_in" TEXT(50));

CREATE TABLE "artist" ("artist_name" TEXT(50) PRIMARY KEY, "preferred_genre" TEXT(50), "country" TEXT(20), "gender" TEXT(20), FOREIGN KEY ("preferred_genre") REFERENCES "genre" ("g_name"));

CREATE TABLE "files" ("f_id" REAL(10) PRIMARY KEY, "artist_name" TEXT(50), "file_size" TEXT(20), "duration" TEXT(20), "formats" TEXT(20), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

CREATE TABLE "song" ("song_name" TEXT(50) PRIMARY KEY, "genre_is" TEXT(20), "f_id" REAL(10), "artist_name" TEXT(50), "country" TEXT(20), "rating" REAL(10), "languages" TEXT(20), "releasedate" DATE, "resolution" REAL(10), FOREIGN KEY ("genre_is") REFERENCES "genre" ("g_name"), FOREIGN KEY ("f_id") REFERENCES "files" ("f_id"), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "genre" ("g_name", "rating", "most_popular_in") VALUES ('Benjamin Stanley', 'they', 'hospital');
INSERT INTO "genre" ("g_name", "rating", "most_popular_in") VALUES ('Victoria Wyatt', 'his', 'hear');
INSERT INTO "genre" ("g_name", "rating", "most_popular_in") VALUES ('Jamie Chavez', 'commercial', 'determine');
INSERT INTO "genre" ("g_name", "rating", "most_popular_in") VALUES ('Patrick Ryan', 'minute', 'anyone');
INSERT INTO "genre" ("g_name", "rating", "most_popular_in") VALUES ('Jessica Silva', 'benefit', 'traditional');
INSERT INTO "genre" ("g_name", "rating", "most_popular_in") VALUES ('Zachary Taylor', 'someone', 'break');
INSERT INTO "genre" ("g_name", "rating", "most_popular_in") VALUES ('Christina Brooks', 'woman', 'theory');
INSERT INTO "genre" ("g_name", "rating", "most_popular_in") VALUES ('Troy Nielsen', 'him', 'surface');
INSERT INTO "genre" ("g_name", "rating", "most_popular_in") VALUES ('Linda Burns', 'unit', 'food');
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('Mia Sutton', 'Benjamin Stanley', 'Uzbekistan', 'onto');
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('Mark Ferguson', 'Benjamin Stanley', 'Northern Mariana Islands', 'discuss');
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('Joel Nelson', 'Benjamin Stanley', 'Portugal', 'reveal');
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('Christopher Becker', 'Patrick Ryan', 'Western Sahara', 'set');
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('Janice Carlson', 'Patrick Ryan', 'Algeria', 'building');
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('David Tran', 'Patrick Ryan', 'Pitcairn Islands', 'rest');
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('David Bradley', 'Christina Brooks', 'Palestinian Territory', 'often');
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('Nicholas Cabrera', 'Christina Brooks', 'Lebanon', 'company');
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('Kim Martinez', 'Christina Brooks', 'Yemen', 'news');
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (1007.5, 'Mia Sutton', 'garden', 'stand', 'term');
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (1008.5, 'Mia Sutton', 'threat', 'arrive', 'almost');
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (1009.5, 'Mia Sutton', 'special', 'drop', 'support');
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (1013.5, 'Christopher Becker', 'value', 'example', 'grow');
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (1014.5, 'Christopher Becker', 'not', 'specific', 'brother');
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (1015.5, 'Christopher Becker', 'social', 'put', 'finally');
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (1019.5, 'David Bradley', 'turn', 'development', 'road');
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (1020.5, 'David Bradley', 'policy', 'notice', 'deep');
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (1021.5, 'David Bradley', 'land', 'show', 'sell');
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Derek Clark', 'Benjamin Stanley', 1007.5, 'Mia Sutton', 'Uzbekistan', 1010.5, 'low', '1973-04-04', 901.0);
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Sherri Edwards', 'Benjamin Stanley', 1007.5, 'Mia Sutton', 'Northern Mariana Islands', 1023.5, 'character', '1973-04-05', 901.0);
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Jennifer Rocha', 'Benjamin Stanley', 1007.5, 'Mia Sutton', 'Portugal', 1036.5, 'evidence', '1973-04-06', 901.0);
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Jesse Mckay', NULL, 1013.5, 'Christopher Becker', 'Western Sahara', 1016.5, 'fire', '1976-07-07', 901.0);
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Deborah Mason', NULL, 1013.5, 'Christopher Becker', 'Algeria', 1029.5, 'thought', '1976-07-08', 901.0);
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Thomas Harrell', NULL, 1013.5, 'Christopher Becker', 'Pitcairn Islands', 1042.5, 'purpose', '1976-07-09', 901.0);
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Zachary Santos', 'Christina Brooks', 1019.5, 'David Bradley', 'Palestinian Territory', 1022.5, 'drug', '1979-10-10', 901.0);
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Joseph Martinez', 'Christina Brooks', 1019.5, 'David Bradley', 'Lebanon', 1035.5, 'per', '1979-10-11', 901.0);
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('George Chapman', 'Christina Brooks', 1019.5, 'David Bradley', 'Yemen', 1048.5, 'discussion', '1979-10-12', 901.0);
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Michael Brown', NULL, 1007.5, 'Mia Sutton', 'Uzbekistan', 1010.5, 'low', '1973-04-04', 901.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT artist_name, country FROM (SELECT song_name, artist_name, country, f_id, genre_is, rating, languages, releasedate, resolution, COUNT(*) OVER () AS n FROM (SELECT * FROM song AS LHS WHERE EXISTS(SELECT 1 FROM artist AS RHS WHERE (LHS.artist_name = RHS.artist_name AND LHS.country = RHS.country)))) WHERE (resolution > 900.0 OR n < 1) ORDER BY artist_name, country NULLS LAST;

/*
Gold Result:
('Christopher Becker', 'Western Sahara')
('David Bradley', 'Palestinian Territory')
('Mia Sutton', 'Uzbekistan')
('Mia Sutton', 'Uzbekistan')
*/

-- Prediction Query
SELECT T1.artist_name, T1.country FROM artist AS T1 JOIN song AS T2 ON T1.artist_name = T2.artist_name WHERE T2.resolution > 900 GROUP BY T2.artist_name HAVING COUNT(*) >= 1;

/*
Prediction Result:
('Christopher Becker', 'Western Sahara')
('David Bradley', 'Palestinian Territory')
('Mia Sutton', 'Uzbekistan')
*/