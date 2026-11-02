-- Schema DDL
CREATE TABLE "stadium" ("Stadium_ID" INTEGER PRIMARY KEY, "Location" TEXT, "Name" TEXT, "Capacity" INTEGER, "Highest" INTEGER, "Lowest" INTEGER, "Average" INTEGER);

CREATE TABLE "singer" ("Singer_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Song_Name" TEXT, "Song_release_year" TEXT, "Age" INTEGER, "Is_male" INTEGER);

CREATE TABLE "concert" ("concert_ID" INTEGER PRIMARY KEY, "Stadium_ID" TEXT, "concert_Name" TEXT, "Theme" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("Stadium_ID"));

CREATE TABLE "singer_in_concert" ("concert_ID" INTEGER, "Singer_ID" TEXT, PRIMARY KEY ("concert_ID", "Singer_ID"), FOREIGN KEY ("Singer_ID") REFERENCES "singer" ("Singer_ID"), FOREIGN KEY ("concert_ID") REFERENCES "concert" ("concert_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "stadium" ("Stadium_ID", "Location", "Name", "Capacity", "Highest", "Lowest", "Average") VALUES (1, 'LA', 'Stadium A', 5000, 4000, 500, 2000);
INSERT INTO "singer" ("Singer_ID", "Name", "Country", "Song_Name", "Song_release_year", "Age", "Is_male") VALUES (1, 'David', 'USA', 'Hit 1', '2018', 28, 1);
INSERT INTO "singer" ("Singer_ID", "Name", "Country", "Song_Name", "Song_release_year", "Age", "Is_male") VALUES (2, 'David', 'UK', 'Hit 2', '2020', 40, 1);
INSERT INTO "singer" ("Singer_ID", "Name", "Country", "Song_Name", "Song_release_year", "Age", "Is_male") VALUES (3, 'David', 'Canada', 'Hit 3', '2021', 22, 1);
INSERT INTO "concert" ("concert_ID", "Stadium_ID", "concert_Name", "Theme", "Year") VALUES (1, '1', 'Fest 1', 'Indie', '2022');
INSERT INTO "concert" ("concert_ID", "Stadium_ID", "concert_Name", "Theme", "Year") VALUES (2, '1', 'Fest 2', 'Rock', '2022');
INSERT INTO "concert" ("concert_ID", "Stadium_ID", "concert_Name", "Theme", "Year") VALUES (3, '1', 'Fest 3', 'Pop', '2023');
INSERT INTO "singer_in_concert" ("concert_ID", "Singer_ID") VALUES (1, '1');
INSERT INTO "singer_in_concert" ("concert_ID", "Singer_ID") VALUES (2, '1');
INSERT INTO "singer_in_concert" ("concert_ID", "Singer_ID") VALUES (3, '1');
INSERT INTO "singer_in_concert" ("concert_ID", "Singer_ID") VALUES (1, '2');
INSERT INTO "singer_in_concert" ("concert_ID", "Singer_ID") VALUES (1, '3');
INSERT INTO "singer_in_concert" ("concert_ID", "Singer_ID") VALUES (2, '3');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, n AS count___ FROM (SELECT LHS.singer_id AS singer_id, LHS.name AS name, LHS.country AS country, LHS.song_name AS song_name, LHS.song_release_year AS song_release_year, LHS.age AS age, LHS.is_male AS is_male, RHS.n AS n FROM singer AS LHS INNER JOIN (SELECT singer_id, COUNT(*) AS n FROM singer_in_concert GROUP BY singer_id) AS RHS ON (LHS.singer_id = RHS.singer_id)) ORDER BY name, count___ NULLS LAST;

/*
Gold Result:
('David', 1)
('David', 2)
('David', 3)
*/

-- Prediction Query
SELECT T2.name, COUNT(*) FROM singer_in_concert AS T1 JOIN singer AS T2 ON T1.singer_id = T2.singer_id GROUP BY T2.singer_id;

/*
Prediction Result:
('David', 3)
('David', 1)
('David', 2)
*/