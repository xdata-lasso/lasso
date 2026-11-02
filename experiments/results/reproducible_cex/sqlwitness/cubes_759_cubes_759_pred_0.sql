-- Schema DDL
CREATE TABLE "musical" ("Musical_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Year" INTEGER, "Award" TEXT, "Category" TEXT, "Nominee" TEXT, "Result" TEXT);

CREATE TABLE "actor" ("Actor_ID" INTEGER PRIMARY KEY, "Musical_ID" INTEGER, "Name" TEXT, "Character" TEXT, "Duration" TEXT, "age" INTEGER, FOREIGN KEY ("Musical_ID") REFERENCES "actor" ("Actor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actor (actor_id, musical_id, name, character, duration, age) VALUES (2, NULL, 'default2', 'default2', 'default2', NULL);
INSERT INTO musical (musical_id, name, year, award, category, nominee, result) VALUES (2, NULL, 1, 'default1', 'default2', 'default2', 'default1'), (1, 'default1', 2, NULL, 'default1', 'default1', 'default1'), (0, NULL, 0, 'default1', 'default2', 'default1', 'default2'), (3, 'default2', 0, NULL, NULL, 'default2', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM musical AS LHS WHERE NOT EXISTS(SELECT 1 FROM actor AS RHS WHERE (LHS.musical_id = RHS.musical_id))) ORDER BY name;

/*
Gold Result:
(None,)
(None,)
('default1',)
('default2',)
*/

-- Prediction Query
SELECT Name FROM musical WHERE NOT Musical_ID IN (SELECT Musical_ID FROM actor);

/*
Prediction Result:
*/