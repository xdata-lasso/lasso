-- Schema DDL
CREATE TABLE "grapes" ("ID" INTEGER PRIMARY KEY, "Grape" TEXT UNIQUE, "Color" TEXT);

CREATE TABLE "appellations" ("No" INTEGER PRIMARY KEY, "Appelation" TEXT UNIQUE, "County" TEXT, "State" TEXT, "Area" TEXT, "isAVA" TEXT);

CREATE TABLE "wine" ("Appelation" TEXT, "Grape" TEXT, "No" INTEGER, "Winery" TEXT, "State" TEXT, "Name" TEXT, "Year" INTEGER, "Price" INTEGER, "Score" INTEGER, "Cases" INTEGER, "Drink" TEXT, FOREIGN KEY ("Appelation") REFERENCES "appellations" ("Appelation"), FOREIGN KEY ("Grape") REFERENCES "grapes" ("Grape"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "appellations" ("no", "appelation", "county", "state", "area", "isava") VALUES (1088, 'food', 'education', 'Arkansas', 'effect', 'unit');
INSERT INTO "appellations" ("no", "appelation", "county", "state", "area", "isava") VALUES (1094, 'show', 'car', 'Florida', 'receive', 'may');
INSERT INTO "grapes" ("id", "grape", "color") VALUES (1089, 'someone', 'your');
INSERT INTO "grapes" ("id", "grape", "color") VALUES (1095, 'our', 'company');
INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('food', 'someone', 1090, 'bar', 'Colorado', 'Jennifer Powers', 1091, 1092, 94, 1093, 'hour');
INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('show', 'our', 1091, 'road', 'Illinois', 'Rose Spence', 1092, 1093, 94, 1094, 'no');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT grape, appelation, name FROM wine WHERE (score > 93) ORDER BY grape, wine.appelation NULLS LAST, wine.no NULLS LAST, wine.winery NULLS LAST, wine.state NULLS LAST, wine.name NULLS LAST, wine.year NULLS LAST, wine.price NULLS LAST, wine.score NULLS LAST, wine.cases NULLS LAST, wine.drink NULLS LAST;

/*
Gold Result:
('our', 'show', 'Rose Spence')
('someone', 'food', 'Jennifer Powers')
*/

-- Prediction Query
SELECT Grape, Appelation, Name FROM WINE WHERE Score > 93 ORDER BY Name, WINE.appelation NULLS LAST, WINE.grape NULLS LAST, WINE.no NULLS LAST, WINE.winery NULLS LAST, WINE.state NULLS LAST, WINE.year NULLS LAST, WINE.price NULLS LAST, WINE.score NULLS LAST, WINE.cases NULLS LAST, WINE.drink NULLS LAST;

/*
Prediction Result:
('someone', 'food', 'Jennifer Powers')
('our', 'show', 'Rose Spence')
*/