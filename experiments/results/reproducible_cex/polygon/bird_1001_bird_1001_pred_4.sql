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
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (41, 'Marina Bay Street Circuit43', 'Marina Bay Street Circuit68', 'Marina Bay Street Circuit43', 'Marina Bay Street Circuit43', 43, 43, 43, 'Marina Bay Street Circuit34');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (45, 'Marina Bay Street Circuit69', 'Marina Bay Street Circuit', 'Marina Bay Street Circuit70', 'Marina Bay Street Circuit71', 72, 73, 74, 'Marina Bay Street Circuit33');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (83, 'Marina Bay Street Circuit43', 'Marina Bay Street Circuit36', 'Marina Bay Street Circuit43', 'Marina Bay Street Circuit43');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (98, 'Marina Bay Street Circuit43', 'Marina Bay Street Circuit35', 'Marina Bay Street Circuit43', 'Marina Bay Street Circuit43');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (82, 'Marina Bay Street Circuit75', 76, 'Marina Bay Street Circuit77', 'Marina Bay Street Circuit91', 'Marina Bay Street Circuit92', '1000-03-20', 'Marina Bay Street Circuit79', 'Marina Bay Street Circuit80');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (97, 'Marina Bay Street Circuit88', 89, 'Marina Bay Street Circuit90', 'Marina Bay Street Circuit91', 'Marina Bay Street Circuit92', '1000-04-04', 'Marina Bay Street Circuit94', 'Marina Bay Street Circuit95');
INSERT INTO "seasons" ("year", "url") VALUES (42, 'Marina Bay Street Circuit38');
INSERT INTO "seasons" ("year", "url") VALUES (2008, 'Marina Bay Street Circuit37');
INSERT INTO "races" ("raceid", "year", "circuitid", "round", "name", "date", "time", "url") VALUES (44, 42, 41, 43, 'Marina Bay Street Circuit43', '1000-02-13', 'Marina Bay Street Circuit43', 'Marina Bay Street Circuit40');
INSERT INTO "races" ("raceid", "year", "circuitid", "round", "name", "date", "time", "url") VALUES (43, 2008, 45, 64, 'Marina Bay Street Circuit65', '1000-03-08', 'Marina Bay Street Circuit67', 'Marina Bay Street Circuit39');
INSERT INTO "constructorResults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (47, 43, 98, 43, 'Marina Bay Street Circuit43');
INSERT INTO "constructorResults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (46, 43, 98, 43, 'Marina Bay Street Circuit43');
INSERT INTO "constructorStandings" ("constructorstandingsid", "raceid", "constructorid", "points", "position", "positiontext", "wins") VALUES (49, 43, 98, 43, 43, 'Marina Bay Street Circuit43', 43);
INSERT INTO "constructorStandings" ("constructorstandingsid", "raceid", "constructorid", "points", "position", "positiontext", "wins") VALUES (48, 43, 98, 43, 43, 'Marina Bay Street Circuit43', 43);
INSERT INTO "driverStandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (51, 43, 97, 43, 43, 'Marina Bay Street Circuit43', 43);
INSERT INTO "driverStandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (50, 43, 97, 43, 43, 'Marina Bay Street Circuit43', 43);
INSERT INTO "lapTimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (43, 97, 53, 43, 'Marina Bay Street Circuit43', 43);
INSERT INTO "lapTimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (43, 97, 52, 43, 'Marina Bay Street Circuit43', 43);
INSERT INTO "pitStops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (44, 97, 43, 43, 'Marina Bay Street Circuit43', 'Marina Bay Street Circuit43', 43);
INSERT INTO "pitStops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (43, 97, 43, 43, 'Marina Bay Street Circuit43', 'Marina Bay Street Circuit43', 43);
INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (81, 43, 82, 83, 84, 1, 'Marina Bay Street Circuit85', 'Marina Bay Street Circuit86', 'Marina Bay Street Circuit87');
INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (96, 43, 97, 98, 99, 100, 'Marina Bay Street Circuit101', 'Marina Bay Street Circuit102', 'Marina Bay Street Circuit103');
INSERT INTO "status" ("statusid", "status") VALUES (55, 'Marina Bay Street Circuit43');
INSERT INTO "status" ("statusid", "status") VALUES (54, 'Marina Bay Street Circuit43');
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "statusid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed") VALUES (57, 43, 82, 98, 54, 43, 43, 43, 'Marina Bay Street Circuit43', 43, 43, 43, 'Marina Bay Street Circuit43', 43, 43, 43, 'Marina Bay Street Circuit43', 'Marina Bay Street Circuit43');
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "statusid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed") VALUES (56, 43, 97, 98, 54, 43, 43, 43, 'Marina Bay Street Circuit43', 43, 43, 43, 'Marina Bay Street Circuit43', 43, 43, 43, 'Marina Bay Street Circuit43', 'Marina Bay Street Circuit43');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.forename, T2.surname FROM qualifying AS T1 INNER JOIN drivers AS T2 ON T1.driverId = T2.driverId INNER JOIN races AS T3 ON T1.raceid = T3.raceid WHERE NOT q3 IS NULL AND T3.year = 2008 AND T3.circuitId IN (SELECT circuitId FROM circuits WHERE name = 'Marina Bay Street Circuit') ORDER BY CAST(SUBSTRING(q3, 1, INSTR(q3, ':') - 1) AS INTEGER) * 60 + CAST(SUBSTRING(q3, INSTR(q3, ':') + 1, INSTR(q3, '.') - INSTR(q3, ':') - 1) AS REAL) + CAST(SUBSTRING(q3, INSTR(q3, '.') + 1) AS REAL) / 1000 ASC, T1.qualifyid NULLS LAST, T2.driverid NULLS LAST, T3.raceid NULLS LAST LIMIT 1;

/*
Gold Result:
('Marina Bay Street Circuit91', 'Marina Bay Street Circuit92')
*/

-- Prediction Query
SELECT T1.forename, T1.surname FROM drivers AS T1 INNER JOIN qualifying AS T2 ON T1.driverId = T2.driverId INNER JOIN races AS T3 ON T2.raceId = T3.raceId WHERE T2.position = 1 AND T3.year = 2008 AND T3.circuitId IN (SELECT circuitId FROM circuits WHERE name = 'Marina Bay Street Circuit');

/*
Prediction Result:
('Marina Bay Street Circuit91', 'Marina Bay Street Circuit92')
*/