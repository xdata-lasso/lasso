-- Schema DDL
CREATE TABLE "grapes" ("ID" INTEGER PRIMARY KEY, "Grape" TEXT UNIQUE, "Color" TEXT);

CREATE TABLE "appellations" ("No" INTEGER PRIMARY KEY, "Appelation" TEXT UNIQUE, "County" TEXT, "State" TEXT, "Area" TEXT, "isAVA" TEXT);

CREATE TABLE "wine" ("Appelation" TEXT, "Grape" TEXT, "No" INTEGER, "Winery" TEXT, "State" TEXT, "Name" TEXT, "Year" INTEGER, "Price" INTEGER, "Score" INTEGER, "Cases" INTEGER, "Drink" TEXT, FOREIGN KEY ("Appelation") REFERENCES "appellations" ("Appelation"), FOREIGN KEY ("Grape") REFERENCES "grapes" ("Grape"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "appellations" ("no", "appelation", "county", "state", "area", "isava") VALUES (1015, 'list', 'perform', 'Louisiana', 'table', 'true');
INSERT INTO "appellations" ("no", "appelation", "county", "state", "area", "isava") VALUES (1022, 'themselves', 'blue', 'Colorado', 'husband', 'bill');
INSERT INTO "grapes" ("id", "grape", "color") VALUES (1016, 'according', 'song');
INSERT INTO "grapes" ("id", "grape", "color") VALUES (1023, 'production', 'throw');
INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('list', 'according', 1017, 'present', 'Hawaii', 'Jamie Arnold', 1018, 1019, 1020, 1021, 'participant');
INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('themselves', 'production', 1018, 'sure', 'Mississippi', 'Gina Moore', 1019, 1020, 1021, 1022, 'source');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, score FROM wine ORDER BY name, wine.appelation NULLS LAST, wine.grape NULLS LAST, wine.no NULLS LAST, wine.winery NULLS LAST, wine.state NULLS LAST, wine.year NULLS LAST, wine.price NULLS LAST, wine.score NULLS LAST, wine.cases NULLS LAST, wine.drink NULLS LAST;

/*
Gold Result:
('Gina Moore', 1021)
('Jamie Arnold', 1020)
*/

-- Prediction Query
SELECT Name, Score FROM WINE;

/*
Prediction Result:
('Jamie Arnold', 1020)
('Gina Moore', 1021)
*/