-- Schema DDL
CREATE TABLE "grapes" ("ID" INTEGER PRIMARY KEY, "Grape" TEXT UNIQUE, "Color" TEXT);

CREATE TABLE "appellations" ("No" INTEGER PRIMARY KEY, "Appelation" TEXT UNIQUE, "County" TEXT, "State" TEXT, "Area" TEXT, "isAVA" TEXT);

CREATE TABLE "wine" ("Appelation" TEXT, "Grape" TEXT, "No" INTEGER, "Winery" TEXT, "State" TEXT, "Name" TEXT, "Year" INTEGER, "Price" INTEGER, "Score" INTEGER, "Cases" INTEGER, "Drink" TEXT, FOREIGN KEY ("Appelation") REFERENCES "appellations" ("Appelation"), FOREIGN KEY ("Grape") REFERENCES "grapes" ("Grape"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO grapes (ID, Grape, Color) VALUES (1, 'Pinot Noir', 'Red');
INSERT INTO appellations (No, Appelation, County, State, Area, isAVA) VALUES (1, 'Sonoma', 'Sonoma', 'CA', 'North Coast', 'Yes');
INSERT INTO appellations (No, Appelation, County, State, Area, isAVA) VALUES (2, 'Dundee Hills', 'Yamhill', 'OR', 'Willamette', 'Yes');
INSERT INTO appellations (No, Appelation, County, State, Area, isAVA) VALUES (3, 'Yakima', 'Yakima', 'WA', 'Columbia', 'Yes');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Sonoma', 'Pinot Noir', 1, 'SplitWinery', 'CA', 'Pinot CA 1', 2018, 50, 90, 200, 'now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Sonoma', 'Pinot Noir', 2, 'SplitWinery', 'CA', 'Pinot CA 2', 2019, 50, 90, 200, 'now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Dundee Hills', 'Pinot Noir', 3, 'SplitWinery', 'OR', 'Pinot OR 1', 2018, 50, 90, 200, 'now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Dundee Hills', 'Pinot Noir', 4, 'SplitWinery', 'OR', 'Pinot OR 2', 2019, 50, 90, 200, 'now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Yakima', 'Pinot Noir', 5, 'SplitWinery', 'WA', 'Pinot WA 1', 2020, 50, 90, 200, 'now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Sonoma', 'Pinot Noir', 6, 'MultiStateWinery', 'CA', 'MS CA 1', 2017, 60, 92, 300, 'now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Sonoma', 'Pinot Noir', 7, 'MultiStateWinery', 'CA', 'MS CA 2', 2018, 60, 92, 300, 'now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Sonoma', 'Pinot Noir', 8, 'MultiStateWinery', 'CA', 'MS CA 3', 2019, 60, 92, 300, 'now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Sonoma', 'Pinot Noir', 9, 'MultiStateWinery', 'CA', 'MS CA 4', 2020, 60, 92, 300, 'now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Dundee Hills', 'Pinot Noir', 10, 'MultiStateWinery', 'OR', 'MS OR 1', 2017, 60, 92, 300, 'now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Dundee Hills', 'Pinot Noir', 11, 'MultiStateWinery', 'OR', 'MS OR 2', 2018, 60, 92, 300, 'now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Dundee Hills', 'Pinot Noir', 12, 'MultiStateWinery', 'OR', 'MS OR 3', 2019, 60, 92, 300, 'now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Dundee Hills', 'Pinot Noir', 13, 'MultiStateWinery', 'OR', 'MS OR 4', 2020, 60, 92, 300, 'now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Sonoma', 'Pinot Noir', 14, 'SingleStateWinery', 'CA', 'SS CA 1', 2017, 45, 89, 150, 'now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Sonoma', 'Pinot Noir', 15, 'SingleStateWinery', 'CA', 'SS CA 2', 2018, 45, 89, 150, 'now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Sonoma', 'Pinot Noir', 16, 'SingleStateWinery', 'CA', 'SS CA 3', 2019, 45, 89, 150, 'now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Sonoma', 'Pinot Noir', 17, 'SingleStateWinery', 'CA', 'SS CA 4', 2020, 45, 89, 150, 'now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Dundee Hills', 'Pinot Noir', 18, 'SingleStateWinery', 'OR', 'SS OR 1', 2020, 45, 89, 150, 'now');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT winery FROM (SELECT state, winery, COUNT(*) AS n FROM wine GROUP BY state, winery) WHERE (n >= 4) ORDER BY winery;

/*
Gold Result:
('MultiStateWinery',)
('MultiStateWinery',)
('SingleStateWinery',)
*/

-- Prediction Query
SELECT Winery FROM WINE GROUP BY Winery HAVING COUNT(*) >= 4;

/*
Prediction Result:
('MultiStateWinery',)
('SingleStateWinery',)
('SplitWinery',)
*/