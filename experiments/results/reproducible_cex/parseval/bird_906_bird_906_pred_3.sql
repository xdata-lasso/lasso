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
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1, 1, -1399556171, -2147483648, 't1__28a82c', '2020-01-23', '9000t5c4ec', 'url_1');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2, 1, -525979501, -2147483648, 't1__28a82c', '2022-07-04', 'o3o9hl72klex', 'A');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (3, 1, -74849714, -2147483648, 't1__28a82c', '2021-06-29', '7zwau2dwyr', 'C');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (-1, 1, -1372125820, -2147483648, 't1__28a82c', '2020-04-20', 'yp5qi2rk', 'url_4');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (0, 1, 222415430, -2147483648, 't1__fe570f', '2022-12-15', 'x58pz0f8je', 'url_5');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (4, 1, -59984348, -2147483648, 'wqcgsk', '2022-04-27', '8c4pgu7vfe', 'url_6');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (5, 1, -59984348, -2147483648, 'wqcgsk', '2022-04-27', '8c4pgu7vfe', 'url_7');

-- Inserting into table: drivers --
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1, '5k5swwqcgs', 247012447, '8c4pgu7vfe', 'Lewis', 'Hamilton', '2025-06-04', 'hria2ypuzhs', 'url_1');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483647, 'uo4nrqrofqy', -1106983592, '5bbp0', 'Lewis', 'Hamilton', '2024-12-15', 'eutliqa11r', 'url_2');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (0, 'd2', 1675430660, 'y9uxj4', 'wb', 'v', '2022-01-29', 'h2gn', 'url_3');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-1, 'rjtu', -361507387, '79fjgq8', 'Lewis', 'Hamilton', '2022-05-01', 'f3dqv0gc', 'url_4');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2, 'k3zbily', 638024588, '6vck6ah0f8js', 'wlq7xb', '72fxa7ryfd', '2023-02-06', 'z16nijjai5d', 'url_5');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (3, 'hria2ypu', 1644814318, 'sr', 'Lewis', 't3__dd5ebd', '2023-11-30', 'b', 'url_6');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (4, 'hria2ypu', 1644814318, 'sr', 't3__186f94', 'Hamilton', '2023-11-30', 'b', 'url_7');

-- Inserting into table: circuits --
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (-2147483648, 'rwbbp6luhvd', 'tti', 'bnp', 'mdpos', 133.007885, 75.403642, -1209887326, 'url_1');

-- Inserting into table: seasons --
INSERT INTO "seasons" ("year", "url") VALUES (1, 'url_1');

-- Inserting into table: driverstandings --
INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (1, 1, 1, 1.0, -1683203397, 'e376nium52', -443340271);

INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (3, 2, 1, 1.0, -1021749117, '3pyu78d99r', -1362461264);

INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (-2147483646, 3, 0, 1.0, 1968874827, 'nqcx5h', -1245312912);

INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (-2147483645, 0, 2, 1.0, -1625552518, 'grgj', -458359144);

INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (-2147483644, 3, 0, 1.0, -1794176801, 'grit', 678047687);

INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (-2147483643, 0, 2, 1.0, -491938169, '1q43', 1235416111);

INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (-2147483642, 3, 0, 1.0, 1948383687, 'e', 195720193);

INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (-2147483641, 0, 2, 1.0, 2035306060, 'x7afu5w1of77', -1099855564);

INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (-2147483640, 3, 1, 1.0, -1957268147, 'c', 1303877941);

INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (-2147483639, 0, 2, 1.0, 7929158, '0v', 820970595);

INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (-2147483638, 1, 1, 1.0, -1488156735, '1i', 1897687032);

INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (-2147483637, 1, 1, 1.0, 199672698, '7cvtjpt', 453836040);

INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (-2147483636, 1, 1, 1.0, -2033879835, 'u5zi', 1944978593);

INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (-2147483635, 1, 1, 1.0, -2072838897, 'foa', 382831862);

INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (-2147483634, 1, 1, 1.0, 2115816682, '7z2zezjo7wg', 1248858185);

INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (-2147483633, 1, 1, 1.0, 1999335832, 'sxcmr0o', 853709925);

INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (-2147483632, 1, 1, 1.0, -1935752926, '5i3', -1405314653);

INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (-2147483631, 1, 1, 1.0, -1212676731, 'm5k', 1379859112);

INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (2, 4, 3, 749.826493, 13244799, 'hvdltt', -1610064545);

INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (4, 5, 4, 749.826493, 13244799, 'hvdltt', -1610064545);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.name, T2.points FROM races AS T1 INNER JOIN driverStandings AS T2 ON T2.raceId = T1.raceId INNER JOIN drivers AS T3 ON T3.driverId = T2.driverId WHERE T3.forename = 'Lewis' AND T3.surname = 'Hamilton' ORDER BY T1.year ASC, T1.raceid NULLS LAST, T2.driverstandingsid NULLS LAST, T3.driverid NULLS LAST LIMIT 1;

/*
Gold Result:
('t1__28a82c', 1.0)
*/

-- Prediction Query
SELECT races.year, results.points FROM results INNER JOIN drivers ON results.driverId = drivers.driverId INNER JOIN races ON results.raceId = races.raceId WHERE drivers.forename = 'Lewis' AND drivers.surname = 'Hamilton' ORDER BY races.date ASC, results.resultid NULLS LAST, drivers.driverid NULLS LAST, races.raceid NULLS LAST LIMIT 1;

/*
Prediction Result:
*/