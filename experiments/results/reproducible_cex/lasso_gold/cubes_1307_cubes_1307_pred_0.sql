-- Schema DDL
CREATE TABLE "grapes" ("ID" INTEGER PRIMARY KEY, "Grape" TEXT UNIQUE, "Color" TEXT);

CREATE TABLE "appellations" ("No" INTEGER PRIMARY KEY, "Appelation" TEXT UNIQUE, "County" TEXT, "State" TEXT, "Area" TEXT, "isAVA" TEXT);

CREATE TABLE "wine" ("Appelation" TEXT, "Grape" TEXT, "No" INTEGER, "Winery" TEXT, "State" TEXT, "Name" TEXT, "Year" INTEGER, "Price" INTEGER, "Score" INTEGER, "Cases" INTEGER, "Drink" TEXT, FOREIGN KEY ("Appelation") REFERENCES "appellations" ("Appelation"), FOREIGN KEY ("Grape") REFERENCES "grapes" ("Grape"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "appellations" ("no", "appelation", "county", "state", "area", "isava") VALUES (1088, 'food', 'education', 'Arkansas', 'effect', 'unit');
INSERT INTO "appellations" ("no", "appelation", "county", "state", "area", "isava") VALUES (1094, 'inside', 'car', 'Florida', 'receive', 'may');
INSERT INTO "grapes" ("id", "grape", "color") VALUES (1089, 'our', 'your');
INSERT INTO "grapes" ("id", "grape", "color") VALUES (1095, 'remain', 'company');
INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('food', 'our', 1090, 'bar', 'Colorado', 'Rose Spence', 2008, 1091, 1092, 1093, 'left');
INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('inside', 'remain', 1091, 'rate', 'Mississippi', 'Melissa Marquez', 2008, 1092, 1093, 1094, 'no');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM wine WHERE (YEAR = 2008) ORDER BY name, wine.appelation NULLS LAST, wine.grape NULLS LAST, wine.no NULLS LAST, wine.winery NULLS LAST, wine.state NULLS LAST, wine.year NULLS LAST, wine.price NULLS LAST, wine.score NULLS LAST, wine.cases NULLS LAST, wine.drink NULLS LAST;

/*
Gold Result:
('Melissa Marquez',)
('Rose Spence',)
*/

-- Prediction Query
SELECT Name FROM WINE WHERE YEAR = '2008';

/*
Prediction Result:
('Rose Spence',)
('Melissa Marquez',)
*/