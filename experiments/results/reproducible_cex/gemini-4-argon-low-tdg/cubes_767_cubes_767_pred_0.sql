-- Schema DDL
CREATE TABLE "musical" ("Musical_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Year" INTEGER, "Award" TEXT, "Category" TEXT, "Nominee" TEXT, "Result" TEXT);

CREATE TABLE "actor" ("Actor_ID" INTEGER PRIMARY KEY, "Musical_ID" INTEGER, "Name" TEXT, "Character" TEXT, "Duration" TEXT, "age" INTEGER, FOREIGN KEY ("Musical_ID") REFERENCES "actor" ("Actor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "musical" ("Musical_ID", "Name", "Year", "Award", "Category", "Nominee", "Result") VALUES (1, NULL, 1990, 'Tony', 'Best Musical', 'Someone', 'Nominated');
INSERT INTO "musical" ("Musical_ID", "Name", "Year", "Award", "Category", "Nominee", "Result") VALUES (2, 'Les Miserables', 1985, 'Tony', 'Best Musical', 'Claude-Michel', 'Won');
INSERT INTO "actor" ("Actor_ID", "Musical_ID", "Name", "Character", "Duration", "age") VALUES (1, 1, 'Actor Linked To Null Musical Name', 'Lead', '1990', 30);
INSERT INTO "actor" ("Actor_ID", "Musical_ID", "Name", "Character", "Duration", "age") VALUES (2, 2, 'Colm Wilkinson', 'Jean Valjean', '1985-1988', 41);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM (SELECT * FROM "actor" AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM "musical" WHERE ("name" <> 'The Phantom of the Opera')) AS RHS WHERE (LHS.musical_id = RHS.musical_id))) ORDER BY name, "name" NULLS LAST;

/*
Gold Result:
('Actor Linked To Null Musical Name',)
*/

-- Prediction Query
SELECT T1.Name FROM actor AS T1 JOIN musical AS T2 ON T1.Musical_ID = T2.Musical_ID WHERE T2.Name = 'The Phantom of the Opera';

/*
Prediction Result:
*/