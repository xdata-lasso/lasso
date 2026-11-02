-- Schema DDL
CREATE TABLE "grapes" ("ID" INTEGER PRIMARY KEY, "Grape" TEXT UNIQUE, "Color" TEXT);

CREATE TABLE "appellations" ("No" INTEGER PRIMARY KEY, "Appelation" TEXT UNIQUE, "County" TEXT, "State" TEXT, "Area" TEXT, "isAVA" TEXT);

CREATE TABLE "wine" ("Appelation" TEXT, "Grape" TEXT, "No" INTEGER, "Winery" TEXT, "State" TEXT, "Name" TEXT, "Year" INTEGER, "Price" INTEGER, "Score" INTEGER, "Cases" INTEGER, "Drink" TEXT, FOREIGN KEY ("Appelation") REFERENCES "appellations" ("Appelation"), FOREIGN KEY ("Grape") REFERENCES "grapes" ("Grape"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering by Area (ASC), secondary tie-breaking by No (ASC), and duplicate output rows (DISTINCT vs ALL).
INSERT INTO "appellations" ("No", "Appelation", "County", "State", "Area", "isAVA") VALUES (3, 'App1', 'Sonoma', 'CA', 'North Coast', 'Yes');
INSERT INTO "appellations" ("No", "Appelation", "County", "State", "Area", "isAVA") VALUES (1, 'App2', 'Napa', 'CA', 'North Coast', 'Yes');
INSERT INTO "appellations" ("No", "Appelation", "County", "State", "Area", "isAVA") VALUES (2, 'App3', 'Monterey', 'CA', 'Central Coast', 'No');
INSERT INTO "appellations" ("No", "Appelation", "County", "State", "Area", "isAVA") VALUES (4, 'App4', 'Napa', 'CA', 'North Coast', 'No');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT area, county FROM appellations ORDER BY area, appellations.no NULLS LAST;

/*
Gold Result:
('Central Coast', 'Monterey')
('North Coast', 'Napa')
('North Coast', 'Sonoma')
('North Coast', 'Napa')
*/

-- Prediction Query
SELECT Area, County FROM APPELLATIONS;

/*
Prediction Result:
('North Coast', 'Napa')
('Central Coast', 'Monterey')
('North Coast', 'Sonoma')
('North Coast', 'Napa')
*/