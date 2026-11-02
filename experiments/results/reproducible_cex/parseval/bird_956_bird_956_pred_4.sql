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
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (-2147483648, -2147483648, -1399556171, -2147483648, 'a9000t5c4eci', '2021-03-18', 'e', 'url_1');

-- Inserting into table: drivers --
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1, '5k5swwqcgs', 247012447, '8c4pgu7vfe', 't2__8edf29', 't2__180168', '1976-01-01', 'hria2ypu', 'url_1');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2, 'b4yp5qi', -227162283, 'f9v', 't2__8edf29', 't2__180168', '1976-01-01', 'x58pz', 'A');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483647, 'f8jegd2', 1675430660, 'y9uxj4', 't2__8edf29', 't2__180168', '1976-01-01', 'wb', 'C');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (3, 'bilyrkn', -688098735, '6ah', 'f8jswwl', '7xb72', '2020-11-23', 'a7ryfd', 'url_4');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (4, '5k5swwqcgs', 247012447, '8c4pgu7vfe', 'hria2ypu', 'hsrwbbp', '1976-01-01', 'luhvdltti', 'url_5');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (5, 'zbuo4nrqrof', 373262291, 'p5s5bbp', '02eutliqa11r', 'ytoo3o9', '1975-12-31', 'l7', 'url_6');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (6, '8jegd21vy9ux', -1492524358, 'wb', 'v', 'ph2', '1975-12-31', 'nd', 'url_7');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (7, '6ah', -348113485, 'jswwlq7xb', '72fxa7ryfd', 'z16ni', '1975-12-31', 'jai', 'url_8');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (8, 'c68x8vacx', -1762140823, 'w1of77pz', '72ct', 'c', NULL, 'mfg62', 'url_9');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (9, '7z2zezj', 1448731351, 'wgxd5ysxc', 'r0oz', 'dgj5i', NULL, 'lq5lnpim', 'url_10');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (10, 'q7sx58b4', -1122409769, 'u', '3auvm', 'rpd', NULL, 'wzw', 'url_11');

-- Inserting into table: constructors --
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (-2147483648, '76nium52', 'name_1', 'zbuo4nrqrof', 'qyp5s5bbp0');

-- Inserting into table: circuits --
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (-2147483648, 'hsrwbbp', 'luhvdltti', 'bnp', 'mdpos', 133.007885, 75.403642, -1209887326, 'url_1');

-- Inserting into table: seasons --
INSERT INTO "seasons" ("year", "url") VALUES (-2147483648, 'url_1');

-- Inserting into table: status --
INSERT INTO "status" ("statusid", "status") VALUES (-2147483648, '2eutliqa11r');

-- Inserting into table: results --
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483648, -2147483648, 1, -2147483648, 2137741668, -525979501, 1898504886, 'o3o9hl72klex', 1775126557, 482.572691, 105869088, 'au2dwy', -953437896, -1097120355, 2, '78d99r', 'jsl', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483647, -2147483648, 2, -2147483648, 2103044118, -1642259219, 1298861365, 'q', -664193365, 250.856497, 555413010, '5hncprjtu0d', 401805964, -1485777725, 2, '8n2f3', 'dqv0gcb98ozk', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483646, -2147483648, 3, -2147483648, 61479715, -1496556994, -2115841792, 'dh5ogrgj', -458359144, 639.801051, 1568069663, 'fgogritsj3ay', -598313376, 1972233925, 2, '4301j', '3d', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483645, -2147483648, 3, -2147483648, -683007527, 2035306060, 1523825314, 'u5', -290314193, 850.85096, 76996700, 'o72ctdc', 1303877941, -1284905200, 2, '62', '0v', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483644, -2147483648, 3, -2147483648, -1488156735, -1858644047, -1180042408, '78507cvt', -1523347137, 789.724834, 1582582341, 'tg6bnou5zi', 1944978593, 1722106924, 2, 'f', 'foa', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483643, -2147483648, 3, -2147483648, 76987628, -253138337, 641521863, 'o7w', -542502665, 965.506647, -526612570, 'cmr0oz', -870767087, -1699185893, 2, '5i3lq5lnpim5', '58q', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (2, -2147483648, 1, -2147483648, 988954859, -1719383707, 1273687251, '2mnajjla3o', -1428186898, 543.846419, -761353513, 'tmu2ne578l', 697257217, -451030047, 2, 'be8yvkv42q7', 'x58b4', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (3, -2147483648, 1, -2147483648, -929383517, -2090240067, -699574669, 'rpd', -609553675, 730.273808, -55494714, 'n9', 101754718, 628082526, 2, '9n0jxfofwsz', 'o', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483640, -2147483648, 1, -2147483648, 2061558815, 895277769, 364043263, 'sorlwyngc1', 681061317, 950.711683, 595714424, 'zgk1yoeyo6l0', -1614619556, 1435223075, 2, 'qyxuzk', '5', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483639, -2147483648, 1, -2147483648, -670154354, -2140468103, 469838697, 'lboeowii1z5', 1557188093, 627.816635, -1552469358, '62q2xlyot', 1083479253, 1774679448, 1, 'oaawg96aq', '0', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483638, -2147483648, 1, -2147483648, 503053726, -1897615568, 2085299664, 'j', -841516418, 535.501742, -625404808, 'um', 989306270, 1147652228, 2, 'u', 'bd0w9603v', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (4, -2147483648, 4, -2147483648, 462974032, -1137908826, -918961358, 'e5u', 1861536320, 345.718563, 44952191, 'fa9', 1620389964, 546571701, NULL, '0t5c4ecigc', 'e376nium52', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (5, -2147483648, 5, -2147483648, -305670381, -1525670226, -453362185, 'au2dwyrq13', 2142703426, 375.832821, 176380444, '9rljsl0b4', 1649269347, -1116181514, 2, 'i2rkf', 'vqx58pz0f', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (6, -2147483648, 6, -2147483648, -1070063173, 555413010, 722884590, 'hncprjtu0dz', -1748371085, 94.390081, 894242932, 'f3dqv0gc', 1631231566, 172461907, 1, 'k3zbily', 'kn6vc', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (7, -2147483648, 7, -2147483648, 1583472758, 1449284300, -977470238, 'd8y', 1129658414, 308.482994, 1250290042, 'og', -946046410, -902895762, NULL, 'ayxp1q43', '1jh3den', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (8, -2147483648, 8, -2147483648, 820970595, 1421303999, -1488156735, '1i', 1897687032, 443.690199, 2004147439, 'tjpttg', -2033879835, 1798111945, 2, '5zi36c', 'bfkfoacd', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (9, -2147483648, 9, -2147483648, 195202164, 1817366143, 1615073310, '7p2r94gth2m', 418247369, 145.067008, -1351793914, 'okv8uttm', 1553368934, -1252009958, 1, '78lfvyz7', 'zzbe8yvkv4', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (10, -2147483648, 10, -2147483648, 101754718, 628082526, -1245584612, 'xfo', -1793230843, 296.34381, -441521858, '2zob', -2019656607, 375841374, NULL, '32o', 'w', -2147483648);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.forename, T2.surname FROM results AS T1 INNER JOIN drivers AS T2 ON T1.driverId = T2.driverId WHERE STRFTIME('%Y', T2.dob) > '1975' AND T1.rank = 2;

/*
Gold Result:
('t2__8edf29', 't2__180168')
('t2__8edf29', 't2__180168')
('f8jswwl', '7xb72')
('f8jswwl', '7xb72')
('f8jswwl', '7xb72')
('f8jswwl', '7xb72')
('t2__8edf29', 't2__180168')
('t2__8edf29', 't2__180168')
('t2__8edf29', 't2__180168')
('t2__8edf29', 't2__180168')
*/

-- Prediction Query
SELECT DISTINCT d.forename, d.surname FROM drivers AS d INNER JOIN results AS r ON d.driverid = r.driverid WHERE STRFTIME('%Y', d.dob) > '1975' AND r.rank = 2;

/*
Prediction Result:
('t2__8edf29', 't2__180168')
('f8jswwl', '7xb72')
*/