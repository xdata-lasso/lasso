-- Schema DDL
CREATE TABLE "musical" ("Musical_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Year" INTEGER, "Award" TEXT, "Category" TEXT, "Nominee" TEXT, "Result" TEXT);

CREATE TABLE "actor" ("Actor_ID" INTEGER PRIMARY KEY, "Musical_ID" INTEGER, "Name" TEXT, "Character" TEXT, "Duration" TEXT, "age" INTEGER, FOREIGN KEY ("Musical_ID") REFERENCES "actor" ("Actor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO musical (musical_id, name, year, award, category, nominee, result) VALUES (0, 'default1', NULL, 'default1', NULL, NULL, 'Tony Award'), (1, 'default2', 0, NULL, 'default2', 'Tony Award', 'default2'), (2, 'Tony Award', NULL, 'default1', NULL, NULL, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "nominee" FROM "musical" WHERE ("award" = 'Tony Award') ORDER BY nominee, "nominee" NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT Nominee FROM musical WHERE Award <> 'Tony Award';

/*
Prediction Result:
(None,)
*/