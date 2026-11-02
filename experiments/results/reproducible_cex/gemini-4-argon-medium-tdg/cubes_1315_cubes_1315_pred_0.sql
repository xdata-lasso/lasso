-- Schema DDL
CREATE TABLE "grapes" ("ID" INTEGER PRIMARY KEY, "Grape" TEXT UNIQUE, "Color" TEXT);

CREATE TABLE "appellations" ("No" INTEGER PRIMARY KEY, "Appelation" TEXT UNIQUE, "County" TEXT, "State" TEXT, "Area" TEXT, "isAVA" TEXT);

CREATE TABLE "wine" ("Appelation" TEXT, "Grape" TEXT, "No" INTEGER, "Winery" TEXT, "State" TEXT, "Name" TEXT, "Year" INTEGER, "Price" INTEGER, "Score" INTEGER, "Cases" INTEGER, "Drink" TEXT, FOREIGN KEY ("Appelation") REFERENCES "appellations" ("Appelation"), FOREIGN KEY ("Grape") REFERENCES "grapes" ("Grape"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests MIN vs MAX aggregation, DISTINCT requirement, ORDER BY direction, and strict inequality (< vs <=)
INSERT INTO "grapes" ("ID", "Grape", "Color") VALUES (1, 'Syrah', 'Red');
INSERT INTO "appellations" ("No", "Appelation", "County", "State", "Area", "isAVA") VALUES (1, 'Napa Valley', 'Napa', 'California', 'North Coast', 'Yes');
INSERT INTO "wine" ("Appelation", "Grape", "No", "Winery", "State", "Name", "Year", "Price", "Score", "Cases", "Drink") VALUES ('Napa Valley', 'Syrah', 1, 'John Anthony', 'California', 'JA Cheap', 2010, 50, 90, 500, 'now');
INSERT INTO "wine" ("Appelation", "Grape", "No", "Winery", "State", "Name", "Year", "Price", "Score", "Cases", "Drink") VALUES ('Napa Valley', 'Syrah', 2, 'John Anthony', 'California', 'JA Expensive', 2012, 100, 95, 200, 'now');
INSERT INTO "wine" ("Appelation", "Grape", "No", "Winery", "State", "Name", "Year", "Price", "Score", "Cases", "Drink") VALUES ('Napa Valley', 'Syrah', 3, 'Other Winery', 'California', 'Wine Z', 2011, 75, 88, 300, 'now');
INSERT INTO "wine" ("Appelation", "Grape", "No", "Winery", "State", "Name", "Year", "Price", "Score", "Cases", "Drink") VALUES ('Napa Valley', 'Syrah', 4, 'Other Winery', 'California', 'Wine A', 2013, 120, 92, 400, 'now');
INSERT INTO "wine" ("Appelation", "Grape", "No", "Winery", "State", "Name", "Year", "Price", "Score", "Cases", "Drink") VALUES ('Napa Valley', 'Syrah', 5, 'Other Winery', 'California', 'Wine Equal', 2014, 50, 85, 600, 'now');
INSERT INTO "wine" ("Appelation", "Grape", "No", "Winery", "State", "Name", "Year", "Price", "Score", "Cases", "Drink") VALUES ('Napa Valley', 'Syrah', 6, 'Other Winery', 'California', 'Wine Cheaper', 2015, 30, 80, 700, 'now');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "name_other" AS "name" FROM (SELECT * FROM (SELECT "LHS"."no" AS "no", "LHS"."grape" AS "grape", "LHS"."winery" AS "winery", "LHS"."appelation" AS "appelation", "LHS"."state" AS "state", "LHS"."name" AS "name", "LHS"."year" AS "year", "LHS"."price" AS "price", "LHS"."score" AS "score", "LHS"."cases" AS "cases", "LHS"."drink" AS "drink", "RHS"."no" AS "no_other", "RHS"."grape" AS "grape_other", "RHS"."winery" AS "winery_other", "RHS"."appelation" AS "appelation_other", "RHS"."state" AS "state_other", "RHS"."name" AS "name_other", "RHS"."year" AS "year_other", "RHS"."price" AS "price_other", "RHS"."score" AS "score_other", "RHS"."cases" AS "cases_other", "RHS"."drink" AS "drink_other" FROM "wine" AS "LHS" CROSS JOIN "wine" AS "RHS") WHERE ("price" < "price_other")) WHERE ("winery" = 'John Anthony') ORDER BY name;

/*
Gold Result:
('JA Expensive',)
('Wine A',)
('Wine Z',)
*/

-- Prediction Query
SELECT DISTINCT Name FROM WINE WHERE Price > (SELECT MIN(Price) FROM wine WHERE Winery = 'John Anthony');

/*
Prediction Result:
('JA Expensive',)
('Wine Z',)
('Wine A',)
*/