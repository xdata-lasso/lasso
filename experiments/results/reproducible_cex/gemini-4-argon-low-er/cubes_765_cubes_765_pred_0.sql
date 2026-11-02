-- Schema DDL
CREATE TABLE "musical" ("Musical_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Year" INTEGER, "Award" TEXT, "Category" TEXT, "Nominee" TEXT, "Result" TEXT);

CREATE TABLE "actor" ("Actor_ID" INTEGER PRIMARY KEY, "Musical_ID" INTEGER, "Name" TEXT, "Character" TEXT, "Duration" TEXT, "age" INTEGER, FOREIGN KEY ("Musical_ID") REFERENCES "actor" ("Actor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "musical" ("Musical_ID", "Name", "Nominee") VALUES (1, 'B', 'Bob Fosse');
INSERT INTO "musical" ("Musical_ID", "Name", "Nominee") VALUES (2, 'A', 'Bob Fosse');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "musical" WHERE ("nominee" = 'Bob Fosse') ORDER BY name, musical.musical_id NULLS LAST;

/*
Gold Result:
('A',)
('B',)
*/

-- Prediction Query
SELECT Name FROM musical WHERE Nominee = 'Bob Fosse';

/*
Prediction Result:
('B',)
('A',)
*/