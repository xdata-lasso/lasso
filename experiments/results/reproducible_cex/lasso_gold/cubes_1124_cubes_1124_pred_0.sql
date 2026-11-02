-- Schema DDL
CREATE TABLE "genre" ("g_name" TEXT(20) PRIMARY KEY, "rating" TEXT(10), "most_popular_in" TEXT(50));

CREATE TABLE "artist" ("artist_name" TEXT(50) PRIMARY KEY, "preferred_genre" TEXT(50), "country" TEXT(20), "gender" TEXT(20), FOREIGN KEY ("preferred_genre") REFERENCES "genre" ("g_name"));

CREATE TABLE "files" ("f_id" REAL(10) PRIMARY KEY, "artist_name" TEXT(50), "file_size" TEXT(20), "duration" TEXT(20), "formats" TEXT(20), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

CREATE TABLE "song" ("song_name" TEXT(50) PRIMARY KEY, "genre_is" TEXT(20), "f_id" REAL(10), "artist_name" TEXT(50), "country" TEXT(20), "rating" REAL(10), "languages" TEXT(20), "releasedate" DATE, "resolution" REAL(10), FOREIGN KEY ("genre_is") REFERENCES "genre" ("g_name"), FOREIGN KEY ("f_id") REFERENCES "files" ("f_id"), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "genre" ("g_name", "rating", "most_popular_in") VALUES ('Andrea Reid', 'arrive', 'support');
INSERT INTO "genre" ("g_name", "rating", "most_popular_in") VALUES ('Danielle Ford', 'drop', 'four');
INSERT INTO "genre" ("g_name", "rating", "most_popular_in") VALUES ('Timothy Watts', 'term', 'institution');
INSERT INTO "genre" ("g_name", "rating", "most_popular_in") VALUES ('Frederick Tate', 'almost', 'executive');
INSERT INTO "genre" ("g_name", "rating", "most_popular_in") VALUES ('Jesse Mckay', 'hour', 'start');
INSERT INTO "genre" ("g_name", "rating", "most_popular_in") VALUES ('Deborah Mason', 'sound', 'win');
INSERT INTO "genre" ("g_name", "rating", "most_popular_in") VALUES ('Thomas Harrell', 'color', 'nice');
INSERT INTO "genre" ("g_name", "rating", "most_popular_in") VALUES ('Mark Lynch', 'notice', 'why');
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('Thomas Bradley', 'Andrea Reid', 'San Marino', 'past');
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('Christy Porter', 'Andrea Reid', 'Myanmar', 'inside');
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('Maria Thomas', 'Andrea Reid', 'Japan', 'high');
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('Patrick Ryan', 'Andrea Reid', 'Ukraine', 'discuss');
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('Fred Smith', 'Jesse Mckay', 'Bangladesh', 'career');
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('Sherry Decker', 'Jesse Mckay', 'Senegal', 'receive');
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('Anthony Humphrey', 'Jesse Mckay', 'Martinique', 'may');
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('Angelica Tucker', 'Jesse Mckay', 'Brunei Darussalam', 'your');
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (1013.5, 'Thomas Bradley', 'certainly', 'someone', 'claim');
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (1014.5, 'Thomas Bradley', 'Mr', 'anyone', 'product');
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (1015.5, 'Thomas Bradley', 'minute', 'traditional', 'collection');
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (1016.5, 'Thomas Bradley', 'benefit', 'break', 'structure');
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (1025.5, 'Fred Smith', 'often', 'turn', 'woman');
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (1026.5, 'Fred Smith', 'company', 'policy', 'show');
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (1027.5, 'Fred Smith', 'evidence', 'land', 'road');
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (1028.5, 'Fred Smith', 'news', 'development', 'deep');
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Linda Cruz', 'Andrea Reid', 1013.5, 'Thomas Bradley', 'Seychelles', 1017.5, 'finally', '1974-05-05', 1021.5);
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Julie King', 'Andrea Reid', 1013.5, 'Thomas Bradley', 'Norway', 1030.5, 'finally', '1974-05-06', 1040.5);
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Terri Frazier', 'Andrea Reid', 1013.5, 'Thomas Bradley', 'Guam', 1043.5, 'finally', '1974-05-07', 1059.5);
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Stephen Potter', 'Andrea Reid', 1013.5, 'Thomas Bradley', 'Bouvet Island (Bouvetoya)', 1056.5, 'finally', '1974-05-08', 1078.5);
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Jennifer Powers', NULL, 1025.5, 'Fred Smith', 'Russian Federation', 1029.5, 'author', '1978-09-09', 1033.5);
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Steven Hayes', NULL, 1025.5, 'Fred Smith', 'Norfolk Island', 1042.5, 'author', '1978-09-10', 1052.5);
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Austin Smith', NULL, 1025.5, 'Fred Smith', 'Bahamas', 1055.5, 'author', '1978-09-11', 1071.5);
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Leah Smith', NULL, 1025.5, 'Fred Smith', 'Denmark', 1068.5, 'author', '1978-09-12', 1090.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT languages FROM (SELECT * FROM (SELECT * FROM (SELECT artist_name, languages, COUNT(*) AS n FROM song GROUP BY artist_name, languages) ORDER BY artist_name DESC) LIMIT 1);

/*
Gold Result:
('finally',)
*/

-- Prediction Query
SELECT languages FROM song GROUP BY languages ORDER BY COUNT(*) DESC, languages NULLS LAST LIMIT 1;

/*
Prediction Result:
('author',)
*/