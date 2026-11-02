-- Schema DDL
CREATE TABLE "grapes" ("ID" INTEGER PRIMARY KEY, "Grape" TEXT UNIQUE, "Color" TEXT);

CREATE TABLE "appellations" ("No" INTEGER PRIMARY KEY, "Appelation" TEXT UNIQUE, "County" TEXT, "State" TEXT, "Area" TEXT, "isAVA" TEXT);

CREATE TABLE "wine" ("Appelation" TEXT, "Grape" TEXT, "No" INTEGER, "Winery" TEXT, "State" TEXT, "Name" TEXT, "Year" INTEGER, "Price" INTEGER, "Score" INTEGER, "Cases" INTEGER, "Drink" TEXT, FOREIGN KEY ("Appelation") REFERENCES "appellations" ("Appelation"), FOREIGN KEY ("Grape") REFERENCES "grapes" ("Grape"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests GROUP BY (state, winery) vs GROUP BY (winery) and SELECT vs SELECT DISTINCT.
-- Case 1: Winery 'SplitWinery' has 2 wines in CA and 2 in OR (total 4, but per-state is 2 -> should NOT be returned).
-- Case 2: Winery 'MultiStateBig' has 4 wines in CA and 4 in OR (should be returned TWICE since there is no DISTINCT).
INSERT INTO grapes (ID, Grape, Color) VALUES (1, 'Pinot Noir', 'Red');
INSERT INTO appellations (No, Appelation, County, State, Area, isAVA) VALUES (1, 'Carneros', 'Napa', 'California', 'North Coast', 'Yes');
-- 'SplitWinery': 2 in California, 2 in Oregon
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Carneros', 'Pinot Noir', 1, 'SplitWinery', 'California', 'S1', 2019, 40, 88, 200, 'now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Carneros', 'Pinot Noir', 2, 'SplitWinery', 'California', 'S2', 2019, 40, 88, 200, 'now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Carneros', 'Pinot Noir', 3, 'SplitWinery', 'Oregon', 'S3', 2019, 40, 88, 200, 'now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Carneros', 'Pinot Noir', 4, 'SplitWinery', 'Oregon', 'S4', 2019, 40, 88, 200, 'now');
-- 'MultiStateBig': 4 in California, 4 in Oregon
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Carneros', 'Pinot Noir', 5, 'MultiStateBig', 'California', 'M1', 2019, 60, 92, 300, 'now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Carneros', 'Pinot Noir', 6, 'MultiStateBig', 'California', 'M2', 2019, 60, 92, 300, 'now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Carneros', 'Pinot Noir', 7, 'MultiStateBig', 'California', 'M3', 2019, 60, 92, 300, 'now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Carneros', 'Pinot Noir', 8, 'MultiStateBig', 'California', 'M4', 2019, 60, 92, 300, 'now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Carneros', 'Pinot Noir', 9, 'MultiStateBig', 'Oregon', 'M5', 2019, 60, 92, 300, 'now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Carneros', 'Pinot Noir', 10, 'MultiStateBig', 'Oregon', 'M6', 2019, 60, 92, 300, 'now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Carneros', 'Pinot Noir', 11, 'MultiStateBig', 'Oregon', 'M7', 2019, 60, 92, 300, 'now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Carneros', 'Pinot Noir', 12, 'MultiStateBig', 'Oregon', 'M8', 2019, 60, 92, 300, 'now');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT winery FROM (SELECT state, winery, COUNT(*) AS n FROM wine GROUP BY state, winery) WHERE (n >= 4) ORDER BY winery;

/*
Gold Result:
('MultiStateBig',)
('MultiStateBig',)
*/

-- Prediction Query
SELECT Winery FROM WINE GROUP BY Winery HAVING COUNT(*) >= 4;

/*
Prediction Result:
('MultiStateBig',)
('SplitWinery',)
*/