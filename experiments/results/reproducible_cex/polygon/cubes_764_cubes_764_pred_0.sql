-- Schema DDL
CREATE TABLE "musical" ("Musical_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Year" INTEGER, "Award" TEXT, "Category" TEXT, "Nominee" TEXT, "Result" TEXT);

CREATE TABLE "actor" ("Actor_ID" INTEGER PRIMARY KEY, "Musical_ID" INTEGER, "Name" TEXT, "Character" TEXT, "Duration" TEXT, "age" INTEGER, FOREIGN KEY ("Musical_ID") REFERENCES "actor" ("Actor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (8, 'Cleavant Derricks11', 12, 'Tony Award', 'Cleavant Derricks13', NULL, 'Tony Award14');
INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (7, 'Cleavant Derricks15', 16, 'Cleavant Derricks', 'Cleavant Derricks17', NULL, 'Tony Award18');
INSERT INTO "actor" ("actor_id", "musical_id", "name", "character", "duration", "age") VALUES (10, 9, 'Cleavant Derricks19', 'Cleavant Derricks19', 'Cleavant Derricks19', 19);
INSERT INTO "actor" ("actor_id", "musical_id", "name", "character", "duration", "age") VALUES (9, 9, 'Cleavant Derricks19', 'Cleavant Derricks19', 'Cleavant Derricks19', 19);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "nominee" FROM "musical" WHERE ("award" = 'Tony Award') ORDER BY nominee, musical.musical_id NULLS LAST;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT Nominee FROM musical WHERE Award = 'Tony Award' OR Award = 'Cleavant Derricks';

/*
Prediction Result:
(None,)
(None,)
*/