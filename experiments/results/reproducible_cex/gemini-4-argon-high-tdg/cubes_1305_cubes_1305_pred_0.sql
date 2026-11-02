-- Schema DDL
CREATE TABLE "grapes" ("ID" INTEGER PRIMARY KEY, "Grape" TEXT UNIQUE, "Color" TEXT);

CREATE TABLE "appellations" ("No" INTEGER PRIMARY KEY, "Appelation" TEXT UNIQUE, "County" TEXT, "State" TEXT, "Area" TEXT, "isAVA" TEXT);

CREATE TABLE "wine" ("Appelation" TEXT, "Grape" TEXT, "No" INTEGER, "Winery" TEXT, "State" TEXT, "Name" TEXT, "Year" INTEGER, "Price" INTEGER, "Score" INTEGER, "Cases" INTEGER, "Drink" TEXT, FOREIGN KEY ("Appelation") REFERENCES "appellations" ("Appelation"), FOREIGN KEY ("Grape") REFERENCES "grapes" ("Grape"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO grapes (ID, Grape, Color) VALUES (1, 'Chardonnay', 'White');
INSERT INTO grapes (ID, Grape, Color) VALUES (2, 'Merlot', 'Red');
INSERT INTO grapes (ID, Grape, Color) VALUES (3, 'Zinfandel', 'Red');
INSERT INTO grapes (ID, Grape, Color) VALUES (4, 'Syrah', 'Red');
INSERT INTO appellations (No, Appelation, County, State, Area, isAVA) VALUES (1, 'A_App', 'A_County', 'A_State', 'Gamma', 'No');
INSERT INTO appellations (No, Appelation, County, State, Area, isAVA) VALUES (2, 'M_App', 'M_County', 'M_State', 'Beta', 'Yes');
INSERT INTO appellations (No, Appelation, County, State, Area, isAVA) VALUES (3, 'Z_App', 'Z_County', 'Z_State', 'Alpha', 'Yes');
INSERT INTO appellations (No, Appelation, County, State, Area, isAVA) VALUES (4, 'Gamma', 'G_County', 'G_State', 'UnmatchedArea1', 'No');
INSERT INTO appellations (No, Appelation, County, State, Area, isAVA) VALUES (5, 'Beta', 'B_County', 'B_State', 'UnmatchedArea2', 'Yes');
INSERT INTO appellations (No, Appelation, County, State, Area, isAVA) VALUES (6, 'Alpha', 'Al_County', 'Al_State', 'UnmatchedArea3', 'No');
INSERT INTO appellations (No, Appelation, County, State, Area, isAVA) VALUES (7, 'DecoyApp', 'D_County', 'D_State', 'DiffArea', 'No');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Gamma', 'Chardonnay', 10, 'Winery1', 'CA', 'Wine1', 2015, 30, 90, 100, 'Now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Beta', 'Merlot', 20, 'Winery2', 'OR', 'Wine2', 2016, 40, 91, 200, 'Now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Beta', 'Merlot', 21, 'Winery3', 'OR', 'Wine3', 2017, 45, 92, 250, 'Hold');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Alpha', 'Zinfandel', 30, 'Winery4', 'WA', 'Wine4', 2018, 50, 93, 300, 'Now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Alpha', 'Zinfandel', 31, 'Winery5', 'WA', 'Wine5', 2019, 55, 94, 350, 'Hold');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Alpha', 'Zinfandel', 32, 'Winery6', 'WA', 'Wine6', 2020, 60, 95, 400, 'Now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('A_App', 'Syrah', 40, 'Winery7', 'CA', 'Wine7', 2014, 25, 88, 150, 'Now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('DecoyApp', 'Syrah', 50, 'Winery8', 'CA', 'Wine8', 2013, 35, 89, 120, 'Now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('DecoyApp', 'Syrah', 51, 'Winery9', 'CA', 'Wine9', 2012, 38, 87, 130, 'Hold');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT appelation AS area FROM (SELECT appelation, grape, n, appelation_other, county, state, isava, NO, appelation AS area FROM (SELECT appelation, grape, n, appelation_other, county, state, isava, n AS NO FROM (SELECT LHS.appelation AS appelation, LHS.grape AS grape, LHS.n AS n, RHS.appelation AS appelation_other, RHS.county AS county, RHS.state AS state, RHS.isava AS isava FROM (SELECT appelation, grape, COUNT(*) AS n FROM wine GROUP BY appelation, grape) AS LHS INNER JOIN appellations AS RHS ON (LHS.n = RHS.no AND LHS.appelation = RHS.area)))) WHERE (n <> 2010) ORDER BY area;

/*
Gold Result:
('Alpha',)
('Beta',)
('Gamma',)
*/

-- Prediction Query
SELECT T1.Area FROM APPELLATIONS AS T1 JOIN WINE AS T2 ON T1.Appelation = T2.Appelation GROUP BY T2.Appelation HAVING T2.year < 2010 ORDER BY COUNT(*) DESC, T1.Area NULLS LAST LIMIT 1;

/*
Prediction Result:
*/