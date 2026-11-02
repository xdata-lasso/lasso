-- Schema DDL
CREATE TABLE "grapes" ("ID" INTEGER PRIMARY KEY, "Grape" TEXT UNIQUE, "Color" TEXT);

CREATE TABLE "appellations" ("No" INTEGER PRIMARY KEY, "Appelation" TEXT UNIQUE, "County" TEXT, "State" TEXT, "Area" TEXT, "isAVA" TEXT);

CREATE TABLE "wine" ("Appelation" TEXT, "Grape" TEXT, "No" INTEGER, "Winery" TEXT, "State" TEXT, "Name" TEXT, "Year" INTEGER, "Price" INTEGER, "Score" INTEGER, "Cases" INTEGER, "Drink" TEXT, FOREIGN KEY ("Appelation") REFERENCES "appellations" ("Appelation"), FOREIGN KEY ("Grape") REFERENCES "grapes" ("Grape"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "grapes" ("id", "grape", "color") VALUES (11, '-722', '-722');
INSERT INTO "grapes" ("id", "grape", "color") VALUES (10, NULL, '-722');
INSERT INTO "appellations" ("no", "appelation", "county", "state", "area", "isava") VALUES (13, '9', '-722', '-722', '-722', '-722');
INSERT INTO "appellations" ("no", "appelation", "county", "state", "area", "isava") VALUES (12, '8', '-722', '-722', '-722', '-722');
INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES (9, NULL, -722, '-722', '15', '-722', NULL, -722, -722, -722, '-722');
INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES (NULL, NULL, -722, '-722', NULL, '-722', NULL, -722, -722, -722, '-722');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT meanprice AS avg_price_, YEAR FROM (SELECT state, YEAR, AVG(price) AS meanprice FROM wine GROUP BY state, YEAR) ORDER BY avg_price_, YEAR NULLS LAST;

/*
Gold Result:
(-722.0, None)
(-722.0, None)
*/

-- Prediction Query
SELECT AVG(Price), YEAR FROM WINE GROUP BY YEAR;

/*
Prediction Result:
(-722.0, None)
*/