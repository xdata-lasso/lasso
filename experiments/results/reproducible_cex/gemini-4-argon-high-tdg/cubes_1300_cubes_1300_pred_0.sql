-- Schema DDL
CREATE TABLE "grapes" ("ID" INTEGER PRIMARY KEY, "Grape" TEXT UNIQUE, "Color" TEXT);

CREATE TABLE "appellations" ("No" INTEGER PRIMARY KEY, "Appelation" TEXT UNIQUE, "County" TEXT, "State" TEXT, "Area" TEXT, "isAVA" TEXT);

CREATE TABLE "wine" ("Appelation" TEXT, "Grape" TEXT, "No" INTEGER, "Winery" TEXT, "State" TEXT, "Name" TEXT, "Year" INTEGER, "Price" INTEGER, "Score" INTEGER, "Cases" INTEGER, "Drink" TEXT, FOREIGN KEY ("Appelation") REFERENCES "appellations" ("Appelation"), FOREIGN KEY ("Grape") REFERENCES "grapes" ("Grape"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO grapes (ID, Grape, Color) VALUES (1, 'Agiorgitiko', 'White');
INSERT INTO grapes (ID, Grape, Color) VALUES (2, 'Barbera', 'Red');
INSERT INTO grapes (ID, Grape, Color) VALUES (3, 'Chardonnay', 'Blush');
INSERT INTO grapes (ID, Grape, Color) VALUES (4, 'Dolcetto', 'Rose');
INSERT INTO grapes (ID, Grape, Color) VALUES (5, 'UnusedGrape', 'Gold');
INSERT INTO appellations (No, Appelation, County, State, Area, isAVA) VALUES (10, 'Napa Valley', 'Napa', 'California', 'North Coast', 'Yes');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Napa Valley', 'Agiorgitiko', 1, 'Winery A', 'California', 'Reserve A1', 2018, 10, 90, 100, 'now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Napa Valley', 'Agiorgitiko', 1, 'Winery A', 'California', 'Reserve A2', 2019, 10, 91, 120, 'now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Napa Valley', 'Barbera', 2, 'Winery B', 'California', 'Reserve B1', 2017, 30, 88, 200, 'now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Napa Valley', 'Chardonnay', 3, 'Winery C', 'California', 'Reserve C1', 2020, 20, 92, 150, 'hold');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Napa Valley', 'Dolcetto', 99, 'Winery D', 'California', 'Wrong No', 2020, 50, 85, 300, 'now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Napa Valley', 'Dolcetto', 1, 'Winery E', 'California', 'Mismatched ID', 2021, 60, 87, 400, 'now');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT color FROM (SELECT LHS.grape AS grape, LHS.no AS NO, LHS.meanprice AS meanprice, RHS.color AS color FROM (SELECT grape, NO, AVG(price) AS meanprice FROM wine GROUP BY grape, NO) AS LHS INNER JOIN grapes AS RHS ON (LHS.no = RHS.id AND LHS.grape = RHS.grape)) ORDER BY color;

/*
Gold Result:
('Blush',)
('Red',)
('White',)
*/

-- Prediction Query
SELECT T1.Color FROM GRAPES AS T1 JOIN WINE AS T2 ON T1.Grape = T2.Grape GROUP BY T2.Grape ORDER BY AVG(Price) DESC, T1.Color NULLS LAST LIMIT 1;

/*
Prediction Result:
('Rose',)
*/