-- Schema DDL
CREATE TABLE "genre" ("g_name" TEXT(20) PRIMARY KEY, "rating" TEXT(10), "most_popular_in" TEXT(50));

CREATE TABLE "artist" ("artist_name" TEXT(50) PRIMARY KEY, "preferred_genre" TEXT(50), "country" TEXT(20), "gender" TEXT(20), FOREIGN KEY ("preferred_genre") REFERENCES "genre" ("g_name"));

CREATE TABLE "files" ("f_id" REAL(10) PRIMARY KEY, "artist_name" TEXT(50), "file_size" TEXT(20), "duration" TEXT(20), "formats" TEXT(20), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

CREATE TABLE "song" ("song_name" TEXT(50) PRIMARY KEY, "genre_is" TEXT(20), "f_id" REAL(10), "artist_name" TEXT(50), "country" TEXT(20), "rating" REAL(10), "languages" TEXT(20), "releasedate" DATE, "resolution" REAL(10), FOREIGN KEY ("genre_is") REFERENCES "genre" ("g_name"), FOREIGN KEY ("f_id") REFERENCES "files" ("f_id"), FOREIGN KEY ("artist_name") REFERENCES "artist" ("artist_name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests standard GROUP BY and primary ORDER BY (count___ ASC) vs DESC, as well as COUNT(DISTINCT gender) vs COUNT(*).
INSERT INTO "genre" ("g_name", "rating", "most_popular_in") VALUES ('Rock', '5', 'USA');
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('Artist1', 'Rock', 'USA', 'Male');
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('Artist2', 'Rock', 'UK', 'Female');
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('Artist3', 'Rock', 'Canada', 'Female');
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('Artist4', 'Rock', 'Australia', 'Non-Binary');
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('Artist5', 'Rock', 'USA', 'Non-Binary');
INSERT INTO "artist" ("artist_name", "preferred_genre", "country", "gender") VALUES ('Artist6', 'Rock', 'UK', 'Non-Binary');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, gender FROM (SELECT gender, COUNT(*) AS n FROM artist GROUP BY gender) ORDER BY count___, gender NULLS LAST;

/*
Gold Result:
(1, 'Male')
(2, 'Female')
(3, 'Non-Binary')
*/

-- Prediction Query
SELECT COUNT(*), gender FROM artist GROUP BY gender;

/*
Prediction Result:
(2, 'Female')
(1, 'Male')
(3, 'Non-Binary')
*/