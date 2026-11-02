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
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1, '5k5swwqcgs', 247012447, '8c4pgu7vfe', 't2__583f1e', 't2__010ade', '1980-01-01', 'German', 'url_1');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2, 'uo4nrqrofqy', -1106983592, '5bbp0', 't2__583f1e', 't2__010ade', '1980-01-01', 'German', 'A');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483647, '2eutliqa11r', 2137741668, 'ytoo3o9hl7', 't2__583f1e', 't2__010ade', '1980-01-01', 'German', 'C');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (3, '13pyu', 176380444, '9rljsl0b4', 'p5qi2rk', '9v', '2022-12-15', 'x58pz0f8je', 'url_4');

-- Inserting into table: circuits --
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (-2147483648, 'hria2ypu', 'hsrwbbp', 'luhvdltti', 'bnp', 787.938887, 986.066566, 907682809, 'url_1');

-- Inserting into table: seasons --
INSERT INTO "seasons" ("year", "url") VALUES (-2147483648, 'url_1');

-- Inserting into table: pitstops --
INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483648, 1620389964, '00t5c4ecigc', 'e376nium52', -443340271);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 2, -2147483647, -1438850342, 'x1', 'ji7zwau2', 364869063);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 3, -2147483646, 1196308825, 'd21vy9uxj4hw', 'd', -736979194);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 2, -2147483645, -1642259219, 'nd', '!', -1052964641);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 2, -2147483644, -1070063173, 'x5hncprjtu0', 'i', -1898531797);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 2, -2147483643, -1485777725, '8n2f3', '!', 806170397);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 2, -2147483642, -688216274, 'gcb98ozk3z', 'B', 1686459626);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 2, -2147483641, -512640349, 'kn6vck6ah0f8', '@', -1520489792);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 2, -2147483640, -639539893, '7xb72', 'A', 1350414441);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 2, -2147483639, -961217731, 'dr', 'A', 777149609);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 2, -2147483638, -1259474148, 'jai', 'i', 1746373317);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 2, -2147483637, -1625552518, 'grgj', 'D', -458359144);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 2, -2147483636, 1568069663, 'fgogritsj3ay', 'b', -598313376);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483635, 1792827279, '4301jh3den8', 'c68x8vacx7', 1523825314);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483634, -47052816, '1of77pzo72c', 'dctmf', 7929158);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483633, -698610044, 'q8qdjpe1io22', '8507cvtjp', 1582582341);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483632, 1467355421, 'ou5z', '36c', 1722106924);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483631, -1776877925, 'oa', 'cd07z2zezjo7', 304189298);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483630, 1248858185, '5', 'sxcmr0o', 853709925);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483629, -1935752926, '5i3', 'q5l', 1339733032);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483628, 1692046802, '5k58', 's27p2', 1497321728);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483627, -1719383707, '2m', 'ajjl', -2096405521);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483626, -1428186898, 'uttmu2ne5', '78lfvyz7zz', -2052653308);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483625, -705922211, 'v42q7sx58b4p', NULL, 319284352);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483624, -200807520, 'vmkrpd', NULL, -609553675);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483623, -55494714, 'n9', NULL, 101754718);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483622, 238533676, 'jxfofws', NULL, 1719800120);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483621, 2015094998, '2zobb0q0k32o', 'w', 440115543);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483620, -1177989415, 'wyn', NULL, 1953495465);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-2147483648, 1, -2147483619, -323362455, 'j9erhizgk1', NULL, 955267863);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.forename, T2.surname FROM pitStops AS T1 INNER JOIN drivers AS T2 ON T1.driverId = T2.driverId WHERE T2.nationality = 'German' AND STRFTIME('%Y', T2.dob) BETWEEN '1980' AND '1985' GROUP BY T2.forename, T2.surname ORDER BY AVG(T1.duration), T2.forename NULLS LAST, T2.surname NULLS LAST LIMIT 5;

/*
Gold Result:
('t2__583f1e', 't2__010ade')
*/

-- Prediction Query
SELECT T1.driverId, T1.forename, T1.surname, AVG(T2.duration) AS avg_duration FROM drivers AS T1 INNER JOIN pitStops AS T2 ON T1.driverId = T2.driverId WHERE T1.nationality = 'German' AND STRFTIME('%Y', T1.dob) BETWEEN '1980' AND '1985' GROUP BY T1.driverId ORDER BY avg_duration ASC, T1.driverId NULLS LAST, T1.forename NULLS LAST, T1.surname NULLS LAST LIMIT 5;

/*
Prediction Result:
(2, 't2__583f1e', 't2__010ade', 0.0)
(1, 't2__583f1e', 't2__010ade', 718.4166666666666)
*/