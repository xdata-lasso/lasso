-- Schema DDL
CREATE TABLE "grapes" ("ID" INTEGER PRIMARY KEY, "Grape" TEXT UNIQUE, "Color" TEXT);

CREATE TABLE "appellations" ("No" INTEGER PRIMARY KEY, "Appelation" TEXT UNIQUE, "County" TEXT, "State" TEXT, "Area" TEXT, "isAVA" TEXT);

CREATE TABLE "wine" ("Appelation" TEXT, "Grape" TEXT, "No" INTEGER, "Winery" TEXT, "State" TEXT, "Name" TEXT, "Year" INTEGER, "Price" INTEGER, "Score" INTEGER, "Cases" INTEGER, "Drink" TEXT, FOREIGN KEY ("Appelation") REFERENCES "appellations" ("Appelation"), FOREIGN KEY ("Grape") REFERENCES "grapes" ("Grape"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO grapes (ID, Grape, Color) VALUES (1, 'Merlot', 'Red');
INSERT INTO appellations (No, Appelation, County, State, Area, isAVA) VALUES (1, 'Napa Valley', 'Napa', 'CA', 'North Coast', 'Yes');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Napa Valley', 'Merlot', 1, 'Winery_D', 'CA', 'Wine 1', 2018, 49, 90, 500, 'now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Napa Valley', 'Merlot', 2, 'Winery_C', 'CA', 'Wine 2', 2018, 50, 91, 500, 'now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Napa Valley', 'Merlot', 3, 'Winery_B', 'CA', 'Wine 3', 2018, 75, 92, 500, 'now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Napa Valley', 'Merlot', 4, 'Winery_A', 'CA', 'Wine 4', 2018, 100, 93, 500, 'now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Napa Valley', 'Merlot', 5, 'Winery_E', 'CA', 'Wine 5', 2018, 101, 94, 500, 'now');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT winery FROM wine WHERE (price >= 50 AND price <= 100) ORDER BY winery;

/*
Gold Result:
('Winery_A',)
('Winery_B',)
('Winery_C',)
*/

-- Prediction Query
SELECT DISTINCT Winery FROM WINE WHERE Price BETWEEN 50 AND 100;

/*
Prediction Result:
('Winery_C',)
('Winery_B',)
('Winery_A',)
*/