-- Schema DDL
CREATE TABLE "grapes" ("ID" INTEGER PRIMARY KEY, "Grape" TEXT UNIQUE, "Color" TEXT);

CREATE TABLE "appellations" ("No" INTEGER PRIMARY KEY, "Appelation" TEXT UNIQUE, "County" TEXT, "State" TEXT, "Area" TEXT, "isAVA" TEXT);

CREATE TABLE "wine" ("Appelation" TEXT, "Grape" TEXT, "No" INTEGER, "Winery" TEXT, "State" TEXT, "Name" TEXT, "Year" INTEGER, "Price" INTEGER, "Score" INTEGER, "Cases" INTEGER, "Drink" TEXT, FOREIGN KEY ("Appelation") REFERENCES "appellations" ("Appelation"), FOREIGN KEY ("Grape") REFERENCES "grapes" ("Grape"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: grapes --
INSERT INTO "grapes" ("id", "grape", "color") VALUES (-2147483648, 'grape_1', 'gu7v');

-- Inserting into table: appellations --
INSERT INTO "appellations" ("no", "appelation", "county", "state", "area", "isava") VALUES (-2147483648, 't1__adb2aa', '5k5swwqcgs', '9n8', 't1__e8a136', '4');

INSERT INTO "appellations" ("no", "appelation", "county", "state", "area", "isava") VALUES (2, 'C', 'yu78', '9', 't1__e8a136', 'rljsl0b4y');

INSERT INTO "appellations" ("no", "appelation", "county", "state", "area", "isava") VALUES (3, 'A', 'p5qi2rkf9v', 'x58pz', 't1__e8a136', 'f8jegd2');

INSERT INTO "appellations" ("no", "appelation", "county", "state", "area", "isava") VALUES (-2147483645, 't2__36e62d', 't1afgog', 'itsj3', 't1__e8a136', 'y');

-- Inserting into table: wine --
INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('t1__adb2aa', 'grape_1', -1865039888, 'hria2ypuzhs', 'rwbbp6luhvd', 'tti', 2009, -1364429300, -1257178728, 1236688122, 'dpos');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('t1__adb2aa', 'grape_1', -1602639011, 'unw6klfa', '9000t5c4ec', 'gce', 2009, -1585009206, -53231346, -443340271, 'uo4nrqrofqy');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('t1__adb2aa', 'grape_1', -921187550, 'bbp02eutliqa', '1ryytoo', 'o9hl72kl', 2009, -305670381, -1525670226, -453362185, 'au2dwyrq13');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('C', 'grape_1', -688509700, '9uxj4hwbdvl', 'h2gn', 'q', 2009, -664193365, -1070063173, 555413010, '5hncprjtu0d');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('C', 'grape_1', -1748371085, 'q8', 'n2f3dqv0gcb9', 'ozk3zbily', 2009, 638024588, -688098735, 1784916884, 'ah0f8jsww');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('C', 'grape_1', 1255343543, '7', '2fxa7ryfdrz', '16nijjai5dh', 2009, 1583472758, 1449284300, -977470238, 'd8y');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('t2__36e62d', 'grape_1', -106471771, '1jh3den', 'c68x8vacx', 'afu5w1of7', 2009, 76996700, -435350511, 1992637800, 'dctmf');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('t2__36e62d', 'grape_1', -242584410, 'v5q8qdj', 'e1io', '278507cv', 2009, -866772222, -847293924, -2033879835, 'u5zi');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('t2__36e62d', 'grape_1', -68044929, 'kf', 'oacd07z2zez', 'o7w', 2009, -542502665, 1999335832, -526612570, 'cmr0oz');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('t2__36e62d', 'grape_1', -1935752926, '5i3', 'q5l', 'pim5', 2009, -1125548818, 1497321728, -95808609, 'h2mna');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('t2__36e62d', 'grape_1', -1478011227, '3', 'okv8uttmu2', 'e578', 2009, 1908593332, 697257217, -451030047, 'be8yvkv42q7');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('t2__36e62d', 'grape_1', 1735561423, '58b4pmaus3a', 'vmkrpd', 'wzw', 2009, -55494714, -1674145149, 234957614, 'o705a9n0jxfo');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('t2__36e62d', 'grape_1', -634585028, 'do2zobb', 'q0k32od', 'cl5ams', 2009, 709097796, -984562992, -605061107, 'gc1d');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('t2__36e62d', 'grape_1', 211603887, 'rhizgk1yoey', 'o6l0hdt6fu', 'yxuzk', 2009, 450555855, -206528034, -1686002788, 'las6');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('t2__36e62d', 'grape_1', 1468640756, 'boeowii1z5nx', 'h66', 'q2xlyoto', 2009, 1774679448, 205676091, -2094843966, '96');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('t2__36e62d', 'grape_1', 966412849, '0', 'bindz', '9tajz9td', 2009, 152478847, -625404808, -1694533100, 'bc3t');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('t2__36e62d', 'grape_1', 1964331395, 'bd0w9603v', 'xw1rxe9', 'fk7qk16', 2009, -246257698, -516345261, -1191116453, 'u06dza');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('t2__36e62d', 'grape_1', 1595632888, 'mkio18ri2hy', '08ftp6ewtqxx', 'jaby', 2009, 462225708, 1528227252, -1277305894, '7h33p6');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('t2__36e62d', 'grape_1', -843082635, 'cj8sh5k', 'zys7', 'y', 2009, -531932574, 357443379, -1502591405, 'h');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('t2__36e62d', 'grape_1', 280292620, 'a8y3a17v4yg', 'mayq3qdpua', '96rn', 2009, 2013152515, 1139012231, -951706262, '5wli');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('t2__36e62d', 'grape_1', -1260548409, 'p490', 'dmsqtg', 'lc', 2009, -1025517017, 1374676344, 238243966, 'ccukjq1q');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('t2__36e62d', 'grape_1', -1575692857, 'yhb08hl', 't1pqo', 'iztv', 2009, -1304516770, -1558272216, 195316816, 'qlud8');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('t2__36e62d', 'grape_1', -835782528, 'r9114qbre', '6bjeuuwsj8k', 'h85', 2009, -609840352, 486475144, -679850352, 'sur');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('t2__36e62d', 'grape_1', -388527046, 'q', 'ncgc8', '3b7v8', 2009, 180947503, -622923312, 1789767331, 'b');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('t1__adb2aa', 'grape_1', -1629148699, 'j47nxar50', 'sj', 'an', 2010, 1195320303, 1463445550, -1096060187, 'mwfw');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('t1__adb2aa', 'grape_1', -1040088060, 'awk', '14r5dqt', 'mg97a', 2010, -1019350771, -225571092, -261782899, 'pj6ddlysu6ip');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('t1__adb2aa', 'grape_1', -1944869637, 'u2gir31vwq5', 'oa2sb3u', 'i1pa', 2010, 1754053934, 1206923461, 1645850786, 'yqro');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('t1__adb2aa', 'grape_1', -1582954378, 'rpo', 'it63xy', 'vm', 2009, 1977502251, -1094296226, 1913338832, '3');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('t1__adb2aa', 'grape_1', -364462246, '0h3r13', 'ir1axyyh', 'l2i9', 2009, -1837449583, 1299933788, 679285124, 'k');

INSERT INTO "wine" ("appelation", "grape", "no", "winery", "state", "name", "year", "price", "score", "cases", "drink") VALUES ('t1__adb2aa', 'grape_1', -662859586, 'r54o6', 'jektb', '1d2nzg3rjk', 2009, 1807244612, 1125564712, -233564324, '8');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT appelation AS area FROM (SELECT appelation, grape, n, appelation_other, county, state, isava, NO, appelation AS area FROM (SELECT appelation, grape, n, appelation_other, county, state, isava, n AS NO FROM (SELECT LHS.appelation AS appelation, LHS.grape AS grape, LHS.n AS n, RHS.appelation AS appelation_other, RHS.county AS county, RHS.state AS state, RHS.isava AS isava FROM (SELECT appelation, grape, COUNT(*) AS n FROM wine GROUP BY appelation, grape) AS LHS INNER JOIN appellations AS RHS ON (LHS.n = RHS.no AND LHS.appelation = RHS.area)))) WHERE (n <> 2010) ORDER BY area;

/*
Gold Result:
*/

-- Prediction Query
SELECT T1.Area FROM APPELLATIONS AS T1 JOIN WINE AS T2 ON T1.Appelation = T2.Appelation GROUP BY T2.Appelation HAVING T2.year < 2010 ORDER BY COUNT(*) DESC, T1.Area NULLS LAST LIMIT 1;

/*
Prediction Result:
('t1__e8a136',)
*/