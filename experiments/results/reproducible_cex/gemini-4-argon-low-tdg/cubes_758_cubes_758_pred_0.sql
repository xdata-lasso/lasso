-- Schema DDL
CREATE TABLE "musical" ("Musical_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Year" INTEGER, "Award" TEXT, "Category" TEXT, "Nominee" TEXT, "Result" TEXT);

CREATE TABLE "actor" ("Actor_ID" INTEGER PRIMARY KEY, "Musical_ID" INTEGER, "Name" TEXT, "Character" TEXT, "Duration" TEXT, "age" INTEGER, FOREIGN KEY ("Musical_ID") REFERENCES "actor" ("Actor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "musical" ("Musical_ID", "Name", "Year", "Award", "Category", "Nominee", "Result") VALUES (1, 'M1', 2001, 'Tony Award', 'Best Musical', 'Zack', 'Won');
INSERT INTO "musical" ("Musical_ID", "Name", "Year", "Award", "Category", "Nominee", "Result") VALUES (2, 'M2', 2002, 'Drama Desk Award', 'Best Musical', 'Adam', 'Nominated');
INSERT INTO "musical" ("Musical_ID", "Name", "Year", "Award", "Category", "Nominee", "Result") VALUES (3, 'M3', 2003, 'Olivier Award', 'Best Actor', 'Adam', 'Won');
INSERT INTO "musical" ("Musical_ID", "Name", "Year", "Award", "Category", "Nominee", "Result") VALUES (4, 'M4', 2004, NULL, 'Best Director', 'Eve', 'Won');
INSERT INTO "musical" ("Musical_ID", "Name", "Year", "Award", "Category", "Nominee", "Result") VALUES (5, 'M5', 2005, 'Grammy Award', 'Best Album', NULL, 'Won');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "nominee" FROM "musical" WHERE ("award" <> 'Tony Award' OR "award" <> 'Drama Desk Award') ORDER BY nominee, "nominee" NULLS LAST;

/*
Gold Result:
(None,)
('Adam',)
('Zack',)
*/

-- Prediction Query
SELECT Nominee FROM musical WHERE Award = 'Tony Award' INTERSECT SELECT Nominee FROM musical WHERE Award = 'Drama Desk Award';

/*
Prediction Result:
*/