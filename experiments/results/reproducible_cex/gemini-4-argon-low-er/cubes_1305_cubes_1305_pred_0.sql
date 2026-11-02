-- Schema DDL
CREATE TABLE "grapes" ("ID" INTEGER PRIMARY KEY, "Grape" TEXT UNIQUE, "Color" TEXT);

CREATE TABLE "appellations" ("No" INTEGER PRIMARY KEY, "Appelation" TEXT UNIQUE, "County" TEXT, "State" TEXT, "Area" TEXT, "isAVA" TEXT);

CREATE TABLE "wine" ("Appelation" TEXT, "Grape" TEXT, "No" INTEGER, "Winery" TEXT, "State" TEXT, "Name" TEXT, "Year" INTEGER, "Price" INTEGER, "Score" INTEGER, "Cases" INTEGER, "Drink" TEXT, FOREIGN KEY ("Appelation") REFERENCES "appellations" ("Appelation"), FOREIGN KEY ("Grape") REFERENCES "grapes" ("Grape"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "grapes" ("ID", "Grape", "Color") VALUES (1, 'Chardonnay', 'White');
INSERT INTO "appellations" ("No", "Appelation", "County", "State", "Area", "isAVA") VALUES (10, 'Napa Valley', 'Napa', 'CA', 'North Coast', 'Yes');
INSERT INTO "wine" ("Appelation", "Grape", "No", "Winery", "State", "Name", "Year", "Price", "Score", "Cases", "Drink") VALUES ('Napa Valley', 'Chardonnay', 1, 'Winery A', 'CA', 'Wine A', 2005, 50, 90, 100, 'Now');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT appelation AS area FROM (SELECT appelation, grape, n, appelation_other, county, state, isava, NO, appelation AS area FROM (SELECT appelation, grape, n, appelation_other, county, state, isava, n AS NO FROM (SELECT LHS.appelation AS appelation, LHS.grape AS grape, LHS.n AS n, RHS.appelation AS appelation_other, RHS.county AS county, RHS.state AS state, RHS.isava AS isava FROM (SELECT appelation, grape, COUNT(*) AS n FROM wine GROUP BY appelation, grape) AS LHS INNER JOIN appellations AS RHS ON (LHS.n = RHS.no AND LHS.appelation = RHS.area)))) WHERE (n <> 2010) ORDER BY area;

/*
Gold Result:
*/

-- Prediction Query
SELECT T1.Area FROM APPELLATIONS AS T1 JOIN WINE AS T2 ON T1.Appelation = T2.Appelation GROUP BY T2.Appelation HAVING T2.year < 2010 ORDER BY COUNT(*) DESC, T1.Area NULLS LAST LIMIT 1;

/*
Prediction Result:
('North Coast',)
*/