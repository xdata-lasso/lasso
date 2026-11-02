-- Schema DDL
CREATE TABLE "grapes" ("ID" INTEGER PRIMARY KEY, "Grape" TEXT UNIQUE, "Color" TEXT);

CREATE TABLE "appellations" ("No" INTEGER PRIMARY KEY, "Appelation" TEXT UNIQUE, "County" TEXT, "State" TEXT, "Area" TEXT, "isAVA" TEXT);

CREATE TABLE "wine" ("Appelation" TEXT, "Grape" TEXT, "No" INTEGER, "Winery" TEXT, "State" TEXT, "Name" TEXT, "Year" INTEGER, "Price" INTEGER, "Score" INTEGER, "Cases" INTEGER, "Drink" TEXT, FOREIGN KEY ("Appelation") REFERENCES "appellations" ("Appelation"), FOREIGN KEY ("Grape") REFERENCES "grapes" ("Grape"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "appellations" ("no", "appelation", "county", "state", "area", "isava") VALUES (1016, 'list', 'perform', 'Louisiana', 'table', 'true');
INSERT INTO "appellations" ("no", "appelation", "county", "state", "area", "isava") VALUES (1023, 'great', 'blue', 'Colorado', 'husband', 'bill');
INSERT INTO "grapes" ("id", "grape", "color") VALUES (1017, 'according', 'song');
INSERT INTO "grapes" ("id", "grape", "color") VALUES (1024, 'her', 'throw');
INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('list', 'according', 1018, 'guy', 'Hawaii', 'Jamie Arnold', 1019, 1020, 1021, 1022, 'capital');
INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('great', 'her', 1019, 'sure', 'Rhode Island', 'Gina Moore', 1020, 1021, 1022, 1023, 'source');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT name FROM wine ORDER BY name;

/*
Gold Result:
('Gina Moore',)
('Jamie Arnold',)
*/

-- Prediction Query
SELECT DISTINCT Name FROM WINE ORDER BY price, Name NULLS LAST;

/*
Prediction Result:
('Jamie Arnold',)
('Gina Moore',)
*/