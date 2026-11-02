-- Schema DDL
CREATE TABLE "grapes" ("ID" INTEGER PRIMARY KEY, "Grape" TEXT UNIQUE, "Color" TEXT);

CREATE TABLE "appellations" ("No" INTEGER PRIMARY KEY, "Appelation" TEXT UNIQUE, "County" TEXT, "State" TEXT, "Area" TEXT, "isAVA" TEXT);

CREATE TABLE "wine" ("Appelation" TEXT, "Grape" TEXT, "No" INTEGER, "Winery" TEXT, "State" TEXT, "Name" TEXT, "Year" INTEGER, "Price" INTEGER, "Score" INTEGER, "Cases" INTEGER, "Drink" TEXT, FOREIGN KEY ("Appelation") REFERENCES "appellations" ("Appelation"), FOREIGN KEY ("Grape") REFERENCES "grapes" ("Grape"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "appellations" ("no", "appelation", "county", "state", "area", "isava") VALUES (1019, 'great', 'blue', 'Colorado', 'husband', 'bill');
INSERT INTO "appellations" ("no", "appelation", "county", "state", "area", "isava") VALUES (1025, 'win', 'human', 'Oklahoma', 'finally', 'themselves');
INSERT INTO "grapes" ("id", "grape", "color") VALUES (1020, 'her', 'throw');
INSERT INTO "grapes" ("id", "grape", "color") VALUES (1026, 'production', 'present');
INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('great', 'her', 1020, 'guy', 'Rhode Island', 'Andrew Stevens', 1021, 1022, 1023, 1024, 'capital');
INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('win', 'production', 1026, 'value', 'Mississippi', 'Michele Williams', 1027, NULL, 1029, 1030, 'drive');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT color FROM (SELECT LHS.grape AS grape, LHS.no AS NO, LHS.meanprice AS meanprice, RHS.color AS color FROM (SELECT grape, NO, AVG(price) AS meanprice FROM wine GROUP BY grape, NO) AS LHS INNER JOIN grapes AS RHS ON (LHS.no = RHS.id AND LHS.grape = RHS.grape)) ORDER BY color;

/*
Gold Result:
('present',)
('throw',)
*/

-- Prediction Query
SELECT T1.Color FROM GRAPES AS T1 JOIN WINE AS T2 ON T1.Grape = T2.Grape GROUP BY T2.Grape ORDER BY AVG(Price) DESC, T1.Color NULLS LAST LIMIT 1;

/*
Prediction Result:
('throw',)
*/