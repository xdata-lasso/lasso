-- Schema DDL
CREATE TABLE "grapes" ("ID" INTEGER PRIMARY KEY, "Grape" TEXT UNIQUE, "Color" TEXT);

CREATE TABLE "appellations" ("No" INTEGER PRIMARY KEY, "Appelation" TEXT UNIQUE, "County" TEXT, "State" TEXT, "Area" TEXT, "isAVA" TEXT);

CREATE TABLE "wine" ("Appelation" TEXT, "Grape" TEXT, "No" INTEGER, "Winery" TEXT, "State" TEXT, "Name" TEXT, "Year" INTEGER, "Price" INTEGER, "Score" INTEGER, "Cases" INTEGER, "Drink" TEXT, FOREIGN KEY ("Appelation") REFERENCES "appellations" ("Appelation"), FOREIGN KEY ("Grape") REFERENCES "grapes" ("Grape"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. Unreferenced rows in `grapes` (kills mutants joining `grapes` without INNER JOIN or grouping by `grapes.Grape`).
-- 2. Ties in `COUNT(*)` with alphabetical ordering on `grape` (kills DESC ordering or missing secondary sort).
-- 3. `NULL` values in `wine.Grape` (kills `COUNT(Grape)` vs `COUNT(*)`, `WHERE Grape IS NOT NULL`, and `NULLS FIRST` vs `NULLS LAST` when tied on count).
-- 4. Duplicate values in other `wine` columns (kills `COUNT(DISTINCT ...)` mutants).
INSERT INTO "grapes" ("ID", "Grape", "Color") VALUES (1, 'Chardonnay', 'White');
INSERT INTO "grapes" ("ID", "Grape", "Color") VALUES (2, 'Merlot', 'Red');
INSERT INTO "grapes" ("ID", "Grape", "Color") VALUES (3, 'Pinot Noir', 'Red');
INSERT INTO "grapes" ("ID", "Grape", "Color") VALUES (4, 'Zinfandel', 'Red');
INSERT INTO "appellations" ("No", "Appelation", "County", "State", "Area", "isAVA") VALUES (1, 'Napa Valley', 'Napa', 'California', 'North Coast', 'Yes');
INSERT INTO "wine" ("Appelation", "Grape", "No", "Winery", "State", "Name", "Year", "Price", "Score", "Cases", "Drink") VALUES ('Napa Valley', 'Merlot', 1, 'Winery A', 'California', 'Wine A', 2020, 50, 90, 100, 'Now');
INSERT INTO "wine" ("Appelation", "Grape", "No", "Winery", "State", "Name", "Year", "Price", "Score", "Cases", "Drink") VALUES ('Napa Valley', 'Chardonnay', 2, 'Winery A', 'California', 'Wine A', 2020, 50, 90, 100, 'Now');
INSERT INTO "wine" ("Appelation", "Grape", "No", "Winery", "State", "Name", "Year", "Price", "Score", "Cases", "Drink") VALUES ('Napa Valley', NULL, 3, 'Winery A', 'California', 'Wine A', 2020, 50, 90, 100, 'Now');
INSERT INTO "wine" ("Appelation", "Grape", "No", "Winery", "State", "Name", "Year", "Price", "Score", "Cases", "Drink") VALUES ('Napa Valley', 'Pinot Noir', 4, 'Winery A', 'California', 'Wine A', 2020, 50, 90, 100, 'Now');
INSERT INTO "wine" ("Appelation", "Grape", "No", "Winery", "State", "Name", "Year", "Price", "Score", "Cases", "Drink") VALUES ('Napa Valley', 'Pinot Noir', 4, 'Winery A', 'California', 'Wine A', 2020, 50, 90, 100, 'Now');
INSERT INTO "wine" ("Appelation", "Grape", "No", "Winery", "State", "Name", "Year", "Price", "Score", "Cases", "Drink") VALUES ('Napa Valley', 'Pinot Noir', 4, 'Winery A', 'California', 'Wine A', 2020, 50, 90, 100, 'Now');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, grape FROM (SELECT grape, COUNT(*) AS n FROM wine GROUP BY grape) ORDER BY count___, grape NULLS LAST;

/*
Gold Result:
(1, 'Chardonnay')
(1, 'Merlot')
(1, None)
(3, 'Pinot Noir')
*/

-- Prediction Query
SELECT COUNT(*), Grape FROM WINE GROUP BY Grape;

/*
Prediction Result:
(1, None)
(1, 'Chardonnay')
(1, 'Merlot')
(3, 'Pinot Noir')
*/