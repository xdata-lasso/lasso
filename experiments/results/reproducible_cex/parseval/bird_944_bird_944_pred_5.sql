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
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1, 2008, -992890117, -2147483648, 'Australian Grand Prix', '2020-01-20', 'ypuzhsrw', 'url_1');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (3, 2008, -975213201, -2147483648, 'Australian Grand Prix', '2021-01-15', 'vqx58pz0f', 'url_2');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2, 2008, 1196308825, -2147483648, 'd21vy9uxj4hw', '2020-04-02', 'v', 'url_3');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (4, 1, -1437333179, -2147483648, 'Australian Grand Prix', '2023-03-15', 'wqcgsk', 'url_4');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (5, 1, -921187550, -2147483648, 'Australian Grand Prix', '2020-03-14', 'p', 'url_5');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (6, 2008, -1437333179, -2147483648, 'rac_93d18e', '2023-03-15', 'wqcgsk', 'url_6');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (7, 1, -921187550, -2147483648, 'rac_93d18e', '2020-03-14', 'p', 'url_7');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (8, 1, -688509700, -2147483648, 'rac_93d18e', '2023-07-16', 'j4hwbd', 'url_8');

-- Inserting into table: drivers --
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483648, 'b', 1072996612, 'luhvdltti', 'bnp', 'mdpos', '2021-06-28', 'e5u', 'url_1');

-- Inserting into table: constructors --
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (-2147483648, 'w6kl', 'name_1', 'a9', '00t5c4e');

-- Inserting into table: circuits --
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (-2147483648, '5k5swwqcgs', '9n8', '4', 'gu7v', 86.520366, 65.761562, 1160656988, 'url_1');

-- Inserting into table: seasons --
INSERT INTO "seasons" ("year", "url") VALUES (2008, 'url_1');

INSERT INTO "seasons" ("year", "url") VALUES (1, 'url_2');

-- Inserting into table: status --
INSERT INTO "status" ("statusid", "status") VALUES (-2147483648, 'cigce376nium');

-- Inserting into table: results --
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483648, 1, -2147483648, -2147483648, 283598170, 742285925, -747753377, 'nrqrofqy', -1106983592, 938.694822, 902551284, 'p', 882961052, 743312762, -1822992503, 'liqa1', 'ryytoo3', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483647, 1, -2147483648, -2147483648, 1178636309, -1390245819, 1055976837, '4ji7zwa', 2123196517, 920.013763, 364869063, ':', -953437896, -1097120355, 244829661, 'jsl', 'b4yp5qi', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483646, 2, -2147483648, -2147483648, -261132974, -1264842910, -1052964641, 'qcx5', 580968159, 210.05299, 1575412235, 'jtu0d', 401805964, -1485777725, -1255130038, '3d', 'qv0gcb98ozk', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483645, 2, -2147483648, -2147483648, -1554531873, 982314585, 638024588, '6vck6ah0f8js', -658391922, 176.824244, -566887085, ':', 602161869, 1350414441, 2094425101, '7', 'yfdrz', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483644, 3, -2147483648, -2147483648, -1483100200, -7597509, -1625552518, 'grgj', -458359144, 639.801051, 1568069663, 'fgogritsj3ay', -598313376, 1972233925, 1792827279, '4301jh3den8', 'c68x8vacx7', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483643, 2, -2147483648, -2147483648, 1371234901, -290314193, 76996700, 'o72ctdc', 1303877941, 695.452114, -1284905200, ':', 7929158, -1744557630, 1870300798, 'q8qdjpe1', 'o22', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483642, 2, -2147483648, -2147483648, -866772222, -847293924, -2033879835, 'u5zi', 1944978593, 900.959264, -2072838897, 'foa', 382831862, -406331049, -461418236, 'zjo7wgxd5ysx', 'm', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483641, 2, -2147483648, -2147483648, 853709925, -870767087, -1699185893, '5i3lq5lnpim5', -1125548818, 848.622384, -95808609, ':', -244633520, 418247369, -1524425594, 'a3o', 'v8u', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483640, 3, -2147483648, -2147483648, -229022515, -1817527403, -1402164108, 'yz7zzb', 924693315, 335.639672, 1043710187, '42q7sx58b4', -1122409769, 1849819405, -929383517, 'u', 'mkrpdj', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483639, 2, -2147483648, -2147483648, -55494714, -1674145149, 234957614, 'o705a9n0jxfo', -1793230843, 296.34381, -441521858, ':', 2015094998, 1010672881, -1197954156, '0', '0k32o', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483638, 2, -2147483648, -2147483648, 895277769, 364043263, -1177989415, 'wyn', 1953495465, 43.579053, 681061317, 'iz', -499913447, -360096930, -1942581013, 'fuqyxuzkb', '521gwnlas6e', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483637, 2, -2147483648, -2147483648, 1731324803, -1159083009, -1589605308, 'z5nxih6', -251205568, 446.264042, 287256667, ':', 1614799674, 1083479253, 1774679448, 'oaawg96aq', '0', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483636, 3, -2147483648, -2147483648, -1897615568, 2085299664, 2038321753, 'z9t', 748154000, 767.502854, -1988582944, 'mbc3td', 1964331395, -1943814113, 1514371324, '603vzxw1r', 'e9yfk7', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483635, 2, -2147483648, -2147483648, -246257698, -516345261, -1191116453, 'u06dza', -154207334, 576.663277, 729449685, ':', -1580984044, 150596046, 431832073, 'hy08ftp6', 'wt', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483634, 2, -2147483648, -2147483648, -1485875026, -2080232972, 462225708, 'n2mfx7h', -156175571, 753.382585, 1220047834, '6sto1cj8sh5k', 1106724223, 1966809332, 1487347213, 'yd1jmgj', 'c', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483633, 2, -2147483648, -2147483648, 620355627, -531872415, -2125172723, 'v4ygmayq3', 1432875972, 578.439563, 1032339628, ':', 608093726, 1595033206, 1291298007, 'tdqr', 'm5', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483632, 3, -2147483648, -2147483648, -1260548409, 1409697108, -1104749933, '0xdmsqtge', -1391541536, 321.654734, -1025517017, 'i9f2ccukj', 1046248997, 1584429327, -1575692857, 'yhb08hl', 't1pqo', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483631, 2, -2147483648, -2147483648, -696672546, 44959255, -74691962, '78aqqlu', 948460309, 21.957253, 1183069552, ':', -1057355067, -1004098188, 316163741, 'uu', 'sj8kjh', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (2, 1, -2147483648, -2147483648, 1939337883, -996196097, 986268139, 'urz0kaqtncg', 428944759, 843.228203, 1446366856, 'b7v88kwd', 1789767331, 1633584225, 1671062261, 'h', '6j47n', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (3, 1, -2147483648, -2147483648, -343920305, 460471995, -1515201134, 'n', 1195320303, 840.734969, -1096060187, 'mwfw', -544173163, -958321297, 2015039199, 'k014r5', 'dqtsmg97aqz2', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483628, 1, -2147483648, -2147483648, -1079009577, -1385967617, 1813965704, 'u6iphdku2gi', 1113005977, 694.682328, -176968915, ':', -717865822, 2061102304, -1204806277, 'sb3uoi1p', 'avcvwnyqroui', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483627, 1, -2147483648, -2147483648, 586437419, -711121679, 1977502251, 'p26m', -2061050846, 940.97048, -364462246, ':', 982289268, 493701528, 461842658, 'ir1axyyh', 'l2i9', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483626, 1, -2147483648, -2147483648, 1092207544, 851545765, 987928936, '6qje', 889799750, 299.758919, 328574939, ':', 1464469520, -209435372, 946571403, '3r', 'jkwns47j2j', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483625, 1, -2147483648, -2147483648, -516707997, 1014871129, -583955995, '6dvdxdo2v7', 1805923837, 337.06993, -1368221491, ':', 231250827, -1519752081, 906349223, 'n7k10z', '2my1ogyv1rg', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483624, 1, -2147483648, -2147483648, 1128553504, 1374917235, -563920971, 'lpe', 1163377746, 553.07135, -1164657946, ':', 693108667, -1882121644, 935816178, 's', 'nhed29', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483623, 1, -2147483648, -2147483648, -1089715864, -165171643, -2051120765, 'kxginl', 1595944351, 563.529532, 1673977398, ':', 1004962990, -1318740197, -306339789, 'o3ak162o', 'cagjeevxzxlu', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483622, 1, -2147483648, -2147483648, -775706063, -1417040770, 858308694, 'lbwvdpu5v0e', -1920675616, 594.359145, -699425950, ':', -432771718, 516500236, 171585273, '5xoepacxdb2f', 'c296xiy', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483621, 1, -2147483648, -2147483648, 1280646590, -568125159, -329270684, 'v8n', -137586537, 59.584068, -1198828889, ':', -744133723, 2063578992, 1795932554, 'ehia3', 'm', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483620, 1, -2147483648, -2147483648, -1977676789, 1434462631, 1621309369, 'wo', -980269466, 779.908464, -1424758178, '9q', NULL, -213453775, -1721445347, 'huij7f8', 'qhi', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483619, 1, -2147483648, -2147483648, -1728059226, 1652765764, 854201197, 'lsa', -924570154, 476.853022, -635922435, 'hl7j43y7', NULL, 209963559, -480726958, '83kr3w', 'jn2z19xg', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483618, 1, -2147483648, -2147483648, 2062713020, -1725535379, 1709325128, 'if4180te', -1003698590, 84.558761, -1147551293, ':', -716185359, -879976368, -806686292, '6lu2c', 'l8', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483617, 1, -2147483648, -2147483648, -1550947002, 858757143, 1865625247, 'ii0f', -2013600868, 839.591264, -415366855, 'qxs2', NULL, 81406544, 1276865022, '88y1k253s', '5', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483616, 1, -2147483648, -2147483648, 1115155768, 428576631, -1253720301, 'daqq', 1306095601, 838.769485, -514593578, 'np64h', NULL, -1324600306, -1250452845, '4m0rrwbjk0', 'p', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483615, 1, -2147483648, -2147483648, -616998913, 1022316699, -1519375860, 'lwtlzh42nyj5', 411661379, 149.30112, 1357426337, ':', 2039586655, 1253306312, 1070662443, 'a38gfxswb2d', 'zmxwdb7', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483614, 1, -2147483648, -2147483648, -1013704446, -317233455, 1548141293, 'c6gwnkd4kc', -1565247126, 163.356861, -419727501, '90nhsp9gobb6', NULL, -976193147, -15423424, 'phy', 'n', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483613, 1, -2147483648, -2147483648, 2017526622, -693920036, 195093192, 'r', -366834342, 287.505213, 1378228777, '0b5m', NULL, -1001218462, -1965995887, 'fx03rz', 'z8', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483612, 1, -2147483648, -2147483648, -1292966884, 1800088659, -322010175, '3vun66e0imol', 1270732094, 421.257127, 354693690, NULL, 399119867, 207340898, -1205465222, 'q833g86', '5zm6dpewew0', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483611, 1, -2147483648, -2147483648, 1571723723, -1357636512, 1511374322, 'ad6q5', -463551703, 260.011898, -791611500, '23lwh99', NULL, -2006209112, -1691663167, 'xjqbloxd4', 'j5il9', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483610, 1, -2147483648, -2147483648, 47431001, -698277997, 748510826, 'wakmwgw73fy3', -1884996250, 50.554806, 1221655010, 'fbl10q', NULL, 2098431017, 41724575, 'fc75m4s2', 'j', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483609, 1, -2147483648, -2147483648, 46301377, 273512703, 262910362, 'efx3u', -18235088, 523.309294, 564132547, ':', NULL, 562558425, -417385007, 'i', 'uumwu7', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483608, 1, -2147483648, -2147483648, -624641029, 55189176, -1632840156, 'oe79350fzrv1', -1406020933, 555.229608, 1719477248, NULL, NULL, 286693031, -728757169, 'ql6n0rlpsax', 'ei', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483607, 1, -2147483648, -2147483648, -2010362797, 1938400567, -1191120749, 'meqv3', -986328637, 915.424655, -562113476, NULL, NULL, 560506797, 830725610, 'l1zm', 'rss', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483606, 1, -2147483648, -2147483648, -85207801, -73867879, 1086562671, 'p3303a1ngqu', 359389091, 62.398913, 1961977235, ':', 1537422187, -1645001664, -451096223, 'dyxk0a0cql1', '8', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483605, 1, -2147483648, -2147483648, -1908930700, 1259583135, 1401274472, 'gk2hjz', -564818339, 104.607205, -1400894698, '9a', NULL, 977578358, 278187714, 'og8dw16f5tqh', 'd5m', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483604, 1, -2147483648, -2147483648, 849869394, -976424792, -837263309, 'l', -1578115092, 740.511922, 1957002795, 'ew5c2', NULL, -1934015200, -826285299, 'havc2c4zpw', '672fve0jf', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483603, 1, -2147483648, -2147483648, 1336897658, -735384165, 1211169035, 'i6tp3t', -1767328130, 730.604038, 2071439307, ':', 2077933154, 232457376, 782631880, '4eufiof8of6', 'bp9qgjradf', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (4, 4, -2147483648, -2147483648, -734455130, 1744686505, -1633151678, 'a2y', 1115440883, 882.963176, 1465859724, ':', -1349201381, 1019800248, -1910425938, 'tilbn', 'rmdp', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (5, 4, -2147483648, -2147483648, -1602639011, -45536098, 1861536320, '6klfa9', 1620389964, 627.258639, 947159877, '5c4ec', -1683203397, 528680845, -1585009206, '52zb', 'uo4nrqrofqy', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (6, 5, -2147483648, -2147483648, -751275471, -1347802441, 1673584235, '1', 2074205376, 274.580687, 274769912, NULL, -188151580, 226938182, 90119032, 'lex', '4ji7zwa', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (7, 5, -2147483648, -2147483648, 1485335077, -511185946, -1021749117, '3pyu78d99r', -1362461264, 943.791649, -904834265, 'b4yp5qi', -227162283, 2056419640, 222415430, 'x58pz', 'f8jegd2', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (8, 6, -2147483648, -2147483648, -734455130, 1744686505, -1633151678, 'a2y', 1115440883, 882.963176, 1465859724, NULL, -1349201381, 1019800248, -1910425938, 'tilbn', 'rmdp', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (9, 6, -2147483648, -2147483648, -1602639011, -45536098, 1861536320, '6klfa9', 1620389964, 627.258639, 947159877, '5c4ec', -1683203397, 528680845, -1585009206, '52zb', 'uo4nrqrofqy', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (10, 7, -2147483648, -2147483648, -751275471, -1347802441, 1673584235, '1', 2074205376, 274.580687, 274769912, ':', -188151580, 226938182, 90119032, 'lex', '4ji7zwa', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (11, 7, -2147483648, -2147483648, 1485335077, -511185946, -1021749117, '3pyu78d99r', -1362461264, 943.791649, -904834265, 'b4yp5qi', -227162283, 2056419640, 222415430, 'x58pz', 'f8jegd2', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (12, 8, -2147483648, -2147483648, -1642259219, 1298861365, 1968874827, 'nqcx5h', -1245312912, 866.804244, -988981234, NULL, -841004020, -361507387, 401805964, 'gq8', 'n2f3dqv0gcb9', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (13, 8, -2147483648, -2147483648, -155284187, 1686459626, -1554531873, 'yrkn6vck6ah0', -1520489792, 346.706184, -1388029300, 'xb72fxa7r', -515895469, 1427161052, 564390026, '6nijjai5dh', 'ogrgjd8y', -2147483648);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
WITH time_in_seconds AS (SELECT T1.positionOrder, CASE WHEN T1.positionOrder = 1 THEN (CAST(SUBSTRING(T1.time, 1, 1) AS REAL) * 3600) + (CAST(SUBSTRING(T1.time, 3, 2) AS REAL) * 60) + CAST(SUBSTRING(T1.time, 6) AS REAL) ELSE CAST(SUBSTRING(T1.time, 2) AS REAL) END AS time_seconds FROM results AS T1 INNER JOIN races AS T2 ON T1.raceId = T2.raceId WHERE T2.name = 'Australian Grand Prix' AND NOT T1.time IS NULL AND T2.year = 2008), champion_time AS (SELECT time_seconds FROM time_in_seconds WHERE positionOrder = 1), last_driver_incremental AS (SELECT time_seconds FROM time_in_seconds WHERE positionOrder = (SELECT MAX(positionOrder) FROM time_in_seconds)) SELECT (CAST((SELECT time_seconds FROM last_driver_incremental) AS REAL) * 100) / (SELECT time_seconds + (SELECT time_seconds FROM last_driver_incremental) FROM champion_time);

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT CAST((MAX(r1.milliseconds) - (SUBSTRING(r2.time, 1, INSTR(r2.time, ':') - 1) * 3600000 + SUBSTRING(r2.time, INSTR(r2.time, ':') + 1, INSTR(r2.time, '.') - INSTR(r2.time, ':') - 1) * 60000 + SUBSTRING(r2.time, INSTR(r2.time, '.') - 2, 3) * 1000 + SUBSTRING(r2.time, INSTR(r2.time, '.') + 1))) AS REAL) * 100 / MAX(r1.milliseconds) AS percentage_difference FROM results AS r1 INNER JOIN races ON r1.raceid = races.raceid INNER JOIN results AS r2 ON r1.raceid = r2.raceid WHERE races.name = 'Australian Grand Prix' AND races.year = 2008 AND r2.time LIKE '%:%';

/*
Prediction Result:
(100.0,)
*/