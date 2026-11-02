-- Schema DDL
CREATE TABLE "grapes" ("ID" INTEGER PRIMARY KEY, "Grape" TEXT UNIQUE, "Color" TEXT);

CREATE TABLE "appellations" ("No" INTEGER PRIMARY KEY, "Appelation" TEXT UNIQUE, "County" TEXT, "State" TEXT, "Area" TEXT, "isAVA" TEXT);

CREATE TABLE "wine" ("Appelation" TEXT, "Grape" TEXT, "No" INTEGER, "Winery" TEXT, "State" TEXT, "Name" TEXT, "Year" INTEGER, "Price" INTEGER, "Score" INTEGER, "Cases" INTEGER, "Drink" TEXT, FOREIGN KEY ("Appelation") REFERENCES "appellations" ("Appelation"), FOREIGN KEY ("Grape") REFERENCES "grapes" ("Grape"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO grapes (ID, Grape, Color) VALUES (1, 'Cabernet Sauvignon', 'Red');
INSERT INTO grapes (ID, Grape, Color) VALUES (2, 'Chardonnay', 'White');
INSERT INTO grapes (ID, Grape, Color) VALUES (3, 'Syrah', 'Red');
INSERT INTO appellations (No, Appelation, County, State, Area, isAVA) VALUES (1, 'Napa Valley', 'Napa', 'California', 'North Coast', 'Yes');
INSERT INTO appellations (No, Appelation, County, State, Area, isAVA) VALUES (2, 'Oak Knoll District', 'Napa', 'California', 'North Coast', 'Yes');
INSERT INTO appellations (No, Appelation, County, State, Area, isAVA) VALUES (3, 'Sonoma Coast', 'Sonoma', 'California', 'North Coast', 'Yes');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Napa Valley', 'Cabernet Sauvignon', 1, 'John Anthony', 'California', 'JA Reserve', 2018, 60, 92, 500, 'now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Oak Knoll District', 'Syrah', 2, 'John Anthony', 'California', 'JA Classic', 2019, 20, 88, 1200, 'now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Sonoma Coast', 'Chardonnay', 3, 'Beringer', 'California', 'Beringer Estate', 2020, 30, 90, 800, 'now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Napa Valley', 'Cabernet Sauvignon', 4, 'Caymus', 'California', 'Caymus Select', 2017, 50, 94, 600, 'now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Napa Valley', 'Cabernet Sauvignon', 5, 'Opus', 'California', 'Opus One', 2016, 90, 97, 300, 'now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Sonoma Coast', 'Chardonnay', 6, 'Mondavi', 'California', 'Mondavi Table', 2021, 15, 85, 2000, 'now');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "name_other" AS "name" FROM (SELECT * FROM (SELECT "LHS"."no" AS "no", "LHS"."grape" AS "grape", "LHS"."winery" AS "winery", "LHS"."appelation" AS "appelation", "LHS"."state" AS "state", "LHS"."name" AS "name", "LHS"."year" AS "year", "LHS"."price" AS "price", "LHS"."score" AS "score", "LHS"."cases" AS "cases", "LHS"."drink" AS "drink", "RHS"."no" AS "no_other", "RHS"."grape" AS "grape_other", "RHS"."winery" AS "winery_other", "RHS"."appelation" AS "appelation_other", "RHS"."state" AS "state_other", "RHS"."name" AS "name_other", "RHS"."year" AS "year_other", "RHS"."price" AS "price_other", "RHS"."score" AS "score_other", "RHS"."cases" AS "cases_other", "RHS"."drink" AS "drink_other" FROM "wine" AS "LHS" CROSS JOIN "wine" AS "RHS") WHERE ("price" < "price_other")) WHERE ("winery" = 'John Anthony') ORDER BY name;

/*
Gold Result:
('Beringer Estate',)
('Caymus Select',)
('JA Reserve',)
('Opus One',)
*/

-- Prediction Query
SELECT DISTINCT Name FROM WINE WHERE Price > (SELECT MIN(Price) FROM wine WHERE Winery = 'John Anthony');

/*
Prediction Result:
('JA Reserve',)
('Beringer Estate',)
('Caymus Select',)
('Opus One',)
*/