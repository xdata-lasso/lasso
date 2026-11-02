-- Schema DDL
CREATE TABLE "musical" ("Musical_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Year" INTEGER, "Award" TEXT, "Category" TEXT, "Nominee" TEXT, "Result" TEXT);

CREATE TABLE "actor" ("Actor_ID" INTEGER PRIMARY KEY, "Musical_ID" INTEGER, "Name" TEXT, "Character" TEXT, "Duration" TEXT, "age" INTEGER, FOREIGN KEY ("Musical_ID") REFERENCES "actor" ("Actor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (1030, 'Tommy Walter', 1031, 'institution', 'executive', 'Bob Fosse', 'attorney');
INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (1032, 'Margaret Hawkins DDS', 1032, 'threat', 'special', 'Bob Fosse', 'stand');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "musical" WHERE ("nominee" = 'Bob Fosse') ORDER BY name, musical.musical_id NULLS LAST;

/*
Gold Result:
('Margaret Hawkins DDS',)
('Tommy Walter',)
*/

-- Prediction Query
SELECT Name FROM musical WHERE Nominee = 'Bob Fosse';

/*
Prediction Result:
('Tommy Walter',)
('Margaret Hawkins DDS',)
*/