-- Schema DDL
CREATE TABLE "grapes" ("ID" INTEGER PRIMARY KEY, "Grape" TEXT UNIQUE, "Color" TEXT);

CREATE TABLE "appellations" ("No" INTEGER PRIMARY KEY, "Appelation" TEXT UNIQUE, "County" TEXT, "State" TEXT, "Area" TEXT, "isAVA" TEXT);

CREATE TABLE "wine" ("Appelation" TEXT, "Grape" TEXT, "No" INTEGER, "Winery" TEXT, "State" TEXT, "Name" TEXT, "Year" INTEGER, "Price" INTEGER, "Score" INTEGER, "Cases" INTEGER, "Drink" TEXT, FOREIGN KEY ("Appelation") REFERENCES "appellations" ("Appelation"), FOREIGN KEY ("Grape") REFERENCES "grapes" ("Grape"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "wine" ("Name", "Price") VALUES ('A', 20);
INSERT INTO "wine" ("Name", "Price") VALUES ('B', 10);
INSERT INTO "wine" ("Name", "Price") VALUES (NULL, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT name FROM wine ORDER BY name;

/*
Gold Result:
(None,)
('A',)
('B',)
*/

-- Prediction Query
SELECT DISTINCT Name FROM WINE ORDER BY price, Name NULLS LAST;

/*
Prediction Result:
(None,)
('B',)
('A',)
*/