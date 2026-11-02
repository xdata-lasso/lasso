-- Schema DDL
CREATE TABLE "genre" ("g_name" TEXT(20) PRIMARY KEY, "rating" TEXT(10), "most_popular_in" TEXT(50));

CREATE TABLE "artist" ("artist_name" TEXT(50) PRIMARY KEY, "preferred_genre" TEXT(50), "country" TEXT(20), "gender" TEXT(20), FOREIGN KEY ("preferred_genre") REFERENCES "genre" ("g_name"));

CREATE TABLE "files" ("f_id" REAL(10) PRIMARY KEY, "artist_name" TEXT(50), "file_size" TEXT(20), "duration" TEXT(20), "formats" TEXT(20), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

CREATE TABLE "song" ("song_name" TEXT(50) PRIMARY KEY, "genre_is" TEXT(20), "f_id" REAL(10), "artist_name" TEXT(50), "country" TEXT(20), "rating" REAL(10), "languages" TEXT(20), "releasedate" DATE, "resolution" REAL(10), FOREIGN KEY ("genre_is") REFERENCES "genre" ("g_name"), FOREIGN KEY ("f_id") REFERENCES "files" ("f_id"), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "genre" ("g_name", "rating", "most_popular_in") VALUES ('Pop', '8', 'USA');
INSERT INTO "genre" ("g_name", "rating", "most_popular_in") VALUES ('Rock', '9', 'UK');
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('Alice', 'Pop', 'USA', 'Female');
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('Bela', 'Rock', 'UK', 'Female');
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('Carlos', 'Pop', 'USA', 'Male');
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (1.0, 'Alice', '4MB', '3:00', 'mp3');
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (2.0, 'Alice', '5MB', '3:30', 'mp3');
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (3.0, 'Alice', '6MB', '4:00', 'wav');
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (4.0, 'Bela', '3MB', '2:45', 'mp3');
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (5.0, 'Bela', '7MB', '4:15', 'flac');
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (6.0, 'Carlos', '4MB', '3:10', 'mp3');
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (7.0, 'Carlos', '5MB', '3:50', 'aac');
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Song_A1', 'Rock', 1.0, 'Alice', 'Canada', 10.0, 'English', '2021-01-10', 720.0);
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Song_A2', 'Pop', 2.0, 'Alice', 'USA', 10.0, 'English', '2021-05-12', 1080.0);
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Song_A3', 'Pop', 3.0, 'Alice', 'USA', 4.0, 'English', '2022-03-15', 480.0);
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Song_B1', 'Pop', 4.0, 'Bela', 'Spain', 2.0, 'Spanish', '2020-07-20', 1080.0);
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Song_B2', 'Rock', 5.0, 'Bela', 'UK', 5.0, 'Spanish', '2020-11-01', 720.0);
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Song_C1', 'Pop', 6.0, 'Carlos', 'USA', 1.0, 'English', '2019-08-09', 720.0);
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Song_C2', 'Pop', 7.0, 'Carlos', 'France', 9.0, 'French', '2021-12-25', 720.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "meanrating" AS "avg_t2_rating_" FROM (SELECT "gender", "languages", AVG("rating") AS "meanrating" FROM (SELECT "LHS"."song_name" AS "song_name", "LHS"."artist_name" AS "artist_name", "LHS"."country" AS "country", "LHS"."f_id" AS "f_id", "LHS"."genre_is" AS "genre_is", "LHS"."rating" AS "rating", "LHS"."languages" AS "languages", "LHS"."releasedate" AS "releasedate", "LHS"."resolution" AS "resolution", "RHS"."country" AS "country_other", "RHS"."gender" AS "gender", "RHS"."preferred_genre" AS "preferred_genre" FROM "song" AS "LHS" INNER JOIN "artist" AS "RHS" ON ("LHS"."artist_name" = "RHS"."artist_name")) GROUP BY "gender", "languages") WHERE ("gender" = 'Female') ORDER BY avg_t2_rating_;

/*
Gold Result:
(3.5,)
(8.0,)
*/

-- Prediction Query
SELECT AVG(T2.rating) FROM artist AS T1 JOIN song AS T2 ON T1.artist_name = T2.artist_name WHERE T1.gender = 'Female';

/*
Prediction Result:
(6.2,)
*/