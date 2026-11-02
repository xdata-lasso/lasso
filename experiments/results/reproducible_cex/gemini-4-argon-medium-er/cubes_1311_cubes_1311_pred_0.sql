-- Schema DDL
CREATE TABLE "grapes" ("ID" INTEGER PRIMARY KEY, "Grape" TEXT UNIQUE, "Color" TEXT);

CREATE TABLE "appellations" ("No" INTEGER PRIMARY KEY, "Appelation" TEXT UNIQUE, "County" TEXT, "State" TEXT, "Area" TEXT, "isAVA" TEXT);

CREATE TABLE "wine" ("Appelation" TEXT, "Grape" TEXT, "No" INTEGER, "Winery" TEXT, "State" TEXT, "Name" TEXT, "Year" INTEGER, "Price" INTEGER, "Score" INTEGER, "Cases" INTEGER, "Drink" TEXT, FOREIGN KEY ("Appelation") REFERENCES "appellations" ("Appelation"), FOREIGN KEY ("Grape") REFERENCES "grapes" ("Grape"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO grapes (ID, Grape, Color) VALUES (1, 'A_Grape', 'Red');
INSERT INTO grapes (ID, Grape, Color) VALUES (2, 'B_Grape', 'White');
INSERT INTO appellations (No, Appelation, County, State, Area, isAVA) VALUES (1, 'App1', 'County1', 'State1', 'Area1', 'Yes');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('App1', 'A_Grape', 1, 'Winery1', 'State1', 'Z_Name', 2020, 50, 95, 100, 'Now');
INSERT INTO wine (Appelation, Grape, No, Winery, State, Name, Year, Price, Score, Cases, Drink) VALUES ('App1', 'B_Grape', 2, 'Winery2', 'State1', 'A_Name', 2020, 50, 95, 100, 'Now');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT grape, appelation, name FROM wine WHERE (score > 93) ORDER BY grape, wine.appelation NULLS LAST, wine.no NULLS LAST, wine.winery NULLS LAST, wine.state NULLS LAST, wine.name NULLS LAST, wine.year NULLS LAST, wine.price NULLS LAST, wine.score NULLS LAST, wine.cases NULLS LAST, wine.drink NULLS LAST;

/*
Gold Result:
('A_Grape', 'App1', 'Z_Name')
('B_Grape', 'App1', 'A_Name')
*/

-- Prediction Query
SELECT Grape, Appelation, Name FROM WINE WHERE Score > 93 ORDER BY Name, WINE.appelation NULLS LAST, WINE.grape NULLS LAST, WINE.no NULLS LAST, WINE.winery NULLS LAST, WINE.state NULLS LAST, WINE.year NULLS LAST, WINE.price NULLS LAST, WINE.score NULLS LAST, WINE.cases NULLS LAST, WINE.drink NULLS LAST;

/*
Prediction Result:
('B_Grape', 'App1', 'A_Name')
('A_Grape', 'App1', 'Z_Name')
*/