-- Schema DDL
CREATE TABLE "grapes" ("ID" INTEGER PRIMARY KEY, "Grape" TEXT UNIQUE, "Color" TEXT);

CREATE TABLE "appellations" ("No" INTEGER PRIMARY KEY, "Appelation" TEXT UNIQUE, "County" TEXT, "State" TEXT, "Area" TEXT, "isAVA" TEXT);

CREATE TABLE "wine" ("Appelation" TEXT, "Grape" TEXT, "No" INTEGER, "Winery" TEXT, "State" TEXT, "Name" TEXT, "Year" INTEGER, "Price" INTEGER, "Score" INTEGER, "Cases" INTEGER, "Drink" TEXT, FOREIGN KEY ("Appelation") REFERENCES "appellations" ("Appelation"), FOREIGN KEY ("Grape") REFERENCES "grapes" ("Grape"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO grapes (ID, Grape, Color) VALUES (1, 'Chardonnay', 'White');
INSERT INTO grapes (ID, Grape, Color) VALUES (2, 'Merlot', 'Red');
INSERT INTO appellations (No, Appelation, County, State, Area, isAVA) VALUES (1, 'Napa Valley', 'Napa', 'California', 'North Coast', 'Yes');
INSERT INTO appellations (No, Appelation, County, State, Area, isAVA) VALUES (2, 'Columbia Valley', 'Benton', 'Washington', 'Eastern', 'Yes');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Napa Valley', 'Chardonnay', 1, 'Zeta Winery', 'California', 'Reserve', 2018, 85, 85, 100, 'Now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Napa Valley', 'Merlot', 2, 'Alpha Winery', 'California', 'Estate', 2019, 95, 90, 200, '2025');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Columbia Valley', 'Merlot', 3, 'Beta Winery', 'Washington', 'Select', 2020, 80, 90, 150, 'Now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Columbia Valley', 'Chardonnay', 4, 'Gamma Winery', 'Washington', 'Classic', 2017, 100, 95, 300, '2026');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT winery FROM (SELECT LHS.no AS NO, LHS.grape AS grape, LHS.winery AS winery, LHS.appelation AS appelation, LHS.state AS state, LHS.name AS name, LHS.year AS YEAR, LHS.price AS price, LHS.score AS score, LHS.cases AS cases, LHS.drink AS drink FROM wine AS LHS INNER JOIN (SELECT state, MIN(score) AS score FROM wine GROUP BY state) AS RHS ON (LHS.state = RHS.state AND LHS.score = RHS.score)) ORDER BY winery;

/*
Gold Result:
('Beta Winery',)
('Zeta Winery',)
*/

-- Prediction Query
SELECT Winery FROM WINE ORDER BY SCORE, WINE.appelation NULLS LAST, WINE.grape NULLS LAST, WINE.no NULLS LAST, WINE.winery NULLS LAST, WINE.state NULLS LAST, WINE.name NULLS LAST, WINE.year NULLS LAST, WINE.price NULLS LAST, WINE.cases NULLS LAST, WINE.drink NULLS LAST LIMIT 1;

/*
Prediction Result:
('Zeta Winery',)
*/