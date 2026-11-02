-- Schema DDL
CREATE TABLE "grapes" ("ID" INTEGER PRIMARY KEY, "Grape" TEXT UNIQUE, "Color" TEXT);

CREATE TABLE "appellations" ("No" INTEGER PRIMARY KEY, "Appelation" TEXT UNIQUE, "County" TEXT, "State" TEXT, "Area" TEXT, "isAVA" TEXT);

CREATE TABLE "wine" ("Appelation" TEXT, "Grape" TEXT, "No" INTEGER, "Winery" TEXT, "State" TEXT, "Name" TEXT, "Year" INTEGER, "Price" INTEGER, "Score" INTEGER, "Cases" INTEGER, "Drink" TEXT, FOREIGN KEY ("Appelation") REFERENCES "appellations" ("Appelation"), FOREIGN KEY ("Grape") REFERENCES "grapes" ("Grape"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "grapes" ("ID", "Grape", "Color") VALUES (1, 'Chardonnay', 'White');
INSERT INTO "grapes" ("ID", "Grape", "Color") VALUES (2, 'Cabernet', 'Red');
INSERT INTO "appellations" ("No", "Appelation", "County", "State", "Area", "isAVA") VALUES (1, 'Napa Valley', 'Napa', 'California', 'North Coast', 'Yes');
INSERT INTO "appellations" ("No", "Appelation", "County", "State", "Area", "isAVA") VALUES (2, 'Sonoma', 'Sonoma', 'California', 'North Coast', 'Yes');
INSERT INTO "wine" ("Appelation", "Grape", "No", "Winery", "State", "Name", "Year", "Price", "Score", "Cases", "Drink") VALUES ('Napa Valley', 'Cabernet', 101, 'Winery Z', 'California', 'Zeta', 2015, 50, 92, 500, 'Now');
INSERT INTO "wine" ("Appelation", "Grape", "No", "Winery", "State", "Name", "Year", "Price", "Score", "Cases", "Drink") VALUES ('Sonoma', 'Chardonnay', 102, 'Winery A', 'California', 'Alpha', 2018, 30, 88, 1200, '2025');
INSERT INTO "wine" ("Appelation", "Grape", "No", "Winery", "State", "Name", "Year", "Price", "Score", "Cases", "Drink") VALUES ('Napa Valley', 'Chardonnay', 103, 'Winery M', 'California', 'Alpha', 2019, 35, 90, 800, 'Now');
INSERT INTO "wine" ("Appelation", "Grape", "No", "Winery", "State", "Name", "Year", "Price", "Score", "Cases", "Drink") VALUES ('Sonoma', 'Cabernet', 104, 'Winery B', 'California', 'Beta', 2016, 60, 95, 300, 'Hold');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT name FROM wine ORDER BY name;

/*
Gold Result:
('Alpha',)
('Beta',)
('Zeta',)
*/

-- Prediction Query
SELECT DISTINCT Name FROM WINE ORDER BY price, Name NULLS LAST;

/*
Prediction Result:
('Alpha',)
('Zeta',)
('Beta',)
*/