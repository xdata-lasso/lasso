-- Schema DDL
CREATE TABLE "musical" ("Musical_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Year" INTEGER, "Award" TEXT, "Category" TEXT, "Nominee" TEXT, "Result" TEXT);

CREATE TABLE "actor" ("Actor_ID" INTEGER PRIMARY KEY, "Musical_ID" INTEGER, "Name" TEXT, "Character" TEXT, "Duration" TEXT, "age" INTEGER, FOREIGN KEY ("Musical_ID") REFERENCES "actor" ("Actor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO musical (Musical_ID, Name, Year, Award, Category, Nominee, Result) VALUES (1, 'B', 1972, 'Tony Award', 'Best Director', 'Bob Fosse', 'Won');
INSERT INTO musical (Musical_ID, Name, Year, Award, Category, Nominee, Result) VALUES (2, 'A', 1973, 'Tony Award', 'Best Director', 'Bob Fosse', 'Won');
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