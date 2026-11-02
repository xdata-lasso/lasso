-- Schema DDL
CREATE TABLE "grapes" ("ID" INTEGER PRIMARY KEY, "Grape" TEXT UNIQUE, "Color" TEXT);

CREATE TABLE "appellations" ("No" INTEGER PRIMARY KEY, "Appelation" TEXT UNIQUE, "County" TEXT, "State" TEXT, "Area" TEXT, "isAVA" TEXT);

CREATE TABLE "wine" ("Appelation" TEXT, "Grape" TEXT, "No" INTEGER, "Winery" TEXT, "State" TEXT, "Name" TEXT, "Year" INTEGER, "Price" INTEGER, "Score" INTEGER, "Cases" INTEGER, "Drink" TEXT, FOREIGN KEY ("Appelation") REFERENCES "appellations" ("Appelation"), FOREIGN KEY ("Grape") REFERENCES "grapes" ("Grape"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "grapes" ("ID", "Grape", "Color") VALUES (1, 'Cabernet', 'Red');
INSERT INTO "grapes" ("ID", "Grape", "Color") VALUES (2, 'Merlot', 'Red');
INSERT INTO "grapes" ("ID", "Grape", "Color") VALUES (3, 'Chardonnay', 'White');
INSERT INTO "appellations" ("No", "Appelation", "County", "State", "Area", "isAVA") VALUES (1, 'Napa', 'Napa', 'CA', 'North Coast', 'Yes');
INSERT INTO "wine" ("Appelation", "Grape", "No", "Winery", "State", "Name", "Year", "Price", "Score", "Cases", "Drink") VALUES ('Napa', 'Cabernet', 1, 'WineryA', 'CA', 'Reserve', 2015, 99, 90, 500, 'Now');
INSERT INTO "wine" ("Appelation", "Grape", "No", "Winery", "State", "Name", "Year", "Price", "Score", "Cases", "Drink") VALUES ('Napa', 'Merlot', 2, 'WineryB', 'CA', 'Estate', 2016, 100, 92, 400, 'Now');
INSERT INTO "wine" ("Appelation", "Grape", "No", "Winery", "State", "Name", "Year", "Price", "Score", "Cases", "Drink") VALUES ('Napa', 'Chardonnay', 3, 'WineryC', 'CA', 'Classic', 2017, 101, 95, 300, '2025');
INSERT INTO "wine" ("Appelation", "Grape", "No", "Winery", "State", "Name", "Year", "Price", "Score", "Cases", "Drink") VALUES ('Napa', 'Cabernet', 4, 'WineryD', 'CA', 'Special', 2018, 250, 98, 100, '2030');
INSERT INTO "wine" ("Appelation", "Grape", "No", "Winery", "State", "Name", "Year", "Price", "Score", "Cases", "Drink") VALUES ('Napa', 'Merlot', 5, 'WineryE', 'CA', 'Ghost', 2019, NULL, 88, 200, 'Now');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT grape, winery, YEAR FROM wine WHERE (price > 100) ORDER BY grape, wine.appelation NULLS LAST, wine.no NULLS LAST, wine.winery NULLS LAST, wine.state NULLS LAST, wine.name NULLS LAST, wine.year NULLS LAST, wine.price NULLS LAST, wine.score NULLS LAST, wine.cases NULLS LAST, wine.drink NULLS LAST;

/*
Gold Result:
('Cabernet', 'WineryD', 2018)
('Chardonnay', 'WineryC', 2017)
*/

-- Prediction Query
SELECT Grape, Winery, YEAR FROM WINE WHERE Price > 100 ORDER BY YEAR, WINE.appelation NULLS LAST, WINE.grape NULLS LAST, WINE.no NULLS LAST, WINE.winery NULLS LAST, WINE.state NULLS LAST, WINE.name NULLS LAST, WINE.price NULLS LAST, WINE.score NULLS LAST, WINE.cases NULLS LAST, WINE.drink NULLS LAST;

/*
Prediction Result:
('Chardonnay', 'WineryC', 2017)
('Cabernet', 'WineryD', 2018)
*/