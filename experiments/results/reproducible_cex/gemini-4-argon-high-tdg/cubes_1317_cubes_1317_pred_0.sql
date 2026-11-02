-- Schema DDL
CREATE TABLE "grapes" ("ID" INTEGER PRIMARY KEY, "Grape" TEXT UNIQUE, "Color" TEXT);

CREATE TABLE "appellations" ("No" INTEGER PRIMARY KEY, "Appelation" TEXT UNIQUE, "County" TEXT, "State" TEXT, "Area" TEXT, "isAVA" TEXT);

CREATE TABLE "wine" ("Appelation" TEXT, "Grape" TEXT, "No" INTEGER, "Winery" TEXT, "State" TEXT, "Name" TEXT, "Year" INTEGER, "Price" INTEGER, "Score" INTEGER, "Cases" INTEGER, "Drink" TEXT, FOREIGN KEY ("Appelation") REFERENCES "appellations" ("Appelation"), FOREIGN KEY ("Grape") REFERENCES "grapes" ("Grape"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO grapes (ID, Grape, Color) VALUES (1, 'Cabernet Sauvignon', 'Red');
INSERT INTO grapes (ID, Grape, Color) VALUES (2, 'Chardonnay', 'White');
INSERT INTO appellations (No, Appelation, County, State, Area, isAVA) VALUES (1, 'Napa Valley', 'Napa', 'California', 'North Coast', 'Yes');
INSERT INTO appellations (No, Appelation, County, State, Area, isAVA) VALUES (2, 'Sonoma Coast', 'Sonoma', 'California', 'North Coast', 'Yes');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Napa Valley', 'Cabernet Sauvignon', 1, 'Charlie Cellars', 'California', 'Reserve', 2015, 50, 90, 500, 'now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Sonoma Coast', 'Chardonnay', 2, 'Bravo Vineyards', 'California', 'Estate', 2016, 65, 88, 300, 'now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Napa Valley', 'Cabernet Sauvignon', 3, 'Bravo Vineyards', 'California', 'Selection', 2017, 85, 92, 400, 'now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Sonoma Coast', 'Chardonnay', 4, 'Alpha Winery', 'California', 'Gold Label', 2018, 100, 95, 200, 'now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Napa Valley', 'Cabernet Sauvignon', 5, 'Delta Estates', 'California', 'Table Red', 2019, 49, 85, 1000, 'now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Sonoma Coast', 'Chardonnay', 6, 'Echo Wines', 'California', 'Grand Cru', 2014, 101, 96, 150, 'now');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT winery FROM wine WHERE (price >= 50 AND price <= 100) ORDER BY winery;

/*
Gold Result:
('Alpha Winery',)
('Bravo Vineyards',)
('Charlie Cellars',)
*/

-- Prediction Query
SELECT DISTINCT Winery FROM WINE WHERE Price BETWEEN 50 AND 100;

/*
Prediction Result:
('Charlie Cellars',)
('Bravo Vineyards',)
('Alpha Winery',)
*/