-- Schema DDL
CREATE TABLE "grapes" ("ID" INTEGER PRIMARY KEY, "Grape" TEXT UNIQUE, "Color" TEXT);

CREATE TABLE "appellations" ("No" INTEGER PRIMARY KEY, "Appelation" TEXT UNIQUE, "County" TEXT, "State" TEXT, "Area" TEXT, "isAVA" TEXT);

CREATE TABLE "wine" ("Appelation" TEXT, "Grape" TEXT, "No" INTEGER, "Winery" TEXT, "State" TEXT, "Name" TEXT, "Year" INTEGER, "Price" INTEGER, "Score" INTEGER, "Cases" INTEGER, "Drink" TEXT, FOREIGN KEY ("Appelation") REFERENCES "appellations" ("Appelation"), FOREIGN KEY ("Grape") REFERENCES "grapes" ("Grape"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic filtering (Color = 'Red' vs others, NULLs), DISTINCT on Name, ORDER BY ASC, and NULLS LAST on Name.
INSERT INTO "grapes" ("ID", "Grape", "Color") VALUES (1, 'Pinot Noir', 'Red');
INSERT INTO "grapes" ("ID", "Grape", "Color") VALUES (2, 'Cabernet', 'Red');
INSERT INTO "grapes" ("ID", "Grape", "Color") VALUES (3, 'Chardonnay', 'White');
INSERT INTO "grapes" ("ID", "Grape", "Color") VALUES (4, 'Rosé Grape', 'Rose');
INSERT INTO "grapes" ("ID", "Grape", "Color") VALUES (5, 'Mystery', NULL);
INSERT INTO "appellations" ("No", "Appelation", "County", "State", "Area", "isAVA") VALUES (1, 'Napa Valley', 'Napa', 'CA', 'North Coast', 'Yes');
INSERT INTO "wine" ("Appelation", "Grape", "No", "Winery", "State", "Name", "Year", "Price", "Score", "Cases", "Drink") VALUES ('Napa Valley', 'Pinot Noir', 1, 'Winery A', 'CA', 'Zinfandel Reserve', 2018, 50, 92, 100, 'Now');
INSERT INTO "wine" ("Appelation", "Grape", "No", "Winery", "State", "Name", "Year", "Price", "Score", "Cases", "Drink") VALUES ('Napa Valley', 'Cabernet', 2, 'Winery B', 'CA', 'Alpha', 2019, 60, 95, 200, 'Hold');
INSERT INTO "wine" ("Appelation", "Grape", "No", "Winery", "State", "Name", "Year", "Price", "Score", "Cases", "Drink") VALUES ('Napa Valley', 'Pinot Noir', 3, 'Winery C', 'CA', 'Alpha', 2020, 45, 90, 150, 'Now');
INSERT INTO "wine" ("Appelation", "Grape", "No", "Winery", "State", "Name", "Year", "Price", "Score", "Cases", "Drink") VALUES ('Napa Valley', 'Pinot Noir', 4, 'Winery D', 'CA', NULL, 2021, 30, 88, 300, 'Now');
INSERT INTO "wine" ("Appelation", "Grape", "No", "Winery", "State", "Name", "Year", "Price", "Score", "Cases", "Drink") VALUES ('Napa Valley', 'Chardonnay', 5, 'Winery E', 'CA', 'Beta White', 2020, 40, 91, 250, 'Now');
INSERT INTO "wine" ("Appelation", "Grape", "No", "Winery", "State", "Name", "Year", "Price", "Score", "Cases", "Drink") VALUES ('Napa Valley', 'Mystery', 6, 'Winery F', 'CA', 'Gamma Mystery', 2017, 25, 85, 500, 'Now');
INSERT INTO "wine" ("Appelation", "Grape", "No", "Winery", "State", "Name", "Year", "Price", "Score", "Cases", "Drink") VALUES ('Napa Valley', NULL, 7, 'Winery G', 'CA', 'Delta NoGrape', 2016, 20, 80, 50, 'Now');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "name" FROM (SELECT * FROM "wine" AS "LHS" WHERE EXISTS(SELECT 1 FROM (SELECT * FROM "grapes" WHERE ("color" = 'Red')) AS RHS WHERE (LHS.grape = RHS.grape))) ORDER BY name, "name" NULLS LAST;

/*
Gold Result:
(None,)
('Alpha',)
('Zinfandel Reserve',)
*/

-- Prediction Query
SELECT DISTINCT T2.Name FROM GRAPES AS T1 JOIN WINE AS T2 ON T1.Grape = T2.Grape WHERE T1.Color = 'Red';

/*
Prediction Result:
('Zinfandel Reserve',)
('Alpha',)
(None,)
*/