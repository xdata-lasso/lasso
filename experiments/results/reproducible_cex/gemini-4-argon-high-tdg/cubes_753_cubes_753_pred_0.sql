-- Schema DDL
CREATE TABLE "musical" ("Musical_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Year" INTEGER, "Award" TEXT, "Category" TEXT, "Nominee" TEXT, "Result" TEXT);

CREATE TABLE "actor" ("Actor_ID" INTEGER PRIMARY KEY, "Musical_ID" INTEGER, "Name" TEXT, "Character" TEXT, "Duration" TEXT, "age" INTEGER, FOREIGN KEY ("Musical_ID") REFERENCES "actor" ("Actor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO musical (Musical_ID, Name, Year, Award, Category, Nominee, Result) VALUES (1, 'Wicked', 2003, 'Tony Award', 'Best Musical', 'Stephen Schwartz', 'Won');
INSERT INTO musical (Musical_ID, Name, Year, Award, Category, Nominee, Result) VALUES (2, 'Cats', 1982, 'Drama Desk Award', 'Outstanding Musical', 'Andrew Lloyd Webber', 'Nominated');
INSERT INTO musical (Musical_ID, Name, Year, Award, Category, Nominee, Result) VALUES (3, 'Hamilton', 2016, 'Pulitzer Prize', 'Drama', 'Lin-Manuel Miranda', 'Won');
INSERT INTO actor (Actor_ID, Musical_ID, Name, Character, Duration, age) VALUES (1, NULL, 'Zoe', 'Orphan', '1 year', 19);
INSERT INTO actor (Actor_ID, Musical_ID, Name, Character, Duration, age) VALUES (2, 1, 'Bob', 'Wizard', '2 years', 55);
INSERT INTO actor (Actor_ID, Musical_ID, Name, Character, Duration, age) VALUES (3, 1, 'Alice', 'Elphaba', '3 years', 28);
INSERT INTO actor (Actor_ID, Musical_ID, Name, Character, Duration, age) VALUES (4, 2, 'Alice', 'Grizabella', '4 years', 32);
INSERT INTO actor (Actor_ID, Musical_ID, Name, Character, Duration, age) VALUES (5, 4, 'Charlie', 'Ghost', '6 months', 40);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name AS name___1, name_other AS name___2 FROM (SELECT LHS.actor_id AS actor_id, LHS.name AS name, LHS.musical_id AS musical_id, LHS.character AS CHARACTER, LHS.duration AS duration, LHS.age AS age, RHS.name AS name_other, RHS.year AS YEAR, RHS.award AS award, RHS.category AS category, RHS.nominee AS nominee, RHS.result AS RESULT FROM actor AS LHS INNER JOIN musical AS RHS ON (LHS.musical_id = RHS.musical_id)) ORDER BY name___1, name___2 NULLS LAST;

/*
Gold Result:
('Alice', 'Cats')
('Alice', 'Wicked')
('Bob', 'Wicked')
*/

-- Prediction Query
SELECT T1.Name, T2.Name FROM actor AS T1 JOIN musical AS T2 ON T1.Musical_ID = T2.Musical_ID;

/*
Prediction Result:
('Bob', 'Wicked')
('Alice', 'Wicked')
('Alice', 'Cats')
*/