-- Schema DDL
CREATE TABLE "grapes" ("ID" INTEGER PRIMARY KEY, "Grape" TEXT UNIQUE, "Color" TEXT);

CREATE TABLE "appellations" ("No" INTEGER PRIMARY KEY, "Appelation" TEXT UNIQUE, "County" TEXT, "State" TEXT, "Area" TEXT, "isAVA" TEXT);

CREATE TABLE "wine" ("Appelation" TEXT, "Grape" TEXT, "No" INTEGER, "Winery" TEXT, "State" TEXT, "Name" TEXT, "Year" INTEGER, "Price" INTEGER, "Score" INTEGER, "Cases" INTEGER, "Drink" TEXT, FOREIGN KEY ("Appelation") REFERENCES "appellations" ("Appelation"), FOREIGN KEY ("Grape") REFERENCES "grapes" ("Grape"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO wine (Winery, State) VALUES ('W1', 'CA');
INSERT INTO wine (Winery, State) VALUES ('W1', 'CA');
INSERT INTO wine (Winery, State) VALUES ('W1', 'OR');
INSERT INTO wine (Winery, State) VALUES ('W1', 'OR');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT winery FROM (SELECT state, winery, COUNT(*) AS n FROM wine GROUP BY state, winery) WHERE (n >= 4) ORDER BY winery;

/*
Gold Result:
*/

-- Prediction Query
SELECT Winery FROM WINE GROUP BY Winery HAVING COUNT(*) >= 4;

/*
Prediction Result:
('W1',)
*/