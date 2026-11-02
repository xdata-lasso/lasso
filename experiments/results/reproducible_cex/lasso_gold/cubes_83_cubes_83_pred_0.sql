-- Schema DDL
CREATE TABLE "museum" ("Museum_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Num_of_Staff" INTEGER, "Open_Year" TEXT);

CREATE TABLE "visitor" ("ID" INTEGER PRIMARY KEY, "Name" TEXT, "Level_of_membership" INTEGER, "Age" INTEGER);

CREATE TABLE "visit" ("Museum_ID" INTEGER, "visitor_ID" TEXT, "Num_of_Ticket" INTEGER, "Total_spent" REAL, PRIMARY KEY ("Museum_ID", "visitor_ID"), FOREIGN KEY ("visitor_ID") REFERENCES "visitor" ("ID"), FOREIGN KEY ("Museum_ID") REFERENCES "museum" ("Museum_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "museum" ("museum_id", "name", "num_of_staff", "open_year") VALUES (1024, 'Plaza Museum', 1026, 'rate');
INSERT INTO "museum" ("museum_id", "name", "num_of_staff", "open_year") VALUES (1026, 'Plaza Museum', 1025, 'science');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "num_of_staff", "open_year" FROM "museum" WHERE ("name" = 'Plaza Museum') ORDER BY num_of_staff, museum.museum_id NULLS LAST;

/*
Gold Result:
(1025, 'science')
(1026, 'rate')
*/

-- Prediction Query
SELECT Num_of_Staff, Open_Year FROM museum WHERE name = 'Plaza Museum';

/*
Prediction Result:
(1026, 'rate')
(1025, 'science')
*/