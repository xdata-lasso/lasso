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
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1, 1980, -992890117, -2147483648, 'Monaco Grand Prix', '2020-01-20', 'ypuzhsrw', 'url_1');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (4, 1980, -472966518, -2147483648, 'Monaco Grand Prix', '2025-06-25', '5bbp0', 'url_2');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2, 1980, -751275471, -2147483648, 'iqa', '2024-10-16', 'ryytoo3', 'url_3');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (3, 1980, -1390245819, -2147483648, 'x14ji7zwau2d', '2024-01-01', 'yrq13pyu78d9', 'url_4');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (5, 1980, -59984348, -2147483648, 'Monaco Grand Prix', '2023-11-15', 'qcgsk9', 'url_5');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (6, 1980, -1980249628, -2147483648, 'Monaco Grand Prix', '2022-10-19', 'u7', 'url_6');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (7, 0, -1585009206, -2147483648, 'Monaco Grand Prix', '2022-02-24', '52zbuo4nrq', 'url_7');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (8, 0, -1437333179, -2147483648, 't3__efa1b8', '2023-03-15', 'wqcgsk', 'url_8');

-- Inserting into table: constructors --
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (1, 'b', 't2__fd3998', 't2__7f7e44', 'p6luhvdlttil');

INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (2, 'unw6klfa', 'name_2', '9000t5c4ec', 'gce');

INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (3, 'fe4hri', 'name_3', 'a2ypuzhsrwbb', 'p6luhvdlttil');

INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (-2147483645, 'n', 'A', 'rmdp', 'siie');

INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (4, 'rofqyp5s5b', 'name_5', 'p', '02eutliqa11r');

INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (5, '9n8c4pgu7v', 'name_6', 'e4', 'hria2ypuzhs');

-- Inserting into table: circuits --
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (-2147483648, '5k5swwqcgs', '9n8', '4', 'gu7v', 86.520366, 65.761562, 1160656988, 'url_1');

-- Inserting into table: seasons --
INSERT INTO "seasons" ("year", "url") VALUES (1980, 'url_1');

INSERT INTO "seasons" ("year", "url") VALUES (0, 'url_2');

INSERT INTO "seasons" ("year", "url") VALUES (1, 'url_3');

-- Inserting into table: constructorresults --
INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (-2147483648, 1, 1, 22.535764, 'nprmdposii');

INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (-2147483647, 1, 2, 0.5, '76nium52');

INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (-2147483646, 1, 2, 0.0, 'zbuo4nrqrof');

INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (-2147483645, 2, 1, 0.5, '9hl7');

INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (-2147483644, 3, 1, 0.0, 'rljsl0b4y');

INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (-2147483643, 1, 2, 0.0, 'qi2rkf9v');

INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (-2147483642, 1, 2, -1.0, 'x58pz');

INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (-2147483641, 2, 1, 0.0, 'f8jegd21vy9u');

INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (-2147483640, 3, 1, -1.0, 'j4hwbd');

INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (-2147483639, 1, 2, 0.5, 'ph2');

INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (-2147483638, 1, 2, 0.0, 'nd');

INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (-2147483637, 2, 1, 0.5, 'nqcx5h');

INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (-2147483636, 3, 1, 0.0, 'cprj');

INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (-2147483635, 1, 2, 0.5, '0dz79f');

INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (-2147483634, 1, 2, 0.0, 'gq8');

INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (-2147483633, 2, 1, 0.0, 'f3dqv0gc');

INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (-2147483632, 3, 1, -1.0, '9');

INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (-2147483631, 1, 2, 0.0, 'k3zbily');

INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (-2147483630, 1, 2, -1.0, 'kn6vc');

INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (-2147483629, 2, 1, 0.0, 'ah0f8jsww');

INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (-2147483628, 3, 1, -1.0, 'q7x');

INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (2, 1, 1, 598.428216, '2fxa7ryfdrz');

INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (3, 1, 1, 753.351134, '6nijjai');

INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (-2147483625, 1, 1, NULL, 'yzt1afgog');

INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (-2147483624, 1, 1, NULL, 'itsj3');

INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (-2147483623, 1, 1, NULL, 'xp1q430');

INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (-2147483622, 1, 1, NULL, 'jh3den8');

INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (-2147483621, 1, 1, 596.764785, '6');

INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (-2147483620, 1, 1, NULL, 'c');

INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (-2147483619, 1, 1, NULL, 'x7afu5w1of77');

INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (-2147483618, 1, 1, NULL, 'o72ctdc');

INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (-2147483617, 1, 1, NULL, 'mfg62');

INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (-2147483616, 1, 1, NULL, 'v5q8qdj');

INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (-2147483615, 1, 1, NULL, 'e1io');

INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (4, 1, 1, 2.0, 'unw6klfa');

INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (5, 5, -2147483645, 3.0, '00t5c4ecigc');

INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (6, 7, 4, 997.73177, 'ytoo3o9hl7');

INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (7, 8, 5, 663.049759, 'wbbp6luhvdlt');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(T1.points), T2.name, T2.nationality FROM constructorResults AS T1 INNER JOIN constructors AS T2 ON T1.constructorId = T2.constructorId INNER JOIN races AS T3 ON T3.raceid = T1.raceid WHERE T3.name = 'Monaco Grand Prix' AND T3.year BETWEEN 1980 AND 2010 GROUP BY T2.name ORDER BY SUM(T1.points) DESC, T2.name NULLS LAST, T2.nationality NULLS LAST LIMIT 1;

/*
Gold Result:
(1973.0798989999998, 't2__fd3998', 't2__7f7e44')
*/

-- Prediction Query
SELECT SUM(cst.points) AS total_points, c.name AS constructor_name, c.nationality AS constructor_nationality FROM races AS r JOIN constructorStandings AS cst ON r.raceId = cst.raceId JOIN constructors AS c ON cst.constructorId = c.constructorId WHERE r.name = 'Monaco Grand Prix' AND r.year BETWEEN 1980 AND 2010 GROUP BY c.constructorId ORDER BY total_points DESC, constructor_name NULLS LAST, constructor_nationality NULLS LAST LIMIT 1;

/*
Prediction Result:
*/