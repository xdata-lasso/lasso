-- Schema DDL
CREATE TABLE "grapes" ("ID" INTEGER PRIMARY KEY, "Grape" TEXT UNIQUE, "Color" TEXT);

CREATE TABLE "appellations" ("No" INTEGER PRIMARY KEY, "Appelation" TEXT UNIQUE, "County" TEXT, "State" TEXT, "Area" TEXT, "isAVA" TEXT);

CREATE TABLE "wine" ("Appelation" TEXT, "Grape" TEXT, "No" INTEGER, "Winery" TEXT, "State" TEXT, "Name" TEXT, "Year" INTEGER, "Price" INTEGER, "Score" INTEGER, "Cases" INTEGER, "Drink" TEXT, FOREIGN KEY ("Appelation") REFERENCES "appellations" ("Appelation"), FOREIGN KEY ("Grape") REFERENCES "grapes" ("Grape"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: grapes --
INSERT INTO "grapes" ("id", "grape", "color") VALUES (-2147483648, 'grape_1', 'e4');

INSERT INTO "grapes" ("id", "grape", "color") VALUES (-2147483647, 'lhs_f08978', '13pyu');

INSERT INTO "grapes" ("id", "grape", "color") VALUES (-2147483646, 'lhs_fdd031', '7ryfdrz16n');

-- Inserting into table: appellations --
INSERT INTO "appellations" ("no", "appelation", "county", "state", "area", "isava") VALUES (-2147483648, 'appelation_1', '5k5swwqcgs', '9n8', '4', 'gu7v');

INSERT INTO "appellations" ("no", "appelation", "county", "state", "area", "isava") VALUES (-2147483647, 'lhs_bb2c83', 'ryytoo3', '9hl7', 'klex14ji', '7zwau2dwyr');

INSERT INTO "appellations" ("no", "appelation", "county", "state", "area", "isava") VALUES (-2147483646, 'lhs_bbfb61', '6ah', 'f8jswwl', '7xb72', 'xa');

-- Inserting into table: wine --
INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'grape_1', 1160656988, 'ia2yp', 'win_e67390', 'uzhsrwbbp6lu', 1019800248, -1910425938, -845863578, -1610064545, 'n');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'grape_1', 2087640001, 'dposiie5unw', 'win_e67390', 'klfa9000t', 1408123494, -1964997180, 1149850321, -1833165707, '6nium52zb');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'grape_1', 902887186, 'qrofqyp5s5b', 'win_e67390', 'p', 882961052, 743312762, -1822992503, -868774469, 'qa1');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_bb2c83', 'lhs_f08978', 1, 'lhs_144c27', 'lhs_ee6ef4', 'lhs_803237', 1, 1, 1, 1, 'lhs_c82588');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'lhs_f08978', -1362461264, 'l0b4y', 'win_e67390', 'p5qi2rkf9v', 556727997, 1178000634, 1836127587, -1529584866, 'd2');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_bb2c83', 'lhs_f08978', 233994589, 'j4hwbd', 'win_e67390', 'lph2gn', 1968874827, -664193365, -1070063173, 555413010, '5hncprjtu0d');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_bb2c83', 'grape_1', -1485777725, '8n2f3', 'win_e67390', 'dqv0gcb98ozk', -155284187, 1686459626, -1554531873, 982314585, 'kn6vc');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_bb2c83', 'lhs_f08978', 1, 'lhs_144c27', 'lhs_ee6ef4', 'lhs_803237', 1, 1, 1, 1, 'lhs_c82588');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_bbfb61', 'lhs_fdd031', 1, 'lhs_78a116', 'lhs_feb223', 'lhs_a48b90', 1, 1, 1, 1, 'lhs_eb023a');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'grape_1', -1483100200, '5dh', 'ogrgjd8y', 't1afgog', -946046410, -902895762, -197933860, 2111987706, 'p1q430');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_bb2c83', 'lhs_fdd031', -1538707438, 'den8c68x', 'win_e67390', 'vacx7afu5', -290314193, 76996700, NULL, -435350511, '72ctdctmfg62');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'lhs_f08978', 1870300798, 'q8qdjpe1', 'win_e67390', 'o22', 2004147439, -691774480, NULL, -1523347137, 'ttg6bnou5zi3');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_bbfb61', 'grape_1', 1722106924, 'f', 'win_e67390', 'foa', 382831862, -406331049, NULL, -461418236, 'zjo7wgxd5ysx');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_bb2c83', 'grape_1', 1, 'lhs_144c27', 'lhs_ee6ef4', 'lhs_803237', 1, 1, 1, 1, 'lhs_c82588');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'lhs_f08978', 983324983, 'ztdg', '5i3', 'q5l', NULL, 1339733032, -1556979799, -55240145, '8qs27p2r');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_bbfb61', 'lhs_fdd031', -95808609, 'h2mna', 'win_e67390', 'jla', NULL, 1919033056, NULL, -1428186898, 'uttmu2ne5');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_bbfb61', 'lhs_fdd031', -1402164108, 'yz7zzb', 'win_e67390', '8y', NULL, -705922211, NULL, 1043710187, '42q7sx58b4');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_bbfb61', 'lhs_fdd031', -1122409769, 'u', 'win_e67390', '3auvm', NULL, 274891948, NULL, 609771851, 'j');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_bb2c83', 'lhs_f08978', 1, 'lhs_144c27', 'lhs_ee6ef4', 'lhs_803237', NULL, 1, 1, 1, 'lhs_c82588');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_bbfb61', 'lhs_fdd031', 1105964624, 'w5chn9m', NULL, 'o705a9n0jxfo', -1793230843, -441521858, 2015094998, 1010672881, 'obb0q0k');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_bb2c83', 'lhs_fdd031', 575038073, 'dwcl', NULL, '5amsorlwyngc', -323362455, 453340472, NULL, 211603887, 'rhizgk1yoey');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_bbfb61', 'grape_1', 718167481, 'hdt6fuq', NULL, 'xuzkb52', -277407746, -670154354, NULL, -2140468103, 'elboeowii');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_bb2c83', 'lhs_f08978', -564679000, '66', NULL, 'q2xlyoto', 1774679448, 205676091, NULL, -2094843966, '96');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_bb2c83', 'lhs_f08978', 1, 'lhs_144c27', NULL, 'lhs_803237', 1, 1, 1, 1, 'lhs_c82588');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_bbfb61', 'grape_1', 966412849, '0', 'bindz', '9tajz9td', 152478847, -625404808, NULL, -1694533100, 'bc3t');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'lhs_fdd031', 1964331395, 'bd0w9603v', 'win_e67390', 'xw1rxe9', -505019168, 1968783602, NULL, 125495479, '162');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'grape_1', 956819642, '5y3dohvu06d', 'win_e67390', 'a35rmki', -1160642134, 769234989, NULL, 168442149, 'tp6ewtqxxn');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_bbfb61', 'grape_1', 917362079, 'mzn2mfx', 'win_e67390', 'h33p6sto1', -1971560508, 1728926031, NULL, -63214972, 'zys7');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_bb2c83', 'lhs_f08978', 1, 'lhs_144c27', 'lhs_ee6ef4', 'lhs_803237', 1, 1, NULL, 1, 'lhs_c82588');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'lhs_f08978', -531932574, 'jmgjach', 'qta8y3a17', NULL, -735270562, 614314115, 306260487, 1168225104, 'q3qdpua');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'lhs_fdd031', 1291298007, 'tdqr', 'win_e67390', NULL, -1670945624, 555368535, NULL, -1369148652, '7');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_bbfb61', 'lhs_fdd031', -1260548409, 'p490', 'win_e67390', NULL, -592014051, 1744849810, NULL, 1996699977, 'tgelc');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_bb2c83', 'lhs_fdd031', -1025517017, 'i9f2ccukj', 'win_e67390', NULL, 1046248997, 1584429327, NULL, -1575692857, 'yhb08hl');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_bb2c83', 'lhs_f08978', 1, 'lhs_144c27', 'lhs_ee6ef4', 'lhs_803237', 1, 1, 1, 1, 'lhs_c82588');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_bb2c83', 'lhs_fdd031', NULL, '1pqom', 'ztv', '6', -1304516770, -1558272216, 195316816, 1728201214, 'ud8');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'lhs_fdd031', NULL, 'b8r91', 'win_e67390', '4qbre6b', -1537647691, 364280973, NULL, 1592061050, 'sj8kjh');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_bbfb61', 'lhs_f08978', NULL, 'pxlvri', 'win_e67390', 'surz0kaqtncg', 428944759, 1446366856, NULL, 438933248, '88kwdmdbdht6');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_bbfb61', 'grape_1', NULL, '7nxar50h', 'win_e67390', 'sjhanzxdpu', 2014610660, 1492264835, NULL, -642512512, 'rlawk');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_bb2c83', 'lhs_f08978', NULL, 'lhs_144c27', 'lhs_ee6ef4', 'lhs_803237', 1, 1, 1, 1, 'lhs_c82588');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_bb2c83', 'lhs_fdd031', 558684943, 'r5dqtsmg', '7aqz2o20p', '6dd', 1216978423, -1087163929, -1944869637, 658507818, NULL);

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_bbfb61', 'lhs_f08978', 1154884242, 'r31', 'win_e67390', 'wq51oa', 1813968674, 1907670428, NULL, 1265709623, NULL);

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_bb2c83', 'lhs_f08978', 1388661799, '1pa', 'win_e67390', 'cvwnyq', -1005394301, 917675957, NULL, -1582954378, NULL);

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'lhs_fdd031', -1143329124, 't63', 'win_e67390', 'xyfvmjwpp26', 1913338832, -2061050846, NULL, 1893953818, NULL);

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_bb2c83', 'lhs_f08978', 1, 'lhs_144c27', 'lhs_ee6ef4', 'lhs_803237', 1, 1, 1, 1, NULL);

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'lhs_fdd031', -364462246, '0h3r13', 'ir1axyyh', 'l2i9', -1837449583, 1299933788, 679285124, 1752727653, 'qwt');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_bb2c83', 'lhs_fdd031', 1339281953, '4o6qjektb1', 'win_e67390', '2', -460035045, 1794943626, NULL, 886926141, 'jkwns47j2j');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'lhs_fdd031', -1881008758, 'y', 'win_e67390', 'vjwq49yr', 1014871129, -583955995, NULL, -1935855834, 'dxdo2v7t3g');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_bb2c83', 'grape_1', -1368221491, 'fjvuun7k1', 'win_e67390', 'z2my1og', -489473841, -333485269, NULL, -1712532464, 'axc1clu');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'lhs_f08978', 1, 'lhs_144c27', 'lhs_ee6ef4', 'lhs_803237', 1, 1, 1, 1, 'lhs_c82588');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'lhs_fdd031', 1128553504, NULL, 'xeilp', 'e019cy7od0', -1882121644, 935816178, -1919535047, -690382359, 'ed');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_bb2c83', 'lhs_fdd031', 253464886, NULL, 'win_e67390', 'qv26u331spx', 764047845, -660620878, NULL, -349181074, 'wk');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_bbfb61', 'lhs_f08978', 1693638235, NULL, 'win_e67390', 'nlj', 1673977398, 1004962990, NULL, -1318740197, '1l2o3ak16');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_bb2c83', 'grape_1', -1954048590, NULL, 'win_e67390', 'je', 1707457950, -582813835, NULL, -572986964, '49kubo');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_bb2c83', 'lhs_f08978', 1, NULL, 'lhs_ee6ef4', 'lhs_803237', 1, 1, 1, 1, 'lhs_c82588');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'lhs_fdd031', 833662145, 'e', 'uekhllbw', 'dpu5v0', -1846517698, NULL, 2117356203, 824044840, 'z129835x');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'grape_1', 1599672055, 'acxdb2f0c29', 'win_e67390', 'xiyet8xjh', 1625280273, NULL, NULL, -1805244571, '6cfperxa61s');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'lhs_f08978', -1265768652, 'ddrokuez', 'win_e67390', 'ctehia3cmvb', -1077762203, NULL, NULL, -1798310553, 'or1esk');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_bb2c83', 'grape_1', 1494789426, 'g01hu', 'win_e67390', 'j7f', -1663813652, NULL, NULL, 1094664154, '8gxb');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_bb2c83', 'lhs_f08978', 1, 'lhs_144c27', 'lhs_ee6ef4', 'lhs_803237', 1, NULL, 1, 1, 'lhs_c82588');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_bb2c83', 'lhs_fdd031', -1037450107, 'saw', 'p4kwi', 'hl7j43y7', 209963559, -480726958, 191797158, NULL, 'r3w');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_bb2c83', 'grape_1', -1213283783, '19xgjja', 'win_e67390', 'cgmukfb5if4', 143843552, 1085074663, NULL, NULL, 'rb');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'grape_1', -1429883874, 'e6', 'win_e67390', 'ltut6', 1143458360, -769244829, NULL, NULL, 'cel8mhfcim');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_bbfb61', 'grape_1', 1865625247, 'ii0f', 'win_e67390', 'bgz5', 1778447090, -580951166, NULL, NULL, '27xh888y1k25');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_bb2c83', 'lhs_f08978', 1, 'lhs_144c27', 'lhs_ee6ef4', 'lhs_803237', 1, 1, 1, NULL, 'lhs_c82588');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT grape AS name FROM (SELECT LHS.no AS NO, LHS.grape AS grape, LHS.winery AS winery, LHS.appelation AS appelation, LHS.state AS state, LHS.name AS name, LHS.year AS YEAR, LHS.price AS price, LHS.score AS score, LHS.cases AS cases, LHS.drink AS drink FROM wine AS LHS INNER JOIN (SELECT state, MIN(score) AS score FROM wine GROUP BY state) AS RHS ON (LHS.state = RHS.state AND LHS.score = RHS.score)) ORDER BY name;

/*
Gold Result:
('grape_1',)
('grape_1',)
('grape_1',)
('lhs_f08978',)
('lhs_f08978',)
('lhs_f08978',)
('lhs_f08978',)
('lhs_f08978',)
('lhs_f08978',)
('lhs_f08978',)
('lhs_f08978',)
('lhs_f08978',)
('lhs_f08978',)
('lhs_f08978',)
('lhs_f08978',)
('lhs_fdd031',)
('lhs_fdd031',)
('lhs_fdd031',)
('lhs_fdd031',)
('lhs_fdd031',)
('lhs_fdd031',)
('lhs_fdd031',)
*/

-- Prediction Query
SELECT Name FROM WINE ORDER BY Score, WINE.appelation NULLS LAST, WINE.grape NULLS LAST, WINE.no NULLS LAST, WINE.winery NULLS LAST, WINE.state NULLS LAST, WINE.name NULLS LAST, WINE.year NULLS LAST, WINE.price NULLS LAST, WINE.cases NULLS LAST, WINE.drink NULLS LAST LIMIT 1;

/*
Prediction Result:
('ltut6',)
*/