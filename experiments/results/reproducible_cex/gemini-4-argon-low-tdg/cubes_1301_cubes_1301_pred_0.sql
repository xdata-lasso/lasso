-- Schema DDL
CREATE TABLE "grapes" ("ID" INTEGER PRIMARY KEY, "Grape" TEXT UNIQUE, "Color" TEXT);

CREATE TABLE "appellations" ("No" INTEGER PRIMARY KEY, "Appelation" TEXT UNIQUE, "County" TEXT, "State" TEXT, "Area" TEXT, "isAVA" TEXT);

CREATE TABLE "wine" ("Appelation" TEXT, "Grape" TEXT, "No" INTEGER, "Winery" TEXT, "State" TEXT, "Name" TEXT, "Year" INTEGER, "Price" INTEGER, "Score" INTEGER, "Cases" INTEGER, "Drink" TEXT, FOREIGN KEY ("Appelation") REFERENCES "appellations" ("Appelation"), FOREIGN KEY ("Grape") REFERENCES "grapes" ("Grape"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO grapes (ID, Grape, Color) VALUES (1, 'Cabernet', 'Red');
INSERT INTO grapes (ID, Grape, Color) VALUES (2, 'Merlot', 'Red');
INSERT INTO appellations (No, Appelation, County, State, Area, isAVA) VALUES (1, 'Napa', 'Napa', 'CA', 'North Coast', 'Yes');
INSERT INTO appellations (No, Appelation, County, State, Area, isAVA) VALUES (2, 'Sonoma', 'Sonoma', 'CA', 'North Coast', 'Yes');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Sonoma', 'Cabernet', 1, 'WineryA', 'CA', 'Reserve', 2015, 50, 95, 100, 'Now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Napa', 'Cabernet', 2, 'WineryB', 'CA', 'Classic', 2016, 40, 88, 200, '2025');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Napa', 'Merlot', 3, 'WineryC', 'CA', NULL, 2017, 60, 92, 150, 'Hold');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Napa', 'Merlot', 4, 'WineryD', 'CA', 'Estate', 2018, 70, NULL, 300, 'Now');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, score FROM wine ORDER BY name, wine.appelation NULLS LAST, wine.grape NULLS LAST, wine.no NULLS LAST, wine.winery NULLS LAST, wine.state NULLS LAST, wine.year NULLS LAST, wine.price NULLS LAST, wine.score NULLS LAST, wine.cases NULLS LAST, wine.drink NULLS LAST;

/*
Gold Result:
(None, 92)
('Classic', 88)
('Estate', None)
('Reserve', 95)
*/

-- Prediction Query
SELECT Name, Score FROM WINE;

/*
Prediction Result:
('Reserve', 95)
('Classic', 88)
(None, 92)
('Estate', None)
*/