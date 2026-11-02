-- Schema DDL
CREATE TABLE "musical" ("Musical_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Year" INTEGER, "Award" TEXT, "Category" TEXT, "Nominee" TEXT, "Result" TEXT);

CREATE TABLE "actor" ("Actor_ID" INTEGER PRIMARY KEY, "Musical_ID" INTEGER, "Name" TEXT, "Character" TEXT, "Duration" TEXT, "age" INTEGER, FOREIGN KEY ("Musical_ID") REFERENCES "actor" ("Actor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO "musical" ("Musical_ID", "Name", "Year", "Award", "Category", "Nominee", "Result") VALUES (1, 'Big Deal', 1986, 'Tony Award', 'Best Choreography', 'Bob Fosse', 'Won');
INSERT INTO "musical" ("Musical_ID", "Name", "Year", "Award", "Category", "Nominee", "Result") VALUES (2, NULL, 1972, 'Tony Award', 'Best Direction', 'Bob Fosse', 'Won');
INSERT INTO "musical" ("Musical_ID", "Name", "Year", "Award", "Category", "Nominee", "Result") VALUES (3, 'Pajama Game', 1954, 'Tony Award', 'Best Choreography', NULL, 'Won');
INSERT INTO "musical" ("Musical_ID", "Name", "Year", "Award", "Category", "Nominee", "Result") VALUES (4, 'Damn Yankees', 1955, 'Tony Award', 'Best Choreography', 'bob fosse', 'Won');
INSERT INTO "musical" ("Musical_ID", "Name", "Year", "Award", "Category", "Nominee", "Result") VALUES (5, 'Redhead', 1959, 'Tony Award', 'Best Choreography', 'Bob Fosse ', 'Won');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "musical" WHERE ("nominee" = 'Bob Fosse') ORDER BY name, musical.musical_id NULLS LAST;

/*
Gold Result:
(None,)
('Big Deal',)
*/

-- Prediction Query
SELECT Name FROM musical WHERE Nominee = 'Bob Fosse';

/*
Prediction Result:
('Big Deal',)
(None,)
*/