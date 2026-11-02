-- Schema DDL
CREATE TABLE "grapes" ("ID" INTEGER PRIMARY KEY, "Grape" TEXT UNIQUE, "Color" TEXT);

CREATE TABLE "appellations" ("No" INTEGER PRIMARY KEY, "Appelation" TEXT UNIQUE, "County" TEXT, "State" TEXT, "Area" TEXT, "isAVA" TEXT);

CREATE TABLE "wine" ("Appelation" TEXT, "Grape" TEXT, "No" INTEGER, "Winery" TEXT, "State" TEXT, "Name" TEXT, "Year" INTEGER, "Price" INTEGER, "Score" INTEGER, "Cases" INTEGER, "Drink" TEXT, FOREIGN KEY ("Appelation") REFERENCES "appellations" ("Appelation"), FOREIGN KEY ("Grape") REFERENCES "grapes" ("Grape"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests GROUP BY (state, winery) vs GROUP BY (winery) alone, and SELECT winery vs SELECT DISTINCT winery.
INSERT INTO grapes (ID, Grape, Color) VALUES (1, 'Pinot Noir', 'Red');
INSERT INTO appellations (No, Appelation, County, State, Area, isAVA) VALUES (1, 'Willamette', 'Yamhill', 'Oregon', 'Willamette Valley', 'Yes');
INSERT INTO appellations (No, Appelation, County, State, Area, isAVA) VALUES (2, 'Sonoma Coast', 'Sonoma', 'California', 'North Coast', 'Yes');
-- 'SplitWinery' has 2 wines in Oregon and 2 in California. Total = 4, but per (state, winery) = 2. Should NOT be returned.
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Willamette', 'Pinot Noir', 1, 'SplitWinery', 'Oregon', 'OR Pin 1', 2018, 45, 90, 100, 'Now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Willamette', 'Pinot Noir', 2, 'SplitWinery', 'Oregon', 'OR Pin 2', 2019, 45, 91, 100, 'Now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Sonoma Coast', 'Pinot Noir', 3, 'SplitWinery', 'California', 'CA Pin 1', 2018, 50, 89, 100, 'Now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Sonoma Coast', 'Pinot Noir', 4, 'SplitWinery', 'California', 'CA Pin 2', 2019, 50, 92, 100, 'Now');
-- 'MultiStateMega' has 4 wines in Oregon and 4 wines in California. Should be returned TWICE in the output because there is no DISTINCT in the reference query.
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Willamette', 'Pinot Noir', 5, 'MultiStateMega', 'Oregon', 'OR1', 2018, 60, 93, 200, 'Hold');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Willamette', 'Pinot Noir', 6, 'MultiStateMega', 'Oregon', 'OR2', 2019, 60, 94, 200, 'Hold');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Willamette', 'Pinot Noir', 7, 'MultiStateMega', 'Oregon', 'OR3', 2020, 60, 92, 200, 'Now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Willamette', 'Pinot Noir', 8, 'MultiStateMega', 'Oregon', 'OR4', 2021, 60, 91, 200, 'Now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Sonoma Coast', 'Pinot Noir', 9, 'MultiStateMega', 'California', 'CA1', 2018, 65, 90, 150, 'Now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Sonoma Coast', 'Pinot Noir', 10, 'MultiStateMega', 'California', 'CA2', 2019, 65, 91, 150, 'Now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Sonoma Coast', 'Pinot Noir', 11, 'MultiStateMega', 'California', 'CA3', 2020, 65, 92, 150, 'Now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Sonoma Coast', 'Pinot Noir', 12, 'MultiStateMega', 'California', 'CA4', 2021, 65, 93, 150, 'Hold');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT winery FROM (SELECT state, winery, COUNT(*) AS n FROM wine GROUP BY state, winery) WHERE (n >= 4) ORDER BY winery;

/*
Gold Result:
('MultiStateMega',)
('MultiStateMega',)
*/

-- Prediction Query
SELECT Winery FROM WINE GROUP BY Winery HAVING COUNT(*) >= 4;

/*
Prediction Result:
('MultiStateMega',)
('SplitWinery',)
*/