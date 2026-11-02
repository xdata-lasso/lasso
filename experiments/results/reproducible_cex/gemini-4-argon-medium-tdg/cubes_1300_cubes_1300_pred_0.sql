-- Schema DDL
CREATE TABLE "grapes" ("ID" INTEGER PRIMARY KEY, "Grape" TEXT UNIQUE, "Color" TEXT);

CREATE TABLE "appellations" ("No" INTEGER PRIMARY KEY, "Appelation" TEXT UNIQUE, "County" TEXT, "State" TEXT, "Area" TEXT, "isAVA" TEXT);

CREATE TABLE "wine" ("Appelation" TEXT, "Grape" TEXT, "No" INTEGER, "Winery" TEXT, "State" TEXT, "Name" TEXT, "Year" INTEGER, "Price" INTEGER, "Score" INTEGER, "Cases" INTEGER, "Drink" TEXT, FOREIGN KEY ("Appelation") REFERENCES "appellations" ("Appelation"), FOREIGN KEY ("Grape") REFERENCES "grapes" ("Grape"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO grapes (ID, Grape, Color) VALUES (1, 'Merlot', 'Red');
INSERT INTO grapes (ID, Grape, Color) VALUES (2, 'Chardonnay', 'White');
INSERT INTO grapes (ID, Grape, Color) VALUES (3, 'Pinot Noir', 'Red');
INSERT INTO grapes (ID, Grape, Color) VALUES (4, 'Syrah', 'Blue');
INSERT INTO grapes (ID, Grape, Color) VALUES (5, 'Riesling', 'Green');
INSERT INTO appellations (No, Appelation, County, State, Area, isAVA) VALUES (10, 'Napa Valley', 'Napa', 'CA', 'North Coast', 'Yes');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Napa Valley', 'Merlot', 1, 'Winery A', 'CA', 'Wine 1', 2020, 50, 90, 100, 'Now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Napa Valley', 'Merlot', 1, 'Winery B', 'CA', 'Wine 2', 2021, 60, 92, 150, 'Now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Napa Valley', 'Chardonnay', 2, 'Winery C', 'CA', 'Wine 3', 2019, 30, 88, 200, 'Now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Napa Valley', 'Pinot Noir', 3, 'Winery D', 'CA', 'Wine 4', 2020, 40, 85, 120, 'Now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Napa Valley', 'Syrah', 99, 'Winery E', 'CA', 'Wine 5', 2018, 70, 95, 80, 'Hold');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Napa Valley', 'Merlot', 5, 'Winery F', 'CA', 'Wine 6', 2017, 25, 80, 300, 'Now');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT color FROM (SELECT LHS.grape AS grape, LHS.no AS NO, LHS.meanprice AS meanprice, RHS.color AS color FROM (SELECT grape, NO, AVG(price) AS meanprice FROM wine GROUP BY grape, NO) AS LHS INNER JOIN grapes AS RHS ON (LHS.no = RHS.id AND LHS.grape = RHS.grape)) ORDER BY color;

/*
Gold Result:
('Red',)
('Red',)
('White',)
*/

-- Prediction Query
SELECT T1.Color FROM GRAPES AS T1 JOIN WINE AS T2 ON T1.Grape = T2.Grape GROUP BY T2.Grape ORDER BY AVG(Price) DESC, T1.Color NULLS LAST LIMIT 1;

/*
Prediction Result:
('Blue',)
*/