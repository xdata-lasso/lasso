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
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1, '5k5swwqcgs', 247012447, '8c4pgu7vfe', 't2__00df39', 't2__a3e5f7', '1980-01-01', 'German', 'url_1');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483647, 'jsl', -346339240, 'yp5qi2rk', 't2__00df39', 't2__a3e5f7', '1980-01-01', 'German', 'C');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (3, '9uxj4hw', -2050247126, 'lph2gn', 'q', 'nqcx5h', '2022-05-10', 'p', 'url_3');

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

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483643, 222415430, 'x58pz', 'f8jegd2', 1675430660);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 3, -2147483642, -988981234, 'u0dz7', 'fjgq8n2f3', 806170397);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483641, -688216274, 'gcb98ozk3z', 'i', -512640349);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483640, 32204797, 'k', 'ah0f8jsww', -1388029300);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483639, -541746689, '7ryfdrz16n', 'jja', -7597509);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483638, 1583472758, 'rg', '!', -1478247928);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, -2147483647, -2147483637, 1250290042, 'og', '"', -946046410);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 3, -2147483636, -902895762, 'ayxp1q43', '"', 1235416111);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 3, -2147483635, -1538707438, 'den8c68x', '"', 1774087382);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483634, 1523825314, 'u5', '"', -290314193);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483633, -1099855564, '72ct', '@', -1928431425);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 3, -2147483632, 481546706, 'g6', 'A', -242584410);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, -2147483647, -2147483631, 820970595, 'qdjpe1io2', 'A', 199672698);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 3, -2147483630, -1962347906, 'jpttg', 'A', -2033879835);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, -2147483647, -2147483629, -29242208, '36c', 'A', 1722106924);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483628, -1776877925, 'oa', 'G', 382831862);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, -2147483647, -2147483627, 76987628, 'zezjo7wg', 'O', 1248858185);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, -2147483647, -2147483626, -526612570, 'cmr0oz', 'O', -870767087);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483625, 875300074, '3lq', 'O', 1816660482);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483624, -1556979799, 'k58qs27p', 'O', 988954859);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483623, -244633520, 'ajjl', '&', -2096405521);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483622, 872694102, 'tmu2n', 'c', -1817527403);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483621, 2123471885, 'yz7zzbe8yvk', 'c', 1043710187);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, -2147483647, -2147483620, -2060082151, 'pmaus3auvmkr', 'c', 609771851);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483619, 1105964624, 'w5chn9m', 'c', 823835795);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483618, 628082526, '9n0jxfofwsz', '@', -210159774);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483617, -2019656607, '0k32o', 'A', -1898678660);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483616, 895277769, 'amsorlwyng', 'A', -1960313034);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 3, -2147483615, 681061317, 'iz', 'A', -499913447);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, -2147483647, -2147483614, 513375398, 'l0hdt6fuq', 'A', 1294064538);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483613, -1418927432, '521gwnlas6e', '!', 1468640756);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483612, 1731324803, 'wii1', ')', -457369423);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 3, -2147483611, -564679000, '66', ')', -251205568);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, -2147483647, -2147483610, -1396673167, 'otow9oaawg', ')', 1044710644);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483609, -381485009, 'i', ')', 503053726);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483608, -457901285, 'tajz9td8n', '5wcgumbc3td', 1964331395);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483607, 1071401016, 'w9603vz', 'xw1rxe9yfk7', -1046720861);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483606, -246257698, '55', '3dohvu0', 30861410);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483605, -2121397544, 'rmkio18r', 'i2hy08ftp6', -1853955201);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483604, -1051623642, 'njabym', 'n2mfx7h', -156175571);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483603, 63063873, 'o1cj8', 'h5knz', 1966809332);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483602, -1884062674, 'yd1jmgjach8', 'qta8y3a17v4y', 306260487);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483601, -499203870, 'qdpuap96', 'ntdqr', -1670945624);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483600, -648564084, 'c7d', 'n2np490xdms', -1027584872);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483599, -1872934808, 'u', 'qb9i9f2ccu', -1414362698);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483598, -325680600, 'ik1yhb', '8hlst1p', -1333785554);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483597, -696672546, 'm4iz78aqq', 'ud8', 948460309);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483596, 192271618, '9114qbre6bj', 'uu', -1451520332);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483595, 1138926079, 'pxlvri', 'surz0kaqtncg', 428944759);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483594, 438933248, '88kwdmdbdht6', 'j47nxar50h', 460471995);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483593, -1652411404, 'zxdp', 'nmwfwx', -1040088060);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483592, 2015039199, 'k014r5', 'dqtsmg97aqz2', -1148194959);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483591, -1079009577, 'ddlysu6ip', 'dk', 658507818);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483590, 1154884242, 'r31', 'wq51oa', 1813968674);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483589, 1265709623, 'uoi1pavc', 'wnyqro', 917675957);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483588, -980625770, 'rpouit63xyf', 'mjwpp2', -1305057240);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483587, 1893953818, '0ju', '0h3r133ir1ax', -485095266);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483586, 370054768, 'i9esap8p', 'gckqwtsr54', -1042838119);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483585, 889799750, 'b1d2n', 'zg3rjkwns47j', -233564324);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483584, 173803229, 'c', '3vjwq49', -516707997);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483583, -583955995, '6dvdxdo2v7', '3gvpl', -1789708299);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483582, 906349223, 'n7k10z', '2my1ogyv1rg', -1873650788);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483581, 423028705, '1', 'l', 324939521);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483580, 1128553504, 'xeilp', 'e019cy7od0', -1882121644);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483579, -1919535047, 'nhed29', 'qv2', 1032462616);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483578, -169055351, 'spxpw30bgwkx', '#', 1693638235);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483577, 404445908, 'j6i', 'c', 1004962990);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483576, 495658460, '2o3', 'k', -229524038);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483575, -1722214030, 'ev', 'zxlu49', -1459357985);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483574, -1195170145, 'cde4uekhl', 'lbwvdpu5v0e', -1920675616);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483573, 824044840, 'z129835x', '!', 1084895939);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483572, 1599672055, 'acxdb2f0c29', 'A', 8608094);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483571, 2011754567, 'et8xjhcf46c', 'pe', -977983676);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483570, -329270684, 'v8n', '3ddrok', -744133723);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483569, 1795932554, 'ehia3', 'm', -682353894);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483568, 736542812, '0', '5', 1434462631);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483567, -1745755546, 'r1es', 'g', 2056318381);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483566, 1403715810, 'q82qg01hu', 'j7f', -1663813652);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483565, 1190577316, 'gm8gxb5qjl', 'awsp4', -1439283063);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483564, -150306637, '7j4', 'y795ybv8', -197208169);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483563, 1895921842, 'w4jn2z19xgj', 'jacgmukfb5', -1603206153);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483562, 143843552, 'erbfo', 'vee', 59326585);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483561, -806686292, '6lu2c', 'l8', 771073365);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483560, -1957884289, 'n5en', 'i0f', -2013600868);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483559, -22531339, 'xs27x', '88', -494119248);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483558, 2132634715, '53sb59ls1e', 'hn1mdaqqhy', 2125055535);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483557, -1224799639, '4hmnnw4m0', 'rwbjk', -356851435);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483556, 1851648795, 'w', '7', -1489765135);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483555, -1398612932, 'lzh42', 'nyj5yrji5m', 1253306312);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483554, 1192169191, '8gfxswb2d0zm', 'wdb7ot', 619382464);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483553, -1013704446, 'k4c6gwn', 'kd4kc3iikaxz', 1008864713);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483552, -1660176735, '9gob', '6', -976193147);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483551, -1539870021, 'yb', 'aayv', 754506713);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483550, 195093192, 'r', 'fs3qn0b', -1500616);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483549, 364506391, 'xcr', 'fx03rz', 1269188010);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483548, 145428926, 'lqme2wb1b3', 'un66e0', -1576807806);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483547, 1915216858, '070zi', '0o50q833g', -43429869);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483546, 1636393410, 'ewew', '092p40u2vi', 770112293);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483545, 1511374322, 'ad6q5', 'iqoauy0', -215230989);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483544, 1236313039, '99', 'fqc1m9gr', 1191255697);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483543, 1072042049, 'xd4s', NULL, -1531362377);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483542, 343349384, 'd6dvygwakmwg', NULL, -151666814);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483541, -144370926, 'dip', NULL, 1484560348);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483540, 832710468, 'l10qx6j6d4fc', NULL, 109383153);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483539, 438276362, 'ajdu26xu', NULL, -395383776);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483538, -1770192505, 'u5u7709q', NULL, 562558425);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483537, -2143583288, 'vuu', NULL, -1296756845);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483536, -2091687257, '0jw', NULL, -1674574732);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483535, -1203705305, '9350fzrv1', NULL, -1406020933);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483534, 1719477248, 'vkviql', NULL, 680112185);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483533, 355372240, 'psa', 'xeeinmbciv5', -1191120749);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483532, 764470079, 'v3r3u', NULL, -562113476);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483531, 830725610, 'l1zm', NULL, -983850650);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483530, -2017107666, '2404qpp33', NULL, -383974656);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483529, -273692516, 'qu', NULL, 359389091);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483528, -619092341, 'jdlhlzpdyxk0', NULL, -358539593);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.forename, T2.surname FROM pitStops AS T1 INNER JOIN drivers AS T2 ON T1.driverId = T2.driverId WHERE T2.nationality = 'German' AND STRFTIME('%Y', T2.dob) BETWEEN '1980' AND '1985' GROUP BY T2.forename, T2.surname ORDER BY AVG(T1.duration), T2.forename NULLS LAST, T2.surname NULLS LAST LIMIT 5;

/*
Gold Result:
('t2__00df39', 't2__a3e5f7')
*/

-- Prediction Query
SELECT d.forename || ' ' || d.surname AS full_name, AVG(CAST(p.duration AS REAL)) AS avg_duration FROM drivers AS d JOIN pitStops AS p ON d.driverId = p.driverId WHERE d.nationality = 'German' AND STRFTIME('%Y', d.dob) BETWEEN '1980' AND '1985' GROUP BY d.driverId ORDER BY avg_duration ASC, full_name NULLS LAST LIMIT 3;

/*
Prediction Result:
('t2__00df39 t2__a3e5f7', 0.0)
('t2__00df39 t2__a3e5f7', 2.4835164835164836)
*/