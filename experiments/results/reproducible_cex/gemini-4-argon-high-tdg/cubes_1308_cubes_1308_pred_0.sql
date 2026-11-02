-- Schema DDL
CREATE TABLE "grapes" ("ID" INTEGER PRIMARY KEY, "Grape" TEXT UNIQUE, "Color" TEXT);

CREATE TABLE "appellations" ("No" INTEGER PRIMARY KEY, "Appelation" TEXT UNIQUE, "County" TEXT, "State" TEXT, "Area" TEXT, "isAVA" TEXT);

CREATE TABLE "wine" ("Appelation" TEXT, "Grape" TEXT, "No" INTEGER, "Winery" TEXT, "State" TEXT, "Name" TEXT, "Year" INTEGER, "Price" INTEGER, "Score" INTEGER, "Cases" INTEGER, "Drink" TEXT, FOREIGN KEY ("Appelation") REFERENCES "appellations" ("Appelation"), FOREIGN KEY ("Grape") REFERENCES "grapes" ("Grape"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO grapes (ID, Grape, Color) VALUES (1, 'Chardonnay', 'White');
INSERT INTO grapes (ID, Grape, Color) VALUES (2, 'Merlot', 'Red');
INSERT INTO grapes (ID, Grape, Color) VALUES (3, 'Syrah', 'Red');
INSERT INTO grapes (ID, Grape, Color) VALUES (4, 'Zinfandel', 'Red');
INSERT INTO grapes (ID, Grape, Color) VALUES (5, 'Pinot Noir', 'Red');
INSERT INTO appellations (No, Appelation, County, State, Area, isAVA) VALUES (1, 'Napa Valley', 'Napa', 'California', 'North Coast', 'Yes');
INSERT INTO appellations (No, Appelation, County, State, Area, isAVA) VALUES (2, 'Sonoma Coast', 'Sonoma', 'California', 'North Coast', 'Yes');
INSERT INTO appellations (No, Appelation, County, State, Area, isAVA) VALUES (3, 'Paso Robles', 'San Luis Obispo', 'California', 'Central Coast', 'Yes');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Napa Valley', 'Chardonnay', 101, 'Alpha', 'California', 'Reserve', 2018, 40, 92, 500, 'now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Napa Valley', 'Chardonnay', 101, 'Alpha', 'California', 'Reserve', 2018, 40, 92, 500, 'now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES (NULL, 'Chardonnay', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Sonoma Coast', NULL, 102, 'Beta', 'California', 'Estate', 2019, 55, 90, 300, 'now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Sonoma Coast', NULL, 103, 'Beta', 'California', 'Estate', 2020, 60, 91, 200, '2025');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Napa Valley', 'Syrah', 104, 'Gamma', 'California', 'Old Vine', 2017, 35, 88, 1000, 'now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Sonoma Coast', 'Syrah', 105, 'Delta', 'California', 'Hillside', 2016, 45, 89, 450, 'now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Napa Valley', 'Merlot', 106, 'Epsilon', 'California', 'Valley', 2015, 25, 85, 1200, 'now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Sonoma Coast', 'Merlot', 107, 'Zeta', 'California', 'Coast', 2021, 30, 87, 800, '2026');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Napa Valley', 'Zinfandel', 108, 'Eta', 'California', 'Classic', 2019, 20, 84, 1500, 'now');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, grape FROM (SELECT grape, COUNT(*) AS n FROM wine GROUP BY grape) ORDER BY count___, grape NULLS LAST;

/*
Gold Result:
(1, 'Zinfandel')
(2, 'Merlot')
(2, 'Syrah')
(2, None)
(3, 'Chardonnay')
*/

-- Prediction Query
SELECT COUNT(*), Grape FROM WINE GROUP BY Grape;

/*
Prediction Result:
(2, None)
(3, 'Chardonnay')
(2, 'Merlot')
(2, 'Syrah')
(1, 'Zinfandel')
*/