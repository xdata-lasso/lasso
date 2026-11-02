-- Schema DDL
CREATE TABLE "grapes" ("ID" INTEGER PRIMARY KEY, "Grape" TEXT UNIQUE, "Color" TEXT);

CREATE TABLE "appellations" ("No" INTEGER PRIMARY KEY, "Appelation" TEXT UNIQUE, "County" TEXT, "State" TEXT, "Area" TEXT, "isAVA" TEXT);

CREATE TABLE "wine" ("Appelation" TEXT, "Grape" TEXT, "No" INTEGER, "Winery" TEXT, "State" TEXT, "Name" TEXT, "Year" INTEGER, "Price" INTEGER, "Score" INTEGER, "Cases" INTEGER, "Drink" TEXT, FOREIGN KEY ("Appelation") REFERENCES "appellations" ("Appelation"), FOREIGN KEY ("Grape") REFERENCES "grapes" ("Grape"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "grapes" ("ID", "Grape", "Color") VALUES (1, 'Chardonnay', 'White');
INSERT INTO "grapes" ("ID", "Grape", "Color") VALUES (2, 'Zinfandel', 'Red');
INSERT INTO "appellations" ("No", "Appelation", "County", "State", "Area", "isAVA") VALUES (1, 'Russian River Valley', 'Sonoma', 'California', 'North Coast', 'Yes');
INSERT INTO "appellations" ("No", "Appelation", "County", "State", "Area", "isAVA") VALUES (2, 'Carmel Valley', 'Monterey', 'California', 'Central Coast', 'Yes');
INSERT INTO "appellations" ("No", "Appelation", "County", "State", "Area", "isAVA") VALUES (3, 'Livermore Valley', 'Alameda', 'California', 'Central Coast', 'No');
INSERT INTO "appellations" ("No", "Appelation", "County", "State", "Area", "isAVA") VALUES (4, 'Ben Lomond Mountain', 'Santa Cruz', 'California', 'Central Coast', 'Yes');
INSERT INTO "appellations" ("No", "Appelation", "County", "State", "Area", "isAVA") VALUES (5, 'Green Valley', 'Sonoma', 'California', 'North Coast', 'No');
INSERT INTO "appellations" ("No", "Appelation", "County", "State", "Area", "isAVA") VALUES (6, 'Rutherford', 'Napa', 'California', 'North Coast', 'Yes');
INSERT INTO "wine" ("Appelation", "Grape", "No", "Winery", "State", "Name", "Year", "Price", "Score", "Cases", "Drink") VALUES ('Russian River Valley', 'Chardonnay', 99, 'Winery A', 'California', 'Reserve', 2018, 45, 92, 500, 'now');
INSERT INTO "wine" ("Appelation", "Grape", "No", "Winery", "State", "Name", "Year", "Price", "Score", "Cases", "Drink") VALUES ('Russian River Valley', 'Zinfandel', 100, 'Winery B', 'California', 'Old Vine', 2019, 35, 90, 300, '2025');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT area, county FROM appellations ORDER BY area, appellations.no NULLS LAST;

/*
Gold Result:
('Central Coast', 'Monterey')
('Central Coast', 'Alameda')
('Central Coast', 'Santa Cruz')
('North Coast', 'Sonoma')
('North Coast', 'Sonoma')
('North Coast', 'Napa')
*/

-- Prediction Query
SELECT Area, County FROM APPELLATIONS;

/*
Prediction Result:
('North Coast', 'Sonoma')
('Central Coast', 'Monterey')
('Central Coast', 'Alameda')
('Central Coast', 'Santa Cruz')
('North Coast', 'Sonoma')
('North Coast', 'Napa')
*/