-- Schema DDL
CREATE TABLE "musical" ("Musical_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Year" INTEGER, "Award" TEXT, "Category" TEXT, "Nominee" TEXT, "Result" TEXT);

CREATE TABLE "actor" ("Actor_ID" INTEGER PRIMARY KEY, "Musical_ID" INTEGER, "Name" TEXT, "Character" TEXT, "Duration" TEXT, "age" INTEGER, FOREIGN KEY ("Musical_ID") REFERENCES "actor" ("Actor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (9, NULL, NULL, 'Tony Award', NULL, NULL, NULL);
INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (8, 'Tony Award16', 17, 'Tony Award15', 'Tony Award18', 'Tony Award21', 'Tony Award19');
INSERT INTO "actor" ("actor_id", "musical_id", "name", "character", "duration", "age") VALUES (10, 10, 'Tony Award20', 'Tony Award20', 'Tony Award20', 20);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "nominee" FROM "musical" WHERE ("award" = 'Tony Award') ORDER BY nominee, "nominee" NULLS LAST;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT DISTINCT Nominee FROM musical WHERE Award <> 'Tony Award';

/*
Prediction Result:
('Tony Award21',)
*/