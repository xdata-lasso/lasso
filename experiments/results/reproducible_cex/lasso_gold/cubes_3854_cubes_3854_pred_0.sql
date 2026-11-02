-- Schema DDL
CREATE TABLE "grapes" ("ID" INTEGER PRIMARY KEY, "Grape" TEXT UNIQUE, "Color" TEXT);

CREATE TABLE "appellations" ("No" INTEGER PRIMARY KEY, "Appelation" TEXT UNIQUE, "County" TEXT, "State" TEXT, "Area" TEXT, "isAVA" TEXT);

CREATE TABLE "wine" ("Appelation" TEXT, "Grape" TEXT, "No" INTEGER, "Winery" TEXT, "State" TEXT, "Name" TEXT, "Year" INTEGER, "Price" INTEGER, "Score" INTEGER, "Cases" INTEGER, "Drink" TEXT, FOREIGN KEY ("Appelation") REFERENCES "appellations" ("Appelation"), FOREIGN KEY ("Grape") REFERENCES "grapes" ("Grape"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "appellations" ("no", "appelation", "county", "state", "area", "isava") VALUES (1025, 'source', 'great', 'Connecticut', 'best', 'husband');
INSERT INTO "appellations" ("no", "appelation", "county", "state", "area", "isava") VALUES (1037, 'production', 'present', 'Mississippi', 'participant', 'dark');
INSERT INTO "grapes" ("id", "grape", "color") VALUES (1026, 'bill', 'her');
INSERT INTO "grapes" ("id", "grape", "color") VALUES (1038, 'sea', 'available');
INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('source', 'bill', 1027, 'throw', 'Minnesota', 'Renee Blair', 1028, 1029, 1030, 1031, 'not');
INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('source', 'bill', 1032, 'capital', 'Minnesota', 'Jamie Arnold', 1033, 1034, 1035, 1036, 'themselves');
INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('production', 'sea', 1039, 'answer', 'Texas', 'Dylan Miller', 1040, 1041, NULL, 1043, 'early');
INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('production', 'sea', 1044, 'trial', 'Texas', 'Donald Reid', 1045, 1046, NULL, 1048, 'his');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT winery FROM (SELECT LHS.no AS NO, LHS.grape AS grape, LHS.winery AS winery, LHS.appelation AS appelation, LHS.state AS state, LHS.name AS name, LHS.year AS YEAR, LHS.price AS price, LHS.score AS score, LHS.cases AS cases, LHS.drink AS drink FROM wine AS LHS INNER JOIN (SELECT state, MIN(score) AS score FROM wine GROUP BY state) AS RHS ON (LHS.state = RHS.state AND LHS.score = RHS.score)) ORDER BY winery;

/*
Gold Result:
('throw',)
*/

-- Prediction Query
SELECT Winery FROM WINE ORDER BY SCORE, WINE.appelation NULLS LAST, WINE.grape NULLS LAST, WINE.no NULLS LAST, WINE.winery NULLS LAST, WINE.state NULLS LAST, WINE.name NULLS LAST, WINE.year NULLS LAST, WINE.price NULLS LAST, WINE.cases NULLS LAST, WINE.drink NULLS LAST LIMIT 1;

/*
Prediction Result:
('answer',)
*/