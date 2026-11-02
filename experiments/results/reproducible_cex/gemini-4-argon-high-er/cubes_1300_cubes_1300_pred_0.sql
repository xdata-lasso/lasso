-- Schema DDL
CREATE TABLE "grapes" ("ID" INTEGER PRIMARY KEY, "Grape" TEXT UNIQUE, "Color" TEXT);

CREATE TABLE "appellations" ("No" INTEGER PRIMARY KEY, "Appelation" TEXT UNIQUE, "County" TEXT, "State" TEXT, "Area" TEXT, "isAVA" TEXT);

CREATE TABLE "wine" ("Appelation" TEXT, "Grape" TEXT, "No" INTEGER, "Winery" TEXT, "State" TEXT, "Name" TEXT, "Year" INTEGER, "Price" INTEGER, "Score" INTEGER, "Cases" INTEGER, "Drink" TEXT, FOREIGN KEY ("Appelation") REFERENCES "appellations" ("Appelation"), FOREIGN KEY ("Grape") REFERENCES "grapes" ("Grape"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO grapes (ID, Grape, Color) VALUES (1, 'Merlot', 'Red');
INSERT INTO appellations (No, Appelation, County, State, Area, isAVA) VALUES (1, 'Napa', 'Napa', 'CA', 'North Coast', 'Yes');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Napa', 'Merlot', 2, 'Winery1', 'CA', 'Wine1', 2020, 50, 90, 100, 'Now');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT color FROM (SELECT LHS.grape AS grape, LHS.no AS NO, LHS.meanprice AS meanprice, RHS.color AS color FROM (SELECT grape, NO, AVG(price) AS meanprice FROM wine GROUP BY grape, NO) AS LHS INNER JOIN grapes AS RHS ON (LHS.no = RHS.id AND LHS.grape = RHS.grape)) ORDER BY color;

/*
Gold Result:
*/

-- Prediction Query
SELECT T1.Color FROM GRAPES AS T1 JOIN WINE AS T2 ON T1.Grape = T2.Grape GROUP BY T2.Grape ORDER BY AVG(Price) DESC, T1.Color NULLS LAST LIMIT 1;

/*
Prediction Result:
('Red',)
*/