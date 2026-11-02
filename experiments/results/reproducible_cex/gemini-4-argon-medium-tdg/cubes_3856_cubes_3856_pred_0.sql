-- Schema DDL
CREATE TABLE "grapes" ("ID" INTEGER PRIMARY KEY, "Grape" TEXT UNIQUE, "Color" TEXT);

CREATE TABLE "appellations" ("No" INTEGER PRIMARY KEY, "Appelation" TEXT UNIQUE, "County" TEXT, "State" TEXT, "Area" TEXT, "isAVA" TEXT);

CREATE TABLE "wine" ("Appelation" TEXT, "Grape" TEXT, "No" INTEGER, "Winery" TEXT, "State" TEXT, "Name" TEXT, "Year" INTEGER, "Price" INTEGER, "Score" INTEGER, "Cases" INTEGER, "Drink" TEXT, FOREIGN KEY ("Appelation") REFERENCES "appellations" ("Appelation"), FOREIGN KEY ("Grape") REFERENCES "grapes" ("Grape"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO grapes (ID, Grape, Color) VALUES (1, 'Pinot Noir', 'Red');
INSERT INTO grapes (ID, Grape, Color) VALUES (2, 'Chardonnay', 'White');
INSERT INTO grapes (ID, Grape, Color) VALUES (3, 'Merlot', 'Red');
INSERT INTO grapes (ID, Grape, Color) VALUES (4, 'Syrah', 'Red');
INSERT INTO appellations (No, Appelation, County, State, Area, isAVA) VALUES (1, 'Napa Valley', 'Napa', 'California', 'North Coast', 'Yes');
INSERT INTO appellations (No, Appelation, County, State, Area, isAVA) VALUES (2, 'Willamette Valley', 'Yamhill', 'Oregon', 'Willamette', 'Yes');
INSERT INTO appellations (No, Appelation, County, State, Area, isAVA) VALUES (3, 'Columbia Valley', 'Benton', 'Washington', 'Eastern', 'Yes');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Napa Valley', 'Pinot Noir', 1, 'Winery A', 'California', 'Wine 1', 2018, 50, 80, 100, 'Now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Napa Valley', 'Chardonnay', 2, 'Winery B', 'California', 'Wine 2', 2019, 40, 85, 200, 'Now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Willamette Valley', 'Merlot', 3, 'Winery C', 'Oregon', 'Wine 3', 2017, 60, 85, 150, 'Hold');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Willamette Valley', 'Syrah', 4, 'Winery D', 'Oregon', 'Wine 4', 2020, 70, 90, 120, 'Now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Columbia Valley', 'Pinot Noir', 5, 'Winery E', 'Washington', 'Wine 5', 2021, 55, 88, 300, 'Now');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT grape AS name FROM (SELECT LHS.no AS NO, LHS.grape AS grape, LHS.winery AS winery, LHS.appelation AS appelation, LHS.state AS state, LHS.name AS name, LHS.year AS YEAR, LHS.price AS price, LHS.score AS score, LHS.cases AS cases, LHS.drink AS drink FROM wine AS LHS INNER JOIN (SELECT state, MIN(score) AS score FROM wine GROUP BY state) AS RHS ON (LHS.state = RHS.state AND LHS.score = RHS.score)) ORDER BY name;

/*
Gold Result:
('Merlot',)
('Pinot Noir',)
('Pinot Noir',)
*/

-- Prediction Query
SELECT Name FROM WINE ORDER BY Score, WINE.appelation NULLS LAST, WINE.grape NULLS LAST, WINE.no NULLS LAST, WINE.winery NULLS LAST, WINE.state NULLS LAST, WINE.name NULLS LAST, WINE.year NULLS LAST, WINE.price NULLS LAST, WINE.cases NULLS LAST, WINE.drink NULLS LAST LIMIT 1;

/*
Prediction Result:
('Wine 1',)
*/