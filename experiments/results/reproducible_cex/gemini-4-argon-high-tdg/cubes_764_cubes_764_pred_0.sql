-- Schema DDL
CREATE TABLE "musical" ("Musical_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Year" INTEGER, "Award" TEXT, "Category" TEXT, "Nominee" TEXT, "Result" TEXT);

CREATE TABLE "actor" ("Actor_ID" INTEGER PRIMARY KEY, "Musical_ID" INTEGER, "Name" TEXT, "Character" TEXT, "Duration" TEXT, "age" INTEGER, FOREIGN KEY ("Musical_ID") REFERENCES "actor" ("Actor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "musical" ("Musical_ID", "Name", "Year", "Award", "Category", "Nominee", "Result") VALUES (1, 'The Phantom of the Opera', 1988, 'Tony Award', 'Best Musical', 'Zoe Caldwell', 'Won');
INSERT INTO "musical" ("Musical_ID", "Name", "Year", "Award", "Category", "Nominee", "Result") VALUES (2, 'Wicked', 2004, 'Drama Desk Award', 'Best Actress', 'Idina Menzel', 'Won');
INSERT INTO "musical" ("Musical_ID", "Name", "Year", "Award", "Category", "Nominee", "Result") VALUES (3, 'Les Miserables', 1987, 'Tony Award', 'Best Book', 'Alain Boublil', 'Nominated');
INSERT INTO "musical" ("Musical_ID", "Name", "Year", "Award", "Category", "Nominee", "Result") VALUES (4, 'Hamilton', 2016, 'Tony Award', 'Best Direction', 'Thomas Kail', 'Won');
INSERT INTO "musical" ("Musical_ID", "Name", "Year", "Award", "Category", "Nominee", "Result") VALUES (5, 'Miss Saigon', 1991, 'Tony Award', 'Best Score', 'Alain Boublil', 'Won');
INSERT INTO "musical" ("Musical_ID", "Name", "Year", "Award", "Category", "Nominee", "Result") VALUES (6, 'Cats', 1983, 'Olivier Award', 'Best New Musical', 'Andrew Lloyd Webber', 'Won');
INSERT INTO "actor" ("Actor_ID", "Musical_ID", "Name", "Character", "Duration", "age") VALUES (1, 1, 'Michael Crawford', 'The Phantom', '1986-1989', 46);
INSERT INTO "actor" ("Actor_ID", "Musical_ID", "Name", "Character", "Duration", "age") VALUES (2, 1, 'Sarah Brightman', 'Christine Daae', '1986-1988', 28);
INSERT INTO "actor" ("Actor_ID", "Musical_ID", "Name", "Character", "Duration", "age") VALUES (3, 2, 'Kristin Chenoweth', 'Glinda', '2003-2004', 35);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "nominee" FROM "musical" WHERE ("award" = 'Tony Award') ORDER BY nominee, musical.musical_id NULLS LAST;

/*
Gold Result:
('Alain Boublil',)
('Alain Boublil',)
('Thomas Kail',)
('Zoe Caldwell',)
*/

-- Prediction Query
SELECT Nominee FROM musical WHERE Award = 'Tony Award' OR Award = 'Cleavant Derricks';

/*
Prediction Result:
('Zoe Caldwell',)
('Alain Boublil',)
('Thomas Kail',)
('Alain Boublil',)
*/