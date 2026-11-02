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

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (4, 1980, -525979501, -2147483648, 'Monaco Grand Prix', '2022-07-04', 'o3o9hl72klex', 'url_2');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2, 1980, -1525670226, -2147483648, '7zwau2dwyr', '2022-12-09', '3pyu78d', 'url_3');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (3, 1980, -1025564911, -2147483648, 'rkf9vqx5', '2022-08-22', 'z0f8jegd21vy', 'url_4');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (6, 1980, 906324270, -2147483648, 'Monaco Grand Prix', '2020-05-06', 'p', 'url_5');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (5, 1980, 1019800248, -2147483648, 'Monaco Grand Prix', '2023-10-03', 'l', 'url_6');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (7, 1, -1602639011, -2147483648, 'Monaco Grand Prix', '2025-06-27', 'nw6klf', 'url_7');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (8, 2011, -1437333179, -2147483648, 't3__688451', '2023-03-15', 'wqcgsk', 'url_8');

-- Inserting into table: constructors --
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (1, 'b', 't2__662761', 't2__86d58e', 'p6luhvdlttil');

INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (3, 'unw6klfa', 'A', 't2__86d58e', '9000t5c4ec');

INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (2, 'gce', 'name_3', '76nium52', 'zbuo4nrqrof');

INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (-2147483645, '5k5swwqcgs', '?', '9n8', '4');

INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (4, 'gu7v', 'name_5', 'e4', 'hria2ypuzhs');

INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (5, 'a9000t5c4eci', 'name_6', 'gce376nium52', 'zbuo4nrqrof');

INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (6, '9n8c4pgu7v', 'name_7', 'e4', 'hria2ypuzhs');

-- Inserting into table: circuits --
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (-2147483648, '5k5swwqcgs', '9n8', '4', 'gu7v', 86.520366, 65.761562, 1160656988, 'url_1');

-- Inserting into table: seasons --
INSERT INTO "seasons" ("year", "url") VALUES (1980, 'url_1');

INSERT INTO "seasons" ("year", "url") VALUES (2011, 'url_2');

INSERT INTO "seasons" ("year", "url") VALUES (1, 'url_3');

-- Inserting into table: constructorresults --
INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (-2147483648, 1, 1, 22.535764, 'nprmdposii');

INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (-2147483647, 1, 2, 0.5, 'qyp5s5bbp0');

INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (-2147483646, 1, 2, 0.0, '2eutliqa11r');

INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (-2147483645, 2, 1, 0.5, '9rljsl0b4');

INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (-2147483644, 3, 1, 0.0, '9uxj4hwbdvl');

INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (-2147483643, 1, 2, 0.5, 'h2gndqwnqcx5');

INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (-2147483642, 1, 2, 0.0, 'hncprjtu0dz');

INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (-2147483641, 2, 1, 0.0, 'gq8');

INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (-2147483640, 3, 1, -1.0, 'n2f3dqv0gcb9');

INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (-2147483639, 1, 2, 0.0, 'k3zbily');

INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (-2147483638, 1, 2, -1.0, 'kn6vc');

INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (-2147483637, 2, 1, 0.0, 'ah0f8jsww');

INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (-2147483636, 3, 1, -1.0, 'q7x');

INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (-2147483635, 1, 2, 0.0, '72fxa7ryfd');

INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (-2147483634, 1, 2, -1.0, 'z16ni');

INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (-2147483633, 2, 1, 0.0, 'ai5');

INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (-2147483632, 3, 1, -1.0, 'h');

INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (-2147483631, 1, 2, 0.0, 'grgj');

INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (-2147483630, 1, 2, -1.0, '8');

INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (-2147483629, 2, 1, 0.0, 't1afgog');

INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (-2147483628, 3, 1, -1.0, 'itsj3');

INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (2, 1, 1, 991.735454, 'p1q430');

INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (3, 1, 1, 947.945777, 'jh3den8c68');

INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (-2147483625, 1, 1, NULL, '1of77pzo72c');

INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (-2147483624, 1, 1, NULL, 'dctmf');

INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (-2147483623, 1, 1, NULL, '2g0v5q8qd');

INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (-2147483622, 1, 1, NULL, 'jpe1io22785');

INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (-2147483621, 1, 1, 993.555996, '7cvtjpttg6b');

INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (-2147483620, 1, 1, NULL, '5zi36c');

INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (-2147483619, 1, 1, NULL, 'bfkfoacd');

INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (-2147483618, 1, 1, NULL, '7z2zezjo7wg');

INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (-2147483617, 1, 1, NULL, 'd5ysxc');

INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (-2147483616, 1, 1, NULL, '0oztd');

INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (-2147483615, 1, 1, NULL, 'j5');

INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (4, 1, 1, 2.0, 'tilbn');

INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (5, 4, 2, 3.0, 'dpos');

INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (6, 7, 5, 586.906897, 'p5s5bbp');

INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (7, 8, 6, 663.049759, 'wbbp6luhvdlt');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(T1.points), T2.name, T2.nationality FROM constructorResults AS T1 INNER JOIN constructors AS T2 ON T1.constructorId = T2.constructorId INNER JOIN races AS T3 ON T3.raceid = T1.raceid WHERE T3.name = 'Monaco Grand Prix' AND T3.year BETWEEN 1980 AND 2010 GROUP BY T2.name ORDER BY SUM(T1.points) DESC, T2.name NULLS LAST, T2.nationality NULLS LAST LIMIT 1;

/*
Gold Result:
(2957.772991, 't2__662761', 't2__86d58e')
*/

-- Prediction Query
SELECT c.name, c.nationality, SUM(cs.points) AS total_points FROM races AS r INNER JOIN constructorstandings AS cs ON r.raceid = cs.raceid INNER JOIN constructors AS c ON cs.constructorid = c.constructorid WHERE r.name = 'Monaco Grand Prix' AND r.year BETWEEN 1980 AND 2010 GROUP BY c.constructorid ORDER BY total_points DESC, c.name NULLS LAST, c.nationality NULLS LAST LIMIT 1;

/*
Prediction Result:
*/