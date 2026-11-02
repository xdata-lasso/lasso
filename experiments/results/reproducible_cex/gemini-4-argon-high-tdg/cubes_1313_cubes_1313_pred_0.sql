-- Schema DDL
CREATE TABLE "grapes" ("ID" INTEGER PRIMARY KEY, "Grape" TEXT UNIQUE, "Color" TEXT);

CREATE TABLE "appellations" ("No" INTEGER PRIMARY KEY, "Appelation" TEXT UNIQUE, "County" TEXT, "State" TEXT, "Area" TEXT, "isAVA" TEXT);

CREATE TABLE "wine" ("Appelation" TEXT, "Grape" TEXT, "No" INTEGER, "Winery" TEXT, "State" TEXT, "Name" TEXT, "Year" INTEGER, "Price" INTEGER, "Score" INTEGER, "Cases" INTEGER, "Drink" TEXT, FOREIGN KEY ("Appelation") REFERENCES "appellations" ("Appelation"), FOREIGN KEY ("Grape") REFERENCES "grapes" ("Grape"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO grapes (ID, Grape, Color) VALUES (1, 'Cabernet', 'Red');
INSERT INTO grapes (ID, Grape, Color) VALUES (2, 'Chardonnay', 'White');
INSERT INTO grapes (ID, Grape, Color) VALUES (3, 'Pinot Noir', 'red');
INSERT INTO grapes (ID, Grape, Color) VALUES (4, 'Syrah', NULL);
INSERT INTO appellations (No, Appelation, County, State, Area, isAVA) VALUES (1, 'Napa Valley', 'Napa', 'CA', 'North Coast', 'Yes');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Napa Valley', 'Cabernet', 10, 'Alpha Winery', 'CA', 'Wine_Z', 2015, 51, 40, 20, 'now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Napa Valley', 'Cabernet', 20, 'Beta Winery', 'CA', 'Wine_A', 2018, 100, 95, 500, 'hold');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Napa Valley', 'Cabernet', 30, 'Gamma Winery', 'CA', 'Wine_Border50', 2016, 50, 90, 200, 'now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Napa Valley', 'Cabernet', 40, 'Delta Winery', 'CA', 'Wine_LowPrice', 2017, 35, 88, 150, 'now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Napa Valley', 'Chardonnay', 50, 'Epsilon Winery', 'CA', 'Wine_WhiteHigh', 2019, 80, 92, 300, 'now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Napa Valley', 'Pinot Noir', 60, 'Zeta Winery', 'CA', 'Wine_LowerRed', 2020, 75, 90, 100, 'now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Napa Valley', 'Syrah', 70, 'Eta Winery', 'CA', 'Wine_NullColor', 2020, 90, 91, 100, 'now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('Napa Valley', 'Cabernet', 80, 'Theta Winery', 'CA', 'Wine_NullPrice', 2020, NULL, 95, 100, 'now');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM (SELECT "LHS"."id" AS "id", "LHS"."grape" AS "grape", "LHS"."color" AS "color", "RHS"."no" AS "no", "RHS"."winery" AS "winery", "RHS"."appelation" AS "appelation", "RHS"."state" AS "state", "RHS"."name" AS "name", "RHS"."year" AS "year", "RHS"."price" AS "price", "RHS"."score" AS "score", "RHS"."cases" AS "cases", "RHS"."drink" AS "drink" FROM "grapes" AS "LHS" INNER JOIN "wine" AS "RHS" ON ("LHS"."grape" = "RHS"."grape")) WHERE ("color" = 'Red' AND price > 50) ORDER BY name, "name" NULLS LAST;

/*
Gold Result:
('Wine_A',)
('Wine_Z',)
*/

-- Prediction Query
SELECT T2.Name FROM Grapes AS T1 JOIN WINE AS T2 ON T1.Grape = T2.Grape WHERE T1.Color = 'Red' AND T2.price > 50;

/*
Prediction Result:
('Wine_Z',)
('Wine_A',)
*/