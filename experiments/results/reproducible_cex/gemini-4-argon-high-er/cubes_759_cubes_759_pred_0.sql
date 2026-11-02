-- Schema DDL
CREATE TABLE "musical" ("Musical_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Year" INTEGER, "Award" TEXT, "Category" TEXT, "Nominee" TEXT, "Result" TEXT);

CREATE TABLE "actor" ("Actor_ID" INTEGER PRIMARY KEY, "Musical_ID" INTEGER, "Name" TEXT, "Character" TEXT, "Duration" TEXT, "age" INTEGER, FOREIGN KEY ("Musical_ID") REFERENCES "actor" ("Actor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO musical (Musical_ID, Name, Year, Award, Category, Nominee, Result) VALUES (1, 'Cats', 2000, 'Tony', 'Best', 'Bob', 'Won');
INSERT INTO actor (Actor_ID, Musical_ID, Name, Character, Duration, age) VALUES (1, NULL, 'Alice', 'Grizabella', '2 years', 30);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM musical AS LHS WHERE NOT EXISTS(SELECT 1 FROM actor AS RHS WHERE (LHS.musical_id = RHS.musical_id))) ORDER BY name;

/*
Gold Result:
('Cats',)
*/

-- Prediction Query
SELECT Name FROM musical WHERE NOT Musical_ID IN (SELECT Musical_ID FROM actor);

/*
Prediction Result:
*/