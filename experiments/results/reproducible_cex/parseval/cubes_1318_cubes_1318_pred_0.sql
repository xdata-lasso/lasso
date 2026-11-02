-- Schema DDL
CREATE TABLE "grapes" ("ID" INTEGER PRIMARY KEY, "Grape" TEXT UNIQUE, "Color" TEXT);

CREATE TABLE "appellations" ("No" INTEGER PRIMARY KEY, "Appelation" TEXT UNIQUE, "County" TEXT, "State" TEXT, "Area" TEXT, "isAVA" TEXT);

CREATE TABLE "wine" ("Appelation" TEXT, "Grape" TEXT, "No" INTEGER, "Winery" TEXT, "State" TEXT, "Name" TEXT, "Year" INTEGER, "Price" INTEGER, "Score" INTEGER, "Cases" INTEGER, "Drink" TEXT, FOREIGN KEY ("Appelation") REFERENCES "appellations" ("Appelation"), FOREIGN KEY ("Grape") REFERENCES "grapes" ("Grape"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: grapes --
INSERT INTO "grapes" ("id", "grape", "color") VALUES (-2147483648, 'grape_1', 'e4');

-- Inserting into table: appellations --
INSERT INTO "appellations" ("no", "appelation", "county", "state", "area", "isava") VALUES (-2147483648, 'appelation_1', '5k5swwqcgs', '9n8', '4', 'gu7v');

-- Inserting into table: wine --
INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'grape_1', 1160656988, 'ia2yp', 'uzhsrwbbp6lu', 'hvdlttilbnpr', 2010, 1, 2087640001, 907682809, 'siie');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'grape_1', 1861536320, '6klfa9', '00t5c4e', 'cigce376nium', 2010, 1, 283598170, 742285925, 'u');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'grape_1', 1119186446, 'rqrofqyp5s', 'bbp02eut', 'iqa', 2010, 1, -314162272, 2137741668, 'ytoo3o9hl7');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'grape_1', -1390245819, 'x14ji7zwau2d', 'yrq13p', 'u78d99r', 2011, 1, -1362461264, -904834265, 'b4yp5qi');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'grape_1', 2056419640, 'vqx58pz0f', '8jegd21vy9ux', 'j4hwbdvlph', 2010, NULL, -261132974, -1264842910, 'wnqcx');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'grape_1', -1245312912, 'rjtu', 'dz79fjg', '8n2f3', NULL, 806170397, 513454646, -688216274, 'gcb98ozk3z');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT price FROM wine WHERE (YEAR <= 2010) ORDER BY price, wine.appelation NULLS LAST, wine.grape NULLS LAST, wine.no NULLS LAST, wine.winery NULLS LAST, wine.state NULLS LAST, wine.name NULLS LAST, wine.year NULLS LAST, wine.score NULLS LAST, wine.cases NULLS LAST, wine.drink NULLS LAST;

/*
Gold Result:
(None,)
(1,)
(1,)
(1,)
*/

-- Prediction Query
SELECT Price FROM WINE WHERE YEAR < 2010;

/*
Prediction Result:
*/