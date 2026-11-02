-- Schema DDL
CREATE TABLE "grapes" ("ID" INTEGER PRIMARY KEY, "Grape" TEXT UNIQUE, "Color" TEXT);

CREATE TABLE "appellations" ("No" INTEGER PRIMARY KEY, "Appelation" TEXT UNIQUE, "County" TEXT, "State" TEXT, "Area" TEXT, "isAVA" TEXT);

CREATE TABLE "wine" ("Appelation" TEXT, "Grape" TEXT, "No" INTEGER, "Winery" TEXT, "State" TEXT, "Name" TEXT, "Year" INTEGER, "Price" INTEGER, "Score" INTEGER, "Cases" INTEGER, "Drink" TEXT, FOREIGN KEY ("Appelation") REFERENCES "appellations" ("Appelation"), FOREIGN KEY ("Grape") REFERENCES "grapes" ("Grape"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "appellations" ("no", "appelation", "county", "state", "area", "isava") VALUES (1004, 'knowledge', 'almost', 'Alaska', 'early', 'discover');
INSERT INTO "appellations" ("no", "appelation", "county", "state", "area", "isava") VALUES (1005, 'sit', 'wait', 'Ohio', 'begin', 'performance');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT area, county FROM appellations ORDER BY area, appellations.no NULLS LAST;

/*
Gold Result:
('begin', 'wait')
('early', 'almost')
*/

-- Prediction Query
SELECT Area, County FROM APPELLATIONS;

/*
Prediction Result:
('early', 'almost')
('begin', 'wait')
*/