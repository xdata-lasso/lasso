-- Schema DDL
CREATE TABLE "musical" ("Musical_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Year" INTEGER, "Award" TEXT, "Category" TEXT, "Nominee" TEXT, "Result" TEXT);

CREATE TABLE "actor" ("Actor_ID" INTEGER PRIMARY KEY, "Musical_ID" INTEGER, "Name" TEXT, "Character" TEXT, "Duration" TEXT, "age" INTEGER, FOREIGN KEY ("Musical_ID") REFERENCES "actor" ("Actor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO musical (Musical_ID, Name, Year, Award, Category, Nominee, Result) VALUES (1, 'The Phantom of the Opera', 1988, 'Tony Award', 'Best Musical', 'Charlie', 'Won');
INSERT INTO musical (Musical_ID, Name, Year, Award, Category, Nominee, Result) VALUES (2, 'Cats', 2000, 'Tony Award', 'Best Musical', 'Alice', 'Won');
INSERT INTO musical (Musical_ID, Name, Year, Award, Category, Nominee, Result) VALUES (3, 'Cats', 2000, 'Drama Desk Award', 'Outstanding Musical', 'Alice', 'Nominated');
INSERT INTO musical (Musical_ID, Name, Year, Award, Category, Nominee, Result) VALUES (4, 'Evita', 2005, 'Tony Award', 'Best Revival', 'Alice', 'Won');
INSERT INTO musical (Musical_ID, Name, Year, Award, Category, Nominee, Result) VALUES (5, 'Sunset Boulevard', 2005, 'Tony Award', 'Best Original Score', 'Alice', 'Nominated');
INSERT INTO musical (Musical_ID, Name, Year, Award, Category, Nominee, Result) VALUES (6, 'School of Rock', 2005, 'Olivier Award', 'Best New Musical', 'Alice', 'Nominated');
INSERT INTO musical (Musical_ID, Name, Year, Award, Category, Nominee, Result) VALUES (7, 'Love Never Dies', 2010, 'Olivier Award', 'Best Musical', 'Alice', 'Nominated');
INSERT INTO musical (Musical_ID, Name, Year, Award, Category, Nominee, Result) VALUES (8, 'Rent', 1990, 'Tony Award', 'Best Musical', 'Bob', 'Won');
INSERT INTO musical (Musical_ID, Name, Year, Award, Category, Nominee, Result) VALUES (9, 'Tick, Tick... Boom!', 1995, 'Drama Desk Award', 'Outstanding Musical', 'Bob', 'Nominated');
INSERT INTO musical (Musical_ID, Name, Year, Award, Category, Nominee, Result) VALUES (10, 'Les Miserables', 1980, 'Tony Award', 'Best Musical', 'Charlie', 'Won');
INSERT INTO musical (Musical_ID, Name, Year, Award, Category, Nominee, Result) VALUES (11, 'Miss Saigon', 1980, 'Tony Award', 'Best Score', 'Charlie', 'Nominated');
INSERT INTO musical (Musical_ID, Name, Year, Award, Category, Nominee, Result) VALUES (12, 'Martin Guerre', 1980, 'Olivier Award', 'Best Musical', 'Charlie', 'Won');
INSERT INTO musical (Musical_ID, Name, Year, Award, Category, Nominee, Result) VALUES (13, 'The Pirate Queen', 1980, 'Drama Desk Award', 'Best Orchestrations', 'Charlie', 'Nominated');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT nominee, n AS count___ FROM (SELECT nominee, YEAR, COUNT(*) AS n FROM musical GROUP BY nominee, YEAR) ORDER BY nominee, count___ NULLS LAST;

/*
Gold Result:
('Alice', 1)
('Alice', 2)
('Alice', 3)
('Bob', 1)
('Bob', 1)
('Charlie', 1)
('Charlie', 4)
*/

-- Prediction Query
SELECT Nominee, COUNT(*) FROM musical GROUP BY Nominee;

/*
Prediction Result:
('Alice', 6)
('Bob', 2)
('Charlie', 5)
*/