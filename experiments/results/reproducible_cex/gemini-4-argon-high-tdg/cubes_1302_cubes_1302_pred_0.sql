-- Schema DDL
CREATE TABLE "grapes" ("ID" INTEGER PRIMARY KEY, "Grape" TEXT UNIQUE, "Color" TEXT);

CREATE TABLE "appellations" ("No" INTEGER PRIMARY KEY, "Appelation" TEXT UNIQUE, "County" TEXT, "State" TEXT, "Area" TEXT, "isAVA" TEXT);

CREATE TABLE "wine" ("Appelation" TEXT, "Grape" TEXT, "No" INTEGER, "Winery" TEXT, "State" TEXT, "Name" TEXT, "Year" INTEGER, "Price" INTEGER, "Score" INTEGER, "Cases" INTEGER, "Drink" TEXT, FOREIGN KEY ("Appelation") REFERENCES "appellations" ("Appelation"), FOREIGN KEY ("Grape") REFERENCES "grapes" ("Grape"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO grapes (ID, Grape, Color) VALUES (1, 'Zinfandel', 'Red');
INSERT INTO grapes (ID, Grape, Color) VALUES (2, 'Chardonnay', 'White');
INSERT INTO grapes (ID, Grape, Color) VALUES (3, 'Cabernet Sauvignon', 'Red');
INSERT INTO grapes (ID, Grape, Color) VALUES (4, 'Unreferenced Grape', 'White');
INSERT INTO appellations (No, Appelation, County, State, Area, isAVA) VALUES (1, 'Sonoma Valley', 'Sonoma', 'California', 'North Coast', 'Yes');
INSERT INTO appellations (No, Appelation, County, State, Area, isAVA) VALUES (2, 'Alexander Valley', 'Sonoma', 'California', 'North Coast', 'Yes');
INSERT INTO appellations (No, Appelation, County, State, Area, isAVA) VALUES (3, 'Napa Valley', 'Napa', 'California', 'North Coast', 'Yes');
INSERT INTO appellations (No, Appelation, County, State, Area, isAVA) VALUES (4, 'Unreferenced Appellation', 'Monterey', 'California', 'Central Coast', 'No');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Sonoma Valley', 'Zinfandel', 10, 'Winery Z', 'California', 'Reserve', 2010, 45, 92, 500, 'now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Napa Valley', 'Chardonnay', 20, 'Winery B', 'California', 'Estate', 2012, 35, 90, 1200, 'now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Alexander Valley', 'Chardonnay', 30, 'Winery A', 'California', 'Classic', 2011, 30, 88, 800, '2025');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Napa Valley', 'Cabernet Sauvignon', 40, 'Winery C', 'California', 'Vintage', 2008, 80, 95, 300, 'now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Napa Valley', 'Cabernet Sauvignon', 40, 'Winery C', 'California', 'Vintage', 2008, 80, 95, 300, 'now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Napa Valley', 'Cabernet Sauvignon', 50, 'Winery D', 'California', 'Select', 2015, 60, 91, 600, '2030');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT grape, appelation FROM wine ORDER BY grape, wine.appelation NULLS LAST, wine.no NULLS LAST, wine.winery NULLS LAST, wine.state NULLS LAST, wine.name NULLS LAST, wine.year NULLS LAST, wine.price NULLS LAST, wine.score NULLS LAST, wine.cases NULLS LAST, wine.drink NULLS LAST;

/*
Gold Result:
('Cabernet Sauvignon', 'Napa Valley')
('Cabernet Sauvignon', 'Napa Valley')
('Cabernet Sauvignon', 'Napa Valley')
('Chardonnay', 'Alexander Valley')
('Chardonnay', 'Napa Valley')
('Zinfandel', 'Sonoma Valley')
*/

-- Prediction Query
SELECT Grape, Appelation FROM WINE;

/*
Prediction Result:
('Zinfandel', 'Sonoma Valley')
('Chardonnay', 'Napa Valley')
('Chardonnay', 'Alexander Valley')
('Cabernet Sauvignon', 'Napa Valley')
('Cabernet Sauvignon', 'Napa Valley')
('Cabernet Sauvignon', 'Napa Valley')
*/