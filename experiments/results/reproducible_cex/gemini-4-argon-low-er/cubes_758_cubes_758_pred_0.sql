-- Schema DDL
CREATE TABLE "musical" ("Musical_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Year" INTEGER, "Award" TEXT, "Category" TEXT, "Nominee" TEXT, "Result" TEXT);

CREATE TABLE "actor" ("Actor_ID" INTEGER PRIMARY KEY, "Musical_ID" INTEGER, "Name" TEXT, "Character" TEXT, "Duration" TEXT, "age" INTEGER, FOREIGN KEY ("Musical_ID") REFERENCES "actor" ("Actor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "musical" ("Musical_ID", "Name", "Year", "Award", "Category", "Nominee", "Result") VALUES (1, 'Musical A', 2020, 'Oscar', 'Best Musical', 'Alice', 'Won');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "nominee" FROM "musical" WHERE ("award" <> 'Tony Award' OR "award" <> 'Drama Desk Award') ORDER BY nominee, "nominee" NULLS LAST;

/*
Gold Result:
('Alice',)
*/

-- Prediction Query
SELECT Nominee FROM musical WHERE Award = 'Tony Award' INTERSECT SELECT Nominee FROM musical WHERE Award = 'Drama Desk Award';

/*
Prediction Result:
*/