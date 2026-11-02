-- Schema DDL
CREATE TABLE "stadium" ("Stadium_ID" INTEGER PRIMARY KEY, "Location" TEXT, "Name" TEXT, "Capacity" INTEGER, "Highest" INTEGER, "Lowest" INTEGER, "Average" INTEGER);

CREATE TABLE "singer" ("Singer_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Song_Name" TEXT, "Song_release_year" TEXT, "Age" INTEGER, "Is_male" INTEGER);

CREATE TABLE "concert" ("concert_ID" INTEGER PRIMARY KEY, "Stadium_ID" TEXT, "concert_Name" TEXT, "Theme" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("Stadium_ID"));

CREATE TABLE "singer_in_concert" ("concert_ID" INTEGER, "Singer_ID" TEXT, PRIMARY KEY ("concert_ID", "Singer_ID"), FOREIGN KEY ("Singer_ID") REFERENCES "singer" ("Singer_ID"), FOREIGN KEY ("concert_ID") REFERENCES "concert" ("concert_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests exact boundary conditions for age (29, 30, 39, 40, 41) with unique countries per row to catch relational operator mutants (<, <=, =, >=, >, <>).
INSERT INTO "singer" ("Singer_ID", "Name", "Country", "Song_Name", "Song_release_year", "Age", "Is_male") VALUES (1, 'Alice', 'USA', 'Song A', '2010', 29, 0);
INSERT INTO "singer" ("Singer_ID", "Name", "Country", "Song_Name", "Song_release_year", "Age", "Is_male") VALUES (2, 'Bob', 'UK', 'Song B', '2011', 30, 1);
INSERT INTO "singer" ("Singer_ID", "Name", "Country", "Song_Name", "Song_release_year", "Age", "Is_male") VALUES (3, 'Charlie', 'Canada', 'Song C', '2012', 39, 1);
INSERT INTO "singer" ("Singer_ID", "Name", "Country", "Song_Name", "Song_release_year", "Age", "Is_male") VALUES (4, 'Diana', 'France', 'Song D', '2013', 40, 0);
INSERT INTO "singer" ("Singer_ID", "Name", "Country", "Song_Name", "Song_release_year", "Age", "Is_male") VALUES (5, 'Evan', 'Germany', 'Song E', '2014', 41, 1);
INSERT INTO "singer" ("Singer_ID", "Name", "Country", "Song_Name", "Song_release_year", "Age", "Is_male") VALUES (6, 'Fiona', 'Japan', 'Song F', '2015', 20, 0);
INSERT INTO "singer" ("Singer_ID", "Name", "Country", "Song_Name", "Song_release_year", "Age", "Is_male") VALUES (7, 'George', 'Brazil', 'Song G', '2016', 35, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT country FROM singer WHERE (age = 40 OR age < 30) ORDER BY country;

/*
Gold Result:
('France',)
('Japan',)
('USA',)
*/

-- Prediction Query
SELECT country FROM singer WHERE age > 40 INTERSECT SELECT country FROM singer WHERE age < 30;

/*
Prediction Result:
*/