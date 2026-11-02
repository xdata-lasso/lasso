-- Schema DDL
CREATE TABLE "musical" ("Musical_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Year" INTEGER, "Award" TEXT, "Category" TEXT, "Nominee" TEXT, "Result" TEXT);

CREATE TABLE "actor" ("Actor_ID" INTEGER PRIMARY KEY, "Musical_ID" INTEGER, "Name" TEXT, "Character" TEXT, "Duration" TEXT, "age" INTEGER, FOREIGN KEY ("Musical_ID") REFERENCES "actor" ("Actor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (1001, 'Allison Hill', 1002, 'dog', 'chair', 'since', 'blue');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "nominee" FROM "musical" WHERE ("award" <> 'Tony Award' OR "award" <> 'Drama Desk Award') ORDER BY nominee, "nominee" NULLS LAST;

/*
Gold Result:
('since',)
*/

-- Prediction Query
SELECT Nominee FROM musical WHERE Award = 'Tony Award' INTERSECT SELECT Nominee FROM musical WHERE Award = 'Drama Desk Award';

/*
Prediction Result:
*/