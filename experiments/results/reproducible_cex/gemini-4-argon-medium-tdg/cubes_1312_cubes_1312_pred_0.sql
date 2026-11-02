-- Schema DDL
CREATE TABLE "grapes" ("ID" INTEGER PRIMARY KEY, "Grape" TEXT UNIQUE, "Color" TEXT);

CREATE TABLE "appellations" ("No" INTEGER PRIMARY KEY, "Appelation" TEXT UNIQUE, "County" TEXT, "State" TEXT, "Area" TEXT, "isAVA" TEXT);

CREATE TABLE "wine" ("Appelation" TEXT, "Grape" TEXT, "No" INTEGER, "Winery" TEXT, "State" TEXT, "Name" TEXT, "Year" INTEGER, "Price" INTEGER, "Score" INTEGER, "Cases" INTEGER, "Drink" TEXT, FOREIGN KEY ("Appelation") REFERENCES "appellations" ("Appelation"), FOREIGN KEY ("Grape") REFERENCES "grapes" ("Grape"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests sorting logic: ORDER BY name, "name" NULLS LAST, "score" NULLS LAST, and duplicate row preservation (SELECT vs SELECT DISTINCT).
INSERT INTO "grapes" ("ID", "Grape", "Color") VALUES (1, 'Riesling', 'White');
INSERT INTO "grapes" ("ID", "Grape", "Color") VALUES (2, 'Chenin Blanc', 'White');
INSERT INTO "wine" ("Appelation", "Grape", "No", "Winery", "State", "Name", "Year", "Price", "Score", "Cases", "Drink") VALUES (NULL, 'Riesling', 1, 'W1', 'NY', 'Wine B', 2018, 20, 92, 100, 'Now');
INSERT INTO "wine" ("Appelation", "Grape", "No", "Winery", "State", "Name", "Year", "Price", "Score", "Cases", "Drink") VALUES (NULL, 'Riesling', 2, 'W2', 'NY', 'Wine A', 2019, 25, 88, 120, 'Now');
INSERT INTO "wine" ("Appelation", "Grape", "No", "Winery", "State", "Name", "Year", "Price", "Score", "Cases", "Drink") VALUES (NULL, 'Chenin Blanc', 3, 'W3', 'NY', 'Wine A', 2020, 30, 95, 80, 'Hold');
INSERT INTO "wine" ("Appelation", "Grape", "No", "Winery", "State", "Name", "Year", "Price", "Score", "Cases", "Drink") VALUES (NULL, 'Chenin Blanc', 4, 'W4', 'NY', 'Wine A', 2021, 30, NULL, 90, 'Now');
INSERT INTO "wine" ("Appelation", "Grape", "No", "Winery", "State", "Name", "Year", "Price", "Score", "Cases", "Drink") VALUES (NULL, 'Riesling', 5, 'W5', 'NY', 'Wine A', 2022, 25, 88, 110, 'Now');
INSERT INTO "wine" ("Appelation", "Grape", "No", "Winery", "State", "Name", "Year", "Price", "Score", "Cases", "Drink") VALUES (NULL, 'Riesling', 6, 'W6', 'NY', NULL, 2020, 15, 90, 200, 'Now');
INSERT INTO "wine" ("Appelation", "Grape", "No", "Winery", "State", "Name", "Year", "Price", "Score", "Cases", "Drink") VALUES (NULL, 'Riesling', 7, 'W7', 'NY', NULL, 2021, 15, 80, 200, 'Now');
INSERT INTO "wine" ("Appelation", "Grape", "No", "Winery", "State", "Name", "Year", "Price", "Score", "Cases", "Drink") VALUES (NULL, 'Chenin Blanc', 8, 'W8', 'NY', NULL, 2021, 15, NULL, 200, 'Now');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name", "score" FROM (SELECT * FROM "wine" AS "LHS" WHERE EXISTS(SELECT 1 FROM (SELECT * FROM "grapes" WHERE ("color" = 'White')) AS RHS WHERE (LHS.grape = RHS.grape))) ORDER BY name, "name" NULLS LAST, "score" NULLS LAST;

/*
Gold Result:
(None, 80)
(None, 90)
(None, None)
('Wine A', 88)
('Wine A', 88)
('Wine A', 95)
('Wine A', None)
('Wine B', 92)
*/

-- Prediction Query
SELECT T2.Name, T2.Score FROM GRAPES AS T1 JOIN WINE AS T2 ON T1.Grape = T2.Grape WHERE T1.Color = 'White';

/*
Prediction Result:
('Wine B', 92)
('Wine A', 88)
('Wine A', 95)
('Wine A', None)
('Wine A', 88)
(None, 90)
(None, 80)
(None, None)
*/