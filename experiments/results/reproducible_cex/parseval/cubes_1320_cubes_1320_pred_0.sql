-- Schema DDL
CREATE TABLE "grapes" ("ID" INTEGER PRIMARY KEY, "Grape" TEXT UNIQUE, "Color" TEXT);

CREATE TABLE "appellations" ("No" INTEGER PRIMARY KEY, "Appelation" TEXT UNIQUE, "County" TEXT, "State" TEXT, "Area" TEXT, "isAVA" TEXT);

CREATE TABLE "wine" ("Appelation" TEXT, "Grape" TEXT, "No" INTEGER, "Winery" TEXT, "State" TEXT, "Name" TEXT, "Year" INTEGER, "Price" INTEGER, "Score" INTEGER, "Cases" INTEGER, "Drink" TEXT, FOREIGN KEY ("Appelation") REFERENCES "appellations" ("Appelation"), FOREIGN KEY ("Grape") REFERENCES "grapes" ("Grape"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: grapes --
INSERT INTO "grapes" ("id", "grape", "color") VALUES (-2147483648, 'grape_1', '5sw');

INSERT INTO "grapes" ("id", "grape", "color") VALUES (-2147483647, 'rhs_1b47ee', 'wbbp6luhvdlt');

-- Inserting into table: appellations --
INSERT INTO "appellations" ("no", "appelation", "county", "state", "area", "isava") VALUES (1, 'lhs_559d02', 'lhs_c3eef0', 'lhs_077abc', 'North Coast', 'lhs_c02386');

INSERT INTO "appellations" ("no", "appelation", "county", "state", "area", "isava") VALUES (2, 'appelation_2', 'h55y', 'dohvu06d', 'a35rmki', '18ri');

INSERT INTO "appellations" ("no", "appelation", "county", "state", "area", "isava") VALUES (-2147483646, 'appelation_3', 'hy08ftp6', 'wt', 'North Coast', 'xxnja');

-- Inserting into table: wine --
INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_559d02', 'grape_1', 1, 'qcgsk9', '8c4p', 'u7', -734455130, 1744686505, -1633151678, -252690330, 'uzhs');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_559d02', 'rhs_1b47ee', 1, 'rhs_1c0ce1', 'ilbnp', 'rhs_b80b92', 1, 1, 1, 1, 'rhs_6ff56f');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_559d02', 'grape_1', 1, 'dposiie5unw', 'klfa9000t', 'c4ecigce', -1585009206, -53231346, -443340271, 757448742, '4nrq');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_559d02', 'rhs_1b47ee', 1, 'rhs_1c0ce1', 'fqyp', 'rhs_b80b92', 1, 1, 1, 1, 'rhs_6ff56f');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_559d02', 'rhs_1b47ee', 1, 'bbp02eut', 'iqa', '1ryytoo', 1644911394, -1666765085, 1178636309, -1390245819, 'x14ji7zwau2d');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_559d02', 'rhs_1b47ee', 1, 'rhs_1c0ce1', 'yrq13pyu78d9', 'rhs_b80b92', 1, 1, 1, 1, 'rhs_6ff56f');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_559d02', 'grape_1', 1, 'sl0', '4', 'p5qi2rk', -705985602, 537874887, -461695645, 836513442, '8jegd21vy9ux');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_559d02', 'rhs_1b47ee', 1, 'rhs_1c0ce1', 'hwbdvlph', 'rhs_b80b92', 1, 1, 1, 1, 'rhs_6ff56f');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_559d02', 'grape_1', 1, 'dqwn', 'cx5hn', 'p', -988981234, -841004020, -361507387, 401805964, 'gq8');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_559d02', 'rhs_1b47ee', 1, 'rhs_1c0ce1', 'f3dqv0gc', 'rhs_b80b92', 1, 1, 1, 1, 'rhs_6ff56f');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_559d02', 'grape_1', 1, 'k3zbily', 'kn6vc', '6ah', -348113485, 138842628, -932772113, -639539893, '7xb72');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_559d02', 'rhs_1b47ee', 1, 'rhs_1c0ce1', 'a7ryfd', 'rhs_b80b92', 1, 1, 1, 1, 'rhs_6ff56f');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_559d02', 'rhs_1b47ee', 1, '16nijjai5dh', 'ogrgjd8y', 't1afgog', -946046410, -902895762, -197933860, 2111987706, 'p1q430');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_559d02', 'rhs_1b47ee', 1, 'rhs_1c0ce1', 'jh3den8c68', 'rhs_b80b92', 1, 1, 1, 1, 'rhs_6ff56f');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_559d02', 'rhs_1b47ee', 1, 'c', 'x7afu5w1of77', 'zo72', -1957268147, -1928431425, 1303877941, -1284905200, NULL);

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_559d02', 'rhs_1b47ee', 1, 'rhs_1c0ce1', '2g0v5q8qd', 'rhs_b80b92', 1, 1, 1, 1, NULL);

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_559d02', 'grape_1', 1, '1i', '2278', '07cvtjpt', 453836040, 1467355421, NULL, -1171104889, '5zi36c4bfkfo');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_559d02', 'rhs_1b47ee', 1, 'rhs_1c0ce1', 'cd07z2zezjo7', 'rhs_b80b92', 1, 1, NULL, 1, 'rhs_6ff56f');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_559d02', 'grape_1', 1, 'd5ysxc', 'r0oz', 'dgj5i', -176606723, -15162884, 1339733032, -1556979799, 'k58qs27p');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_559d02', 'rhs_1b47ee', 1, 'rhs_1c0ce1', '4gth2mnaj', 'rhs_b80b92', 1, 1, 1, 1, 'rhs_6ff56f');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_559d02', 'grape_1', 1, '3', 'okv8uttmu2', 'e578', 1908593332, 697257217, -451030047, NULL, 'be8yvkv42q7');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_559d02', 'rhs_1b47ee', 1, 'rhs_1c0ce1', '58b4pm', 'rhs_b80b92', 1, 1, 1, NULL, 'rhs_6ff56f');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_559d02', 'rhs_1b47ee', 1, NULL, '3auvm', 'rpd', -609553675, 989018473, -55494714, -1674145149, 'mo705a9n0');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_559d02', 'rhs_1b47ee', 1, NULL, 'fofwsz', 'rhs_b80b92', 1, 1, 1, 1, 'rhs_6ff56f');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_559d02', 'grape_1', NULL, '2zobb0q0k32o', 'w', 'l', 895277769, 364043263, -1177989415, -1352968577, 'ngc1dj9');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_559d02', 'rhs_1b47ee', NULL, 'rhs_1c0ce1', 'rhizgk1yoey', 'rhs_b80b92', 1, 1, 1, 1, 'rhs_6ff56f');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_559d02', 'grape_1', 1, 'hdt6fuq', 'xuzkb52', 'gwnlas6', NULL, -2076274980, 1731324803, -1159083009, 'i1z');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_559d02', 'rhs_1b47ee', 1, 'rhs_1c0ce1', 'xih6', 'rhs_b80b92', NULL, 1, 1, 1, 'rhs_6ff56f');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_559d02', 'rhs_1b47ee', 1, 'xlyotow9', 'aawg', '6aqb0tbin', -1897615568, NULL, 2085299664, 2038321753, 'z9t');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_559d02', 'rhs_1b47ee', 1, 'rhs_1c0ce1', 'n5wcgumbc', 'rhs_b80b92', 1, NULL, 1, 1, 'rhs_6ff56f');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_559d02', 'rhs_1b47ee', 1, 'u', 'bd0w9603v', NULL, 2018368241, 920097188, -639616320, 1689143863, 'e9yfk7');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_559d02', 'rhs_1b47ee', 1, 'rhs_1c0ce1', '162', 'rhs_b80b92', 1, 1, 1, 1, 'rhs_6ff56f');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_559d02', 'grape_1', -1312038093, 'n2mfx7h33p', '6sto1cj8sh5k', 'zys7', 1487347213, 1328948152, -1923069176, -1520090613, 'gjach8qta8y');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "name" FROM (SELECT "LHS"."no" AS "no", "LHS"."appelation" AS "appelation", "LHS"."county" AS "county", "LHS"."state" AS "state", "LHS"."area" AS "area", "LHS"."isava" AS "isava", "RHS"."no" AS "no_other", "RHS"."grape" AS "grape", "RHS"."winery" AS "winery", "RHS"."name" AS "name", "RHS"."year" AS "year", "RHS"."price" AS "price", "RHS"."score" AS "score", "RHS"."cases" AS "cases", "RHS"."drink" AS "drink" FROM "appellations" AS "LHS" INNER JOIN "wine" AS "RHS" ON ("LHS"."appelation" = "RHS"."appelation" AND "LHS"."state" = "RHS"."state")) WHERE ("area" = 'North Coast') ORDER BY name, "name" NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT T2.Name FROM APPELLATIONs AS T1 JOIN WINE AS T2 ON T1.Appelation = T2.Appelation WHERE T1.Area = 'North Coast';

/*
Prediction Result:
('u7',)
('rhs_b80b92',)
('c4ecigce',)
('1ryytoo',)
('p5qi2rk',)
('p',)
('6ah',)
('t1afgog',)
('zo72',)
('07cvtjpt',)
('dgj5i',)
('e578',)
('rpd',)
('l',)
('gwnlas6',)
('6aqb0tbin',)
(None,)
('zys7',)
*/