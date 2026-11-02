-- Schema DDL
CREATE TABLE "grapes" ("ID" INTEGER PRIMARY KEY, "Grape" TEXT UNIQUE, "Color" TEXT);

CREATE TABLE "appellations" ("No" INTEGER PRIMARY KEY, "Appelation" TEXT UNIQUE, "County" TEXT, "State" TEXT, "Area" TEXT, "isAVA" TEXT);

CREATE TABLE "wine" ("Appelation" TEXT, "Grape" TEXT, "No" INTEGER, "Winery" TEXT, "State" TEXT, "Name" TEXT, "Year" INTEGER, "Price" INTEGER, "Score" INTEGER, "Cases" INTEGER, "Drink" TEXT, FOREIGN KEY ("Appelation") REFERENCES "appellations" ("Appelation"), FOREIGN KEY ("Grape") REFERENCES "grapes" ("Grape"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "grapes" ("ID", "Grape", "Color") VALUES (1, 'Chardonnay', 'White');
INSERT INTO "appellations" ("No", "Appelation", "County", "State", "Area", "isAVA") VALUES (1, 'Napa Valley', 'Napa', 'CA', 'North Coast', 'Yes');
INSERT INTO "wine" ("Appelation", "Grape", "No", "Winery", "State", "Name", "Year", "Price", "Score", "Cases", "Drink") VALUES ('Napa Valley', 'Chardonnay', 1, 'Test Winery', 'NY', 'Test Wine', 2020, 50, 90, 100, 'Now');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "name" FROM (SELECT "LHS"."no" AS "no", "LHS"."appelation" AS "appelation", "LHS"."county" AS "county", "LHS"."state" AS "state", "LHS"."area" AS "area", "LHS"."isava" AS "isava", "RHS"."no" AS "no_other", "RHS"."grape" AS "grape", "RHS"."winery" AS "winery", "RHS"."name" AS "name", "RHS"."year" AS "year", "RHS"."price" AS "price", "RHS"."score" AS "score", "RHS"."cases" AS "cases", "RHS"."drink" AS "drink" FROM "appellations" AS "LHS" INNER JOIN "wine" AS "RHS" ON ("LHS"."appelation" = "RHS"."appelation" AND "LHS"."state" = "RHS"."state")) WHERE ("area" = 'North Coast') ORDER BY name, "name" NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT T2.Name FROM APPELLATIONs AS T1 JOIN WINE AS T2 ON T1.Appelation = T2.Appelation WHERE T1.Area = 'North Coast';

/*
Prediction Result:
('Test Wine',)
*/