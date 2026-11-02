-- Schema DDL
CREATE TABLE "grapes" ("ID" INTEGER PRIMARY KEY, "Grape" TEXT UNIQUE, "Color" TEXT);

CREATE TABLE "appellations" ("No" INTEGER PRIMARY KEY, "Appelation" TEXT UNIQUE, "County" TEXT, "State" TEXT, "Area" TEXT, "isAVA" TEXT);

CREATE TABLE "wine" ("Appelation" TEXT, "Grape" TEXT, "No" INTEGER, "Winery" TEXT, "State" TEXT, "Name" TEXT, "Year" INTEGER, "Price" INTEGER, "Score" INTEGER, "Cases" INTEGER, "Drink" TEXT, FOREIGN KEY ("Appelation") REFERENCES "appellations" ("Appelation"), FOREIGN KEY ("Grape") REFERENCES "grapes" ("Grape"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO grapes (ID, Grape, Color) VALUES (1, 'Cabernet Sauvignon', 'Red');
INSERT INTO grapes (ID, Grape, Color) VALUES (2, 'Chardonnay', 'White');
INSERT INTO grapes (ID, Grape, Color) VALUES (3, 'Zinfandel', 'Red');
INSERT INTO appellations (No, Appelation, County, State, Area, isAVA) VALUES (1, 'Napa Valley', 'Napa', 'California', 'North Coast', 'Yes');
INSERT INTO appellations (No, Appelation, County, State, Area, isAVA) VALUES (2, 'Sonoma Coast', 'Sonoma', 'California', 'North Coast', 'Yes');
INSERT INTO appellations (No, Appelation, County, State, Area, isAVA) VALUES (3, 'Columbia Valley', 'Walla Walla', 'Washington', 'Columbia', 'Yes');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Sonoma Coast', 'Zinfandel', 10, 'Alpha Winery', 'California', 'Zinfandel Reserve', 2005, 20, 88, 500, 'now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Columbia Valley', 'Cabernet Sauvignon', 20, 'Beta Cellars', 'Washington', 'Apex Red', 2012, 85, 91, 200, '2020');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Napa Valley', 'Chardonnay', 5, 'Gamma Vineyards', 'California', 'Estate Reserve', 2010, 50, 96, 300, 'now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Sonoma Coast', 'Chardonnay', 15, 'Delta Winery', 'California', 'Estate Reserve', 2008, 40, 89, 400, 'now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Columbia Valley', 'Zinfandel', 25, 'Epsilon Wines', 'Washington', 'Old Vine', 2009, 30, 85, 600, 'now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Napa Valley', 'Zinfandel', 30, 'Zeta Estates', 'California', 'Old Vine', 2011, 60, 94, 150, '2018');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Napa Valley', 'Cabernet Sauvignon', 35, 'Eta Winery', 'California', 'Classic Cab', 2007, 45, 90, 1000, 'now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Sonoma Coast', 'Cabernet Sauvignon', 40, 'Theta Vintners', 'California', 'Classic Cab', 2008, 55, 90, 800, 'now');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, score FROM wine ORDER BY name, wine.appelation NULLS LAST, wine.grape NULLS LAST, wine.no NULLS LAST, wine.winery NULLS LAST, wine.state NULLS LAST, wine.year NULLS LAST, wine.price NULLS LAST, wine.score NULLS LAST, wine.cases NULLS LAST, wine.drink NULLS LAST;

/*
Gold Result:
('Apex Red', 91)
('Classic Cab', 90)
('Classic Cab', 90)
('Estate Reserve', 96)
('Estate Reserve', 89)
('Old Vine', 85)
('Old Vine', 94)
('Zinfandel Reserve', 88)
*/

-- Prediction Query
SELECT Name, Score FROM WINE;

/*
Prediction Result:
('Zinfandel Reserve', 88)
('Apex Red', 91)
('Estate Reserve', 96)
('Estate Reserve', 89)
('Old Vine', 85)
('Old Vine', 94)
('Classic Cab', 90)
('Classic Cab', 90)
*/