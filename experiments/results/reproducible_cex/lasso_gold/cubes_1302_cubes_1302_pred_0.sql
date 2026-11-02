-- Schema DDL
CREATE TABLE "grapes" ("ID" INTEGER PRIMARY KEY, "Grape" TEXT UNIQUE, "Color" TEXT);

CREATE TABLE "appellations" ("No" INTEGER PRIMARY KEY, "Appelation" TEXT UNIQUE, "County" TEXT, "State" TEXT, "Area" TEXT, "isAVA" TEXT);

CREATE TABLE "wine" ("Appelation" TEXT, "Grape" TEXT, "No" INTEGER, "Winery" TEXT, "State" TEXT, "Name" TEXT, "Year" INTEGER, "Price" INTEGER, "Score" INTEGER, "Cases" INTEGER, "Drink" TEXT, FOREIGN KEY ("Appelation") REFERENCES "appellations" ("Appelation"), FOREIGN KEY ("Grape") REFERENCES "grapes" ("Grape"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "appellations" ("no", "appelation", "county", "state", "area", "isava") VALUES (1015, 'human', 'perform', 'Louisiana', 'table', 'true');
INSERT INTO "appellations" ("no", "appelation", "county", "state", "area", "isava") VALUES (1022, 'list', 'blue', 'Colorado', 'husband', 'bill');
INSERT INTO "grapes" ("id", "grape", "color") VALUES (1016, 'win', 'song');
INSERT INTO "grapes" ("id", "grape", "color") VALUES (1023, 'according', 'throw');
INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('human', 'win', 1017, 'bar', 'Hawaii', 'Gina Moore', 1018, 1019, 1020, 1021, 'high');
INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('list', 'according', 1018, 'sure', 'Oklahoma', 'Mark Mcclure', 1019, 1020, 1021, 1022, 'source');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT grape, appelation FROM wine ORDER BY grape, wine.appelation NULLS LAST, wine.no NULLS LAST, wine.winery NULLS LAST, wine.state NULLS LAST, wine.name NULLS LAST, wine.year NULLS LAST, wine.price NULLS LAST, wine.score NULLS LAST, wine.cases NULLS LAST, wine.drink NULLS LAST;

/*
Gold Result:
('according', 'list')
('win', 'human')
*/

-- Prediction Query
SELECT Grape, Appelation FROM WINE;

/*
Prediction Result:
('win', 'human')
('according', 'list')
*/