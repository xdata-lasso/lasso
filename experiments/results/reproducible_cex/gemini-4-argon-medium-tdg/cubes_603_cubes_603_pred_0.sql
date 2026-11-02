-- Schema DDL
CREATE TABLE "singer" ("Singer_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Birth_Year" REAL, "Net_Worth_Millions" REAL, "Citizenship" TEXT);

CREATE TABLE "song" ("Song_ID" INTEGER PRIMARY KEY, "Singer_ID" INTEGER, "Title" TEXT, "Sales" REAL, "Highest_Position" REAL, FOREIGN KEY ("Singer_ID") REFERENCES "singer" ("Singer_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO singer (Singer_ID, Name, Birth_Year, Net_Worth_Millions, Citizenship) VALUES (10, 'Eve', 1975.0, 50.0, 'UK');
INSERT INTO singer (Singer_ID, Name, Birth_Year, Net_Worth_Millions, Citizenship) VALUES (20, 'Frank', 1982.0, 30.0, 'UK');
INSERT INTO song (Song_ID, Singer_ID, Title, Sales, Highest_Position) VALUES (1, 10, 'Hit 1', 500.0, 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT citizenship FROM (SELECT LHS.singer_id AS singer_id, LHS.name AS name, LHS.birth_year AS birth_year, LHS.net_worth_millions AS net_worth_millions, LHS.citizenship AS citizenship, LHS.n AS n, RHS.name AS name_other, RHS.birth_year AS birth_year_other, RHS.net_worth_millions AS net_worth_millions_other, RHS.n AS n_other FROM (SELECT singer_id, name, birth_year, net_worth_millions, citizenship, COUNT(*) OVER () AS n FROM singer) AS LHS INNER JOIN (SELECT singer_id, name, birth_year, net_worth_millions, citizenship, COUNT(*) OVER () AS n FROM singer) AS RHS ON (LHS.n = RHS.singer_id AND LHS.citizenship = RHS.citizenship)) ORDER BY citizenship;

/*
Gold Result:
*/

-- Prediction Query
SELECT Citizenship FROM singer GROUP BY Citizenship ORDER BY COUNT(*) DESC, Citizenship NULLS LAST LIMIT 1;

/*
Prediction Result:
('UK',)
*/