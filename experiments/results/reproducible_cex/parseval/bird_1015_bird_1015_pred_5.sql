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
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1, -2147483648, -992890117, 1, 'Austrian Grand Prix', '2020-01-20', 'ypuzhsrw', 'url_1');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (-2147483647, -2147483648, -1264842910, 1, 'Austrian Grand Prix', '2022-11-09', 'nqcx5h', 'A');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2, -2147483648, -516345261, 1, 'Austrian Grand Prix', '2020-07-18', 'ohvu06dza3', 'url_3');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (3, -2147483648, 1966809332, 2, '7dyyd', '2024-10-07', 'jmgjach8qt', 'url_4');

-- Inserting into table: drivers --
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483648, 'p', 13244799, 'hvdltt', 'lbn', 'rmdp', '2022-07-21', 'siie5unw6k', 'url_1');

-- Inserting into table: constructors --
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (-2147483648, 'fa9', 'name_1', '00t5c4e', 'cigce376nium');

-- Inserting into table: circuits --
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1, '5k5swwqcgs', '9n8', '4', 'gu7v', 86.520366, 65.761562, 1160656988, 'url_1');

INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (-2147483647, 'f8jegd2', 'vy9uxj4', 'wb', 'v', 185.427628, 243.480613, 1581736075, 'url_2');

INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (3, 'q8qdjpe1', 'o22', '8507cvtjp', 'ttg6bnou5zi3', 510.534763, 32.017558, -68044929, 'url_3');

INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (2, 'oa', 'cd07z2zezjo7', 'wgxd5ysxcm', '0oztd', 104.37745, 703.796681, -1609653472, 'url_4');

-- Inserting into table: seasons --
INSERT INTO "seasons" ("year", "url") VALUES (-2147483648, 'url_1');

-- Inserting into table: status --
INSERT INTO "status" ("statusid", "status") VALUES (-2147483648, '52zbuo4nrq');

-- Inserting into table: results --
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483648, 1, -2147483648, -2147483648, 418417917, -1031969798, -1106983592, '5bbp0', 743312762, 825.231787, -1822992503, 'liqa1', 2074205376, 274769912, -188151580, 't1__41405d', 'hl72klex1', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483647, 1, -2147483648, -2147483648, -453362185, 481163439, 2123196517, 'dwyrq13pyu78', 244829661, 182.777264, -904834265, 'b4yp5qi', -227162283, 2056419640, 222415430, '1', 'x58pz', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483646, 1, -2147483648, -2147483648, -841004020, -361507387, 401805964, 'gq8', -1255130038, 89.552801, 806170397, 'qv0gcb98ozk', -155284187, 1686459626, -1554531873, 't1__41405d', 'yrkn6vck6ah0', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483645, 1, -2147483648, -2147483648, -658391922, -1388029300, -566887085, '72fxa7ryfd', 564390026, 569.30821, -1259474148, 'jai', 1746373317, 1360271423, 1583472758, 't1__cce1ba', 'rg', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483644, 1, -2147483648, -2147483648, 1129658414, 1250290042, -1717646459, 'ri', -902895762, 453.914926, 2111987706, 'p1q430', 1923912467, 518609210, 1948383687, '1', 'e', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483643, 1, -2147483648, -2147483648, 1774087382, 1732258051, -1762140823, 'w1of77pz', 87529806, 752.977863, -1957268147, 'c', 1303877941, -1284905200, 7929158, '1', '0v', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483642, 1, -2147483648, -2147483648, -1212676731, 1692046802, -1300180872, '58q', 1817366143, 876.038555, 1055237066, 'r94gth2m', 418247369, -1524425594, -1351793914, 't1__41405d', 'okv8uttm', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483641, 1, -2147483648, -2147483648, -1817527403, -1402164108, 2123471885, 'yz7zzbe8yvk', 1043710187, 574.117269, -233617564, '7sx58b4pma', -929383517, -2090240067, -699574669, '1', 'rpd', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483640, 1, -2147483648, -2147483648, -2013213247, 101754718, 628082526, '9n0jxfofwsz', -210159774, 562.960947, -2071531094, 'q0k32od', -613916489, 2061558815, 895277769, 't1__41405d', 'amsorlwyng', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483639, 1, -2147483648, -2147483648, 453340472, 211603887, -413043724, 'k1yoeyo6l0h', -1942581013, 506.13059, -795975227, 'xuzkb52', -277407746, -670154354, -2140468103, '1', 'elboeowii', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483638, 1, -2147483648, -2147483648, -1552469358, 7342822, -1034034171, 'lyotow', 205676091, 735.218284, -2094843966, '96', 1044710644, 966412849, -2061634386, 't1__41405d', 'bindz', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483637, 1, -2147483648, -2147483648, 1376887048, 261633665, 748154000, 'cgumbc', 1295379066, 749.454983, 40558455, 'vzxw1rxe', -505019168, 1968783602, 125495479, '1', '162', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483636, 1, -2147483648, -2147483648, 789756515, -1160642134, 769234989, '8ftp6ewtqx', 2013745856, 2.747847, 917362079, 'mzn2mfx', 1243701948, -156175571, 1220047834, 't1__41405d', '6sto1cj8sh5k', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483635, 3, -2147483648, -2147483648, -2125172723, 339193890, -493230039, 'mayq3qdpua', 1291298007, 961.532162, 2013152515, 'q', -951706262, -1324935647, -648564084, '1', 'c7d', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483634, 1, -2147483648, -2147483648, 379651188, -592014051, 1744849810, 'sqtgelcuqb', 1374676344, 555.47049, -788896327, 'q1q', -796609690, -1459013972, -1670335771, 't1__41405d', '8hlst1p', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483633, 1, -2147483648, -2147483648, 2141720493, 1793241362, -1304516770, 'z78', -2128972904, 857.91055, -1043357093, 'd8ftb8', 1183069552, -1057355067, -1004098188, '1', '6bjeuuwsj8k', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483632, 1, -2147483648, -2147483648, 486475144, -679850352, 1205111943, '0kaqtnc', 697582781, 599.871479, 1446366856, 'b7v88kwd', 1789767331, 1633584225, 1671062261, 't1__41405d', 'h', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483631, 1, -2147483648, -2147483648, -1215810104, -982188592, 1981548099, 'sj', -1652411404, 210.413164, -553121210, 'punmwfwxqrl', 2015039199, -641927001, 558684943, '1', 'r5dqtsmg', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483630, 1, -2147483648, -2147483648, -261782899, -1079009577, -1385967617, 'u6iph', -1944869637, 653.320799, 334376591, 'ir', -176968915, -717865822, 2061102304, 't1__41405d', 'a2sb', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483629, 3, -2147483648, -2147483648, -1574319760, 473443538, 1754053934, 'v', 2095277250, 959.09934, -1067465394, 'uirl', 721232773, 323781506, 1026055008, '1', 'it63xy', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483628, 1, -2147483648, -2147483648, -1094296226, 1913338832, -2061050846, 'j', 960696718, 146.452142, 1663074182, '0h3r133ir1ax', -485095266, -1617977597, -1366005916, 't1__41405d', '9es', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483627, 1, -2147483648, -2147483648, 679285124, 1752727653, 1394285393, 'wtsr5', -69263912, 504.138859, -1464066437, '1', 1464469520, -209435372, 946571403, '1', '3r', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483626, 1, -2147483648, -2147483648, 1125564712, -233564324, -1881008758, 'y', -1015337060, 559.980792, 403107330, 'nxs6d', -1910754958, -1900450199, -232312083, 't1__41405d', '7t3gvplj9f', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483625, 1, -2147483648, -2147483648, 1200703349, 108903912, -307050678, 'z2my1ogyv1r', -1712532464, 396.356531, 423028705, '1', -1970162044, 324939521, -1131290294, '1', 'ly78oitxeilp', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483624, 1, -2147483648, -2147483648, 72217086, -392891099, 1529023742, 'dlhdsvnhed29', -1066046077, 726.542267, 1032462616, '331spxpw30bg', -607931326, 1659285381, 1693638235, 't1__41405d', 'nlj', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483623, 3, -2147483648, -2147483648, 495658460, 1530380378, 1069076646, 'ak162oca', 1627742823, 144.19338, -1862623291, 'vxzxlu49ku', -2051917235, 833662145, -1943810603, '1', 'uekhllbw', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483622, 1, -2147483648, -2147483648, 1551904707, -400879450, -1920675616, 'y9v2z12983', 1870044139, 363.048023, -1147311649, 'acxd', -2062902911, -1809620481, -1963064871, 't1__41405d', '6xiyet8xj', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483621, 1, -2147483648, -2147483648, -2003500453, 1280646590, -568125159, '1sjv8nv3d', -1891572006, 220.875898, -744133723, 'ctehia3', 652687353, 848275284, 736542812, '1', '0', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483620, 3, -2147483648, -2147483648, -1853296452, 2056318381, 1749319777, '2qg01huij', 128895724, 603.128475, -1663813652, 'u5gm8gxb5qj', 1311066510, -924570154, -99415515, 't1__41405d', 'i3hl7j', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483619, 1, -2147483648, -2147483648, -51114840, -2018922963, -197208169, '3w4jn', -561387633, 152.79514, -1496507520, 'cgmukfb5if4', 143843552, 1085074663, -1819463450, '1', 'f', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483618, 3, -2147483648, -2147483648, -1371170489, -759584258, 1143458360, '2cel8m', 1197643380, 81.334226, -1957884289, 'n5en', -1591272038, 1985372765, 1443327784, 't1__41405d', 'bgz5', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483617, 1, -2147483648, -2147483648, 1775901296, 81406544, 1276865022, '88y1k253s', -2074118737, 804.161471, 1772219707, '1ehn1', 1134827548, 320743233, -1016026459, '1', 'yy', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483616, 1, -2147483648, -2147483648, -1324600306, -1250452845, -1301565530, 'rwbjk', -356851435, 245.509819, -1940885010, '7', -1489765135, 1550706713, -604038417, 't1__41405d', 'lzh42nyj5yrj', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483615, 1, -2147483648, -2147483648, 1253306312, 1070662443, 683746439, '38gfxswb2d0', -1318060436, 357.155644, 1705750528, 'otp5qo1k4', 404180628, -616308274, 542602362, '1', '4', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483614, 1, -2147483648, -2147483648, -419727501, -1220824615, -888694642, 'gobb6nrn5', -1539870021, 122.54076, -2074051940, 'a', -534612951, 754506713, -500097534, 't1__41405d', '8scr0fs3qn', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (2, 1, -2147483648, -2147483648, -1334768184, 364506391, -1406926883, 'r', -1756413046, 410.046262, 1142505194, 'gz84lqm', -1833815393, 931351333, -2071541072, '1', '3', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (3, 1, -2147483648, -2147483648, 61145737, 1522069539, -1576807806, 'olt070zi90o5', -193700628, 100.260607, 608918735, 'm6dpewe', 2014227445, -1133072015, -243587307, '1', 'l21', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483611, 3, -2147483648, -2147483648, -463551703, -1030741026, -791611500, '23lwh99', -2006209112, 193.215124, -1691663167, 'xjqbloxd4', -928434146, 1083095660, 343349384, 't1__41405d', 'd6dvygwakmwg', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483610, 1, -2147483648, -2147483648, -487579632, -1884996250, -1930352392, 'txfb', 1018356621, 863.650527, -296531894, 'x6j6d', -45970152, 438276362, -208881437, '1', 'du2', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483609, 1, -2147483648, -2147483648, -1770192505, -199427879, -18235088, '709qf9lx8', 562558425, 402.819976, -1552763743, 'umwu7a', -1401325547, 1580782292, -624641029, 't1__41405d', 'hh2oe7935', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483608, 1, -2147483648, -2147483648, 1124849943, 1147847511, -313392629, '930', 286693031, 167.84281, -728757169, 'ql6n0rlpsax', -1827274099, 1178397242, -2045667486, '1', 'v5o', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483607, 1, -2147483648, -2147483648, 1844867559, -986328637, 1784235325, 'doxa0o', 858882953, 426.876274, 1930622140, 'mjrssbh72404', 1550708132, -167830093, -383974656, 't1__41405d', '1', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483606, 3, -2147483648, -2147483648, -1645001664, -451096223, 1239116964, '0a0cql1c8c', -656017519, 4.971847, -1089271699, '60ugk2hjz', -564818339, -1698199106, -1400894698, 't1__41405d', '9a', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483605, 1, -2147483648, -2147483648, 278187714, 935509881, 371075029, 'dw16f5tqh', -1920701595, 929.695228, -2099978946, 'kr2t', -1903548007, -1578115092, 1957002795, '1', 'ew5c2', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483604, 1, -2147483648, -2147483648, 758391026, 681805258, 1254343862, '4', -429097391, 355.299179, 1690729846, 've', -390816038, -1748913439, -1608712068, 't1__41405d', '99kvn', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483603, 1, -2147483648, -2147483648, -871131109, -192243223, -1767328130, 'dtw89qy6sru4', -1877887746, 86.902776, 1474709013, 'bp9qgjrad', -1746125330, 765163181, 24627578, '1', '53p8e5olf0y', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483602, 1, -2147483648, -2147483648, -405021191, -351624428, 861728040, 'j597fznqcuex', -130254436, 88.852607, 1358642481, 'je448u5', -1400298523, -1879695947, 1337608681, 't1__41405d', '3cehye3oylc', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483601, 3, -2147483648, -2147483648, 788036815, 2055250957, -1325997790, '0pq97', -30073701, 764.224206, -70372742, 'xbk11ysp', 1408494635, 1686931087, -111324604, 't1__41405d', 'pjjv', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483600, 1, -2147483648, -2147483648, -656237101, -1721897132, -898823195, '45j', 1847668366, 494.405694, 1652097981, 'wo', -1611243101, 16782608, -164454935, '1', 'dx5hn75b73', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483599, 1, -2147483648, -2147483648, -1714719754, 1946934142, -852843717, 'woua4', 453154609, 134.65937, 823950453, 'c4f1q9w4', -168704210, 535909504, -215535291, 't1__41405d', '4j9f', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483598, 1, -2147483648, -2147483648, 266841961, 1728774879, 1232103941, 'e6aj6ql167', 1083169975, 573.191945, 1093235102, 'azkjyfxsov', 1450500765, 946867225, 874634276, '1', '5v8ikp3q', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483597, 1, -2147483648, -2147483648, 1469886207, -991357557, -263728848, 'u6v8hk', -1348351819, 563.259731, -163756060, '8yb4qp', -1154116262, -55064672, -1329457837, NULL, 'ct', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483596, 1, -2147483648, -2147483648, 1530956156, -622372461, 626179209, '5i', -270264442, 306.031816, -1484204197, '8ry9lhw6lv7', -1524863063, -209713762, -270252656, NULL, 'qt5uw42', -2147483648);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
WITH fastest_lap_times AS (SELECT T1.raceId, T1.FastestLapTime, (CAST(SUBSTRING(T1.FastestLapTime, 1, INSTR(T1.FastestLapTime, ':') - 1) AS REAL) * 60) + (CAST(SUBSTRING(T1.FastestLapTime, INSTR(T1.FastestLapTime, ':') + 1, INSTR(T1.FastestLapTime, '.') - INSTR(T1.FastestLapTime, ':') - 1) AS REAL)) + (CAST(SUBSTRING(T1.FastestLapTime, INSTR(T1.FastestLapTime, '.') + 1) AS REAL) / 1000) AS time_in_seconds FROM results AS T1 WHERE NOT T1.FastestLapTime IS NULL) SELECT T2.name FROM races AS T2 INNER JOIN circuits AS T3 ON T2.circuitId = T3.circuitId INNER JOIN results AS T1 ON T2.raceId = T1.raceId INNER JOIN (SELECT MIN(fastest_lap_times.time_in_seconds) AS min_time_in_seconds FROM fastest_lap_times INNER JOIN races AS T2 ON fastest_lap_times.raceId = T2.raceId INNER JOIN circuits AS T3 ON T2.circuitId = T3.circuitId WHERE T2.name = 'Austrian Grand Prix') AS T4 ON (CAST(SUBSTRING(T1.FastestLapTime, 1, INSTR(T1.FastestLapTime, ':') - 1) AS REAL) * 60) + (CAST(SUBSTRING(T1.FastestLapTime, INSTR(T1.FastestLapTime, ':') + 1, INSTR(T1.FastestLapTime, '.') - INSTR(T1.FastestLapTime, ':') - 1) AS REAL)) + (CAST(SUBSTRING(T1.FastestLapTime, INSTR(T1.FastestLapTime, '.') + 1) AS REAL) / 1000) = T4.min_time_in_seconds WHERE T2.name = 'Austrian Grand Prix';

/*
Gold Result:
('Austrian Grand Prix',)
('Austrian Grand Prix',)
('Austrian Grand Prix',)
('Austrian Grand Prix',)
('Austrian Grand Prix',)
('Austrian Grand Prix',)
('Austrian Grand Prix',)
('Austrian Grand Prix',)
('Austrian Grand Prix',)
('Austrian Grand Prix',)
('Austrian Grand Prix',)
('Austrian Grand Prix',)
('Austrian Grand Prix',)
('Austrian Grand Prix',)
('Austrian Grand Prix',)
('Austrian Grand Prix',)
('Austrian Grand Prix',)
('Austrian Grand Prix',)
('Austrian Grand Prix',)
('Austrian Grand Prix',)
('Austrian Grand Prix',)
*/

-- Prediction Query
SELECT r.name FROM races AS r INNER JOIN laptimes AS l ON r.raceid = l.raceid WHERE r.name = 'Austrian Grand Prix' ORDER BY l.milliseconds ASC, r.raceid NULLS LAST, l.raceid NULLS LAST, l.driverid NULLS LAST, l.lap NULLS LAST LIMIT 1;

/*
Prediction Result:
*/