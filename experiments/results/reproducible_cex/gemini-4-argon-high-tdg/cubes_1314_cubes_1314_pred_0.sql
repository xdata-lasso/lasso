-- Schema DDL
CREATE TABLE "grapes" ("ID" INTEGER PRIMARY KEY, "Grape" TEXT UNIQUE, "Color" TEXT);

CREATE TABLE "appellations" ("No" INTEGER PRIMARY KEY, "Appelation" TEXT UNIQUE, "County" TEXT, "State" TEXT, "Area" TEXT, "isAVA" TEXT);

CREATE TABLE "wine" ("Appelation" TEXT, "Grape" TEXT, "No" INTEGER, "Winery" TEXT, "State" TEXT, "Name" TEXT, "Year" INTEGER, "Price" INTEGER, "Score" INTEGER, "Cases" INTEGER, "Drink" TEXT, FOREIGN KEY ("Appelation") REFERENCES "appellations" ("Appelation"), FOREIGN KEY ("Grape") REFERENCES "grapes" ("Grape"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO grapes (ID, Grape, Color) VALUES (1, 'Cabernet Sauvignon', 'Red');
INSERT INTO grapes (ID, Grape, Color) VALUES (2, 'Zinfandel', 'Red');
INSERT INTO appellations (No, Appelation, County, State, Area, isAVA) VALUES (1, 'Rutherford', 'Napa', 'California', 'North Coast', 'Yes');
INSERT INTO appellations (No, Appelation, County, State, Area, isAVA) VALUES (2, 'Oakville', 'Napa', 'California', 'North Coast', 'Yes');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Rutherford', 'Cabernet Sauvignon', 1, 'Oak Ridge', 'California', 'Lot 1', 2016, 150, 92, 100, 'Now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Rutherford', 'Cabernet Sauvignon', 2, 'Oak Ridge', 'California', 'Lot 2', 2016, 180, 94, 120, 'Hold');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Oakville', 'Cabernet Sauvignon', 3, 'Apex Winery', 'California', 'Crown', 2019, 120, 90, 80, 'Now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Oakville', 'Zinfandel', 4, 'Barton Cellars', 'California', 'Old Vine', 2014, 110, 88, 60, 'Now');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT grape, winery, YEAR FROM wine WHERE (price > 100) ORDER BY grape, wine.appelation NULLS LAST, wine.no NULLS LAST, wine.winery NULLS LAST, wine.state NULLS LAST, wine.name NULLS LAST, wine.year NULLS LAST, wine.price NULLS LAST, wine.score NULLS LAST, wine.cases NULLS LAST, wine.drink NULLS LAST;

/*
Gold Result:
('Cabernet Sauvignon', 'Apex Winery', 2019)
('Cabernet Sauvignon', 'Oak Ridge', 2016)
('Cabernet Sauvignon', 'Oak Ridge', 2016)
('Zinfandel', 'Barton Cellars', 2014)
*/

-- Prediction Query
SELECT Grape, Winery, YEAR FROM WINE WHERE Price > 100 ORDER BY YEAR, WINE.appelation NULLS LAST, WINE.grape NULLS LAST, WINE.no NULLS LAST, WINE.winery NULLS LAST, WINE.state NULLS LAST, WINE.name NULLS LAST, WINE.price NULLS LAST, WINE.score NULLS LAST, WINE.cases NULLS LAST, WINE.drink NULLS LAST;

/*
Prediction Result:
('Zinfandel', 'Barton Cellars', 2014)
('Cabernet Sauvignon', 'Oak Ridge', 2016)
('Cabernet Sauvignon', 'Oak Ridge', 2016)
('Cabernet Sauvignon', 'Apex Winery', 2019)
*/