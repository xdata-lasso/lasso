-- Schema DDL
CREATE TABLE "grapes" ("ID" INTEGER PRIMARY KEY, "Grape" TEXT UNIQUE, "Color" TEXT);

CREATE TABLE "appellations" ("No" INTEGER PRIMARY KEY, "Appelation" TEXT UNIQUE, "County" TEXT, "State" TEXT, "Area" TEXT, "isAVA" TEXT);

CREATE TABLE "wine" ("Appelation" TEXT, "Grape" TEXT, "No" INTEGER, "Winery" TEXT, "State" TEXT, "Name" TEXT, "Year" INTEGER, "Price" INTEGER, "Score" INTEGER, "Cases" INTEGER, "Drink" TEXT, FOREIGN KEY ("Appelation") REFERENCES "appellations" ("Appelation"), FOREIGN KEY ("Grape") REFERENCES "grapes" ("Grape"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "grapes" ("ID", "Grape", "Color") VALUES (1, 'Cabernet', 'Red');
INSERT INTO "appellations" ("No", "Appelation", "County", "State", "Area", "isAVA") VALUES (1, 'Sonoma', 'Sonoma', 'CA', 'North Coast', 'Yes');
INSERT INTO "wine" ("Appelation", "Grape", "No", "Winery", "State", "Name", "Year", "Price", "Score", "Cases", "Drink") VALUES ('Sonoma', 'Cabernet', 201, 'Winery X', 'CA', 'Zinfandel Reserve', 2015, 60, 88, 500, '2025');
INSERT INTO "wine" ("Appelation", "Grape", "No", "Winery", "State", "Name", "Year", "Price", "Score", "Cases", "Drink") VALUES ('Sonoma', 'Cabernet', 202, 'Winery Y', 'CA', NULL, 2016, 70, 95, 300, '2026');
INSERT INTO "wine" ("Appelation", "Grape", "No", "Winery", "State", "Name", "Year", "Price", "Score", "Cases", "Drink") VALUES ('Sonoma', 'Cabernet', 203, 'Winery Z', 'CA', 'Alpha Estate', 2017, 80, 92, 200, '2027');
INSERT INTO "wine" ("Appelation", "Grape", "No", "Winery", "State", "Name", "Year", "Price", "Score", "Cases", "Drink") VALUES ('Sonoma', 'Cabernet', 204, 'Winery W', 'CA', 'Alpha Estate', 2019, 90, 90, 150, '2028');
INSERT INTO "wine" ("Appelation", "Grape", "No", "Winery", "State", "Name", "Year", "Price", "Score", "Cases", "Drink") VALUES ('Sonoma', 'Cabernet', 205, 'Winery V', 'CA', 'Beta Blend', 2020, 55, 89, 400, '2024');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM (SELECT "LHS"."id" AS "id", "LHS"."grape" AS "grape", "LHS"."color" AS "color", "RHS"."no" AS "no", "RHS"."winery" AS "winery", "RHS"."appelation" AS "appelation", "RHS"."state" AS "state", "RHS"."name" AS "name", "RHS"."year" AS "year", "RHS"."price" AS "price", "RHS"."score" AS "score", "RHS"."cases" AS "cases", "RHS"."drink" AS "drink" FROM "grapes" AS "LHS" INNER JOIN "wine" AS "RHS" ON ("LHS"."grape" = "RHS"."grape")) WHERE ("color" = 'Red' AND price > 50) ORDER BY name, "name" NULLS LAST;

/*
Gold Result:
(None,)
('Alpha Estate',)
('Alpha Estate',)
('Beta Blend',)
('Zinfandel Reserve',)
*/

-- Prediction Query
SELECT T2.Name FROM Grapes AS T1 JOIN WINE AS T2 ON T1.Grape = T2.Grape WHERE T1.Color = 'Red' AND T2.price > 50;

/*
Prediction Result:
('Zinfandel Reserve',)
(None,)
('Alpha Estate',)
('Alpha Estate',)
('Beta Blend',)
*/