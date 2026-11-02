-- Schema DDL
CREATE TABLE "musical" ("Musical_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Year" INTEGER, "Award" TEXT, "Category" TEXT, "Nominee" TEXT, "Result" TEXT);

CREATE TABLE "actor" ("Actor_ID" INTEGER PRIMARY KEY, "Musical_ID" INTEGER, "Name" TEXT, "Character" TEXT, "Duration" TEXT, "age" INTEGER, FOREIGN KEY ("Musical_ID") REFERENCES "actor" ("Actor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO musical (Musical_ID, Year, Nominee) VALUES (1, 2000, 'Alice');
INSERT INTO musical (Musical_ID, Year, Nominee) VALUES (2, 2010, 'Bob');
INSERT INTO musical (Musical_ID, Year, Nominee) VALUES (3, 2011, 'Bob');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT nominee FROM (SELECT * FROM (SELECT * FROM (SELECT nominee, YEAR, MAX(n) AS n FROM (SELECT nominee, YEAR, COUNT(*) AS n FROM musical GROUP BY nominee, YEAR) GROUP BY nominee, YEAR) ORDER BY YEAR) LIMIT 1);

/*
Gold Result:
('Alice',)
*/

-- Prediction Query
SELECT Nominee FROM musical GROUP BY Nominee ORDER BY COUNT(*) DESC, Nominee NULLS LAST LIMIT 1;

/*
Prediction Result:
('Bob',)
*/