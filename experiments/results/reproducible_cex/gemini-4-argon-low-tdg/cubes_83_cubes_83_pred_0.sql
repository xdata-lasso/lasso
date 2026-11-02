-- Schema DDL
CREATE TABLE "museum" ("Museum_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Num_of_Staff" INTEGER, "Open_Year" TEXT);

CREATE TABLE "visitor" ("ID" INTEGER PRIMARY KEY, "Name" TEXT, "Level_of_membership" INTEGER, "Age" INTEGER);

CREATE TABLE "visit" ("Museum_ID" INTEGER, "visitor_ID" TEXT, "Num_of_Ticket" INTEGER, "Total_spent" REAL, PRIMARY KEY ("Museum_ID", "visitor_ID"), FOREIGN KEY ("visitor_ID") REFERENCES "visitor" ("ID"), FOREIGN KEY ("Museum_ID") REFERENCES "museum" ("Museum_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "museum" ("Museum_ID", "Name", "Num_of_Staff", "Open_Year") VALUES (1, 'Plaza Museum', 50, '1990');
INSERT INTO "museum" ("Museum_ID", "Name", "Num_of_Staff", "Open_Year") VALUES (2, 'Plaza Museum', 20, '2000');
INSERT INTO "museum" ("Museum_ID", "Name", "Num_of_Staff", "Open_Year") VALUES (3, 'Plaza Museum', 35, '2010');
INSERT INTO "museum" ("Museum_ID", "Name", "Num_of_Staff", "Open_Year") VALUES (4, 'City Museum', 10, '1980');
INSERT INTO "museum" ("Museum_ID", "Name", "Num_of_Staff", "Open_Year") VALUES (5, 'plaza museum', 15, '1995');
INSERT INTO "museum" ("Museum_ID", "Name", "Num_of_Staff", "Open_Year") VALUES (6, 'The Plaza Museum', 25, '2005');
INSERT INTO "museum" ("Museum_ID", "Name", "Num_of_Staff", "Open_Year") VALUES (7, NULL, 30, '2015');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "num_of_staff", "open_year" FROM "museum" WHERE ("name" = 'Plaza Museum') ORDER BY num_of_staff, museum.museum_id NULLS LAST;

/*
Gold Result:
(20, '2000')
(35, '2010')
(50, '1990')
*/

-- Prediction Query
SELECT Num_of_Staff, Open_Year FROM museum WHERE name = 'Plaza Museum';

/*
Prediction Result:
(50, '1990')
(20, '2000')
(35, '2010')
*/