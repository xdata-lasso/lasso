-- Schema DDL
CREATE TABLE "genre" ("g_name" TEXT(20) PRIMARY KEY, "rating" TEXT(10), "most_popular_in" TEXT(50));

CREATE TABLE "artist" ("artist_name" TEXT(50) PRIMARY KEY, "preferred_genre" TEXT(50), "country" TEXT(20), "gender" TEXT(20), FOREIGN KEY ("preferred_genre") REFERENCES "genre" ("g_name"));

CREATE TABLE "files" ("f_id" REAL(10) PRIMARY KEY, "artist_name" TEXT(50), "file_size" TEXT(20), "duration" TEXT(20), "formats" TEXT(20), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

CREATE TABLE "song" ("song_name" TEXT(50) PRIMARY KEY, "genre_is" TEXT(20), "f_id" REAL(10), "artist_name" TEXT(50), "country" TEXT(20), "rating" REAL(10), "languages" TEXT(20), "releasedate" DATE, "resolution" REAL(10), FOREIGN KEY ("genre_is") REFERENCES "genre" ("g_name"), FOREIGN KEY ("f_id") REFERENCES "files" ("f_id"), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "genre" ("g_name", "rating", "most_popular_in") VALUES ('blues', 'high', 'USA');
INSERT INTO "genre" ("g_name", "rating", "most_popular_in") VALUES ('rock', 'high', 'UK');
INSERT INTO "genre" ("g_name", "rating", "most_popular_in") VALUES ('jazz', 'medium', 'USA');
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('ArtistA', 'blues', 'USA', 'M');
INSERT INTO "files" ("f_id", "artist_name", "file_size", "duration", "formats") VALUES (1.0, 'ArtistA', '5MB', '3:00', 'mp3');
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Blues_Mid', 'blues', 1.0, 'ArtistA', 'USA', 7.0, 'English', '2020-01-01', 320.0);
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Blues_Low', 'blues', 1.0, 'ArtistA', 'USA', 5.0, 'English', '2020-01-02', 320.0);
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Rock_Low', 'rock', 1.0, 'ArtistA', 'USA', 5.0, 'English', '2020-01-03', 320.0);
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Rock_Mid', 'rock', 1.0, 'ArtistA', 'USA', 7.0, 'English', '2020-01-04', 320.0);
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Rock_High', 'rock', 1.0, 'ArtistA', 'USA', 9.0, 'English', '2020-01-05', 320.0);
INSERT INTO "song" ("song_name", "genre_is", "f_id", "artist_name", "country", "rating", "languages", "releasedate", "resolution") VALUES ('Jazz_Mid', 'jazz', 1.0, 'ArtistA', 'USA', 6.0, 'English', '2020-01-06', 320.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "song_name_other" AS "song_name" FROM (SELECT * FROM (SELECT "LHS"."song_name" AS "song_name", "LHS"."artist_name" AS "artist_name", "LHS"."country" AS "country", "LHS"."f_id" AS "f_id", "LHS"."genre_is" AS "genre_is", "LHS"."rating" AS "rating", "LHS"."languages" AS "languages", "LHS"."releasedate" AS "releasedate", "LHS"."resolution" AS "resolution", "RHS"."song_name" AS "song_name_other", "RHS"."artist_name" AS "artist_name_other", "RHS"."country" AS "country_other", "RHS"."f_id" AS "f_id_other", "RHS"."genre_is" AS "genre_is_other", "RHS"."rating" AS "rating_other", "RHS"."languages" AS "languages_other", "RHS"."releasedate" AS "releasedate_other", "RHS"."resolution" AS "resolution_other" FROM "song" AS "LHS" CROSS JOIN "song" AS "RHS") WHERE ("genre_is" <> "genre_is_other" AND "rating" >= "rating_other")) WHERE ("genre_is" = 'blues') ORDER BY song_name;

/*
Gold Result:
('Jazz_Mid',)
('Rock_Low',)
('Rock_Low',)
('Rock_Mid',)
*/

-- Prediction Query
SELECT song_name FROM song WHERE rating < (SELECT MAX(rating) FROM song WHERE genre_is = 'blues');

/*
Prediction Result:
('Blues_Low',)
('Rock_Low',)
('Jazz_Mid',)
*/