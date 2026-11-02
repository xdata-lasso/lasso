-- Schema DDL
CREATE TABLE "grapes" ("ID" INTEGER PRIMARY KEY, "Grape" TEXT UNIQUE, "Color" TEXT);

CREATE TABLE "appellations" ("No" INTEGER PRIMARY KEY, "Appelation" TEXT UNIQUE, "County" TEXT, "State" TEXT, "Area" TEXT, "isAVA" TEXT);

CREATE TABLE "wine" ("Appelation" TEXT, "Grape" TEXT, "No" INTEGER, "Winery" TEXT, "State" TEXT, "Name" TEXT, "Year" INTEGER, "Price" INTEGER, "Score" INTEGER, "Cases" INTEGER, "Drink" TEXT, FOREIGN KEY ("Appelation") REFERENCES "appellations" ("Appelation"), FOREIGN KEY ("Grape") REFERENCES "grapes" ("Grape"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "appellations" ("no", "appelation", "county", "state", "area", "isava") VALUES (1, 'purpose', 'site', 'Iowa', 'purpose', 'blue');
INSERT INTO "appellations" ("no", "appelation", "county", "state", "area", "isava") VALUES (1001, 'brother', 'face', 'Florida', 'brother', 'require');
INSERT INTO "appellations" ("no", "appelation", "county", "state", "area", "isava") VALUES (1002, 'ago', 'election', 'West Virginia', 'ago', 'sit');
INSERT INTO "grapes" ("id", "grape", "color") VALUES (1003, 'wait', 'performance');
INSERT INTO "grapes" ("id", "grape", "color") VALUES (1004, 'offer', 'knowledge');
INSERT INTO "grapes" ("id", "grape", "color") VALUES (1005, 'begin', 'almost');
INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('purpose', 'wait', 1006, 'all', 'North Carolina', 'Michelle Miles', 1009, 1012, 1015, 1018, 'grow');
INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('purpose', 'wait', 1013.0, 'better', 'Rhode Island', 'Jerry Ramirez', 1024.0, 1029.0, 1034.0, 1039.0, 'fall');
INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('purpose', 'wait', 1020.0, 'discover', 'Alaska', 'Olivia Moore', 1039.0, 1046.0, 1053.0, 1060.0, 'clearly');
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
('purpose',)
*/