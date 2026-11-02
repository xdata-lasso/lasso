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
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (-2147483648, -2147483648, 2026480202, -2147483648, 'ie5', '2023-09-04', 'w6kl', 'url_1');

-- Inserting into table: drivers --
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1, '5k5swwqcgs', 247012447, '8c4pgu7vfe', 't2__b0cbc7', 't2__383d69', '1980-01-01', 'German', 'url_1');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2, 'jsl', -346339240, 'yp5qi2rk', 't2__b0cbc7', 't2__383d69', '1980-01-01', 'German', 'C');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483647, '9v', 556727997, '8pz0f8je', 't2__b0cbc7', 't2__383d69', '1980-01-01', 'German', 'A');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (3, 'i', 1746373317, 'h', '@', 'I', '1980-01-01', 'German', 'url_4');

-- Inserting into table: circuits --
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (-2147483648, 'hria2ypu', 'hsrwbbp', 'luhvdltti', 'bnp', 787.938887, 986.066566, 907682809, 'url_1');

-- Inserting into table: seasons --
INSERT INTO "seasons" ("year", "url") VALUES (-2147483648, 'url_1');

-- Inserting into table: pitstops --
INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483648, 1620389964, '00t5c4ecigc', 'e376nium52', -443340271);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483647, -1179823637, 'rqro', 'fqyp5s5bbp0', 743312762);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483646, -751275471, 'iqa', '1ryytoo', 1644911394);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483645, 226938182, '72k', 'ex1', -74849714);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483644, -453362185, 'au2dwyrq13', 'yu78', 244829661);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 2, -2147483643, 910894705, '1vy9uxj4', 'wb', -1929953647);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483642, 2103044118, 'h2gndqwnqcx5', 'hncprjtu0dz', -1748371085);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483641, -1255130038, '3d', 'qv0gcb98ozk', -155284187);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483640, -1554531873, 'yrkn6vck6ah0', '8j', -932772113);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483639, -1388029300, 'xb72fxa7r', 'fdrz16n', -1496556994);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483638, -1738458256, 'jd', '!', 1074760385);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, -2147483647, -2147483637, 600440952, 'f', 'A', -1717646459);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, -2147483647, -2147483636, 710458518, 'sj3ayxp1q430', 'A', 1923912467);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483635, -163600466, 'n8', 'A', 195720193);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483634, 2035306060, 'x7afu5w1of77', 'A', -1099855564);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483633, 1992637800, 'dctmf', '!', 7929158);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 3, -2147483632, 1870300798, 'q8qdjpe1', '`', -1180042408);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 3, -2147483631, 2119806856, '7cvtjpttg6b', '`', -1171104889);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 3, -2147483630, 1691780814, '6c4bfkfo', '`', -1950324754);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 3, -2147483629, -253138337, 'zj', '`', 1448731351);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483628, -542502665, 'ysxcmr0o', '!', 853709925);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483627, -1699185893, '5i3lq5lnpim5', '"', -1125548818);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 3, -2147483626, -1719383707, '2m', '"', 418247369);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 2, -2147483625, -1351793914, 'okv8uttm', '"', 1553368934);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483624, 1908593332, 'vy', '"', -451030047);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483623, 924693315, 'kv42q7', 'B', -2060082151);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 2, -2147483622, 1849819405, 'us3auvmkrpdj', 'C', 1105964624);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, -2147483647, -2147483621, -55494714, 'n9', 'C', 101754718);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483620, -1245584612, 'xfo', 'C', -1793230843);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 3, -2147483619, -210159774, 'obb0q0k32o', 'C', -1898678660);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483618, 2061558815, '5amsorlwyngc', '!', -323362455);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483617, -413043724, 'k1yoeyo6l0h', '%', -1942581013);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, -2147483647, -2147483616, -477129795, 'uzkb521gwnl', '%', 1718516876);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483615, 1468640756, 'boeowii1z5nx', '%', -1552469358);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, -2147483647, -2147483614, 287256667, 'otow9oa', '%', 456034296);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483613, -1048779857, 'tbindz3', '%', -2140923099);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, -2147483647, -2147483612, 748154000, 'cgumbc', 'c', 1295379066);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 3, -2147483611, 1514371324, '603vzxw1r', 'c', 237552112);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 2, -2147483610, 125495479, '162', 'c', -1231488097);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 3, -2147483609, 2105860871, 'dohvu06d', 'c', -438741674);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483608, 1595632888, 'mkio18ri2hy', '08ftp6ewtqxx', 1664452437);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483607, 917362079, 'mzn2mfx', 'h33p6sto1', -1971560508);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483606, -1643065004, 'nzy', '7dyyd', 357443379);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483605, 591870819, 'jach8qta8y3', '1', 339193890);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483604, 614314115, 'ma', 'q3qdpua', 1291298007);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483603, 2013152515, 'q', 'hm5wl', -1573704891);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483602, 594760660, 'np490xdm', 'sqtgelcuqb', 1374676344);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483601, -788896327, 'q1q', 'ik1yhb', 1862728578);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483600, -324012243, 'qomiztvb6m', 'iz78aqql', -753065777);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483599, -835782528, 'r9114qbre', '6bjeuuwsj8k', -1486030107);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483598, -609840352, 'lvrisu', 'z0kaq', 1388796595);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483597, 697582781, 'c8s3b7v88k', 'dmdbdh', 313797011);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483596, -1215810104, 'r', '0hsjhanz', 1463445550);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483595, 1720208360, 'nmwfwx', 'rlawk', 558684943);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483594, -967107842, 'dqtsmg97aqz2', '20pj', -1385967617);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483593, 719861381, 'iphdku2gi', '31vwq', 1188674483);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483592, -1204806277, 'sb3uoi1p', 'avcvwnyqroui', -980625770);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483591, 323781506, 'ouit63xyfvmj', 'wpp26mb3aj0j', 982289268);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483590, 1498627641, '133ir', 'axyyhpl', -1837449583);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483589, 1803900001, 'pgckqwtsr', '54o6qjektb1', 1464469520);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483588, -460035045, '3rjkwns47j2j', '8', -1881008758);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483587, -526608193, 'vjwq49yrnx', '6dvdx', -1900450199);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483586, 134065688, 'gvplj9fj', 'uun7k1', -251621840);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483585, 1883146395, 'gyv1', 'gezax', -316078323);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483584, 324939521, 'gly7', '8oitxeilpe0', -1958403507);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483583, -392891099, 'dlhdsvnh', 'd2', -1066046077);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483582, 1032462616, '331spxpw30bg', 'kxginl', 1595944351);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483581, 1004962990, 'p61l', 'o3ak162o', -1954048590);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483580, -1862623291, 'vxzxlu49ku', 'o', 833662145);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483579, -92242817, 'kh', 'llbwvdpu5v0e', -1920675616);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483578, 824044840, 'z129835x', '%', 1084895939);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483577, 1599672055, 'acxdb2f0c29', '1', 8608094);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483576, 2011754567, 'et8xjhcf46c', 'pe', -977983676);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483575, -329270684, 'v8n', '3ddrok', -744133723);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483574, 1795932554, 'ehia3', 'm', -682353894);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483573, 736542812, '0', '!', 1434462631);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483572, -1745755546, 'r1es', 'a', 2056318381);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483571, 1403715810, 'q82qg01hu', 'j7f', -1663813652);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483570, 1190577316, 'gm8gxb5qjl', 'awsp4', -1439283063);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483569, -150306637, '7j4', 'y795ybv8', -197208169);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483568, 1895921842, 'w4jn2z19xgj', '"', 319828561);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483567, 2062713020, 'gmukfb5if4', 'c', 143843552);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483566, -1819463450, 'f', 'kvee', 59326585);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483565, -806686292, '6lu2c', 'l8', 771073365);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483564, -1957884289, 'n5en', 'i0f', -2013600868);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483563, -22531339, 'xs27x', '88', -494119248);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483562, 2132634715, '53sb59ls1e', 'hn1mdaqqhy', 2125055535);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483561, -1224799639, '4hmnnw4m0', 'rwbjk', -356851435);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483560, 1851648795, 'w', '7', -1489765135);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483559, -1398612932, 'lzh42', 'nyj5yrji5m', 1253306312);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483558, 1192169191, '8gfxswb2d0zm', 'wdb7ot', 619382464);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483557, -1013704446, 'k4c6gwn', 'kd4kc3iikaxz', 1008864713);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483556, -1660176735, '9gob', '6', -976193147);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483555, -1539870021, 'yb', 'aayv', 754506713);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483554, 195093192, 'r', 'fs3qn0b', -1500616);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483553, 364506391, 'xcr', 'fx03rz', 1269188010);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483552, 145428926, 'lqme2wb1b3', 'un66e0', -1576807806);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483551, 1915216858, '070zi', '0o50q833g', -43429869);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483550, 1636393410, 'ewew', '092p40u2vi', 770112293);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483549, 1511374322, 'ad6q5', 'iqoauy0', -215230989);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483548, 1236313039, '99', 'fqc1m9gr', 1191255697);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483547, 1072042049, 'xd4s', '5il', 1338378083);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483546, 1293700593, 'gwakmwg', '73fy3d', -1436037867);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483545, 1221655010, 'fbl10q', '6j6d4f', 877176214);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483544, 1869989693, 's2ajdu26xu', 'j90tefx3u5u', 564132547);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483543, 1585107626, '8qzabi', NULL, -686517061);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483542, -1296756845, '7alj0j', NULL, 1930844936);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483541, 55189176, '2o', NULL, 1342717090);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483540, -721010924, 'l93', NULL, 1719477248);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483539, -693758664, 'viql6n0rlp', NULL, 307649752);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483538, 666969074, 'ei', NULL, 1178397242);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483537, 1011792600, 'i', NULL, 1938400567);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483536, -890072422, 'eqv3r3uxdox', NULL, 1264155936);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483535, -1392585113, 'zmjrssbh724', NULL, -373858639);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483534, 1086562671, 'p3303a1ngqu', NULL, 359389091);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483533, -619092341, 'jdlhlzpdyxk0', '0', -1965798280);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483532, 1951564466, 'adbp07', NULL, 1386881333);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483531, 1192445638, 'hjzxpg1l', NULL, -1959143827);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483530, 977578358, 'jog8dw16f5', NULL, -805818449);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483529, -1920701595, 'abmk', NULL, -976424792);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483528, -1903548007, '6', NULL, -1578115092);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.forename, T2.surname FROM pitStops AS T1 INNER JOIN drivers AS T2 ON T1.driverId = T2.driverId WHERE T2.nationality = 'German' AND STRFTIME('%Y', T2.dob) BETWEEN '1980' AND '1985' GROUP BY T2.forename, T2.surname ORDER BY AVG(T1.duration), T2.forename NULLS LAST, T2.surname NULLS LAST LIMIT 5;

/*
Gold Result:
('@', 'I')
('t2__b0cbc7', 't2__383d69')
*/

-- Prediction Query
SELECT d.forename, d.surname, AVG(ps.duration) AS avg_duration FROM drivers AS d INNER JOIN pitstops AS ps ON d.driverId = ps.driverId WHERE d.dob BETWEEN '1980-01-01' AND '1985-12-31' AND d.nationality = 'German' GROUP BY d.forename, d.surname ORDER BY avg_duration ASC, d.forename NULLS LAST, d.surname NULLS LAST LIMIT 3;

/*
Prediction Result:
('@', 'I', 0.0)
('t2__b0cbc7', 't2__383d69', 4.479591836734694)
*/