-- Schema DDL
CREATE TABLE "stadium" ("Stadium_ID" INTEGER PRIMARY KEY, "Location" TEXT, "Name" TEXT, "Capacity" INTEGER, "Highest" INTEGER, "Lowest" INTEGER, "Average" INTEGER);

CREATE TABLE "singer" ("Singer_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Song_Name" TEXT, "Song_release_year" TEXT, "Age" INTEGER, "Is_male" INTEGER);

CREATE TABLE "concert" ("concert_ID" INTEGER PRIMARY KEY, "Stadium_ID" TEXT, "concert_Name" TEXT, "Theme" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("Stadium_ID"));

CREATE TABLE "singer_in_concert" ("concert_ID" INTEGER, "Singer_ID" TEXT, PRIMARY KEY ("concert_ID", "Singer_ID"), FOREIGN KEY ("Singer_ID") REFERENCES "singer" ("Singer_ID"), FOREIGN KEY ("concert_ID") REFERENCES "concert" ("concert_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests NULL handling in Age and Country, and tests mutants that erroneously INNER JOIN with singer_in_concert or concert.
INSERT INTO "stadium" ("Stadium_ID", "Location", "Name", "Capacity", "Highest", "Lowest", "Average") VALUES (1, 'NY', 'Big Arena', 50000, 48000, 10000, 30000);
INSERT INTO "concert" ("concert_ID", "Stadium_ID", "concert_Name", "Theme", "Year") VALUES (10, '1', 'Rock Fest', 'Rock', '2020');
INSERT INTO "singer" ("Singer_ID", "Name", "Country", "Song_Name", "Song_release_year", "Age", "Is_male") VALUES (1, 'Eve', 'France', 'Chanson', '2019', 30, 0);
INSERT INTO "singer" ("Singer_ID", "Name", "Country", "Song_Name", "Song_release_year", "Age", "Is_male") VALUES (2, 'Frank', 'Germany', 'Lied', '2020', 22, 1);
INSERT INTO "singer" ("Singer_ID", "Name", "Country", "Song_Name", "Song_release_year", "Age", "Is_male") VALUES (3, 'Grace', 'Italy', 'Aria', '2021', NULL, 0);
INSERT INTO "singer" ("Singer_ID", "Name", "Country", "Song_Name", "Song_release_year", "Age", "Is_male") VALUES (4, 'Heidi', NULL, 'Ballad', '2022', 25, 0);
INSERT INTO "singer_in_concert" ("concert_ID", "Singer_ID") VALUES (10, '1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT country FROM singer WHERE (age >= 20) ORDER BY country;

/*
Gold Result:
(None,)
('France',)
('Germany',)
*/

-- Prediction Query
SELECT DISTINCT country FROM singer WHERE age > 20;

/*
Prediction Result:
('France',)
('Germany',)
(None,)
*/