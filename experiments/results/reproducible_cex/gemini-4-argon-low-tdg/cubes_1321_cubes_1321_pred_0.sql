-- Schema DDL
CREATE TABLE "grapes" ("ID" INTEGER PRIMARY KEY, "Grape" TEXT UNIQUE, "Color" TEXT);

CREATE TABLE "appellations" ("No" INTEGER PRIMARY KEY, "Appelation" TEXT UNIQUE, "County" TEXT, "State" TEXT, "Area" TEXT, "isAVA" TEXT);

CREATE TABLE "wine" ("Appelation" TEXT, "Grape" TEXT, "No" INTEGER, "Winery" TEXT, "State" TEXT, "Name" TEXT, "Year" INTEGER, "Price" INTEGER, "Score" INTEGER, "Cases" INTEGER, "Drink" TEXT, FOREIGN KEY ("Appelation") REFERENCES "appellations" ("Appelation"), FOREIGN KEY ("Grape") REFERENCES "grapes" ("Grape"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering by Area (ASC), secondary tie-breaking by No (ASC), duplicate output rows (to kill SELECT DISTINCT mutants), and joins with the wine table (to kill inner/left join mutants with 0 vs 2 matching wines).
INSERT INTO grapes (ID, Grape, Color) VALUES (1, 'Chardonnay', 'White');
INSERT INTO appellations (No, Appelation, County, State, Area, isAVA) VALUES (10, 'App1', 'Sonoma', 'CA', 'North Coast', 'Yes');
INSERT INTO appellations (No, Appelation, County, State, Area, isAVA) VALUES (20, 'App2', 'Sonoma', 'CA', 'North Coast', 'No');
INSERT INTO appellations (No, Appelation, County, State, Area, isAVA) VALUES (5, 'App3', 'Napa', 'CA', 'North Coast', 'Yes');
INSERT INTO appellations (No, Appelation, County, State, Area, isAVA) VALUES (15, 'App4', 'Monterey', 'CA', 'Central Coast', 'Yes');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('App1', 'Chardonnay', 100, 'W1', 'CA', 'N1', 2020, 30, 90, 500, 'now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('App1', 'Chardonnay', 101, 'W2', 'CA', 'N2', 2021, 40, 92, 300, 'now');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT area, county FROM appellations ORDER BY area, appellations.no NULLS LAST;

/*
Gold Result:
('Central Coast', 'Monterey')
('North Coast', 'Napa')
('North Coast', 'Sonoma')
('North Coast', 'Sonoma')
*/

-- Prediction Query
SELECT Area, County FROM APPELLATIONS;

/*
Prediction Result:
('North Coast', 'Napa')
('North Coast', 'Sonoma')
('Central Coast', 'Monterey')
('North Coast', 'Sonoma')
*/