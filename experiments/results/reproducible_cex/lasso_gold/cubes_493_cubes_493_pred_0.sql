-- Schema DDL
CREATE TABLE "stadium" ("Stadium_ID" INTEGER PRIMARY KEY, "Location" TEXT, "Name" TEXT, "Capacity" INTEGER, "Highest" INTEGER, "Lowest" INTEGER, "Average" INTEGER);

CREATE TABLE "singer" ("Singer_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Song_Name" TEXT, "Song_release_year" TEXT, "Age" INTEGER, "Is_male" INTEGER);

CREATE TABLE "concert" ("concert_ID" INTEGER PRIMARY KEY, "Stadium_ID" TEXT, "concert_Name" TEXT, "Theme" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("Stadium_ID"));

CREATE TABLE "singer_in_concert" ("concert_ID" INTEGER, "Singer_ID" TEXT, PRIMARY KEY ("concert_ID", "Singer_ID"), FOREIGN KEY ("Singer_ID") REFERENCES "singer" ("Singer_ID"), FOREIGN KEY ("concert_ID") REFERENCES "concert" ("concert_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "singer" ("singer_id", "name", "country", "song_name", "song_release_year", "age", "is_male") VALUES (1218, 'Katherine Mcguire', 'Bermuda', 'Jared Sanchez', 'record', 1219, 1220);
INSERT INTO "stadium" ("stadium_id", "location", "name", "capacity", "highest", "lowest", "average") VALUES (1221, '856 Bell Motorway Suite 443
Lake Jamesville, WA 70737', 'Melissa Lee', 1222, 1223, 1224, 1225);
INSERT INTO "concert" ("concert_id", "stadium_id", "concert_name", "theme", "year") VALUES (1226, 1221, 'Destiny Lawrence', NULL, '2014');
INSERT INTO "singer_in_concert" ("concert_id", "singer_id") VALUES (1226, 1218);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.singer_id AS singer_id, LHS.name AS name, LHS.country AS country, LHS.song_name AS song_name, LHS.song_release_year AS song_release_year, LHS.age AS age, LHS.is_male AS is_male, LHS.concert_id AS concert_id, LHS.concert_name AS concert_name, LHS.theme AS theme, LHS.stadium_id AS stadium_id, LHS.year AS YEAR FROM (SELECT LHS.singer_id AS singer_id, LHS.name AS name, LHS.country AS country, LHS.song_name AS song_name, LHS.song_release_year AS song_release_year, LHS.age AS age, LHS.is_male AS is_male, LHS.concert_id AS concert_id, RHS.concert_name AS concert_name, RHS.theme AS theme, RHS.stadium_id AS stadium_id, RHS.year AS YEAR FROM (SELECT LHS.singer_id AS singer_id, LHS.name AS name, LHS.country AS country, LHS.song_name AS song_name, LHS.song_release_year AS song_release_year, LHS.age AS age, LHS.is_male AS is_male, RHS.concert_id AS concert_id FROM singer AS LHS INNER JOIN singer_in_concert AS RHS ON (LHS.singer_id = RHS.singer_id)) AS LHS INNER JOIN concert AS RHS ON (LHS.concert_id = RHS.concert_id)) AS LHS INNER JOIN (SELECT * FROM concert WHERE (YEAR = 2014)) AS RHS ON (LHS.concert_id = RHS.concert_id AND LHS.concert_name = RHS.concert_name AND LHS.theme = RHS.theme AND LHS.stadium_id = RHS.stadium_id AND LHS.year = RHS.year)) ORDER BY name;

/*
Gold Result:
*/

-- Prediction Query
SELECT T2.name FROM singer_in_concert AS T1 JOIN singer AS T2 ON T1.singer_id = T2.singer_id JOIN concert AS T3 ON T1.concert_id = T3.concert_id WHERE T3.year = 2014;

/*
Prediction Result:
('Katherine Mcguire',)
*/