-- Schema DDL
CREATE TABLE "genre" ("g_name" TEXT(20) PRIMARY KEY, "rating" TEXT(10), "most_popular_in" TEXT(50));

CREATE TABLE "artist" ("artist_name" TEXT(50) PRIMARY KEY, "preferred_genre" TEXT(50), "country" TEXT(20), "gender" TEXT(20), FOREIGN KEY ("preferred_genre") REFERENCES "genre" ("g_name"));

CREATE TABLE "files" ("f_id" REAL(10) PRIMARY KEY, "artist_name" TEXT(50), "file_size" TEXT(20), "duration" TEXT(20), "formats" TEXT(20), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

CREATE TABLE "song" ("song_name" TEXT(50) PRIMARY KEY, "genre_is" TEXT(20), "f_id" REAL(10), "artist_name" TEXT(50), "country" TEXT(20), "rating" REAL(10), "languages" TEXT(20), "releasedate" DATE, "resolution" REAL(10), FOREIGN KEY ("genre_is") REFERENCES "genre" ("g_name"), FOREIGN KEY ("f_id") REFERENCES "files" ("f_id"), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "genre" ("g_name", "rating", "most_popular_in") VALUES ('Colleen Nguyen', 'special', 'stand');
INSERT INTO "genre" ("g_name", "rating", "most_popular_in") VALUES ('Thomas Ellis', 'evidence', 'chair');
INSERT INTO "genre" ("g_name", "rating", "most_popular_in") VALUES ('Shannon Hernandez', 'collection', 'structure');
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('Rodney Trujillo', 'Colleen Nguyen', 'Iran', 'executive');
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('Justin Baker', 'Thomas Ellis', 'Myanmar', 'later');
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('Linda Cruz', 'Shannon Hernandez', 'Nepal', 'management');
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (1010.5, 'Rodney Trujillo', 'attorney', 'development', 'white');
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (1013.5, 'Justin Baker', 'water', 'past', 'inside');
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (1016.5, 'Linda Cruz', 'newspaper', 'enter', 'on');
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Sherri Edwards', 'Colleen Nguyen', 1010.5, 'Rodney Trujillo', 'Palau', 1011.5, 'money', '1973-04-04', 1012.5);
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Zachary Taylor', 'Thomas Ellis', 1013.5, 'Justin Baker', 'Lithuania', NULL, 'benefit', '1974-05-05', 1015.5);
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Alexandra Le', 'Shannon Hernandez', 1016.5, 'Linda Cruz', 'Pitcairn Islands', 1017.5, 'benefit', '1974-05-05', 1018.5);
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Nicole Mack', 'Colleen Nguyen', 1010.5, 'Rodney Trujillo', 'Palau', NULL, 'money', '1973-04-04', 1012.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT meanrating AS avg_rating_, languages FROM (SELECT languages, releasedate, AVG(rating) AS meanrating FROM song GROUP BY languages, releasedate) ORDER BY avg_rating_, languages NULLS LAST;

/*
Gold Result:
(1011.5, 'money')
(1017.5, 'benefit')
*/

-- Prediction Query
SELECT AVG(rating), languages FROM song GROUP BY languages;

/*
Prediction Result:
(1017.5, 'benefit')
(1011.5, 'money')
*/