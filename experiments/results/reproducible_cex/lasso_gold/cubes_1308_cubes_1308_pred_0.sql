-- Schema DDL
CREATE TABLE "grapes" ("ID" INTEGER PRIMARY KEY, "Grape" TEXT UNIQUE, "Color" TEXT);

CREATE TABLE "appellations" ("No" INTEGER PRIMARY KEY, "Appelation" TEXT UNIQUE, "County" TEXT, "State" TEXT, "Area" TEXT, "isAVA" TEXT);

CREATE TABLE "wine" ("Appelation" TEXT, "Grape" TEXT, "No" INTEGER, "Winery" TEXT, "State" TEXT, "Name" TEXT, "Year" INTEGER, "Price" INTEGER, "Score" INTEGER, "Cases" INTEGER, "Drink" TEXT, FOREIGN KEY ("Appelation") REFERENCES "appellations" ("Appelation"), FOREIGN KEY ("Grape") REFERENCES "grapes" ("Grape"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "appellations" ("no", "appelation", "county", "state", "area", "isava") VALUES (1008, 'knowledge', 'almost', 'Alaska', 'better', 'discover');
INSERT INTO "appellations" ("no", "appelation", "county", "state", "area", "isava") VALUES (1015, 'list', 'perform', 'Louisiana', 'table', 'true');
INSERT INTO "appellations" ("no", "appelation", "county", "state", "area", "isava") VALUES (1022, 'great', 'blue', 'Colorado', 'husband', 'bill');
INSERT INTO "grapes" ("id", "grape", "color") VALUES (1009, 'early', 'mouth');
INSERT INTO "grapes" ("id", "grape", "color") VALUES (1016, 'according', 'song');
INSERT INTO "grapes" ("id", "grape", "color") VALUES (1023, 'capital', 'her');
INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('knowledge', 'early', 1010, 'play', 'Oklahoma', 'Matthew Gardner', 1011, 1012, 1013, 1014, 'discussion');
INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES (NULL, 'according', 1017, 'sure', 'Hawaii', 'Gina Moore', 1018, 1019, 1020, 1021, 'source');
INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('great', 'according', 1024, 'throw', 'Minnesota', 'Renee Blair', 1025, 1026, 1027, 1028, 'not');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, grape FROM (SELECT grape, COUNT(*) AS n FROM wine GROUP BY grape) ORDER BY count___, grape NULLS LAST;

/*
Gold Result:
(1, 'early')
(2, 'according')
*/

-- Prediction Query
SELECT COUNT(*), Grape FROM WINE GROUP BY Grape;

/*
Prediction Result:
(2, 'according')
(1, 'early')
*/