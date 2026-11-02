-- Schema DDL
CREATE TABLE "museum" ("Museum_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Num_of_Staff" INTEGER, "Open_Year" TEXT);

CREATE TABLE "visitor" ("ID" INTEGER PRIMARY KEY, "Name" TEXT, "Level_of_membership" INTEGER, "Age" INTEGER);

CREATE TABLE "visit" ("Museum_ID" INTEGER, "visitor_ID" TEXT, "Num_of_Ticket" INTEGER, "Total_spent" REAL, PRIMARY KEY ("Museum_ID", "visitor_ID"), FOREIGN KEY ("visitor_ID") REFERENCES "visitor" ("ID"), FOREIGN KEY ("Museum_ID") REFERENCES "museum" ("Museum_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "museum" ("museum_id", "name", "num_of_staff", "open_year") VALUES (1018, 'Kimberly Dudley', 1019, 'animal');
INSERT INTO "museum" ("museum_id", "name", "num_of_staff", "open_year") VALUES (1020, 'Gabrielle Davis', 1020, 'bill');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM museum AS LHS WHERE NOT EXISTS(SELECT 1 FROM visit AS RHS WHERE (LHS.museum_id = RHS.museum_id))) ORDER BY name;

/*
Gold Result:
('Gabrielle Davis',)
('Kimberly Dudley',)
*/

-- Prediction Query
SELECT name FROM museum WHERE NOT Museum_ID IN (SELECT museum_id FROM visit);

/*
Prediction Result:
('Kimberly Dudley',)
('Gabrielle Davis',)
*/