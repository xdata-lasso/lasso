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
INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'grape_1', 1160656988, 'ia2yp', 'win_0967d2', 'uzhsrwbbp6lu', 1, 1019800248, -1910425938, -845863578, 'lbn');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'grape_1', 2087640001, 'dposiie5unw', 'win_0967d2', 'klfa9000t', 1, 1408123494, -1964997180, 1149850321, 'e');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'grape_1', 1313172851, 'm52zbu', 'win_0967d2', '4nrq', 1, 418417917, -1031969798, -1106983592, '5bbp0');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'grape_1', -751275471, 'iqa', 'win_0967d2', '1ryytoo', 1, 1644911394, -1666765085, 1178636309, 'ex1');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'grape_1', 105869088, 'au2dwy', 'win_0967d2', 'q13py', 1, 244829661, -1362461264, -904834265, 'b4yp5qi');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'grape_1', 2056419640, 'vqx58pz0f', 'win_0967d2', '8jegd21vy9ux', 1, -1492524358, -1612443122, -2050247126, 'lph2gn');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'grape_1', -664193365, 'cx5hn', 'p', 'jtu0d', NULL, 401805964, -1485777725, -1255130038, '3d');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'grape_1', -1454058168, 'bilyrkn', 'win_0967d2', '6vck6ah0f8js', NULL, NULL, -658391922, -1388029300, 'xb72fxa7r');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'grape_1', 1427161052, 'z16ni', 'win_0967d2', 'jai', NULL, NULL, 1746373317, 1360271423, 'ogrgjd8y');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'grape_1', 600440952, 'f', 'win_0967d2', 'og', NULL, NULL, -946046410, -902895762, 'ayxp1q43');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'grape_1', 518609210, '3d', NULL, 'n8', 195720193, 1774087382, 1732258051, -1762140823, 'w1of77pz');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'grape_1', -1957268147, 'c', NULL, 'mfg62', 1, NULL, -1744557630, 1870300798, 'q8qdjpe1');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'grape_1', -241848752, '8507cvtjp', NULL, 'ttg6bnou5zi3', 1, NULL, -68044929, -1776877925, 'oa');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'grape_1', 2115816682, '7z2zezjo7wg', NULL, 'd5ysxc', 1, NULL, -405743609, -1935752926, '5i3');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'grape_1', 1816660482, 'npi', 'win_0967d2', '5k58', 1, NULL, -1125548818, 1497321728, '4gth2mnaj');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'grape_1', -2096405521, 'okv8uttmu2', 'win_0967d2', 'e578', 1, NULL, 1908593332, 697257217, '7zzbe8y');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'grape_1', 1043710187, '42q7sx58b4', 'win_0967d2', 'pmaus3auvmkr', 1, NULL, 609771851, -1934017803, 'wzw5chn9mo70');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'grape_1', -1245584612, 'xfo', 'win_0967d2', 'ws', 1, NULL, 1719800120, -210159774, 'obb0q0k32o');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'grape_1', 440115543, 'msorlwyngc', 'win_0967d2', 'dj9erhi', 1, NULL, 1056589776, -499913447, 'yo');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'grape_1', -1614619556, '6fuqy', 'win_0967d2', 'uzkb52', 1, NULL, -277407746, -670154354, 'as6');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'grape_1', 1048147204, 'eowi', 'win_0967d2', '1z5', 1, NULL, 1557188093, 548968280, 'h66');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'grape_1', 287256667, 'otow9oa', 'win_0967d2', 'awg96aqb0tbi', 1, NULL, 503053726, -1897615568, '9tajz9td');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'grape_1', 1148916014, 'g', 'win_0967d2', 'mbc3td', 1, NULL, 1964331395, -1943814113, '9603vz');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT meanprice AS avg_price_, YEAR FROM (SELECT state, YEAR, AVG(price) AS meanprice FROM wine GROUP BY state, YEAR) ORDER BY avg_price_, YEAR NULLS LAST;

/*
Gold Result:
(None, 1)
(None, None)
(401805964.0, None)
(540593059.3333334, 1)
(1774087382.0, 195720193)
*/

-- Prediction Query
SELECT AVG(Price), YEAR FROM WINE GROUP BY YEAR;

/*
Prediction Result:
(401805964.0, None)
(540593059.3333334, 1)
(1774087382.0, 195720193)
*/