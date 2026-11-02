-- Schema DDL
CREATE TABLE "stadium" ("Stadium_ID" INTEGER PRIMARY KEY, "Location" TEXT, "Name" TEXT, "Capacity" INTEGER, "Highest" INTEGER, "Lowest" INTEGER, "Average" INTEGER);

CREATE TABLE "singer" ("Singer_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Song_Name" TEXT, "Song_release_year" TEXT, "Age" INTEGER, "Is_male" INTEGER);

CREATE TABLE "concert" ("concert_ID" INTEGER PRIMARY KEY, "Stadium_ID" TEXT, "concert_Name" TEXT, "Theme" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("Stadium_ID"));

CREATE TABLE "singer_in_concert" ("concert_ID" INTEGER, "Singer_ID" TEXT, PRIMARY KEY ("concert_ID", "Singer_ID"), FOREIGN KEY ("Singer_ID") REFERENCES "singer" ("Singer_ID"), FOREIGN KEY ("concert_ID") REFERENCES "concert" ("concert_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic boundary conditions for Age (19, 20, 21), DISTINCT deduplication, and ORDER BY sorting.
-- Also tests extraneous joins by leaving singer_in_concert empty for these singers.
INSERT INTO "singer" ("Singer_ID", "Name", "Country", "Song_Name", "Song_release_year", "Age", "Is_male") VALUES (1, 'Alice', 'USA', 'Song A', '2020', 20, 0);
INSERT INTO "singer" ("Singer_ID", "Name", "Country", "Song_Name", "Song_release_year", "Age", "Is_male") VALUES (2, 'Bob', 'Canada', 'Song B', '2019', 19, 1);
INSERT INTO "singer" ("Singer_ID", "Name", "Country", "Song_Name", "Song_release_year", "Age", "Is_male") VALUES (3, 'Charlie', 'France', 'Song C', '2021', 25, 1);
INSERT INTO "singer" ("Singer_ID", "Name", "Country", "Song_Name", "Song_release_year", "Age", "Is_male") VALUES (4, 'Diana', 'France', 'Song D', '2018', 30, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT country FROM singer WHERE (age >= 20) ORDER BY country;

/*
Gold Result:
('France',)
('USA',)
*/

-- Prediction Query
SELECT DISTINCT country FROM singer WHERE age > 20;

/*
Prediction Result:
('France',)
*/