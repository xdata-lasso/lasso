-- Schema DDL
CREATE TABLE "musical" ("Musical_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Year" INTEGER, "Award" TEXT, "Category" TEXT, "Nominee" TEXT, "Result" TEXT);

CREATE TABLE "actor" ("Actor_ID" INTEGER PRIMARY KEY, "Musical_ID" INTEGER, "Name" TEXT, "Character" TEXT, "Duration" TEXT, "age" INTEGER, FOREIGN KEY ("Musical_ID") REFERENCES "actor" ("Actor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "musical" ("Musical_ID", "Name", "Year", "Award", "Category", "Nominee", "Result") VALUES (1, 'The Phantom of the Opera', 1988, 'Tony', 'Best Musical', 'Phantom', 'Won');
INSERT INTO "musical" ("Musical_ID", "Name", "Year", "Award", "Category", "Nominee", "Result") VALUES (2, 'Cats', 1983, 'Tony', 'Best Musical', 'Cats', 'Won');
INSERT INTO "musical" ("Musical_ID", "Name", "Year", "Award", "Category", "Nominee", "Result") VALUES (3, NULL, 1990, 'Tony', 'Best Musical', 'None', 'Nominated');
INSERT INTO "actor" ("Actor_ID", "Musical_ID", "Name", "Character", "Duration", "age") VALUES (1, 1, 'Michael Crawford', 'Phantom', '2 years', 45);
INSERT INTO "actor" ("Actor_ID", "Musical_ID", "Name", "Character", "Duration", "age") VALUES (2, 1, 'Michael Crawford', 'Phantom2', '1 year', 46);
INSERT INTO "actor" ("Actor_ID", "Musical_ID", "Name", "Character", "Duration", "age") VALUES (3, 2, 'Elaine Paige', 'Grizabella', '3 years', 35);
INSERT INTO "actor" ("Actor_ID", "Musical_ID", "Name", "Character", "Duration", "age") VALUES (4, 3, 'Sarah Brightman', 'Christine', '2 years', 28);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM (SELECT * FROM "actor" AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM "musical" WHERE ("name" <> 'The Phantom of the Opera')) AS RHS WHERE (LHS.musical_id = RHS.musical_id))) ORDER BY name, "name" NULLS LAST;

/*
Gold Result:
('Michael Crawford',)
('Michael Crawford',)
('Sarah Brightman',)
*/

-- Prediction Query
SELECT T1.Name FROM actor AS T1 JOIN musical AS T2 ON T1.Musical_ID = T2.Musical_ID WHERE T2.Name = 'The Phantom of the Opera';

/*
Prediction Result:
('Michael Crawford',)
('Michael Crawford',)
*/