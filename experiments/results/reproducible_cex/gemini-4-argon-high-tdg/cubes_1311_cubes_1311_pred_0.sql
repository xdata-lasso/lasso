-- Schema DDL
CREATE TABLE "grapes" ("ID" INTEGER PRIMARY KEY, "Grape" TEXT UNIQUE, "Color" TEXT);

CREATE TABLE "appellations" ("No" INTEGER PRIMARY KEY, "Appelation" TEXT UNIQUE, "County" TEXT, "State" TEXT, "Area" TEXT, "isAVA" TEXT);

CREATE TABLE "wine" ("Appelation" TEXT, "Grape" TEXT, "No" INTEGER, "Winery" TEXT, "State" TEXT, "Name" TEXT, "Year" INTEGER, "Price" INTEGER, "Score" INTEGER, "Cases" INTEGER, "Drink" TEXT, FOREIGN KEY ("Appelation") REFERENCES "appellations" ("Appelation"), FOREIGN KEY ("Grape") REFERENCES "grapes" ("Grape"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO grapes (ID, Grape, Color) VALUES (1, 'Cabernet', 'Red');
INSERT INTO grapes (ID, Grape, Color) VALUES (2, 'Merlot', 'Red');
INSERT INTO grapes (ID, Grape, Color) VALUES (3, 'Zinfandel', 'Red');
INSERT INTO grapes (ID, Grape, Color) VALUES (4, 'Chardonnay', 'White');
INSERT INTO appellations (No, Appelation, County, State, Area, isAVA) VALUES (1, 'Sonoma', 'Sonoma', 'CA', 'North Coast', 'Yes');
INSERT INTO appellations (No, Appelation, County, State, Area, isAVA) VALUES (2, 'Carneros', 'Napa', 'CA', 'North Coast', 'Yes');
INSERT INTO appellations (No, Appelation, County, State, Area, isAVA) VALUES (3, 'Napa Valley', 'Napa', 'CA', 'North Coast', 'No');
INSERT INTO appellations (No, Appelation, County, State, Area, isAVA) VALUES (4, 'Paso Robles', 'San Luis Obispo', 'CA', 'Central Coast', 'Yes');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Napa Valley', 'Zinfandel', 10, 'Winery B', 'OR', 'Alpha', 2010, 50, 95, 80, 'now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Sonoma', 'Cabernet', 20, 'Winery C', 'WA', 'Omega', 2012, 40, 94, 60, 'hold');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Carneros', 'Merlot', 5, 'Winery A', 'NY', 'Beta', 2008, 30, 98, 70, 'now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Paso Robles', 'Chardonnay', 100, 'Winery D', 'CA', 'Gamma', 2015, 120, 93, 500, 'now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Sonoma', 'Merlot', 99, 'Winery E', 'CA', 'Delta', 2018, 150, 92, 1000, 'hold');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Napa Valley', 'Cabernet', 95, 'Winery F', 'CA', 'Epsilon', 2020, 200, NULL, 300, 'now');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT grape, appelation, name FROM wine WHERE (score > 93) ORDER BY grape, wine.appelation NULLS LAST, wine.no NULLS LAST, wine.winery NULLS LAST, wine.state NULLS LAST, wine.name NULLS LAST, wine.year NULLS LAST, wine.price NULLS LAST, wine.score NULLS LAST, wine.cases NULLS LAST, wine.drink NULLS LAST;

/*
Gold Result:
('Cabernet', 'Sonoma', 'Omega')
('Merlot', 'Carneros', 'Beta')
('Zinfandel', 'Napa Valley', 'Alpha')
*/

-- Prediction Query
SELECT Grape, Appelation, Name FROM WINE WHERE Score > 93 ORDER BY Name, WINE.appelation NULLS LAST, WINE.grape NULLS LAST, WINE.no NULLS LAST, WINE.winery NULLS LAST, WINE.state NULLS LAST, WINE.year NULLS LAST, WINE.price NULLS LAST, WINE.score NULLS LAST, WINE.cases NULLS LAST, WINE.drink NULLS LAST;

/*
Prediction Result:
('Zinfandel', 'Napa Valley', 'Alpha')
('Merlot', 'Carneros', 'Beta')
('Cabernet', 'Sonoma', 'Omega')
*/