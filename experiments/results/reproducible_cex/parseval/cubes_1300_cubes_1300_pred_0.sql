-- Schema DDL
CREATE TABLE "grapes" ("ID" INTEGER PRIMARY KEY, "Grape" TEXT UNIQUE, "Color" TEXT);

CREATE TABLE "appellations" ("No" INTEGER PRIMARY KEY, "Appelation" TEXT UNIQUE, "County" TEXT, "State" TEXT, "Area" TEXT, "isAVA" TEXT);

CREATE TABLE "wine" ("Appelation" TEXT, "Grape" TEXT, "No" INTEGER, "Winery" TEXT, "State" TEXT, "Name" TEXT, "Year" INTEGER, "Price" INTEGER, "Score" INTEGER, "Cases" INTEGER, "Drink" TEXT, FOREIGN KEY ("Appelation") REFERENCES "appellations" ("Appelation"), FOREIGN KEY ("Grape") REFERENCES "grapes" ("Grape"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: grapes --
INSERT INTO "grapes" ("id", "grape", "color") VALUES (1, 'grape_1', 'rhs_a28ad3');

INSERT INTO "grapes" ("id", "grape", "color") VALUES (-2147483647, 'win_864af5', 'e4');

INSERT INTO "grapes" ("id", "grape", "color") VALUES (-2147483646, 'grape_3', 'rhs_d6a564');

-- Inserting into table: appellations --
INSERT INTO "appellations" ("no", "appelation", "county", "state", "area", "isava") VALUES (-2147483648, 'appelation_1', '5k5swwqcgs', '9n8', '4', 'gu7v');

-- Inserting into table: wine --
INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'win_864af5', 1, 'hria2ypuzhs', 'rwbbp6luhvd', 'tti', -1364429300, -1257178728, 1236688122, 2087640001, 'dposiie5unw');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'win_864af5', 1, 'fa9', '00t5c4e', 'cigce376nium', 283598170, 742285925, -747753377, 902887186, 'qrofqyp5s5b');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'win_864af5', 1, '02eu', 'liqa1', 'ryytoo3', -1666765085, 1178636309, -1390245819, 1055976837, '4ji7zwa');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'win_864af5', 1, '2dwyrq13pyu7', 'd99rljsl0', '4', 1649269347, -1116181514, 1255852738, -1555456236, 'kf9vq');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'win_864af5', 1, '8pz0f8je', 'd2', 'vy9uxj4', -1612443122, -2050247126, -736979194, 2103044118, 'h2gndqwnqcx5');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'win_864af5', 1, 'cprj', 'u0dz7', 'fjgq8n2f3', 806170397, 513454646, -688216274, 331812443, 'cb98ozk3zbil');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'win_864af5', NULL, 'kn6vck6ah0f8', 'sww', 'q7x', -541746689, 1294666887, -515895469, 1427161052, 'z16ni');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'win_864af5', NULL, 'ai5', 'h', 'ogrgjd8y', 1129658414, NULL, 1250290042, -1717646459, 'ri');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'win_864af5', NULL, 'sj3ayxp1q430', 'jh3den8', 'c68x8vacx7', 1523825314, NULL, 2078438287, -47052816, '1of77pzo72c');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'win_864af5', NULL, 'c', 'mfg62', '0v', 820970595, NULL, 1421303999, -1488156735, '1i');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'win_864af5', 199672698, '7cvtjpt', 'tg6bnou5zi', '6c4bfkfo', -1950324754, 2115816682, 76987628, -253138337, 'zj');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'grape_3', 1, 'wgxd5ysxcm', '0oztd', 'j5', -1609653472, NULL, -1405314653, 1816660482, 'npi');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'win_864af5', 1, '58q', 's27p2r94gth2', 'najj', -1351793914, NULL, 1919033056, -1428186898, 'uttmu2ne5');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'grape_1', 1, 'yz7zzb', '8y', 'kv42q7', -2060082151, NULL, -1122409769, 1849819405, 'us3auvmkrpdj');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'win_864af5', 1, 'w5chn9m', 'o705a9n0jxfo', 'ws', 1719800120, NULL, -210159774, 270415200, 'b');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'win_864af5', 1, '0k32o', 'w', 'l', 895277769, NULL, 364043263, -1177989415, 'wyn');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'win_864af5', 1, '1', 'j', '9erhizgk1yoe', 1483450542, NULL, 513375398, 718167481, 'hdt6fuq');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'win_864af5', 1, 'uzkb52', 'gwnlas6', 'elboeowii1', -457369423, NULL, 1557188093, 548968280, 'h66');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'win_864af5', 1, '2xlyo', 'tow9oaawg96a', 'qb0tbindz39t', 2038321753, NULL, 1376887048, 261633665, '8');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'win_864af5', 1, '5wcgumbc3td', 'u6bd0w9603', 'vzxw1rxe9y', -1046720861, NULL, 643589729, -1231488097, '55y3dohvu06d');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'win_864af5', 1, '3', 'rmkio18r', 'i2hy08ftp6', -1853955201, NULL, -805997097, -586285368, 'jaby');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'win_864af5', 1, 'n2mfx7h', '3p6sto1c', '8sh', -63214972, NULL, 1106724223, 1966809332, '7dyyd');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'win_864af5', 1, 'jmgjach8qt', 'a8y3a17v4yg', 'mayq3qdpua', 1291298007, NULL, 1982265552, 2013152515, 'q');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'win_864af5', 1, 'm5', 'wlic7dn2np', '90xdmsqt', -1685482179, NULL, -1391541536, -1025517017, 'i9f2ccukj');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'win_864af5', 1, '1quik1yhb08h', 'st1', 'qomi', 1784997708, NULL, -696672546, 44959255, 'iz78aqql');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'win_864af5', 1, '8', 'tb', 'r9114qbre', 316163741, NULL, -752650834, 2134937984, '8kj');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT color FROM (SELECT LHS.grape AS grape, LHS.no AS NO, LHS.meanprice AS meanprice, RHS.color AS color FROM (SELECT grape, NO, AVG(price) AS meanprice FROM wine GROUP BY grape, NO) AS LHS INNER JOIN grapes AS RHS ON (LHS.no = RHS.id AND LHS.grape = RHS.grape)) ORDER BY color;

/*
Gold Result:
('rhs_a28ad3',)
*/

-- Prediction Query
SELECT T1.Color FROM GRAPES AS T1 JOIN WINE AS T2 ON T1.Grape = T2.Grape GROUP BY T2.Grape ORDER BY AVG(Price) DESC, T1.Color NULLS LAST LIMIT 1;

/*
Prediction Result:
('e4',)
*/