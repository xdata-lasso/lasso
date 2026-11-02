-- Schema DDL
CREATE TABLE "musical" ("Musical_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Year" INTEGER, "Award" TEXT, "Category" TEXT, "Nominee" TEXT, "Result" TEXT);

CREATE TABLE "actor" ("Actor_ID" INTEGER PRIMARY KEY, "Musical_ID" INTEGER, "Name" TEXT, "Character" TEXT, "Duration" TEXT, "age" INTEGER, FOREIGN KEY ("Musical_ID") REFERENCES "actor" ("Actor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO musical (musical_id, name, year, award, category, nominee, result) VALUES (0, NULL, NULL, 'default2', 'default2', 'default1', NULL), (1, 'default2', 1, NULL, 'default1', 'default2', 'default2'), (2, 'default2', 0, 'default2', 'default1', 'default2', 'default2'), (3, 'default1', NULL, NULL, 'default2', 'default1', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT nominee, n AS count___ FROM (SELECT nominee, YEAR, COUNT(*) AS n FROM musical GROUP BY nominee, YEAR) ORDER BY nominee, count___ NULLS LAST;

/*
Gold Result:
('default1', 2)
('default2', 1)
('default2', 1)
*/

-- Prediction Query
SELECT Nominee, COUNT(*) FROM musical GROUP BY Nominee;

/*
Prediction Result:
('default1', 2)
('default2', 2)
*/