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
INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'grape_1', 1160656988, 'win_95e93b', 'ia2yp', 'uzhsrwbbp6lu', 1019800248, -1910425938, -845863578, -1610064545, 'n');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'grape_1', 2087640001, 'win_95e93b', 'dposiie5unw', 'klfa9000t', 1408123494, -1964997180, 1149850321, -1833165707, '6nium52zb');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'grape_1', 902887186, 'win_95e93b', 'qrofqyp5s5b', 'p', 882961052, 743312762, -1822992503, -868774469, 'qa1');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'grape_1', 2137741668, 'win_95e93b', 'ytoo3o9hl7', 'klex14ji', -453362185, 481163439, 2123196517, 364869063, 'q13py');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'grape_1', -977635379, 'win_95e93b', 'sl0', '4', 1649269347, -1116181514, 1255852738, -1555456236, 'kf9vq');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'grape_1', 1836127587, 'win_95e93b', 'f8jegd2', 'vy9uxj4', -1612443122, -2050247126, -736979194, 2103044118, 'h2gndqwnqcx5');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'grape_1', -1106350634, 'win_95e93b', 'tu0', 'z', -1748371085, -1742081330, 894242932, -211209314, 'dqv0gcb9');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'grape_1', 1443629118, 'win_95e93b', 'zbilyrkn', '6vck6ah0f8js', -658391922, -1388029300, -566887085, 602161869, 'xa');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'grape_1', -1888505890, 'win_95e93b', 'z16nijjai5d', 'h5ogrgjd8yz', 1250290042, -1717646459, -1696173285, 710458518, 'sj3ayxp1q430');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'grape_1', 1948383687, 'win_95e93b', 'e', '8c68', -683007527, 2035306060, 1523825314, 2078438287, '5w1of7');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'grape_1', 87529806, 'win_95e93b', 'ctdctmfg62g0', '5q8qdj', -1139855872, -288338724, 1897687032, -241848752, '8507cvtjp');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'grape_1', 1467355421, 'win_95e93b', 'ou5z', '36c', 1722106924, -2072838897, -1173368267, 382831862, '0');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'grape_1', -461418236, 'win_95e93b', 'zjo7wgxd5ysx', 'm', 1721638020, 983324983, 1269522000, 853709925, 'dgj5i');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'grape_1', -15162884, 'win_95e93b', 'pim5', '58q', 1817366143, 1615073310, 1055237066, 988954859, 'th');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'grape_1', 418247369, 'win_95e93b', 'jla', 'okv8uttm', 1553368934, -1252009958, 1908593332, 697257217, '7zzbe8y');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'grape_1', 1043710187, NULL, '42q7sx58b4', 'pmaus3auvmkr', 609771851, -1934017803, 1105964624, -663234145, 'h');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'grape_1', 823835795, NULL, '05a9n0jxf', 'fwsz', -210159774, 270415200, -2071531094, -397848196, '0k32odwcl5a');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'grape_1', 709097796, NULL, 'lwyng', '1', 681061317, 1935791961, 595714424, 1056589776, 'k1');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'grape_1', -360096930, NULL, 't', 'fuqyxuzkb', -30041412, -277407746, -670154354, -2140468103, 'elboeowii');
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
(None,)
('win_95e93b',)
*/