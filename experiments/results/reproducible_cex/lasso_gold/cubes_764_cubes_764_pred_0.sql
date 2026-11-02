-- Schema DDL
CREATE TABLE "musical" ("Musical_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Year" INTEGER, "Award" TEXT, "Category" TEXT, "Nominee" TEXT, "Result" TEXT);

CREATE TABLE "actor" ("Actor_ID" INTEGER PRIMARY KEY, "Musical_ID" INTEGER, "Name" TEXT, "Character" TEXT, "Duration" TEXT, "age" INTEGER, FOREIGN KEY ("Musical_ID") REFERENCES "actor" ("Actor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (1030, 'Margaret Hawkins DDS', 1031, 'Tony Award', 'institution', 'special', 'attorney');
INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (1032, 'Rodney Trujillo', 1032, 'Tony Award', 'threat', 'development', 'stand');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "nominee" FROM "musical" WHERE ("award" = 'Tony Award') ORDER BY nominee, musical.musical_id NULLS LAST;

/*
Gold Result:
('development',)
('special',)
*/

-- Prediction Query
SELECT Nominee FROM musical WHERE Award = 'Tony Award' OR Award = 'Cleavant Derricks';

/*
Prediction Result:
('special',)
('development',)
*/