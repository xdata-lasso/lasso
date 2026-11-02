-- Schema DDL
CREATE TABLE "musical" ("Musical_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Year" INTEGER, "Award" TEXT, "Category" TEXT, "Nominee" TEXT, "Result" TEXT);

CREATE TABLE "actor" ("Actor_ID" INTEGER PRIMARY KEY, "Musical_ID" INTEGER, "Name" TEXT, "Character" TEXT, "Duration" TEXT, "age" INTEGER, FOREIGN KEY ("Musical_ID") REFERENCES "actor" ("Actor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. WHERE clause filtering ('Tony Award' vs other awards, case sensitivity, partial matches, NULL award).
-- 2. DISTINCT projection (duplicate nominees with 'Tony Award').
-- 3. ORDER BY ascending and NULLS LAST (insertion order is intentionally unsorted with NULL first).
-- 4. Column mismatch mutations (Name, Category, Result differ from Nominee).
-- 5. Unnecessary INNER JOIN with "actor" table (Musical_ID 2, 3, 4 have no matching actors).
INSERT INTO "musical" ("Musical_ID", "Name", "Year", "Award", "Category", "Nominee", "Result") VALUES (1, 'Musical Z', 2005, 'Tony Award', 'Best Musical', NULL, 'Nominated');
INSERT INTO "musical" ("Musical_ID", "Name", "Year", "Award", "Category", "Nominee", "Result") VALUES (2, 'Musical A', 2010, 'Tony Award', 'Best Actor', 'Zack', 'Won');
INSERT INTO "musical" ("Musical_ID", "Name", "Year", "Award", "Category", "Nominee", "Result") VALUES (3, 'Musical M', 2012, 'Tony Award', 'Best Director', 'Alice', 'Nominated');
INSERT INTO "musical" ("Musical_ID", "Name", "Year", "Award", "Category", "Nominee", "Result") VALUES (4, 'Musical B', 2015, 'Tony Award', 'Best Revival', 'Alice', 'Won');
INSERT INTO "musical" ("Musical_ID", "Name", "Year", "Award", "Category", "Nominee", "Result") VALUES (5, 'Musical C', 2018, 'Drama Desk Award', 'Best Musical', 'Bob', 'Won');
INSERT INTO "musical" ("Musical_ID", "Name", "Year", "Award", "Category", "Nominee", "Result") VALUES (6, 'Musical D', 2020, 'tony award', 'Best Score', 'Charlie', 'Nominated');
INSERT INTO "musical" ("Musical_ID", "Name", "Year", "Award", "Category", "Nominee", "Result") VALUES (7, 'Musical E', 2021, 'Tony Awards', 'Best Book', 'David', 'Won');
INSERT INTO "musical" ("Musical_ID", "Name", "Year", "Award", "Category", "Nominee", "Result") VALUES (8, 'Musical F', 2022, NULL, 'Best Choreography', 'Eve', 'Nominated');
INSERT INTO "actor" ("Actor_ID", "Musical_ID", "Name", "Character", "Duration", "age") VALUES (1, 1, 'Actor One', 'Lead', '2 years', 30);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "nominee" FROM "musical" WHERE ("award" = 'Tony Award') ORDER BY nominee, "nominee" NULLS LAST;

/*
Gold Result:
(None,)
('Alice',)
('Zack',)
*/

-- Prediction Query
SELECT DISTINCT Nominee FROM musical WHERE Award <> 'Tony Award';

/*
Prediction Result:
('Bob',)
('Charlie',)
('David',)
*/