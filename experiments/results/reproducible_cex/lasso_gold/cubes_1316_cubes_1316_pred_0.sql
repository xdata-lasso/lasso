-- Schema DDL
CREATE TABLE "grapes" ("ID" INTEGER PRIMARY KEY, "Grape" TEXT UNIQUE, "Color" TEXT);

CREATE TABLE "appellations" ("No" INTEGER PRIMARY KEY, "Appelation" TEXT UNIQUE, "County" TEXT, "State" TEXT, "Area" TEXT, "isAVA" TEXT);

CREATE TABLE "wine" ("Appelation" TEXT, "Grape" TEXT, "No" INTEGER, "Winery" TEXT, "State" TEXT, "Name" TEXT, "Year" INTEGER, "Price" INTEGER, "Score" INTEGER, "Cases" INTEGER, "Drink" TEXT, FOREIGN KEY ("Appelation") REFERENCES "appellations" ("Appelation"), FOREIGN KEY ("Grape") REFERENCES "grapes" ("Grape"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "appellations" ("no", "appelation", "county", "state", "area", "isava") VALUES (1022, 'great', 'blue', 'Colorado', 'husband', 'bill');
INSERT INTO "appellations" ("no", "appelation", "county", "state", "area", "isava") VALUES (1029, 'win', 'human', 'Oklahoma', 'finally', 'themselves');
INSERT INTO "grapes" ("id", "grape", "color") VALUES (1023, 'her', 'throw');
INSERT INTO "grapes" ("id", "grape", "color") VALUES (1030, 'production', 'present');
INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('great', 'her', 1024, 'guy', 'Rhode Island', 'Andrew Stevens', 1025, 1026, 1027, 1028, 'capital');
INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('win', 'production', 1031, 'value', 'Mississippi', 'Michele Williams', 1032, NULL, 1034, 1035, 'drive');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT meanprice AS avg_price_, YEAR FROM (SELECT state, YEAR, AVG(price) AS meanprice FROM wine GROUP BY state, YEAR) ORDER BY avg_price_, YEAR NULLS LAST;

/*
Gold Result:
(None, 1032)
(1026.0, 1025)
*/

-- Prediction Query
SELECT AVG(Price), YEAR FROM WINE GROUP BY YEAR;

/*
Prediction Result:
(1026.0, 1025)
(None, 1032)
*/