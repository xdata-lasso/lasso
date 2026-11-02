-- Schema DDL
CREATE TABLE "grapes" ("ID" INTEGER PRIMARY KEY, "Grape" TEXT UNIQUE, "Color" TEXT);

CREATE TABLE "appellations" ("No" INTEGER PRIMARY KEY, "Appelation" TEXT UNIQUE, "County" TEXT, "State" TEXT, "Area" TEXT, "isAVA" TEXT);

CREATE TABLE "wine" ("Appelation" TEXT, "Grape" TEXT, "No" INTEGER, "Winery" TEXT, "State" TEXT, "Name" TEXT, "Year" INTEGER, "Price" INTEGER, "Score" INTEGER, "Cases" INTEGER, "Drink" TEXT, FOREIGN KEY ("Appelation") REFERENCES "appellations" ("Appelation"), FOREIGN KEY ("Grape") REFERENCES "grapes" ("Grape"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO grapes (ID, Grape, Color) VALUES (1, 'Cabernet Sauvignon', 'Red');
INSERT INTO grapes (ID, Grape, Color) VALUES (2, 'Chardonnay', 'White');
INSERT INTO appellations (No, Appelation, County, State, Area, isAVA) VALUES (1, 'Napa Valley', 'Napa', 'California', 'North Coast', 'Yes');
INSERT INTO appellations (No, Appelation, County, State, Area, isAVA) VALUES (2, 'Sonoma Coast', 'Sonoma', 'California', 'North Coast', 'Yes');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Napa Valley', 'Cabernet Sauvignon', 10, 'Apex Cellars', 'California', 'Zeta Reserve', 2008, 75, 92, 500, 'now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Sonoma Coast', 'Chardonnay', 20, 'Beacon Hill', 'California', 'Alpha Cuvee', 2008, 45, 90, 1200, 'now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Napa Valley', 'Cabernet Sauvignon', 30, 'Crest Winery', 'California', 'Alpha Cuvee', 2008, 60, 94, 800, '2025');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Sonoma Coast', 'Chardonnay', 40, 'Dawn Estate', 'California', 'Beta Blanc', 2008, 35, 88, 300, 'now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Napa Valley', 'Cabernet Sauvignon', 2008, 'Echo Vineyards', 'California', 'Wrong Year 2007', 2007, 2008, 91, 2008, 'now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Sonoma Coast', 'Chardonnay', 50, 'Frost Winery', 'California', 'Wrong Year 2009', 2009, 50, 2008, 400, '2026');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Napa Valley', 'Cabernet Sauvignon', 60, 'Ghost Vines', 'California', 'Null Year Wine', NULL, 55, 89, 600, 'now');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM wine WHERE (YEAR = 2008) ORDER BY name, wine.appelation NULLS LAST, wine.grape NULLS LAST, wine.no NULLS LAST, wine.winery NULLS LAST, wine.state NULLS LAST, wine.year NULLS LAST, wine.price NULLS LAST, wine.score NULLS LAST, wine.cases NULLS LAST, wine.drink NULLS LAST;

/*
Gold Result:
('Alpha Cuvee',)
('Alpha Cuvee',)
('Beta Blanc',)
('Zeta Reserve',)
*/

-- Prediction Query
SELECT Name FROM WINE WHERE YEAR = '2008';

/*
Prediction Result:
('Zeta Reserve',)
('Alpha Cuvee',)
('Alpha Cuvee',)
('Beta Blanc',)
*/