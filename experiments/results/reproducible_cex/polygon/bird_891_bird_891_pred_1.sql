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
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (64, 'Singapore Grand Prix58', 'Singapore Grand Prix58', 'Singapore Grand Prix58', 'Singapore Grand Prix58', 58, 58, 58, 'Singapore Grand Prix36');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (105, 'Singapore Grand Prix58', 'Singapore Grand Prix38', 'Singapore Grand Prix58', 'Singapore Grand Prix58');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (89, 'Singapore Grand Prix58', 'Singapore Grand Prix37', 'Singapore Grand Prix58', 'Singapore Grand Prix58');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (58, 'Singapore Grand Prix76', 77, 'Singapore Grand Prix78', 'Singapore Grand Prix86', 'Singapore Grand Prix87', '1000-03-21', 'Singapore Grand Prix80', 'Singapore Grand Prix40');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (44, 'Singapore Grand Prix81', 82, 'Singapore Grand Prix83', 'Singapore Grand Prix120', 'Singapore Grand Prix121', '1000-03-26', 'Singapore Grand Prix85', 'Singapore Grand Prix39');
INSERT INTO "seasons" ("year", "url") VALUES (2010, 'Singapore Grand Prix42');
INSERT INTO "seasons" ("year", "url") VALUES (45, 'Singapore Grand Prix41');
INSERT INTO "races" ("raceid", "year", "circuitid", "round", "name", "date", "time", "url") VALUES (52, 2010, 64, 53, 'Singapore Grand Prix', '1000-02-24', 'Singapore Grand Prix55', 'Singapore Grand Prix56');
INSERT INTO "races" ("raceid", "year", "circuitid", "round", "name", "date", "time", "url") VALUES (63, 2010, 64, 65, 'Singapore Grand Prix', '1000-03-08', 'Singapore Grand Prix67', 'Singapore Grand Prix68');
INSERT INTO "constructorResults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (58, 52, 105, 58, 'Singapore Grand Prix58');
INSERT INTO "constructorStandings" ("constructorstandingsid", "raceid", "constructorid", "points", "position", "positiontext", "wins") VALUES (47, 63, 105, 58, 58, 'Singapore Grand Prix58', 58);
INSERT INTO "driverStandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (57, 52, 58, 59, 60, 'Singapore Grand Prix61', 62);
INSERT INTO "driverStandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (69, 63, 58, 70, 71, 'Singapore Grand Prix72', 73);
INSERT INTO "pitStops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (52, 44, 58, 58, 'Singapore Grand Prix58', 'Singapore Grand Prix58', 58);
INSERT INTO "status" ("statusid", "status") VALUES (106, 'Singapore Grand Prix58');
INSERT INTO "status" ("statusid", "status") VALUES (90, 'Singapore Grand Prix58');
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "statusid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed") VALUES (88, 63, 58, 89, 90, 91, 92, 93, 'Singapore Grand Prix94', 95, 96, 97, 'Singapore Grand Prix98', 99, 100, 101, 'Singapore Grand Prix102', 'Singapore Grand Prix103');
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "statusid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed") VALUES (104, 52, 44, 105, 106, 107, 108, 109, 'Singapore Grand Prix110', 111, 112, 113, 'Singapore Grand Prix114', 115, 116, 117, 'Singapore Grand Prix118', 'Singapore Grand Prix119');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.forename, T3.surname FROM races AS T1 INNER JOIN driverStandings AS T2 ON T2.raceId = T1.raceId INNER JOIN drivers AS T3 ON T3.driverId = T2.driverId WHERE T1.name = 'Singapore Grand Prix' AND T1.year = 2010 ORDER BY T2.position ASC, T1.raceid NULLS LAST, T2.driverstandingsid NULLS LAST, T3.driverid NULLS LAST;

/*
Gold Result:
('Singapore Grand Prix86', 'Singapore Grand Prix87')
('Singapore Grand Prix86', 'Singapore Grand Prix87')
*/

-- Prediction Query
SELECT drivers.forename, drivers.surname FROM results JOIN races ON results.raceId = races.raceId JOIN drivers ON results.driverId = drivers.driverId WHERE races.year = 2010 AND races.name = 'Singapore Grand Prix' ORDER BY results.position, results.resultid NULLS LAST, races.raceid NULLS LAST, drivers.driverid NULLS LAST;

/*
Prediction Result:
('Singapore Grand Prix86', 'Singapore Grand Prix87')
('Singapore Grand Prix120', 'Singapore Grand Prix121')
*/