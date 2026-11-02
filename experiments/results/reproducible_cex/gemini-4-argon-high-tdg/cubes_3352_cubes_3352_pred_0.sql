-- Schema DDL
CREATE TABLE "musical" ("Musical_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Year" INTEGER, "Award" TEXT, "Category" TEXT, "Nominee" TEXT, "Result" TEXT);

CREATE TABLE "actor" ("Actor_ID" INTEGER PRIMARY KEY, "Musical_ID" INTEGER, "Name" TEXT, "Character" TEXT, "Duration" TEXT, "age" INTEGER, FOREIGN KEY ("Musical_ID") REFERENCES "actor" ("Actor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO musical (Musical_ID, Name, Year, Award, Category, Nominee, Result) VALUES (1, 'Sunrise Boulevard', 1975, 'Tony Award', 'Best Musical', 'Aaron', 'Won');
INSERT INTO musical (Musical_ID, Name, Year, Award, Category, Nominee, Result) VALUES (2, 'Velvet Curtain', 1965, 'Drama Desk Award', 'Best Actor', 'Victor', 'Nominated');
INSERT INTO musical (Musical_ID, Name, Year, Award, Category, Nominee, Result) VALUES (3, 'Velvet Curtain', 1965, 'Outer Critics Circle', 'Best Actor', 'Victor', 'Nominated');
INSERT INTO musical (Musical_ID, Name, Year, Award, Category, Nominee, Result) VALUES (4, 'Midnight Echo', 1985, 'Tony Award', 'Best Director', 'Clara', 'Won');
INSERT INTO musical (Musical_ID, Name, Year, Award, Category, Nominee, Result) VALUES (5, 'Midnight Echo', 1985, 'Drama Desk Award', 'Best Director', 'Clara', 'Won');
INSERT INTO musical (Musical_ID, Name, Year, Award, Category, Nominee, Result) VALUES (6, 'Midnight Echo', 1985, 'Olivier Award', 'Best Director', 'Clara', 'Won');
INSERT INTO musical (Musical_ID, Name, Year, Award, Category, Nominee, Result) VALUES (7, 'Neon Harbor', 1995, 'Tony Award', 'Best Score', 'David', 'Nominated');
INSERT INTO actor (Actor_ID, Musical_ID, Name, Character, Duration, age) VALUES (1, 1, 'John Smith', 'Lead', '2 years', 34);
INSERT INTO actor (Actor_ID, Musical_ID, Name, Character, Duration, age) VALUES (4, 4, 'Mary Jane', 'Supporting', '1 year', 28);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT nominee FROM (SELECT * FROM (SELECT * FROM (SELECT nominee, YEAR, MAX(n) AS n FROM (SELECT nominee, YEAR, COUNT(*) AS n FROM musical GROUP BY nominee, YEAR) GROUP BY nominee, YEAR) ORDER BY YEAR) LIMIT 1);

/*
Gold Result:
('Victor',)
*/

-- Prediction Query
SELECT Nominee FROM musical GROUP BY Nominee ORDER BY COUNT(*) DESC, Nominee NULLS LAST LIMIT 1;

/*
Prediction Result:
('Clara',)
*/