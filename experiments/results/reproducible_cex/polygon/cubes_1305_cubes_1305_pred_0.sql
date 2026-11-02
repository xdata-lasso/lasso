-- Schema DDL
CREATE TABLE "grapes" ("ID" INTEGER PRIMARY KEY, "Grape" TEXT UNIQUE, "Color" TEXT);

CREATE TABLE "appellations" ("No" INTEGER PRIMARY KEY, "Appelation" TEXT UNIQUE, "County" TEXT, "State" TEXT, "Area" TEXT, "isAVA" TEXT);

CREATE TABLE "wine" ("Appelation" TEXT, "Grape" TEXT, "No" INTEGER, "Winery" TEXT, "State" TEXT, "Name" TEXT, "Year" INTEGER, "Price" INTEGER, "Score" INTEGER, "Cases" INTEGER, "Drink" TEXT, FOREIGN KEY ("Appelation") REFERENCES "appellations" ("Appelation"), FOREIGN KEY ("Grape") REFERENCES "grapes" ("Grape"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "grapes" ("id", "grape", "color") VALUES (18, NULL, '21');
INSERT INTO "grapes" ("id", "grape", "color") VALUES (17, '30', '21');
INSERT INTO "appellations" ("no", "appelation", "county", "state", "area", "isava") VALUES (19, '20', NULL, NULL, '21', NULL);
INSERT INTO "appellations" ("no", "appelation", "county", "state", "area", "isava") VALUES (1, '21', '31', '32', '21', '33');
INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES (20, NULL, NULL, NULL, NULL, NULL, 649, NULL, NULL, NULL, NULL);
INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES (21, 30, 44, '45', '46', '47', -721, 48, 49, 50, '51');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT appelation AS area FROM (SELECT appelation, grape, n, appelation_other, county, state, isava, NO, appelation AS area FROM (SELECT appelation, grape, n, appelation_other, county, state, isava, n AS NO FROM (SELECT LHS.appelation AS appelation, LHS.grape AS grape, LHS.n AS n, RHS.appelation AS appelation_other, RHS.county AS county, RHS.state AS state, RHS.isava AS isava FROM (SELECT appelation, grape, COUNT(*) AS n FROM wine GROUP BY appelation, grape) AS LHS INNER JOIN appellations AS RHS ON (LHS.n = RHS.no AND LHS.appelation = RHS.area)))) WHERE (n <> 2010) ORDER BY area;

/*
Gold Result:
('21',)
*/

-- Prediction Query
SELECT T1.Area FROM APPELLATIONS AS T1 JOIN WINE AS T2 ON T1.Appelation = T2.Appelation GROUP BY T2.Appelation HAVING T2.year < 2010 ORDER BY COUNT(*) DESC, T1.Area NULLS LAST LIMIT 1;

/*
Prediction Result:
('21',)
*/