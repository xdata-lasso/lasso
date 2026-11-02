-- Schema DDL
CREATE TABLE circuits (circuitId INTEGER PRIMARY KEY AUTOINCREMENT, circuitRef TEXT DEFAULT '' NOT NULL, name TEXT DEFAULT '' NOT NULL, location TEXT, country TEXT, lat REAL, lng REAL, alt INTEGER, url TEXT DEFAULT '' NOT NULL UNIQUE);

CREATE TABLE constructors (constructorId INTEGER PRIMARY KEY AUTOINCREMENT, constructorRef TEXT DEFAULT '' NOT NULL, name TEXT DEFAULT '' NOT NULL UNIQUE, nationality TEXT, url TEXT DEFAULT '' NOT NULL);

CREATE TABLE drivers (driverId INTEGER PRIMARY KEY AUTOINCREMENT, driverRef TEXT DEFAULT '' NOT NULL, number INTEGER, code TEXT, forename TEXT DEFAULT '' NOT NULL, surname TEXT DEFAULT '' NOT NULL, dob DATE, nationality TEXT, url TEXT DEFAULT '' NOT NULL UNIQUE);

CREATE TABLE seasons (year INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, url TEXT DEFAULT '' NOT NULL UNIQUE);

CREATE TABLE races (raceId INTEGER PRIMARY KEY AUTOINCREMENT, year INTEGER DEFAULT 0 NOT NULL, round INTEGER DEFAULT 0 NOT NULL, circuitId INTEGER DEFAULT 0 NOT NULL, name TEXT DEFAULT '' NOT NULL, date DATE DEFAULT '0000-00-00' NOT NULL, time TEXT, url TEXT UNIQUE, FOREIGN KEY (year) REFERENCES seasons (year), FOREIGN KEY (circuitId) REFERENCES circuits (circuitId));

CREATE TABLE constructorResults (constructorResultsId INTEGER PRIMARY KEY AUTOINCREMENT, raceId INTEGER DEFAULT 0 NOT NULL, constructorId INTEGER DEFAULT 0 NOT NULL, points REAL, status TEXT, FOREIGN KEY (raceId) REFERENCES races (raceId), FOREIGN KEY (constructorId) REFERENCES constructors (constructorId));

CREATE TABLE constructorStandings (constructorStandingsId INTEGER PRIMARY KEY AUTOINCREMENT, raceId INTEGER DEFAULT 0 NOT NULL, constructorId INTEGER DEFAULT 0 NOT NULL, points REAL DEFAULT 0 NOT NULL, position INTEGER, positionText TEXT, wins INTEGER DEFAULT 0 NOT NULL, FOREIGN KEY (raceId) REFERENCES races (raceId), FOREIGN KEY (constructorId) REFERENCES constructors (constructorId));

CREATE TABLE driverStandings (driverStandingsId INTEGER PRIMARY KEY AUTOINCREMENT, raceId INTEGER DEFAULT 0 NOT NULL, driverId INTEGER DEFAULT 0 NOT NULL, points REAL DEFAULT 0 NOT NULL, position INTEGER, positionText TEXT, wins INTEGER DEFAULT 0 NOT NULL, FOREIGN KEY (raceId) REFERENCES races (raceId), FOREIGN KEY (driverId) REFERENCES drivers (driverId));

CREATE TABLE lapTimes (raceId INTEGER NOT NULL, driverId INTEGER NOT NULL, lap INTEGER NOT NULL, position INTEGER, time TEXT, milliseconds INTEGER, PRIMARY KEY (raceId, driverId, lap), FOREIGN KEY (raceId) REFERENCES races (raceId), FOREIGN KEY (driverId) REFERENCES drivers (driverId));

CREATE TABLE pitStops (raceId INTEGER NOT NULL, driverId INTEGER NOT NULL, stop INTEGER NOT NULL, lap INTEGER NOT NULL, time TEXT NOT NULL, duration TEXT, milliseconds INTEGER, PRIMARY KEY (raceId, driverId, stop), FOREIGN KEY (raceId) REFERENCES races (raceId), FOREIGN KEY (driverId) REFERENCES drivers (driverId));

CREATE TABLE qualifying (qualifyId INTEGER PRIMARY KEY AUTOINCREMENT, raceId INTEGER DEFAULT 0 NOT NULL, driverId INTEGER DEFAULT 0 NOT NULL, constructorId INTEGER DEFAULT 0 NOT NULL, number INTEGER DEFAULT 0 NOT NULL, position INTEGER, q1 TEXT, q2 TEXT, q3 TEXT, FOREIGN KEY (raceId) REFERENCES races (raceId), FOREIGN KEY (driverId) REFERENCES drivers (driverId), FOREIGN KEY (constructorId) REFERENCES constructors (constructorId));

CREATE TABLE status (statusId INTEGER PRIMARY KEY AUTOINCREMENT, status TEXT DEFAULT '' NOT NULL);

CREATE TABLE results (resultId INTEGER PRIMARY KEY AUTOINCREMENT, raceId INTEGER DEFAULT 0 NOT NULL, driverId INTEGER DEFAULT 0 NOT NULL, constructorId INTEGER DEFAULT 0 NOT NULL, number INTEGER, grid INTEGER DEFAULT 0 NOT NULL, position INTEGER, positionText TEXT DEFAULT '' NOT NULL, positionOrder INTEGER DEFAULT 0 NOT NULL, points REAL DEFAULT 0 NOT NULL, laps INTEGER DEFAULT 0 NOT NULL, time TEXT, milliseconds INTEGER, fastestLap INTEGER, rank INTEGER DEFAULT 0, fastestLapTime TEXT, fastestLapSpeed TEXT, statusId INTEGER DEFAULT 0 NOT NULL, FOREIGN KEY (raceId) REFERENCES races (raceId), FOREIGN KEY (driverId) REFERENCES drivers (driverId), FOREIGN KEY (constructorId) REFERENCES constructors (constructorId), FOREIGN KEY (statusId) REFERENCES status (statusId));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: races --
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1, 2000, 700088193, -2147483648, 'ecigce376n', '2021-06-20', 'm52zbu', 'url_1');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2, 2000, -847293924, -2147483648, 'bnou5zi36', '2020-05-11', 'bfkfoacd', 'url_2');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (3, 2000, 1919033056, -2147483648, 'v8u', '2023-07-01', 'tmu2ne578l', 'url_3');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (4, 2000, -1437333179, -2147483648, 'wwqcg', '2023-04-14', '9n8', 'url_4');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (5, 2000, 328305758, -2147483648, 'tliqa1', '2024-10-14', 'yytoo', 'url_5');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (6, 1, -1437333179, -2147483648, 'wwqcg', '2023-04-14', '9n8', 'url_6');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (7, 1, 328305758, -2147483648, 'tliqa1', '2024-10-14', 'yytoo', 'url_7');

-- Inserting into table: drivers --
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1, '5k5swwqcgs', 247012447, '8c4pgu7vfe', 'hria2ypu', 'hsrwbbp', '1984-12-31', 'luhvdltti', 'url_1');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2, 'cprj', -841004020, 'dz79fjg', '8n2f3', 'dqv0gcb98ozk', '1984-12-31', 'zbilyrkn', 'url_2');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (3, 'dh5ogrgj', -458359144, '1afgogritsj', 'ayxp1q43', '1jh3den', '2020-07-09', '68x8vacx7a', 'url_3');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (4, '4', -734455130, '4h', 'ia2yp', 'uzhsrwbbp6lu', NULL, 'hvdlttilbnpr', 'url_4');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (5, 'o9hl72kl', -305670381, 'i7z', 'au2dwy', 'q13py', NULL, '78d99r', 'url_5');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (6, '4', -734455130, '4h', 'ia2yp', 'uzhsrwbbp6lu', '1984-12-31', 'hvdlttilbnpr', 'url_6');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (7, 'o9hl72kl', -305670381, 'i7z', 'au2dwy', 'q13py', '1984-12-31', '78d99r', 'url_7');

-- Inserting into table: constructors --
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (-2147483648, 'rqro', 'name_1', 'fqyp5s5bbp0', '2eutliqa11r');

-- Inserting into table: circuits --
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (-2147483648, 'bnp', 'mdpos', 'ie5', 'nw6klf', 741.842896, 587.783596, 1419861592, 'url_1');

-- Inserting into table: seasons --
INSERT INTO "seasons" ("year", "url") VALUES (2000, 'url_1');

INSERT INTO "seasons" ("year", "url") VALUES (0, 'url_2');

INSERT INTO "seasons" ("year", "url") VALUES (1, 'url_3');

-- Inserting into table: status --
INSERT INTO "status" ("statusid", "status") VALUES (-2147483648, 'ytoo3o9');

-- Inserting into table: results --
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483648, 1, 1, -2147483648, -1666765085, 1178636309, -1390245819, 'x14ji7zwau2d', 1485335077, 721.918386, -511185946, '13pyu', 176380444, -977635379, 1661181156, '0b4', 'p5qi2rk', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483647, 1, 1, -2147483648, 556727997, 1178000634, 1836127587, 'f8jegd2', 1675430660, 339.69384, 51, '9uxj4hwbdvl', 2103044118, -1642259219, 1298861365, 'q', 'nqcx5h', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483646, 1, 1, -2147483648, -348113485, 138842628, -932772113, 'lq7xb7', 602161869, 814.417862, 2094425101, '7', 1294666887, -515895469, 1427161052, 'z16ni', 'jai', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483645, 1, 3, -2147483648, 1371234901, -290314193, 76996700, 'o72ctdc', 1303877941, 695.452114, 51, 'fg62', -1744557630, 1870300798, 820970595, 'qdjpe1io2', '78507cvt', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483644, 1, 3, -2147483648, -461418236, -468701684, 1448731351, 'wgxd5ysxc', -405743609, 49.297401, -20116244, 'lq5lnpim', -55240145, 1379859112, 195202164, 's27p2r94gth2', 'najj', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483643, 3, 1, -2147483648, -526633767, 448935289, 458835042, '8y', -705922211, 743.007715, 51, '42q7sx58b4', -1122409769, 1849819405, -929383517, 'u', 'mkrpdj', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483642, 1, 3, -2147483648, -2013213247, 101754718, 628082526, '9n0jxfofwsz', -210159774, 562.960947, -2071531094, 'q0k32od', -613916489, 2061558815, 895277769, 'amsorlwyng', '1', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483641, 1, 3, -2147483648, 211603887, -413043724, 761519897, 'yoeyo6l', 1428194830, 124.067083, 51, '6fuqy', 778835680, 1755752040, 1262491793, '5', '1gwnlas6', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483640, 1, 3, -2147483648, 1731324803, -1159083009, -1589605308, 'z5nxih6', -251205568, 446.264042, 287256667, 'otow9oa', 456034296, -628433041, 1044710644, 'qb0tbindz39t', 'j', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483639, 3, 1, -2147483648, 748154000, 1148916014, -1988582944, 'mbc3td', 1964331395, 506.209886, 51, 'd', 40558455, 740386991, 2018368241, 'xw1rxe9yfk7', 'k162n', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483638, 3, 3, -2147483648, -141591627, 440797047, -732999244, '6dza35r', 2072023304, 683.879518, -1160642134, 'ri2hy08ft', 2066302536, 24053253, -646944990, 'xxnja', 'bymzn2mfx7h3', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483637, 1, 1, -2147483648, 63063873, -843082635, -285085577, '8sh', -63214972, 207.572242, 51, 'ys7dyyd', 357443379, -1502591405, -2008781089, 'qta8y3a17', 'v4ygmayq3qdp', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483636, 3, 1, -2147483648, 2013152515, 1139012231, -951706262, '5wli', 899787662, 638.478504, 833568923, '90xdmsqt', -1685482179, -1391541536, -1025517017, 'i9f2ccukj', '1quik', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483635, 1, 1, -2147483648, 775289854, -2052350430, 166124233, 'st1', 2101986789, 961.035335, 51, 'iztv', -1304516770, -1558272216, 195316816, 'qlud8', 'tb', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483634, 1, 2, -2147483648, -2063751689, 36589303, -1537647691, 'uuwsj8kjh8', -55270062, 243.463869, 1939337883, 'isurz', -388527046, -1040951738, -1218774640, 'gc8s3b7v88k', 'dmdbdh', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483633, 1, 3, -2147483648, 1946419004, -1215810104, -982188592, 'hsjhanz', 1463445550, 48.58913, 51, 'unmw', -1782325492, -544173163, -958321297, 'w', '014', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483632, 1, 3, -2147483648, -911953404, 1084127083, -1019350771, 'o20pj6dd', 1216978423, 383.695713, -1087163929, 'k', 658507818, 334376591, 1154884242, 'r31', 'wq51oa', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483631, 3, 1, -2147483648, 1265709623, 1731005516, 1388661799, '1pa', 1754053934, 781.008765, 51, 'wnyqro', 917675957, -1582954378, -1143329124, 't63', 'xyfvmjwpp26', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483630, 3, 2, -2147483648, 960696718, 1663074182, -352678633, 'r133ir1a', -569461411, 379.844141, 1498496406, 'l2i9', -1837449583, 1299933788, 679285124, 'k', 'wtsr5', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483629, 1, 1, -2147483648, 17776256, -1464066437, -1892701926, 'zg3r', 294604606, 159.965354, 51, 'ns47j2ja8dc', -1955129162, -1015337060, 403107330, 'nxs6d', 'dxdo2v', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483628, 1, 3, -2147483648, -1136928894, -1789708299, -743497747, '7k10', 720126052, 646.587479, 973615628, '1ogyv1rgezax', -316078323, -754769711, 1128553504, 'xeilp', 'e019cy7od0', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483627, 1, 3, -2147483648, 1735624376, -1665891229, -929713613, 'hed2', -1066046077, 726.542267, 51, 'u331spxpw', -165171643, -2051120765, -607931326, 'xginlj6idm', '61l2', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483626, 1, 1, -2147483648, 1562909425, 950497469, -1722214030, 'ev', -582813835, 366.591075, 387548943, 'kuboe8cde', 1557266002, -775706063, -1417040770, 'llbwvdpu5v0e', 'u', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483625, 3, 1, -2147483648, -214587907, -54963162, 1084895939, 'pa', -563021857, 702.882758, 51, '2', -1809620481, -1963064871, 8608094, 'yet', 'xjhcf46cf', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483624, 1, 3, -2147483648, 1082379969, -878613380, 1660953326, '3ddrok', -744133723, 980.464424, 1795932554, 'ehia3', 652687353, 848275284, 736542812, '0', 'ffwor1', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (2, 1, 1, -2147483648, 2056318381, 1749319777, -213453775, '01', -1618292687, 130.898052, 51, '7f8kqhiu5g', -1728059226, 1652765764, 854201197, 'lsa', 'sp4kwi', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (3, 1, 1, -2147483648, -1480511510, -189319798, -51114840, 'v', -197208169, 271.953128, 51, 'w4jn2z19', 643485636, -1693332814, 319828561, 'c', 'gmukfb5if4', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483621, 1, 2, -2147483648, -2055620484, 1176294340, -1429883874, 'e6', -879976368, 312.178711, -1374901328, 'cel8mhfc', -1550947002, 858757143, 1865625247, 'ii0f', 'bgz5', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483620, 1, 1, -2147483648, -30240851, -887179029, 1904358742, '1ehn1mdaqq', 1306095601, 838.769485, -514593578, 'np64h', -1324600306, -1250452845, -1301565530, 'rwbjk', 'bph6gdw', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483619, 1, 2, -2147483648, 1693885387, 444740797, 1357832405, 'nyj5yrji5m', 1253306312, 169.455148, 1070662443, 'a38gfxswb2d', 1823879859, -1318060436, -613511812, '7', 'tp5q', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483618, 1, 1, -2147483648, 825979697, -1565247126, -419727501, '90nhsp9gobb6', -976193147, 496.408957, 51, 'phy', -2074051940, 1487440939, 1295963771, 'vhvyx8s', 'r', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483617, 1, 1, -2147483648, -1001218462, -1965995887, -1756413046, '3rzgz84', 624911807, 836.511775, 51, 'qme2wb1b3vu', 795347051, 61145737, 1522069539, 'mol', '070zi', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483616, 1, 2, -2147483648, 162901577, -159167628, -43429869, '6dpe', -1869902412, 618.342373, 796830191, '0u2vil21', -555808510, -2091367850, 1367239582, '5ziqoauy023', 'wh9', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483615, 1, 3, -2147483648, 1191255697, 1903061181, 943944514, 'loxd4sj5il', 1338378083, 612.52666, 945802166, 'dvygwakmw', 374958195, -151666814, -487579632, 'k', 'i', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483614, 1, 1, -2147483648, 1950702818, 877176214, 109383153, '4s2a', -1532823638, 324.000347, 51, '6xuj90tefx', -199427879, -18235088, 564132547, '9l', '8qzabi', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483613, 1, 2, -2147483648, 1317293788, -1401325547, 1580782292, 'jwk6hh2oe7', 1342717090, 408.066092, 1100953564, 'zrv1ll930xvk', 2045017461, 513178845, -974198226, 'saxe', 'in', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483612, 1, 1, -2147483648, 764470079, -1038583670, -195750727, 'uxdoxa0o', 858882953, 426.876274, 1930622140, 'mjrssbh72404', 1550708132, -167830093, -383974656, '1', 'gqut', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483611, 1, 1, -2147483648, -1408342453, 1689665778, 842122481, 'xk0a0cql1c8c', -656017519, 4.971847, -1089271699, '60ugk2hjz', -564818339, -1698199106, -1400894698, '9a', 'gkjog8dw', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483610, 1, 1, -2147483648, -4093179, -1050631698, -1920701595, 'abmk', -976424792, 850.829726, 51, 'zdlb6', -1578115092, 1957002795, 1239479860, 'w5c29dwt1ha', 'vc2c4zpw8672', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483609, 1, 3, -2147483648, -1501533097, -106120329, 1124850667, 'nbhvi6', -871131109, 455.239887, -1767328130, 'dtw89qy6sru4', -1877887746, -1774239054, 1474709013, 'bp9qgjrad', 'fhj8zr6k53', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483608, 1, 1, -2147483648, -23658516, -1799118529, 1246886254, '1u', -1457401052, 136.427632, 51, '0g50j597fz', -1232470711, 615649657, -779262852, '41faxc', 'je448u5', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483607, 1, 3, -2147483648, 1337608681, 709713623, -1664812348, '3o', -508328860, 648.558542, -1585881270, 'ly46upl', 972288112, 1349808277, -194344351, '0pq97j534j5', 'bk11ys', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483606, 1, 1, -2147483648, 1686931087, -111324604, -1305865435, 'jve', 1806134886, 438.058244, 50, 'rn6j72vkweg', -948703093, 1686819558, -1256487758, '5jw5pbgw', 'ojnhh6va3tdx', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483605, 1, 1, -2147483648, 1082262335, 67983002, -171251505, '58zb', -1714719754, 721.092336, 1, 't0twou', 1942685474, -470913545, 882611339, 'h5c4f1q9w43', 'al8', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483604, 1, 1, -2147483648, -1159228699, 1969582207, 266841961, 'cq2iae6aj6ql', 29713329, 690.778298, -2109911190, 'kjyfxsove9', 191093512, 1633213040, -56395913, 'ikp3qu77c', 'swgr12', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483603, 1, 1, -2147483648, 1641944645, -1662143968, -1348351819, 'y93zu8yb4q', -1134421846, 109.03259, 51, 'mdhct', 931265534, 177710966, 1530956156, 'hlh5i1', 't', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (4, 4, 4, -2147483648, -1137908826, -918961358, -1602639011, 'unw6klfa', 1419861592, 663.001988, 51, 'ecigce376n', 1313172851, -761141909, 283598170, 'zbuo4nrq', 'rofqyp5s5b', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (5, 5, 5, -2147483648, -904834265, -346339240, 1692174491, 'qi2rkf9v', 556727997, 860.770887, 50, '8pz0f8je', 1196308825, 910894705, -283454505, '9uxj4hw', 'd', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (6, 6, 6, -2147483648, -1137908826, -918961358, -1602639011, 'unw6klfa', 1419861592, 663.001988, 51, 'ecigce376n', 1313172851, -761141909, 283598170, 'zbuo4nrq', 'rofqyp5s5b', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (7, 7, 7, -2147483648, -904834265, -346339240, 1692174491, 'qi2rkf9v', 556727997, 860.770887, 50, '8pz0f8je', 1196308825, 910894705, -283454505, '9uxj4hw', 'd', -2147483648);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(IIF(STRFTIME('%Y', T3.dob) < '1985' AND T1.laps > 50, 1, 0)) AS REAL) * 100 / COUNT(*) FROM results AS T1 INNER JOIN races AS T2 ON T1.raceId = T2.raceId INNER JOIN drivers AS T3 ON T1.driverId = T3.driverId WHERE T2.year BETWEEN 2000 AND 2005;

/*
Gold Result:
(52.083333333333336,)
*/

-- Prediction Query
SELECT (CAST(COUNT(DISTINCT d.driverId) AS REAL) * 100.0 / CAST((SELECT COUNT(DISTINCT driverId) FROM results AS r JOIN races AS ra ON r.raceId = ra.raceId WHERE ra.year BETWEEN 2000 AND 2005) AS REAL)) AS percentage FROM drivers AS d JOIN results AS r ON d.driverId = r.driverId JOIN races AS ra ON r.raceId = ra.raceId WHERE ra.year BETWEEN 2000 AND 2005 AND STRFTIME('%Y', d.dob) < '1985' AND r.laps > 50;

/*
Prediction Result:
(40.0,)
*/