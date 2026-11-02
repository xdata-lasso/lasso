-- Schema DDL
CREATE TABLE "grapes" ("ID" INTEGER PRIMARY KEY, "Grape" TEXT UNIQUE, "Color" TEXT);

CREATE TABLE "appellations" ("No" INTEGER PRIMARY KEY, "Appelation" TEXT UNIQUE, "County" TEXT, "State" TEXT, "Area" TEXT, "isAVA" TEXT);

CREATE TABLE "wine" ("Appelation" TEXT, "Grape" TEXT, "No" INTEGER, "Winery" TEXT, "State" TEXT, "Name" TEXT, "Year" INTEGER, "Price" INTEGER, "Score" INTEGER, "Cases" INTEGER, "Drink" TEXT, FOREIGN KEY ("Appelation") REFERENCES "appellations" ("Appelation"), FOREIGN KEY ("Grape") REFERENCES "grapes" ("Grape"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "grapes" ("ID", "Grape", "Color") VALUES (1, 'Chardonnay', 'White');
INSERT INTO "grapes" ("ID", "Grape", "Color") VALUES (2, 'Sauvignon Blanc', 'White');
INSERT INTO "grapes" ("ID", "Grape", "Color") VALUES (3, 'Cabernet Sauvignon', 'Red');
INSERT INTO "grapes" ("ID", "Grape", "Color") VALUES (4, 'Grenache', 'Rose');
INSERT INTO "grapes" ("ID", "Grape", "Color") VALUES (5, 'Pinot Gris', 'white');
INSERT INTO "grapes" ("ID", "Grape", "Color") VALUES (6, 'Mystery Grape', NULL);
INSERT INTO "appellations" ("No", "Appelation", "County", "State", "Area", "isAVA") VALUES (10, 'Napa Valley', 'Napa', 'California', 'North Coast', 'Yes');
INSERT INTO "appellations" ("No", "Appelation", "County", "State", "Area", "isAVA") VALUES (20, 'Sonoma Coast', 'Sonoma', 'California', 'North Coast', 'Yes');
INSERT INTO "wine" ("Appelation", "Grape", "No", "Winery", "State", "Name", "Year", "Price", "Score", "Cases", "Drink") VALUES ('Napa Valley', 'Chardonnay', 3, 'Apex Cellars', 'California', 'Reserve Cuvée', 2018, 45, 94, 500, 'now');
INSERT INTO "wine" ("Appelation", "Grape", "No", "Winery", "State", "Name", "Year", "Price", "Score", "Cases", "Drink") VALUES ('Sonoma Coast', 'Sauvignon Blanc', 4, 'Beta Vintners', 'California', 'Reserve Cuvée', 2019, 30, NULL, 300, 'now');
INSERT INTO "wine" ("Appelation", "Grape", "No", "Winery", "State", "Name", "Year", "Price", "Score", "Cases", "Drink") VALUES (NULL, 'Chardonnay', 5, 'Gamma Winery', 'Oregon', 'Reserve Cuvée', 2020, 25, 88, 200, 'hold');
INSERT INTO "wine" ("Appelation", "Grape", "No", "Winery", "State", "Name", "Year", "Price", "Score", "Cases", "Drink") VALUES ('Napa Valley', 'Sauvignon Blanc', 6, 'Delta Estate', 'California', 'Alpine Blanc', 2021, 50, 92, 150, 'now');
INSERT INTO "wine" ("Appelation", "Grape", "No", "Winery", "State", "Name", "Year", "Price", "Score", "Cases", "Drink") VALUES ('Sonoma Coast', 'Chardonnay', 7, 'Epsilon Wine', 'California', 'Alpine Blanc', 2021, 55, 92, 100, 'now');
INSERT INTO "wine" ("Appelation", "Grape", "No", "Winery", "State", "Name", "Year", "Price", "Score", "Cases", "Drink") VALUES ('Napa Valley', 'Chardonnay', 8, 'Zeta Hills', 'California', NULL, 2017, 60, 91, 400, 'now');
INSERT INTO "wine" ("Appelation", "Grape", "No", "Winery", "State", "Name", "Year", "Price", "Score", "Cases", "Drink") VALUES ('Napa Valley', 'Sauvignon Blanc', 9, 'Eta Vineyards', 'California', NULL, 2016, 40, NULL, 250, 'hold');
INSERT INTO "wine" ("Appelation", "Grape", "No", "Winery", "State", "Name", "Year", "Price", "Score", "Cases", "Drink") VALUES ('Napa Valley', 'Cabernet Sauvignon', 1, 'Red Oak', 'California', 'Dark Tannin', 2015, 80, 96, 600, 'hold');
INSERT INTO "wine" ("Appelation", "Grape", "No", "Winery", "State", "Name", "Year", "Price", "Score", "Cases", "Drink") VALUES ('Sonoma Coast', 'Grenache', 2, 'Pink Petal', 'California', 'Summer Blush', 2022, 20, 85, 800, 'now');
INSERT INTO "wine" ("Appelation", "Grape", "No", "Winery", "State", "Name", "Year", "Price", "Score", "Cases", "Drink") VALUES ('Napa Valley', 'Pinot Gris', 10, 'Lower Case', 'California', 'Ghost White', 2020, 22, 87, 350, 'now');
INSERT INTO "wine" ("Appelation", "Grape", "No", "Winery", "State", "Name", "Year", "Price", "Score", "Cases", "Drink") VALUES ('Napa Valley', 'Mystery Grape', 11, 'Unknown Vine', 'California', 'Null Color Wine', 2019, 35, 89, 120, 'now');
INSERT INTO "wine" ("Appelation", "Grape", "No", "Winery", "State", "Name", "Year", "Price", "Score", "Cases", "Drink") VALUES ('Napa Valley', NULL, 12, 'Orphan Vine', 'California', 'Unlinked Grape Wine', 2019, 35, 90, 120, 'now');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name", "score" FROM (SELECT * FROM "wine" AS "LHS" WHERE EXISTS(SELECT 1 FROM (SELECT * FROM "grapes" WHERE ("color" = 'White')) AS RHS WHERE (LHS.grape = RHS.grape))) ORDER BY name, "name" NULLS LAST, "score" NULLS LAST;

/*
Gold Result:
(None, 91)
(None, None)
('Alpine Blanc', 92)
('Alpine Blanc', 92)
('Reserve Cuvée', 88)
('Reserve Cuvée', 94)
('Reserve Cuvée', None)
*/

-- Prediction Query
SELECT T2.Name, T2.Score FROM GRAPES AS T1 JOIN WINE AS T2 ON T1.Grape = T2.Grape WHERE T1.Color = 'White';

/*
Prediction Result:
('Reserve Cuvée', 94)
('Reserve Cuvée', None)
('Reserve Cuvée', 88)
('Alpine Blanc', 92)
('Alpine Blanc', 92)
(None, 91)
(None, None)
*/