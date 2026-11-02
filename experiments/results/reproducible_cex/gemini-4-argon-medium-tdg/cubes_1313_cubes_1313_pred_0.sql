-- Schema DDL
CREATE TABLE "grapes" ("ID" INTEGER PRIMARY KEY, "Grape" TEXT UNIQUE, "Color" TEXT);

CREATE TABLE "appellations" ("No" INTEGER PRIMARY KEY, "Appelation" TEXT UNIQUE, "County" TEXT, "State" TEXT, "Area" TEXT, "isAVA" TEXT);

CREATE TABLE "wine" ("Appelation" TEXT, "Grape" TEXT, "No" INTEGER, "Winery" TEXT, "State" TEXT, "Name" TEXT, "Year" INTEGER, "Price" INTEGER, "Score" INTEGER, "Cases" INTEGER, "Drink" TEXT, FOREIGN KEY ("Appelation") REFERENCES "appellations" ("Appelation"), FOREIGN KEY ("Grape") REFERENCES "grapes" ("Grape"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "grapes" ("ID", "Grape", "Color") VALUES (1, 'Cabernet', 'Red');
INSERT INTO "grapes" ("ID", "Grape", "Color") VALUES (2, 'Malbec', 'Red');
INSERT INTO "appellations" ("No", "Appelation", "County", "State", "Area", "isAVA") VALUES (1, 'Sonoma', 'Sonoma', 'CA', 'North Coast', 'Yes');
INSERT INTO "wine" ("Appelation", "Grape", "No", "Winery", "State", "Name", "Year", "Price", "Score", "Cases", "Drink") VALUES ('Sonoma', 'Cabernet', 201, 'W1', 'CA', 'Zeta', 2015, 60, 90, 100, 'Now');
INSERT INTO "wine" ("Appelation", "Grape", "No", "Winery", "State", "Name", "Year", "Price", "Score", "Cases", "Drink") VALUES ('Sonoma', 'Cabernet', 202, 'W2', 'CA', 'Alpha', 2016, 120, 95, 150, 'Now');
INSERT INTO "wine" ("Appelation", "Grape", "No", "Winery", "State", "Name", "Year", "Price", "Score", "Cases", "Drink") VALUES ('Sonoma', 'Malbec', 203, 'W3', 'CA', 'Alpha', 2017, 80, 92, 200, 'Now');
INSERT INTO "wine" ("Appelation", "Grape", "No", "Winery", "State", "Name", "Year", "Price", "Score", "Cases", "Drink") VALUES ('Sonoma', 'Malbec', 204, 'W4', 'CA', NULL, 2018, 90, 91, 250, 'Now');
INSERT INTO "wine" ("Appelation", "Grape", "No", "Winery", "State", "Name", "Year", "Price", "Score", "Cases", "Drink") VALUES ('Sonoma', 'Cabernet', 205, 'W5', 'CA', 'Beta', 2019, 55, 88, 300, 'Now');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM (SELECT "LHS"."id" AS "id", "LHS"."grape" AS "grape", "LHS"."color" AS "color", "RHS"."no" AS "no", "RHS"."winery" AS "winery", "RHS"."appelation" AS "appelation", "RHS"."state" AS "state", "RHS"."name" AS "name", "RHS"."year" AS "year", "RHS"."price" AS "price", "RHS"."score" AS "score", "RHS"."cases" AS "cases", "RHS"."drink" AS "drink" FROM "grapes" AS "LHS" INNER JOIN "wine" AS "RHS" ON ("LHS"."grape" = "RHS"."grape")) WHERE ("color" = 'Red' AND price > 50) ORDER BY name, "name" NULLS LAST;

/*
Gold Result:
(None,)
('Alpha',)
('Alpha',)
('Beta',)
('Zeta',)
*/

-- Prediction Query
SELECT T2.Name FROM Grapes AS T1 JOIN WINE AS T2 ON T1.Grape = T2.Grape WHERE T1.Color = 'Red' AND T2.price > 50;

/*
Prediction Result:
('Zeta',)
('Alpha',)
('Alpha',)
(None,)
('Beta',)
*/