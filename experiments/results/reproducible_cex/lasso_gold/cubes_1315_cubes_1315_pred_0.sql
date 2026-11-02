-- Schema DDL
CREATE TABLE "grapes" ("ID" INTEGER PRIMARY KEY, "Grape" TEXT UNIQUE, "Color" TEXT);

CREATE TABLE "appellations" ("No" INTEGER PRIMARY KEY, "Appelation" TEXT UNIQUE, "County" TEXT, "State" TEXT, "Area" TEXT, "isAVA" TEXT);

CREATE TABLE "wine" ("Appelation" TEXT, "Grape" TEXT, "No" INTEGER, "Winery" TEXT, "State" TEXT, "Name" TEXT, "Year" INTEGER, "Price" INTEGER, "Score" INTEGER, "Cases" INTEGER, "Drink" TEXT, FOREIGN KEY ("Appelation") REFERENCES "appellations" ("Appelation"), FOREIGN KEY ("Grape") REFERENCES "grapes" ("Grape"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "appellations" ("no", "appelation", "county", "state", "area", "isava") VALUES (1159, 'per', 'discussion', 'Alabama', 'avoid', 'second');
INSERT INTO "appellations" ("no", "appelation", "county", "state", "area", "isava") VALUES (1171, 'own', 'part', 'New Mexico', 'eight', 'still');
INSERT INTO "grapes" ("id", "grape", "color") VALUES (1160, 'program', 'artist');
INSERT INTO "grapes" ("id", "grape", "color") VALUES (1172, 'material', 'surface');
INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('per', 'program', 1161, 'John Anthony', 'Iowa', 'Andre Rivera', 1162, 1163, 1164, 1165, 'my');
INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('per', 'program', 1166, 'economy', 'Louisiana', 'Cindy Anderson', 1167, 1168, 1169, 1170, 'worry');
INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('own', 'material', 1173, 'us', 'Nebraska', 'Brent Jordan', 1174, 1175, 1176, 1177, 'land');
INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('own', 'material', 1178, 'us', 'New Jersey', 'Amy Valdez', 1179, 1180, 1181, 1182, 'race');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "name_other" AS "name" FROM (SELECT * FROM (SELECT "LHS"."no" AS "no", "LHS"."grape" AS "grape", "LHS"."winery" AS "winery", "LHS"."appelation" AS "appelation", "LHS"."state" AS "state", "LHS"."name" AS "name", "LHS"."year" AS "year", "LHS"."price" AS "price", "LHS"."score" AS "score", "LHS"."cases" AS "cases", "LHS"."drink" AS "drink", "RHS"."no" AS "no_other", "RHS"."grape" AS "grape_other", "RHS"."winery" AS "winery_other", "RHS"."appelation" AS "appelation_other", "RHS"."state" AS "state_other", "RHS"."name" AS "name_other", "RHS"."year" AS "year_other", "RHS"."price" AS "price_other", "RHS"."score" AS "score_other", "RHS"."cases" AS "cases_other", "RHS"."drink" AS "drink_other" FROM "wine" AS "LHS" CROSS JOIN "wine" AS "RHS") WHERE ("price" < "price_other")) WHERE ("winery" = 'John Anthony') ORDER BY name;

/*
Gold Result:
('Amy Valdez',)
('Brent Jordan',)
('Cindy Anderson',)
*/

-- Prediction Query
SELECT DISTINCT Name FROM WINE WHERE Price > (SELECT MIN(Price) FROM wine WHERE Winery = 'John Anthony');

/*
Prediction Result:
('Cindy Anderson',)
('Brent Jordan',)
('Amy Valdez',)
*/