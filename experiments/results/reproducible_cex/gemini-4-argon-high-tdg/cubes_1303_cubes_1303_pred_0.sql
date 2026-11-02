-- Schema DDL
CREATE TABLE "grapes" ("ID" INTEGER PRIMARY KEY, "Grape" TEXT UNIQUE, "Color" TEXT);

CREATE TABLE "appellations" ("No" INTEGER PRIMARY KEY, "Appelation" TEXT UNIQUE, "County" TEXT, "State" TEXT, "Area" TEXT, "isAVA" TEXT);

CREATE TABLE "wine" ("Appelation" TEXT, "Grape" TEXT, "No" INTEGER, "Winery" TEXT, "State" TEXT, "Name" TEXT, "Year" INTEGER, "Price" INTEGER, "Score" INTEGER, "Cases" INTEGER, "Drink" TEXT, FOREIGN KEY ("Appelation") REFERENCES "appellations" ("Appelation"), FOREIGN KEY ("Grape") REFERENCES "grapes" ("Grape"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "grapes" ("ID", "Grape", "Color") VALUES (1, 'Cabernet Sauvignon', 'Red');
INSERT INTO "grapes" ("ID", "Grape", "Color") VALUES (2, 'Chardonnay', 'White');
INSERT INTO "appellations" ("No", "Appelation", "County", "State", "Area", "isAVA") VALUES (1, 'Rutherford', 'Napa', 'CA', 'Alpha', 'Yes');
INSERT INTO "appellations" ("No", "Appelation", "County", "State", "Area", "isAVA") VALUES (2, 'Oakville', 'Napa', 'CA', 'Alpha', 'Yes');
INSERT INTO "appellations" ("No", "Appelation", "County", "State", "Area", "isAVA") VALUES (3, 'St. Helena', 'Napa', 'CA', 'Alpha', 'Yes');
INSERT INTO "appellations" ("No", "Appelation", "County", "State", "Area", "isAVA") VALUES (4, 'Calistoga', 'Napa', 'CA', 'Beta', 'Yes');
INSERT INTO "appellations" ("No", "Appelation", "County", "State", "Area", "isAVA") VALUES (5, 'Yountville', 'Napa', 'CA', 'Gamma', 'Yes');
INSERT INTO "appellations" ("No", "Appelation", "County", "State", "Area", "isAVA") VALUES (6, 'Mount Veeder', 'Napa', 'CA', 'Gamma', 'Yes');
INSERT INTO "appellations" ("No", "Appelation", "County", "State", "Area", "isAVA") VALUES (7, 'Howell Mountain', 'Napa', 'CA', 'Delta', 'Yes');
INSERT INTO "appellations" ("No", "Appelation", "County", "State", "Area", "isAVA") VALUES (8, 'Atlas Peak', 'Napa', 'CA', 'Delta', 'No');
INSERT INTO "appellations" ("No", "Appelation", "County", "State", "Area", "isAVA") VALUES (9, 'Russian River', 'Sonoma', 'CA', 'Alpha', 'Yes');
INSERT INTO "appellations" ("No", "Appelation", "County", "State", "Area", "isAVA") VALUES (10, 'Alexander Valley', 'Sonoma', 'CA', 'Alpha', 'Yes');
INSERT INTO "appellations" ("No", "Appelation", "County", "State", "Area", "isAVA") VALUES (11, 'Sonoma Coast', 'Sonoma', 'CA', 'Napa', 'Yes');
INSERT INTO "wine" ("Appelation", "Grape", "No", "Winery", "State", "Name", "Year", "Price", "Score", "Cases", "Drink") VALUES ('Calistoga', 'Cabernet Sauvignon', 101, 'Winery A', 'CA', 'Reserve', 2018, 80, 94, 500, 'Now');
INSERT INTO "wine" ("Appelation", "Grape", "No", "Winery", "State", "Name", "Year", "Price", "Score", "Cases", "Drink") VALUES ('Calistoga', 'Cabernet Sauvignon', 102, 'Winery B', 'CA', 'Estate', 2019, 95, 95, 300, 'Hold');
INSERT INTO "wine" ("Appelation", "Grape", "No", "Winery", "State", "Name", "Year", "Price", "Score", "Cases", "Drink") VALUES ('Calistoga', 'Chardonnay', 103, 'Winery C', 'CA', 'Blanc', 2020, 60, 91, 800, 'Now');
INSERT INTO "wine" ("Appelation", "Grape", "No", "Winery", "State", "Name", "Year", "Price", "Score", "Cases", "Drink") VALUES ('Rutherford', 'Cabernet Sauvignon', 104, 'Winery D', 'CA', 'Dust', 2017, 120, 96, 200, 'Hold');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "n" AS "count___" FROM (SELECT "area", "county", COUNT(*) AS "n" FROM "appellations" GROUP BY "area", "county") WHERE ("county" = 'Napa') ORDER BY count___;

/*
Gold Result:
(1,)
(2,)
(2,)
(3,)
*/

-- Prediction Query
SELECT COUNT(*) FROM APPELLATIONS WHERE County = 'Napa';

/*
Prediction Result:
(8,)
*/