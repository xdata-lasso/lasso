-- Schema DDL
CREATE TABLE "grapes" ("ID" INTEGER PRIMARY KEY, "Grape" TEXT UNIQUE, "Color" TEXT);

CREATE TABLE "appellations" ("No" INTEGER PRIMARY KEY, "Appelation" TEXT UNIQUE, "County" TEXT, "State" TEXT, "Area" TEXT, "isAVA" TEXT);

CREATE TABLE "wine" ("Appelation" TEXT, "Grape" TEXT, "No" INTEGER, "Winery" TEXT, "State" TEXT, "Name" TEXT, "Year" INTEGER, "Price" INTEGER, "Score" INTEGER, "Cases" INTEGER, "Drink" TEXT, FOREIGN KEY ("Appelation") REFERENCES "appellations" ("Appelation"), FOREIGN KEY ("Grape") REFERENCES "grapes" ("Grape"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO grapes ("ID", "Grape", "Color") VALUES (1, 'Chardonnay', 'White');
INSERT INTO appellations ("No", "Appelation", "County", "State", "Area", "isAVA") VALUES (1, 'Sonoma', 'Sonoma', 'California', 'North Coast', 'Yes');
INSERT INTO wine ("Appelation", "Grape", "No", "Winery", "State", "Name", "Year", "Price", "Score", "Cases", "Drink") VALUES ('Sonoma', 'Chardonnay', 10, 'WineryZ', 'California', 'Zinfandel Reserve', 2008, 30, 95, 300, 'Now');
INSERT INTO wine ("Appelation", "Grape", "No", "Winery", "State", "Name", "Year", "Price", "Score", "Cases", "Drink") VALUES ('Sonoma', 'Chardonnay', 20, 'WineryA', 'California', 'Albarino Special', 2008, 80, 85, 800, 'Hold');
INSERT INTO wine ("Appelation", "Grape", "No", "Winery", "State", "Name", "Year", "Price", "Score", "Cases", "Drink") VALUES ('Sonoma', 'Chardonnay', 15, 'WineryM', 'California', 'Albarino Special', 2008, 50, 90, 500, 'Now');
INSERT INTO wine ("Appelation", "Grape", "No", "Winery", "State", "Name", "Year", "Price", "Score", "Cases", "Drink") VALUES ('Sonoma', 'Chardonnay', 30, 'WineryN', 'California', NULL, 2008, 40, 88, 400, 'Now');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM wine WHERE (YEAR = 2008) ORDER BY name, wine.appelation NULLS LAST, wine.grape NULLS LAST, wine.no NULLS LAST, wine.winery NULLS LAST, wine.state NULLS LAST, wine.year NULLS LAST, wine.price NULLS LAST, wine.score NULLS LAST, wine.cases NULLS LAST, wine.drink NULLS LAST;

/*
Gold Result:
(None,)
('Albarino Special',)
('Albarino Special',)
('Zinfandel Reserve',)
*/

-- Prediction Query
SELECT Name FROM WINE WHERE YEAR = '2008';

/*
Prediction Result:
('Zinfandel Reserve',)
('Albarino Special',)
('Albarino Special',)
(None,)
*/