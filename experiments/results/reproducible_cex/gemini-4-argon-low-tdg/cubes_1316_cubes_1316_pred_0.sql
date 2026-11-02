-- Schema DDL
CREATE TABLE "grapes" ("ID" INTEGER PRIMARY KEY, "Grape" TEXT UNIQUE, "Color" TEXT);

CREATE TABLE "appellations" ("No" INTEGER PRIMARY KEY, "Appelation" TEXT UNIQUE, "County" TEXT, "State" TEXT, "Area" TEXT, "isAVA" TEXT);

CREATE TABLE "wine" ("Appelation" TEXT, "Grape" TEXT, "No" INTEGER, "Winery" TEXT, "State" TEXT, "Name" TEXT, "Year" INTEGER, "Price" INTEGER, "Score" INTEGER, "Cases" INTEGER, "Drink" TEXT, FOREIGN KEY ("Appelation") REFERENCES "appellations" ("Appelation"), FOREIGN KEY ("Grape") REFERENCES "grapes" ("Grape"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic GROUP BY (state, year), AVG calculation (including fractional averages), and primary/secondary ORDER BY.
-- Also tests that grouping by state+year is distinct from grouping by only year or only state.
INSERT INTO grapes (ID, Grape, Color) VALUES (1, 'Chardonnay', 'White');
INSERT INTO appellations (No, Appelation, County, State, Area, isAVA) VALUES (1, 'Napa Valley', 'Napa', 'California', 'North Coast', 'Yes');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Napa Valley', 'Chardonnay', 1, 'Winery A', 'California', 'Reserve', 2010, 10, 90, 100, 'Now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Napa Valley', 'Chardonnay', 2, 'Winery B', 'California', 'Reserve', 2010, 25, 92, 200, 'Now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Napa Valley', 'Chardonnay', 3, 'Winery C', 'Oregon', 'Estate', 2010, 50, 95, 150, 'Hold');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Napa Valley', 'Chardonnay', 4, 'Winery D', 'California', 'Select', 2012, 50, 88, 300, 'Now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Napa Valley', 'Chardonnay', 5, 'Winery E', 'Washington', 'Vintage', 2008, 50, 91, 120, 'Now');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT meanprice AS avg_price_, YEAR FROM (SELECT state, YEAR, AVG(price) AS meanprice FROM wine GROUP BY state, YEAR) ORDER BY avg_price_, YEAR NULLS LAST;

/*
Gold Result:
(17.5, 2010)
(50.0, 2008)
(50.0, 2010)
(50.0, 2012)
*/

-- Prediction Query
SELECT AVG(Price), YEAR FROM WINE GROUP BY YEAR;

/*
Prediction Result:
(50.0, 2008)
(28.333333333333332, 2010)
(50.0, 2012)
*/