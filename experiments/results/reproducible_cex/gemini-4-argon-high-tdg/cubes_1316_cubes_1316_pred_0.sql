-- Schema DDL
CREATE TABLE "grapes" ("ID" INTEGER PRIMARY KEY, "Grape" TEXT UNIQUE, "Color" TEXT);

CREATE TABLE "appellations" ("No" INTEGER PRIMARY KEY, "Appelation" TEXT UNIQUE, "County" TEXT, "State" TEXT, "Area" TEXT, "isAVA" TEXT);

CREATE TABLE "wine" ("Appelation" TEXT, "Grape" TEXT, "No" INTEGER, "Winery" TEXT, "State" TEXT, "Name" TEXT, "Year" INTEGER, "Price" INTEGER, "Score" INTEGER, "Cases" INTEGER, "Drink" TEXT, FOREIGN KEY ("Appelation") REFERENCES "appellations" ("Appelation"), FOREIGN KEY ("Grape") REFERENCES "grapes" ("Grape"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO grapes (ID, Grape, Color) VALUES (1, 'Pinot Noir', 'Red');
INSERT INTO grapes (ID, Grape, Color) VALUES (2, 'Chardonnay', 'White');
INSERT INTO appellations (No, Appelation, County, State, Area, isAVA) VALUES (1, 'Napa Valley', 'Napa', 'CA', 'North Coast', 'Yes');
INSERT INTO appellations (No, Appelation, County, State, Area, isAVA) VALUES (2, 'Sonoma Coast', 'Sonoma', 'CA', 'North Coast', 'Yes');
INSERT INTO appellations (No, Appelation, County, State, Area, isAVA) VALUES (3, 'Willamette Valley', 'Yamhill', 'OR', 'Willamette', 'Yes');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Napa Valley', 'Pinot Noir', 101, 'Winery A', 'CA', 'Reserve', 2019, 10, 90, 500, 'Now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Sonoma Coast', 'Chardonnay', 102, 'Winery B', 'CA', 'Estate', 2019, 10, 92, 300, 'Hold');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Napa Valley', 'Pinot Noir', 103, 'Winery C', 'CA', 'Classic', 2019, 40, 88, 200, 'Now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Willamette Valley', 'Pinot Noir', 104, 'Winery D', 'OR', 'Select', 2015, 20, 95, 150, 'Hold');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Willamette Valley', 'Chardonnay', 105, 'Winery E', 'OR', 'Blanc', 2019, 10, 85, 400, 'Now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Willamette Valley', 'Pinot Noir', 106, 'Winery D', 'OR', 'Noir', 2019, 15, 89, 250, 'Now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Napa Valley', 'Chardonnay', 107, 'Winery A', 'CA', 'Gold', 2018, 50, 94, 100, 'Hold');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT meanprice AS avg_price_, YEAR FROM (SELECT state, YEAR, AVG(price) AS meanprice FROM wine GROUP BY state, YEAR) ORDER BY avg_price_, YEAR NULLS LAST;

/*
Gold Result:
(12.5, 2019)
(20.0, 2015)
(20.0, 2019)
(50.0, 2018)
*/

-- Prediction Query
SELECT AVG(Price), YEAR FROM WINE GROUP BY YEAR;

/*
Prediction Result:
(20.0, 2015)
(50.0, 2018)
(17.0, 2019)
*/