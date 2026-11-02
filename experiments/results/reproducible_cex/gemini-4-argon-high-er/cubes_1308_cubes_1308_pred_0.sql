-- Schema DDL
CREATE TABLE "grapes" ("ID" INTEGER PRIMARY KEY, "Grape" TEXT UNIQUE, "Color" TEXT);

CREATE TABLE "appellations" ("No" INTEGER PRIMARY KEY, "Appelation" TEXT UNIQUE, "County" TEXT, "State" TEXT, "Area" TEXT, "isAVA" TEXT);

CREATE TABLE "wine" ("Appelation" TEXT, "Grape" TEXT, "No" INTEGER, "Winery" TEXT, "State" TEXT, "Name" TEXT, "Year" INTEGER, "Price" INTEGER, "Score" INTEGER, "Cases" INTEGER, "Drink" TEXT, FOREIGN KEY ("Appelation") REFERENCES "appellations" ("Appelation"), FOREIGN KEY ("Grape") REFERENCES "grapes" ("Grape"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "grapes" ("ID", "Grape", "Color") VALUES (1, 'A', 'Red');
INSERT INTO "grapes" ("ID", "Grape", "Color") VALUES (2, 'B', 'White');
INSERT INTO "appellations" ("No", "Appelation", "County", "State", "Area", "isAVA") VALUES (1, 'Napa', 'Napa', 'CA', 'North Coast', 'Yes');
INSERT INTO "wine" ("Appelation", "Grape", "No", "Winery", "State", "Name", "Year", "Price", "Score", "Cases", "Drink") VALUES ('Napa', 'A', 1, 'W1', 'CA', 'N1', 2020, 50, 90, 100, 'Now');
INSERT INTO "wine" ("Appelation", "Grape", "No", "Winery", "State", "Name", "Year", "Price", "Score", "Cases", "Drink") VALUES ('Napa', 'A', 2, 'W1', 'CA', 'N2', 2020, 50, 90, 100, 'Now');
INSERT INTO "wine" ("Appelation", "Grape", "No", "Winery", "State", "Name", "Year", "Price", "Score", "Cases", "Drink") VALUES ('Napa', 'B', 3, 'W1', 'CA', 'N3', 2020, 50, 90, 100, 'Now');
INSERT INTO "wine" ("Appelation", "Grape", "No", "Winery", "State", "Name", "Year", "Price", "Score", "Cases", "Drink") VALUES ('Napa', NULL, 4, 'W1', 'CA', 'N4', 2020, 50, 90, 100, 'Now');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, grape FROM (SELECT grape, COUNT(*) AS n FROM wine GROUP BY grape) ORDER BY count___, grape NULLS LAST;

/*
Gold Result:
(1, 'B')
(1, None)
(2, 'A')
*/

-- Prediction Query
SELECT COUNT(*), Grape FROM WINE GROUP BY Grape;

/*
Prediction Result:
(1, None)
(2, 'A')
(1, 'B')
*/