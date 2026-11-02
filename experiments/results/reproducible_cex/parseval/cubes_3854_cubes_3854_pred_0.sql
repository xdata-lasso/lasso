-- Schema DDL
CREATE TABLE "grapes" ("ID" INTEGER PRIMARY KEY, "Grape" TEXT UNIQUE, "Color" TEXT);

CREATE TABLE "appellations" ("No" INTEGER PRIMARY KEY, "Appelation" TEXT UNIQUE, "County" TEXT, "State" TEXT, "Area" TEXT, "isAVA" TEXT);

CREATE TABLE "wine" ("Appelation" TEXT, "Grape" TEXT, "No" INTEGER, "Winery" TEXT, "State" TEXT, "Name" TEXT, "Year" INTEGER, "Price" INTEGER, "Score" INTEGER, "Cases" INTEGER, "Drink" TEXT, FOREIGN KEY ("Appelation") REFERENCES "appellations" ("Appelation"), FOREIGN KEY ("Grape") REFERENCES "grapes" ("Grape"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: grapes --
INSERT INTO "grapes" ("id", "grape", "color") VALUES (-2147483648, 'grape_1', 'e4');

INSERT INTO "grapes" ("id", "grape", "color") VALUES (-2147483647, 'lhs_6f3a01', '13pyu');

INSERT INTO "grapes" ("id", "grape", "color") VALUES (-2147483646, 'lhs_818645', '7ryfdrz16n');

-- Inserting into table: appellations --
INSERT INTO "appellations" ("no", "appelation", "county", "state", "area", "isava") VALUES (-2147483648, 'appelation_1', '5k5swwqcgs', '9n8', '4', 'gu7v');

INSERT INTO "appellations" ("no", "appelation", "county", "state", "area", "isava") VALUES (-2147483647, 'lhs_c7e1f4', 'ryytoo3', '9hl7', 'klex14ji', '7zwau2dwyr');

INSERT INTO "appellations" ("no", "appelation", "county", "state", "area", "isava") VALUES (-2147483646, 'lhs_c19a78', '6ah', 'f8jswwl', '7xb72', 'xa');

-- Inserting into table: wine --
INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'grape_1', 1160656988, 'ia2yp', 'win_faeea9', 'uzhsrwbbp6lu', 1019800248, -1910425938, -845863578, -1610064545, 'n');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'grape_1', 2087640001, 'dposiie5unw', 'win_faeea9', 'klfa9000t', 1408123494, -1964997180, 1149850321, -1833165707, '6nium52zb');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'grape_1', 902887186, 'qrofqyp5s5b', 'win_faeea9', 'p', 882961052, 743312762, -1822992503, -868774469, 'qa1');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_c7e1f4', 'lhs_6f3a01', 1, 'lhs_fd6700', 'lhs_21ed21', 'lhs_a2fcad', 1, 1, 1, 1, 'lhs_bf7f1f');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'lhs_6f3a01', -1362461264, 'l0b4y', 'win_faeea9', 'p5qi2rkf9v', 556727997, 1178000634, 1836127587, -1529584866, 'd2');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_c7e1f4', 'lhs_6f3a01', 233994589, 'j4hwbd', 'win_faeea9', 'lph2gn', 1968874827, -664193365, -1070063173, 555413010, '5hncprjtu0d');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_c7e1f4', 'grape_1', -1485777725, '8n2f3', 'win_faeea9', 'dqv0gcb98ozk', -155284187, 1686459626, -1554531873, 982314585, 'kn6vc');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_c7e1f4', 'lhs_6f3a01', 1, 'lhs_fd6700', 'lhs_21ed21', 'lhs_a2fcad', 1, 1, 1, 1, 'lhs_bf7f1f');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_c19a78', 'lhs_818645', 1, 'lhs_375591', 'lhs_9a62b2', 'lhs_37a268', 1, 1, 1, 1, 'lhs_e996de');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'grape_1', -1483100200, '5dh', 'ogrgjd8y', 't1afgog', -946046410, -902895762, -197933860, 2111987706, 'p1q430');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_c7e1f4', 'lhs_818645', -1538707438, 'den8c68x', 'win_faeea9', 'vacx7afu5', -290314193, 76996700, NULL, -435350511, '72ctdctmfg62');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'lhs_6f3a01', 1870300798, 'q8qdjpe1', 'win_faeea9', 'o22', 2004147439, -691774480, NULL, -1523347137, 'ttg6bnou5zi3');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_c19a78', 'grape_1', 1722106924, 'f', 'win_faeea9', 'foa', 382831862, -406331049, NULL, -461418236, 'zjo7wgxd5ysx');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'lhs_6f3a01', 1, 'lhs_fd6700', 'lhs_21ed21', 'lhs_a2fcad', 1, 1, 1, 1, 'lhs_bf7f1f');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'lhs_6f3a01', 983324983, 'ztdg', '5i3', 'q5l', 1339733032, -1556979799, -55240145, NULL, '8qs27p2r');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_c19a78', 'lhs_818645', -95808609, 'h2mna', 'win_faeea9', 'jla', 1919033056, -1428186898, NULL, NULL, 'uttmu2ne5');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_c19a78', 'lhs_818645', -1402164108, 'yz7zzb', 'win_faeea9', '8y', -705922211, 1043710187, NULL, NULL, '42q7sx58b4');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_c19a78', 'lhs_818645', -1122409769, 'u', 'win_faeea9', '3auvm', 274891948, 609771851, NULL, NULL, 'j');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_c7e1f4', 'lhs_6f3a01', 1, 'lhs_fd6700', 'lhs_21ed21', 'lhs_a2fcad', 1, 1, 1, NULL, 'lhs_bf7f1f');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_c19a78', 'lhs_818645', NULL, 'zw5chn', 'mo705a9n0', 'xfo', -1793230843, -441521858, 2015094998, 1010672881, 'obb0q0k');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_c7e1f4', 'lhs_818645', NULL, '2odwcl5amso', 'win_faeea9', 'lwyng', -1960313034, 681061317, NULL, 1935791961, 'izgk1yoeyo6');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_c19a78', 'grape_1', NULL, 'hdt6fuq', 'win_faeea9', 'xuzkb52', -277407746, -670154354, NULL, -2140468103, 'elboeowii');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_c7e1f4', 'lhs_6f3a01', NULL, 'nxih662q', 'win_faeea9', 'xlyotow9', 727608179, 456034296, NULL, -628433041, '6aqb0tbin');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_c7e1f4', 'lhs_6f3a01', NULL, 'lhs_fd6700', 'lhs_21ed21', 'lhs_a2fcad', 1, 1, 1, 1, 'lhs_bf7f1f');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'lhs_6f3a01', 2085299664, 'j', '9td8n5w', 'g', NULL, -794767771, 989306270, 1147652228, 'u');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_c19a78', 'grape_1', 1071401016, 'w9603vz', 'win_faeea9', 'xw1rxe9yfk7', NULL, -1046720861, NULL, 643589729, 'h55y');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_c7e1f4', 'grape_1', 440797047, 'vu', 'win_faeea9', '6dza35r', NULL, 2072023304, NULL, 789756515, '18ri');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_c7e1f4', 'grape_1', 389700824, '08ftp6ewtqxx', 'win_faeea9', 'jaby', NULL, 462225708, NULL, 1528227252, 'fx7h');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_c7e1f4', 'lhs_6f3a01', 1, 'lhs_fd6700', 'lhs_21ed21', 'lhs_a2fcad', NULL, 1, 1, 1, 'lhs_bf7f1f');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_c7e1f4', 'lhs_6f3a01', 1220047834, '6sto1cj8sh5k', 'zys7', 'y', -531932574, 357443379, -1502591405, -2008781089, 'qta8y3a17');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_c19a78', 'lhs_818645', -735270562, 'ygmayq3qdpu', 'win_faeea9', 'p', -845136979, -1042976410, NULL, -1670945624, 'wlic7dn2');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'lhs_818645', 833568923, '90xdmsqt', 'win_faeea9', 'el', -1974774786, 422046500, NULL, -1750715330, 'ccukjq1qui');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'lhs_6f3a01', -1670335771, '8hlst1p', 'win_faeea9', 'qomiztvb6m', -74691962, -2128972904, NULL, -1043357093, 'd8ftb8');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_c7e1f4', 'lhs_6f3a01', 1, 'lhs_fd6700', 'lhs_21ed21', 'lhs_a2fcad', 1, 1, 1, 1, 'lhs_bf7f1f');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_c19a78', 'lhs_818645', 1183069552, NULL, '4qbre6b', 'jeuuwsj8kj', -55270062, -1101814296, 1939337883, -996196097, 'surz0kaqtncg');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_c19a78', 'grape_1', 1446366856, NULL, 'win_faeea9', 'b7v88kwd', 1789767331, 1633584225, NULL, 1671062261, 'h');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_c7e1f4', 'lhs_818645', 313797011, NULL, 'win_faeea9', '7nxar50h', 460471995, -1515201134, NULL, -2121944911, 'xdpunmw');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'lhs_6f3a01', -544173163, NULL, 'win_faeea9', 'lawk0', -300547632, -967107842, NULL, -1011152325, 'mg97a');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_c7e1f4', 'lhs_6f3a01', 1, NULL, 'lhs_21ed21', 'lhs_a2fcad', 1, 1, 1, 1, 'lhs_bf7f1f');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_c7e1f4', 'lhs_6f3a01', -225571092, '0pj6ddly', NULL, 'u6iph', -1944869637, 658507818, 334376591, 1154884242, 'r31');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_c7e1f4', 'lhs_6f3a01', 2061102304, 'a2sb', NULL, 'uoi1pavc', 1645850786, -471852873, NULL, -1005394301, 'uirlrpouit');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_c19a78', 'lhs_818645', 1589523321, 'yfvmjwpp26m', NULL, '3', 1893953818, -364462246, NULL, 982289268, '3r');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_c19a78', 'lhs_6f3a01', 461842658, 'ir1axyyh', NULL, 'l2i9', -1837449583, 1299933788, NULL, 679285124, 'k');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_c7e1f4', 'lhs_6f3a01', 1, 'lhs_fd6700', NULL, 'lhs_a2fcad', 1, 1, 1, 1, 'lhs_bf7f1f');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_c7e1f4', 'lhs_6f3a01', 1092207544, 'r54o6qjektb1', '2', 'zg3r', 294604606, -1460437682, 1014069980, 1070869226, NULL);

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_c19a78', 'lhs_818645', -1522433566, 'a8d', 'win_faeea9', 'c', -526608193, 1560573473, NULL, 472597763, NULL);

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_c19a78', 'lhs_818645', -1015337060, 'yrnxs6dvd', 'win_faeea9', 'do2v7t', 1770139230, -1680744918, NULL, -1136928894, NULL);

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'lhs_818645', -1789708299, 'uun7k1', 'win_faeea9', 'z2my1og', -489473841, -333485269, NULL, -1712532464, NULL);

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_c7e1f4', 'lhs_6f3a01', 1, 'lhs_fd6700', 'lhs_21ed21', 'lhs_a2fcad', 1, 1, 1, 1, NULL);

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_c7e1f4', 'grape_1', 423028705, '1', 'l', 'upgly78oit', -563920971, NULL, 1484825817, 1009703228, '19cy7od');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_c19a78', 'lhs_6f3a01', -1882121644, 'hdsvnhed29lq', 'win_faeea9', '26u331', -894726713, NULL, NULL, -1089715864, '0bgwkxgi');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_c19a78', 'grape_1', -1919229426, '61l2', 'win_faeea9', 'o3ak162ocagj', 1361395061, NULL, NULL, 1707457950, 'zxlu49');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'lhs_6f3a01', -2051917235, '8c', 'win_faeea9', 'e', 1557266002, NULL, NULL, -775706063, 'khllbwvdpu');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_c7e1f4', 'lhs_6f3a01', 1, 'lhs_fd6700', 'lhs_21ed21', 'lhs_a2fcad', 1, NULL, 1, 1, 'lhs_bf7f1f');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_c19a78', 'lhs_6f3a01', 1551904707, 'eduy9v2', '129835x', NULL, 1084895939, 765955451, 1372042958, 1147974039, 'f0c296xi');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_c7e1f4', 'lhs_818645', 1755688363, '8xjhc', 'win_faeea9', NULL, -1805244571, 66352888, NULL, 312333412, 'erxa61sjv8nv');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_c7e1f4', 'grape_1', -1891572006, 'kuez', 'win_faeea9', NULL, 1795932554, -831032281, NULL, 2006256976, 'a3c');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_c19a78', 'grape_1', -682353894, '7vpc0xffwo', 'win_faeea9', NULL, -980269466, 1202197697, NULL, -1424758178, '9q');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_c7e1f4', 'lhs_6f3a01', 1, 'lhs_fd6700', 'lhs_21ed21', NULL, 1, 1, 1, 1, 'lhs_bf7f1f');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_c19a78', 'lhs_6f3a01', -1048234032, '1huij7f', '8kqhiu5gm8', 'xb', 854201197, -1497515537, NULL, 1432878454, 'awsp4kwi3h');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'lhs_818645', -1480511510, 'y795ybv8', 'win_faeea9', 'kr3w4jn2', 1424689173, 1847608594, NULL, 643485636, 'jj');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('appelation_1', 'lhs_818645', 2062713020, 'gmukfb5if4', 'win_faeea9', '80terbf', 1176294340, -1429883874, NULL, -1844939963, 'sltut6lu2');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_c19a78', 'grape_1', 1224512097, 'mhfcimn5e', 'win_faeea9', 'ii0f', -2013600868, -415366855, NULL, 1778447090, 's27xh8');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('lhs_c7e1f4', 'lhs_6f3a01', 1, 'lhs_fd6700', 'lhs_21ed21', 'lhs_a2fcad', 1, 1, NULL, 1, 'lhs_bf7f1f');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT winery FROM (SELECT LHS.no AS NO, LHS.grape AS grape, LHS.winery AS winery, LHS.appelation AS appelation, LHS.state AS state, LHS.name AS name, LHS.year AS YEAR, LHS.price AS price, LHS.score AS score, LHS.cases AS cases, LHS.drink AS drink FROM wine AS LHS INNER JOIN (SELECT state, MIN(score) AS score FROM wine GROUP BY state) AS RHS ON (LHS.state = RHS.state AND LHS.score = RHS.score)) ORDER BY winery;

/*
Gold Result:
(None,)
(None,)
('1',)
('5dh',)
('6sto1cj8sh5k',)
('eduy9v2',)
('j',)
('lhs_375591',)
('lhs_fd6700',)
('lhs_fd6700',)
('lhs_fd6700',)
('lhs_fd6700',)
('lhs_fd6700',)
('lhs_fd6700',)
('lhs_fd6700',)
('lhs_fd6700',)
('lhs_fd6700',)
('lhs_fd6700',)
('qrofqyp5s5b',)
('r54o6qjektb1',)
('ztdg',)
('zw5chn',)
*/

-- Prediction Query
SELECT Winery FROM WINE ORDER BY SCORE, WINE.appelation NULLS LAST, WINE.grape NULLS LAST, WINE.no NULLS LAST, WINE.winery NULLS LAST, WINE.state NULLS LAST, WINE.name NULLS LAST, WINE.year NULLS LAST, WINE.price NULLS LAST, WINE.cases NULLS LAST, WINE.drink NULLS LAST LIMIT 1;

/*
Prediction Result:
('8c',)
*/