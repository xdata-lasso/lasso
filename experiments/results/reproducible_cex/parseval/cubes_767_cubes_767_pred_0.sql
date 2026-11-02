-- Schema DDL
CREATE TABLE "musical" ("Musical_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Year" INTEGER, "Award" TEXT, "Category" TEXT, "Nominee" TEXT, "Result" TEXT);

CREATE TABLE "actor" ("Actor_ID" INTEGER PRIMARY KEY, "Musical_ID" INTEGER, "Name" TEXT, "Character" TEXT, "Duration" TEXT, "age" INTEGER, FOREIGN KEY ("Musical_ID") REFERENCES "actor" ("Actor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: actor --
INSERT INTO "actor" ("actor_id", "musical_id", "name", "character", "duration", "age") VALUES (1, 1, 'lhs_47930b', 'lhs_0cc42f', 'lhs_99dd35', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM (SELECT * FROM "actor" AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM "musical" WHERE ("name" <> 'The Phantom of the Opera')) AS RHS WHERE (LHS.musical_id = RHS.musical_id))) ORDER BY name, "name" NULLS LAST;

/*
Gold Result:
('lhs_47930b',)
*/

-- Prediction Query
SELECT T1.Name FROM actor AS T1 JOIN musical AS T2 ON T1.Musical_ID = T2.Musical_ID WHERE T2.Name = 'The Phantom of the Opera';

/*
Prediction Result:
*/