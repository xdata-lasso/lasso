-- Schema DDL
CREATE TABLE "grapes" ("ID" INTEGER PRIMARY KEY, "Grape" TEXT UNIQUE, "Color" TEXT);

CREATE TABLE "appellations" ("No" INTEGER PRIMARY KEY, "Appelation" TEXT UNIQUE, "County" TEXT, "State" TEXT, "Area" TEXT, "isAVA" TEXT);

CREATE TABLE "wine" ("Appelation" TEXT, "Grape" TEXT, "No" INTEGER, "Winery" TEXT, "State" TEXT, "Name" TEXT, "Year" INTEGER, "Price" INTEGER, "Score" INTEGER, "Cases" INTEGER, "Drink" TEXT, FOREIGN KEY ("Appelation") REFERENCES "appellations" ("Appelation"), FOREIGN KEY ("Grape") REFERENCES "grapes" ("Grape"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "grapes" ("ID", "Grape", "Color") VALUES (1, 'Chardonnay', 'White');
INSERT INTO "grapes" ("ID", "Grape", "Color") VALUES (2, 'Pinot Gris', 'White');
INSERT INTO "wine" ("Appelation", "Grape", "No", "Winery", "State", "Name", "Year", "Price", "Score", "Cases", "Drink") VALUES (NULL, 'Chardonnay', 1, 'Winery A', 'CA', 'Reserve', 2020, 50, 90, 100, 'Now');
INSERT INTO "wine" ("Appelation", "Grape", "No", "Winery", "State", "Name", "Year", "Price", "Score", "Cases", "Drink") VALUES (NULL, 'Chardonnay', 2, 'Winery B', 'OR', 'Reserve', 2021, 55, 90, 120, 'Hold');
INSERT INTO "wine" ("Appelation", "Grape", "No", "Winery", "State", "Name", "Year", "Price", "Score", "Cases", "Drink") VALUES (NULL, 'Pinot Gris', 3, 'Winery C', 'WA', 'Estate', 2019, 30, 95, 200, 'Now');
INSERT INTO "wine" ("Appelation", "Grape", "No", "Winery", "State", "Name", "Year", "Price", "Score", "Cases", "Drink") VALUES (NULL, 'Pinot Gris', 4, 'Winery D', 'CA', 'Estate', 2020, 35, 85, 250, 'Now');
INSERT INTO "wine" ("Appelation", "Grape", "No", "Winery", "State", "Name", "Year", "Price", "Score", "Cases", "Drink") VALUES (NULL, 'Chardonnay', 5, 'Winery E', 'NY', 'Estate', 2018, 40, NULL, 300, 'Hold');
INSERT INTO "wine" ("Appelation", "Grape", "No", "Winery", "State", "Name", "Year", "Price", "Score", "Cases", "Drink") VALUES (NULL, 'Chardonnay', 6, 'Winery F', 'CA', NULL, 2022, 60, 92, 80, 'Now');
INSERT INTO "wine" ("Appelation", "Grape", "No", "Winery", "State", "Name", "Year", "Price", "Score", "Cases", "Drink") VALUES (NULL, 'Pinot Gris', 7, 'Winery G', 'OR', NULL, 2021, 45, 88, 90, 'Now');
INSERT INTO "wine" ("Appelation", "Grape", "No", "Winery", "State", "Name", "Year", "Price", "Score", "Cases", "Drink") VALUES (NULL, 'Pinot Gris', 8, 'Winery H', 'WA', NULL, 2020, 50, NULL, 110, 'Hold');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name", "score" FROM (SELECT * FROM "wine" AS "LHS" WHERE EXISTS(SELECT 1 FROM (SELECT * FROM "grapes" WHERE ("color" = 'White')) AS RHS WHERE (LHS.grape = RHS.grape))) ORDER BY name, "name" NULLS LAST, "score" NULLS LAST;

/*
Gold Result:
(None, 88)
(None, 92)
(None, None)
('Estate', 85)
('Estate', 95)
('Estate', None)
('Reserve', 90)
('Reserve', 90)
*/

-- Prediction Query
SELECT T2.Name, T2.Score FROM GRAPES AS T1 JOIN WINE AS T2 ON T1.Grape = T2.Grape WHERE T1.Color = 'White';

/*
Prediction Result:
('Reserve', 90)
('Reserve', 90)
('Estate', 95)
('Estate', 85)
('Estate', None)
(None, 92)
(None, 88)
(None, None)
*/