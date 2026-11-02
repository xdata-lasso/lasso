-- Schema DDL
CREATE TABLE "musical" ("Musical_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Year" INTEGER, "Award" TEXT, "Category" TEXT, "Nominee" TEXT, "Result" TEXT);

CREATE TABLE "actor" ("Actor_ID" INTEGER PRIMARY KEY, "Musical_ID" INTEGER, "Name" TEXT, "Character" TEXT, "Duration" TEXT, "age" INTEGER, FOREIGN KEY ("Musical_ID") REFERENCES "actor" ("Actor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "musical" ("Musical_ID", "Name", "Year", "Award", "Category", "Nominee", "Result") VALUES (1, 'The Phantom of the Opera', 1988, 'Tony Award', 'Best Musical', 'Andrew Lloyd Webber', 'Won');
INSERT INTO "musical" ("Musical_ID", "Name", "Year", "Award", "Category", "Nominee", "Result") VALUES (2, 'Les Misérables', 1987, 'Tony Award', 'Best Musical', 'Claude-Michel Schönberg', 'Won');
INSERT INTO "musical" ("Musical_ID", "Name", "Year", "Award", "Category", "Nominee", "Result") VALUES (3, 'Cats', 1983, 'Tony Award', 'Best Musical', 'Andrew Lloyd Webber', 'Won');
INSERT INTO "actor" ("Actor_ID", "Musical_ID", "Name", "Character", "Duration", "age") VALUES (1, 1, 'Zoe Hart', 'Christine Daaé', '1988-1990', 28);
INSERT INTO "actor" ("Actor_ID", "Musical_ID", "Name", "Character", "Duration", "age") VALUES (2, 2, 'Bob Smith', 'Jean Valjean', '1987-1989', 35);
INSERT INTO "actor" ("Actor_ID", "Musical_ID", "Name", "Character", "Duration", "age") VALUES (3, 3, 'Charlie Brown', 'Grizabella', '1983-1985', 30);
INSERT INTO "actor" ("Actor_ID", "Musical_ID", "Name", "Character", "Duration", "age") VALUES (4, 1, 'Alice Cooper', 'The Phantom', '1990-1992', 42);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM (SELECT * FROM "actor" AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM "musical" WHERE ("name" <> 'The Phantom of the Opera')) AS RHS WHERE (LHS.musical_id = RHS.musical_id))) ORDER BY name, "name" NULLS LAST;

/*
Gold Result:
('Alice Cooper',)
('Zoe Hart',)
*/

-- Prediction Query
SELECT T1.Name FROM actor AS T1 JOIN musical AS T2 ON T1.Musical_ID = T2.Musical_ID WHERE T2.Name = 'The Phantom of the Opera';

/*
Prediction Result:
('Zoe Hart',)
('Alice Cooper',)
*/