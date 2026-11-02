-- Schema DDL
CREATE TABLE "grapes" ("ID" INTEGER PRIMARY KEY, "Grape" TEXT UNIQUE, "Color" TEXT);

CREATE TABLE "appellations" ("No" INTEGER PRIMARY KEY, "Appelation" TEXT UNIQUE, "County" TEXT, "State" TEXT, "Area" TEXT, "isAVA" TEXT);

CREATE TABLE "wine" ("Appelation" TEXT, "Grape" TEXT, "No" INTEGER, "Winery" TEXT, "State" TEXT, "Name" TEXT, "Year" INTEGER, "Price" INTEGER, "Score" INTEGER, "Cases" INTEGER, "Drink" TEXT, FOREIGN KEY ("Appelation") REFERENCES "appellations" ("Appelation"), FOREIGN KEY ("Grape") REFERENCES "grapes" ("Grape"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO appellations (No, Appelation, County, State, Area, isAVA) VALUES (1, 'App1', 'County1', 'State1', 'Z_Area', 'Yes');
INSERT INTO appellations (No, Appelation, County, State, Area, isAVA) VALUES (2, 'App2', 'County2', 'State2', 'A_Area', 'Yes');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT area, county FROM appellations ORDER BY area, appellations.no NULLS LAST;

/*
Gold Result:
('A_Area', 'County2')
('Z_Area', 'County1')
*/

-- Prediction Query
SELECT Area, County FROM APPELLATIONS;

/*
Prediction Result:
('Z_Area', 'County1')
('A_Area', 'County2')
*/