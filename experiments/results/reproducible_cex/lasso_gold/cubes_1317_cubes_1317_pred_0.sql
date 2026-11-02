-- Schema DDL
CREATE TABLE "grapes" ("ID" INTEGER PRIMARY KEY, "Grape" TEXT UNIQUE, "Color" TEXT);

CREATE TABLE "appellations" ("No" INTEGER PRIMARY KEY, "Appelation" TEXT UNIQUE, "County" TEXT, "State" TEXT, "Area" TEXT, "isAVA" TEXT);

CREATE TABLE "wine" ("Appelation" TEXT, "Grape" TEXT, "No" INTEGER, "Winery" TEXT, "State" TEXT, "Name" TEXT, "Year" INTEGER, "Price" INTEGER, "Score" INTEGER, "Cases" INTEGER, "Drink" TEXT, FOREIGN KEY ("Appelation") REFERENCES "appellations" ("Appelation"), FOREIGN KEY ("Grape") REFERENCES "grapes" ("Grape"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "appellations" ("no", "appelation", "county", "state", "area", "isava") VALUES (1120, 'between', 'bill', 'Texas', 'lawyer', 'health');
INSERT INTO "appellations" ("no", "appelation", "county", "state", "area", "isava") VALUES (1126, 'interesting', 'should', 'Michigan', 'such', 'training');
INSERT INTO "grapes" ("id", "grape", "color") VALUES (1121, 'land', 'item');
INSERT INTO "grapes" ("id", "grape", "color") VALUES (1127, 'boy', 'energy');
INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('between', 'land', 1122, 'manage', 'Illinois', 'Brenda White', 1123, 50, 1124, 1125, 'ask');
INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('interesting', 'boy', 1123, 'enjoy', 'Washington', 'Matthew Lucas', 1124, 50, 1125, 1126, 'maintain');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT winery FROM wine WHERE (price >= 50 AND price <= 100) ORDER BY winery;

/*
Gold Result:
('enjoy',)
('manage',)
*/

-- Prediction Query
SELECT DISTINCT Winery FROM WINE WHERE Price BETWEEN 50 AND 100;

/*
Prediction Result:
('manage',)
('enjoy',)
*/