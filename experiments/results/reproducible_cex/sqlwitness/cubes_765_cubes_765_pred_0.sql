-- Schema DDL
CREATE TABLE "musical" ("Musical_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Year" INTEGER, "Award" TEXT, "Category" TEXT, "Nominee" TEXT, "Result" TEXT);

CREATE TABLE "actor" ("Actor_ID" INTEGER PRIMARY KEY, "Musical_ID" INTEGER, "Name" TEXT, "Character" TEXT, "Duration" TEXT, "age" INTEGER, FOREIGN KEY ("Musical_ID") REFERENCES "actor" ("Actor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO musical (musical_id, name, year, award, category, nominee, result) VALUES (1, NULL, 0, 'Bob Fosse', 'Bob Fosse', 'Bob Fosse', 'default1'), (0, 'Bob Fosse', 1, 'Bob Fosse', 'default1', NULL, 'default1'), (2, 'default1', NULL, 'Bob Fosse', 'Bob Fosse', 'Bob Fosse', 'default2'), (3, NULL, 0, 'Bob Fosse', NULL, 'Bob Fosse', 'default2'), (4, NULL, 1, 'Bob Fosse', 'Bob Fosse', 'Bob Fosse', 'default1'), (5, NULL, 1, 'default1', 'Bob Fosse', 'Bob Fosse', 'Bob Fosse'), (6, NULL, 1, 'default1', 'Bob Fosse', 'Bob Fosse', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "musical" WHERE ("nominee" = 'Bob Fosse') ORDER BY name, musical.musical_id NULLS LAST;

/*
Gold Result:
(None,)
(None,)
(None,)
(None,)
(None,)
('default1',)
*/

-- Prediction Query
SELECT Name FROM musical WHERE Nominee = 'Bob Fosse';

/*
Prediction Result:
(None,)
('default1',)
(None,)
(None,)
(None,)
(None,)
*/