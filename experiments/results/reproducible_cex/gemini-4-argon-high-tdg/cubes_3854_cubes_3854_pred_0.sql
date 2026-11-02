-- Schema DDL
CREATE TABLE "grapes" ("ID" INTEGER PRIMARY KEY, "Grape" TEXT UNIQUE, "Color" TEXT);

CREATE TABLE "appellations" ("No" INTEGER PRIMARY KEY, "Appelation" TEXT UNIQUE, "County" TEXT, "State" TEXT, "Area" TEXT, "isAVA" TEXT);

CREATE TABLE "wine" ("Appelation" TEXT, "Grape" TEXT, "No" INTEGER, "Winery" TEXT, "State" TEXT, "Name" TEXT, "Year" INTEGER, "Price" INTEGER, "Score" INTEGER, "Cases" INTEGER, "Drink" TEXT, FOREIGN KEY ("Appelation") REFERENCES "appellations" ("Appelation"), FOREIGN KEY ("Grape") REFERENCES "grapes" ("Grape"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO grapes (ID, Grape, Color) VALUES (1, 'Pinot Noir', 'Red');
INSERT INTO grapes (ID, Grape, Color) VALUES (2, 'Chardonnay', 'White');
INSERT INTO grapes (ID, Grape, Color) VALUES (3, 'Cabernet', 'Red');
INSERT INTO appellations (No, Appelation, County, State, Area, isAVA) VALUES (1, 'Napa Valley', 'Napa', 'CA', 'North Coast', 'Yes');
INSERT INTO appellations (No, Appelation, County, State, Area, isAVA) VALUES (2, 'Willamette', 'Yamhill', 'OR', 'Willamette Valley', 'Yes');
INSERT INTO appellations (No, Appelation, County, State, Area, isAVA) VALUES (3, 'Walla Walla', 'Walla Walla', 'WA', 'Columbia Valley', 'Yes');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Napa Valley', 'Cabernet', 1, 'Delta_Wrong', 'CA', 'Reserve', 2010, 15, 90, 50, 'now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Napa Valley', 'Pinot Noir', 10, 'Gamma', 'CA', 'Estate', 2017, 30, 85, 200, 'drink');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Walla Walla', 'Cabernet', 3, 'Zeta_Wrong', 'WA', 'Select', 2014, 25, 85, 40, 'now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Walla Walla', 'Chardonnay', 30, 'Beta', 'WA', 'Classic', 2021, 70, 80, 100, 'hold');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Willamette', 'Pinot Noir', 2, 'Epsilon_Wrong', 'OR', 'Cuvee', 2012, 20, 95, 60, 'now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Willamette', 'Chardonnay', 20, 'Alpha', 'OR', 'blanc', 2019, 50, 90, 300, 'drink');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT winery FROM (SELECT LHS.no AS NO, LHS.grape AS grape, LHS.winery AS winery, LHS.appelation AS appelation, LHS.state AS state, LHS.name AS name, LHS.year AS YEAR, LHS.price AS price, LHS.score AS score, LHS.cases AS cases, LHS.drink AS drink FROM wine AS LHS INNER JOIN (SELECT state, MIN(score) AS score FROM wine GROUP BY state) AS RHS ON (LHS.state = RHS.state AND LHS.score = RHS.score)) ORDER BY winery;

/*
Gold Result:
('Alpha',)
('Beta',)
('Gamma',)
*/

-- Prediction Query
SELECT Winery FROM WINE ORDER BY SCORE, WINE.appelation NULLS LAST, WINE.grape NULLS LAST, WINE.no NULLS LAST, WINE.winery NULLS LAST, WINE.state NULLS LAST, WINE.name NULLS LAST, WINE.year NULLS LAST, WINE.price NULLS LAST, WINE.cases NULLS LAST, WINE.drink NULLS LAST LIMIT 1;

/*
Prediction Result:
('Beta',)
*/