-- Schema DDL
CREATE TABLE "grapes" ("ID" INTEGER PRIMARY KEY, "Grape" TEXT UNIQUE, "Color" TEXT);

CREATE TABLE "appellations" ("No" INTEGER PRIMARY KEY, "Appelation" TEXT UNIQUE, "County" TEXT, "State" TEXT, "Area" TEXT, "isAVA" TEXT);

CREATE TABLE "wine" ("Appelation" TEXT, "Grape" TEXT, "No" INTEGER, "Winery" TEXT, "State" TEXT, "Name" TEXT, "Year" INTEGER, "Price" INTEGER, "Score" INTEGER, "Cases" INTEGER, "Drink" TEXT, FOREIGN KEY ("Appelation") REFERENCES "appellations" ("Appelation"), FOREIGN KEY ("Grape") REFERENCES "grapes" ("Grape"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO grapes (ID, Grape, Color) VALUES (1, 'Merlot', 'Red');
INSERT INTO grapes (ID, Grape, Color) VALUES (2, 'Chardonnay', 'White');
INSERT INTO grapes (ID, Grape, Color) VALUES (3, 'Syrah', 'Red');
INSERT INTO appellations (No, Appelation, County, State, Area, isAVA) VALUES (1, 'Napa', 'Napa', 'CA', 'North Coast', 'Yes');
INSERT INTO appellations (No, Appelation, County, State, Area, isAVA) VALUES (2, 'Sonoma', 'Sonoma', 'CA', 'Napa', 'Yes');
INSERT INTO appellations (No, Appelation, County, State, Area, isAVA) VALUES (3, 'Carneros', 'Napa', 'CA', 'Sonoma', 'Yes');
INSERT INTO appellations (No, Appelation, County, State, Area, isAVA) VALUES (4, 'Rutherford', 'Napa', 'CA', 'Napa', 'Yes');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Napa', 'Merlot', 99, 'WineryA', 'CA', 'Wine1', 2010, 50, 90, 100, 'Now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Napa', 'Merlot', 99, 'WineryB', 'CA', 'Wine2', 2015, 60, 92, 200, 'Now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Sonoma', 'Chardonnay', 88, 'WineryC', 'CA', 'Wine3', 2018, 40, 88, 150, 'Now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Sonoma', 'Chardonnay', 88, 'WineryD', 'CA', 'Wine4', 2019, 45, 89, 120, 'Now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Sonoma', 'Chardonnay', 88, 'WineryE', 'CA', 'Wine5', 2020, 55, 91, 130, 'Now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Carneros', 'Syrah', 1, 'WineryF', 'CA', 'Wine6', 2017, 70, 94, 80, 'Now');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT appelation AS area FROM (SELECT appelation, grape, n, appelation_other, county, state, isava, NO, appelation AS area FROM (SELECT appelation, grape, n, appelation_other, county, state, isava, n AS NO FROM (SELECT LHS.appelation AS appelation, LHS.grape AS grape, LHS.n AS n, RHS.appelation AS appelation_other, RHS.county AS county, RHS.state AS state, RHS.isava AS isava FROM (SELECT appelation, grape, COUNT(*) AS n FROM wine GROUP BY appelation, grape) AS LHS INNER JOIN appellations AS RHS ON (LHS.n = RHS.no AND LHS.appelation = RHS.area)))) WHERE (n <> 2010) ORDER BY area;

/*
Gold Result:
('Napa',)
('Sonoma',)
*/

-- Prediction Query
SELECT T1.Area FROM APPELLATIONS AS T1 JOIN WINE AS T2 ON T1.Appelation = T2.Appelation GROUP BY T2.Appelation HAVING T2.year < 2010 ORDER BY COUNT(*) DESC, T1.Area NULLS LAST LIMIT 1;

/*
Prediction Result:
*/