-- Schema DDL
CREATE TABLE "grapes" ("ID" INTEGER PRIMARY KEY, "Grape" TEXT UNIQUE, "Color" TEXT);

CREATE TABLE "appellations" ("No" INTEGER PRIMARY KEY, "Appelation" TEXT UNIQUE, "County" TEXT, "State" TEXT, "Area" TEXT, "isAVA" TEXT);

CREATE TABLE "wine" ("Appelation" TEXT, "Grape" TEXT, "No" INTEGER, "Winery" TEXT, "State" TEXT, "Name" TEXT, "Year" INTEGER, "Price" INTEGER, "Score" INTEGER, "Cases" INTEGER, "Drink" TEXT, FOREIGN KEY ("Appelation") REFERENCES "appellations" ("Appelation"), FOREIGN KEY ("Grape") REFERENCES "grapes" ("Grape"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "grapes" ("id", "grape", "color") VALUES (14, '31', '31');
INSERT INTO "grapes" ("id", "grape", "color") VALUES (13, NULL, '31');
INSERT INTO "appellations" ("no", "appelation", "county", "state", "area", "isava") VALUES (16, NULL, '31', '31', '31', '31');
INSERT INTO "appellations" ("no", "appelation", "county", "state", "area", "isava") VALUES (15, '20', '31', '31', '31', '31');
INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES (20, NULL, 21, '22', '31', NULL, 24, 25, -719, 26, '27');
INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES (NULL, NULL, 29, NULL, '31', '32', 33, 34, -719, 35, '36');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT grape AS name FROM (SELECT LHS.no AS NO, LHS.grape AS grape, LHS.winery AS winery, LHS.appelation AS appelation, LHS.state AS state, LHS.name AS name, LHS.year AS YEAR, LHS.price AS price, LHS.score AS score, LHS.cases AS cases, LHS.drink AS drink FROM wine AS LHS INNER JOIN (SELECT state, MIN(score) AS score FROM wine GROUP BY state) AS RHS ON (LHS.state = RHS.state AND LHS.score = RHS.score)) ORDER BY name;

/*
Gold Result:
(None,)
(None,)
*/

-- Prediction Query
SELECT Name FROM WINE ORDER BY Score, WINE.appelation NULLS LAST, WINE.grape NULLS LAST, WINE.no NULLS LAST, WINE.winery NULLS LAST, WINE.state NULLS LAST, WINE.name NULLS LAST, WINE.year NULLS LAST, WINE.price NULLS LAST, WINE.cases NULLS LAST, WINE.drink NULLS LAST LIMIT 1;

/*
Prediction Result:
(None,)
*/