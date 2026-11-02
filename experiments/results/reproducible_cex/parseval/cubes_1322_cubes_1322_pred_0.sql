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
INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'grape_1', 1160656988, 'ia2yp', 'uzhsrwbbp6lu', 'win_c4e8ea', 0, 1019800248, -1910425938, -845863578, 'lbn');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'grape_1', 2087640001, 'dposiie5unw', 'klfa9000t', 'win_c4e8ea', 0, 1408123494, -1964997180, 1149850321, 'e');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'grape_1', 1313172851, 'm52zbu', '4nrq', 'win_c4e8ea', 0, 418417917, -1031969798, -1106983592, '5bbp0');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'grape_1', -751275471, 'iqa', '1ryytoo', 'win_c4e8ea', 2001, 1644911394, -1666765085, 1178636309, 'ex1');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'grape_1', 105869088, 'au2dwy', 'q13py', NULL, 0, 244829661, -1362461264, -904834265, 'b4yp5qi');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'grape_1', 2056419640, 'vqx58pz0f', '8jegd21vy9ux', 'j4hwbdvlph', 2010, -261132974, -1264842910, -1052964641, 'qcx5');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'grape_1', -59984348, 'wqcgsk', '9n8c4pgu7v', 'e4', NULL, 1160656988, -992890117, 1914020640, 'ypuzhsrw');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM wine WHERE (YEAR <= 2000 OR YEAR >= 2010) ORDER BY name, wine.appelation NULLS LAST, wine.grape NULLS LAST, wine.no NULLS LAST, wine.winery NULLS LAST, wine.state NULLS LAST, wine.year NULLS LAST, wine.price NULLS LAST, wine.score NULLS LAST, wine.cases NULLS LAST, wine.drink NULLS LAST;

/*
Gold Result:
(None,)
('j4hwbdvlph',)
('win_c4e8ea',)
('win_c4e8ea',)
('win_c4e8ea',)
*/

-- Prediction Query
SELECT DISTINCT Name FROM WINE WHERE YEAR < 2000 OR YEAR > 2010;

/*
Prediction Result:
('win_c4e8ea',)
(None,)
*/