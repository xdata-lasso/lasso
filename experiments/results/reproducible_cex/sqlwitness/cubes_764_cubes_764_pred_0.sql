-- Schema DDL
CREATE TABLE "musical" ("Musical_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Year" INTEGER, "Award" TEXT, "Category" TEXT, "Nominee" TEXT, "Result" TEXT);

CREATE TABLE "actor" ("Actor_ID" INTEGER PRIMARY KEY, "Musical_ID" INTEGER, "Name" TEXT, "Character" TEXT, "Duration" TEXT, "age" INTEGER, FOREIGN KEY ("Musical_ID") REFERENCES "actor" ("Actor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO musical (musical_id, name, year, award, category, nominee, result) VALUES (1, 'Cleavant Derricks', 0, 'default2', 'default2', 'default1', 'default2'), (0, 'Tony Award', 1, NULL, 'default2', 'default1', 'Tony Award'), (2, 'Cleavant Derricks', 1, 'default1', NULL, 'default2', NULL), (3, 'Cleavant Derricks', 0, 'Cleavant Derricks', 'Tony Award', 'Tony Award', 'Cleavant Derricks');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "nominee" FROM "musical" WHERE ("award" = 'Tony Award') ORDER BY nominee, musical.musical_id NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
SELECT Nominee FROM musical WHERE Award = 'Tony Award' OR Award = 'Cleavant Derricks';

/*
Prediction Result:
('Tony Award',)
*/