-- Schema DDL
CREATE TABLE "museum" ("Museum_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Num_of_Staff" INTEGER, "Open_Year" TEXT);

CREATE TABLE "visitor" ("ID" INTEGER PRIMARY KEY, "Name" TEXT, "Level_of_membership" INTEGER, "Age" INTEGER);

CREATE TABLE "visit" ("Museum_ID" INTEGER, "visitor_ID" TEXT, "Num_of_Ticket" INTEGER, "Total_spent" REAL, PRIMARY KEY ("Museum_ID", "visitor_ID"), FOREIGN KEY ("visitor_ID") REFERENCES "visitor" ("ID"), FOREIGN KEY ("Museum_ID") REFERENCES "museum" ("Museum_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "museum" ("Museum_ID", "Name", "Num_of_Staff", "Open_Year") VALUES (1, 'Plaza Museum', 100, '1975');
INSERT INTO "museum" ("Museum_ID", "Name", "Num_of_Staff", "Open_Year") VALUES (2, 'Plaza Museum', 9, '2018');
INSERT INTO "museum" ("Museum_ID", "Name", "Num_of_Staff", "Open_Year") VALUES (3, 'Plaza Museum', 25, '2010');
INSERT INTO "museum" ("Museum_ID", "Name", "Num_of_Staff", "Open_Year") VALUES (4, 'Plaza Museum', 25, '1985');
INSERT INTO "museum" ("Museum_ID", "Name", "Num_of_Staff", "Open_Year") VALUES (5, 'City Art Museum', 25, '1990');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "num_of_staff", "open_year" FROM "museum" WHERE ("name" = 'Plaza Museum') ORDER BY num_of_staff, museum.museum_id NULLS LAST;

/*
Gold Result:
(9, '2018')
(25, '2010')
(25, '1985')
(100, '1975')
*/

-- Prediction Query
SELECT Num_of_Staff, Open_Year FROM museum WHERE name = 'Plaza Museum';

/*
Prediction Result:
(100, '1975')
(9, '2018')
(25, '2010')
(25, '1985')
*/