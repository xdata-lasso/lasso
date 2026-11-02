-- Schema DDL
CREATE TABLE "grapes" ("ID" INTEGER PRIMARY KEY, "Grape" TEXT UNIQUE, "Color" TEXT);

CREATE TABLE "appellations" ("No" INTEGER PRIMARY KEY, "Appelation" TEXT UNIQUE, "County" TEXT, "State" TEXT, "Area" TEXT, "isAVA" TEXT);

CREATE TABLE "wine" ("Appelation" TEXT, "Grape" TEXT, "No" INTEGER, "Winery" TEXT, "State" TEXT, "Name" TEXT, "Year" INTEGER, "Price" INTEGER, "Score" INTEGER, "Cases" INTEGER, "Drink" TEXT, FOREIGN KEY ("Appelation") REFERENCES "appellations" ("Appelation"), FOREIGN KEY ("Grape") REFERENCES "grapes" ("Grape"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests WHERE boundary conditions (score: 92, 93, 94, 95, NULL) and primary ORDER BY (grape) including NULLs
INSERT INTO grapes (ID, Grape, Color) VALUES (1, 'Chardonnay', 'White');
INSERT INTO grapes (ID, Grape, Color) VALUES (2, 'Merlot', 'Red');
INSERT INTO grapes (ID, Grape, Color) VALUES (3, 'Pinot Noir', 'Red');
INSERT INTO appellations (No, Appelation, County, State, Area, isAVA) VALUES (1, 'Napa Valley', 'Napa', 'CA', 'North Coast', 'Yes');
INSERT INTO appellations (No, Appelation, County, State, Area, isAVA) VALUES (2, 'Sonoma Coast', 'Sonoma', 'CA', 'North Coast', 'Yes');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Napa Valley', 'Pinot Noir', 1, 'Winery A', 'CA', 'Wine 92', 2018, 50, 92, 100, 'now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Napa Valley', 'Pinot Noir', 2, 'Winery B', 'CA', 'Wine 93', 2018, 55, 93, 100, 'now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Napa Valley', 'Merlot', 3, 'Winery C', 'CA', 'Wine 94', 2018, 60, 94, 100, 'now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Sonoma Coast', 'Chardonnay', 4, 'Winery D', 'CA', 'Wine 95', 2019, 65, 95, 200, 'now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Sonoma Coast', NULL, 5, 'Winery E', 'CA', 'Wine Null Grape', 2020, 70, 96, 300, 'now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Napa Valley', 'Chardonnay', 6, 'Winery F', 'CA', 'Wine Null Score', 2020, 75, NULL, 300, 'now');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT grape, appelation, name FROM wine WHERE (score > 93) ORDER BY grape, wine.appelation NULLS LAST, wine.no NULLS LAST, wine.winery NULLS LAST, wine.state NULLS LAST, wine.name NULLS LAST, wine.year NULLS LAST, wine.price NULLS LAST, wine.score NULLS LAST, wine.cases NULLS LAST, wine.drink NULLS LAST;

/*
Gold Result:
(None, 'Sonoma Coast', 'Wine Null Grape')
('Chardonnay', 'Sonoma Coast', 'Wine 95')
('Merlot', 'Napa Valley', 'Wine 94')
*/

-- Prediction Query
SELECT Grape, Appelation, Name FROM WINE WHERE Score > 93 ORDER BY Name, WINE.appelation NULLS LAST, WINE.grape NULLS LAST, WINE.no NULLS LAST, WINE.winery NULLS LAST, WINE.state NULLS LAST, WINE.year NULLS LAST, WINE.price NULLS LAST, WINE.score NULLS LAST, WINE.cases NULLS LAST, WINE.drink NULLS LAST;

/*
Prediction Result:
('Merlot', 'Napa Valley', 'Wine 94')
('Chardonnay', 'Sonoma Coast', 'Wine 95')
(None, 'Sonoma Coast', 'Wine Null Grape')
*/