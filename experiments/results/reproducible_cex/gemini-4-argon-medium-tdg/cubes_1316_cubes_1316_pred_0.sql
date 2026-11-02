-- Schema DDL
CREATE TABLE "grapes" ("ID" INTEGER PRIMARY KEY, "Grape" TEXT UNIQUE, "Color" TEXT);

CREATE TABLE "appellations" ("No" INTEGER PRIMARY KEY, "Appelation" TEXT UNIQUE, "County" TEXT, "State" TEXT, "Area" TEXT, "isAVA" TEXT);

CREATE TABLE "wine" ("Appelation" TEXT, "Grape" TEXT, "No" INTEGER, "Winery" TEXT, "State" TEXT, "Name" TEXT, "Year" INTEGER, "Price" INTEGER, "Score" INTEGER, "Cases" INTEGER, "Drink" TEXT, FOREIGN KEY ("Appelation") REFERENCES "appellations" ("Appelation"), FOREIGN KEY ("Grape") REFERENCES "grapes" ("Grape"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "grapes" ("ID", "Grape", "Color") VALUES (1, 'Chardonnay', 'White');
INSERT INTO "appellations" ("No", "Appelation", "County", "State", "Area", "isAVA") VALUES (1, 'Napa Valley', 'Napa', 'California', 'Napa', 'Yes');
INSERT INTO "appellations" ("No", "Appelation", "County", "State", "Area", "isAVA") VALUES (2, 'Willamette Valley', 'Yamhill', 'Oregon', 'Willamette', 'Yes');
INSERT INTO "appellations" ("No", "Appelation", "County", "State", "Area", "isAVA") VALUES (3, 'Columbia Valley', 'Benton', 'Washington', 'Columbia', 'Yes');
-- Group 1: (CA, 2010) -> AVG(Price) = (10 + 15) / 2 = 12.5. Tests floating point average, AVG(DISTINCT) vs AVG, and SUM vs AVG.
INSERT INTO "wine" ("Appelation", "Grape", "No", "Winery", "State", "Name", "Year", "Price", "Score", "Cases", "Drink") VALUES ('Napa Valley', 'Chardonnay', 1, 'W1', 'California', 'N1', 2010, 10, 90, 100, 'Now');
INSERT INTO "wine" ("Appelation", "Grape", "No", "Winery", "State", "Name", "Year", "Price", "Score", "Cases", "Drink") VALUES ('Napa Valley', 'Chardonnay', 2, 'W2', 'California', 'N2', 2010, 15, 92, 200, 'Now');
-- Group 2: (OR, 2010) -> AVG(Price) = (20 + 20 + 50) / 3 = 30.0. Tests AVG(DISTINCT) (which would be 35.0) and GROUP BY state, year vs GROUP BY year.
INSERT INTO "wine" ("Appelation", "Grape", "No", "Winery", "State", "Name", "Year", "Price", "Score", "Cases", "Drink") VALUES ('Willamette Valley', 'Chardonnay', 3, 'W3', 'Oregon', 'N3', 2010, 20, 88, 150, 'Now');
INSERT INTO "wine" ("Appelation", "Grape", "No", "Winery", "State", "Name", "Year", "Price", "Score", "Cases", "Drink") VALUES ('Willamette Valley', 'Chardonnay', 4, 'W4', 'Oregon', 'N4', 2010, 20, 89, 150, 'Now');
INSERT INTO "wine" ("Appelation", "Grape", "No", "Winery", "State", "Name", "Year", "Price", "Score", "Cases", "Drink") VALUES ('Willamette Valley', 'Chardonnay', 5, 'W5', 'Oregon', 'N5', 2010, 50, 95, 50, 'Hold');
-- Group 3: (CA, 2012) -> AVG(Price) = 30.0. Ties with Group 2 on avg_price_ (30.0) to test secondary sort on YEAR (2010 vs 2012) and SELECT DISTINCT mutations.
INSERT INTO "wine" ("Appelation", "Grape", "No", "Winery", "State", "Name", "Year", "Price", "Score", "Cases", "Drink") VALUES ('Napa Valley', 'Chardonnay', 6, 'W6', 'California', 'N6', 2012, 30, 91, 300, 'Now');
-- Group 4: (WA, 2010) -> AVG(Price) = 30.0. Ties with Group 2 on both avg_price_ (30.0) and YEAR (2010) to kill outer SELECT DISTINCT or GROUP BY year.
INSERT INTO "wine" ("Appelation", "Grape", "No", "Winery", "State", "Name", "Year", "Price", "Score", "Cases", "Drink") VALUES ('Columbia Valley', 'Chardonnay', 7, 'W7', 'Washington', 'N7', 2010, 30, 85, 500, 'Now');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT meanprice AS avg_price_, YEAR FROM (SELECT state, YEAR, AVG(price) AS meanprice FROM wine GROUP BY state, YEAR) ORDER BY avg_price_, YEAR NULLS LAST;

/*
Gold Result:
(12.5, 2010)
(30.0, 2010)
(30.0, 2010)
(30.0, 2012)
*/

-- Prediction Query
SELECT AVG(Price), YEAR FROM WINE GROUP BY YEAR;

/*
Prediction Result:
(24.166666666666668, 2010)
(30.0, 2012)
*/