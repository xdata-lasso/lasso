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
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (47, 'Hamilton45', 'Hamilton45', 'Hamilton45', 'Hamilton45', 45, 45, 45, 'Lewis36');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (46, 'Hamilton45', 'Hamilton45', 'Hamilton45', 'Hamilton45', 45, 45, 45, 'Hamilton35');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (53, 'Hamilton45', 'Lewis38', 'Hamilton45', 'Hamilton45');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (84, 'Hamilton45', 'Hamilton37', 'Hamilton45', 'Hamilton45');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (44, 'Lewis78', 79, 'Lewis80', 'Lewis', 'Hamilton', NULL, 'Lewis82', 'Hamilton39');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (98, 'Hamilton99', NULL, 'Hamilton101', 'Lewis', 'Hamilton', '1000-04-13', 'Hamilton103', 'Lewis104');
INSERT INTO "seasons" ("year", "url") VALUES (120, 'Hamilton41');
INSERT INTO "seasons" ("year", "url") VALUES (119, 'Lewis40');
INSERT INTO "races" ("raceid", "year", "circuitid", "round", "name", "date", "time", "url") VALUES (52, 120, 46, 59, 'Lewis60', '1000-03-03', 'Lewis62', 'Hamilton43');
INSERT INTO "races" ("raceid", "year", "circuitid", "round", "name", "date", "time", "url") VALUES (45, 119, 47, 67, 'Lewis68', '1000-03-11', 'Lewis70', 'Lewis42');
INSERT INTO "constructorStandings" ("constructorstandingsid", "raceid", "constructorid", "points", "position", "positiontext", "wins") VALUES (49, 52, 84, 45, 45, 'Hamilton45', 45);
INSERT INTO "constructorStandings" ("constructorstandingsid", "raceid", "constructorid", "points", "position", "positiontext", "wins") VALUES (48, 52, 53, 45, 45, 'Hamilton45', 45);
INSERT INTO "driverStandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (71, 45, 44, 72, 73, NULL, 75);
INSERT INTO "driverStandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (50, 45, 98, 63, 64, 'Hamilton65', 66);
INSERT INTO "lapTimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (52, 98, 45, 45, 'Hamilton45', 45);
INSERT INTO "lapTimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (52, 44, 45, 45, 'Hamilton45', 45);
INSERT INTO "pitStops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (45, 98, 45, 45, 'Hamilton45', 'Hamilton45', 45);
INSERT INTO "pitStops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (52, 44, 45, 45, 'Hamilton45', 'Hamilton45', 45);
INSERT INTO "status" ("statusid", "status") VALUES (85, 'Hamilton45');
INSERT INTO "status" ("statusid", "status") VALUES (54, 'Hamilton45');
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "statusid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed") VALUES (83, 45, 98, 84, 85, 86, 87, 88, 'Hamilton89', 90, 118, 91, 'Lewis92', 93, 94, 95, NULL, 'Hamilton97');
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "statusid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed") VALUES (51, 52, 44, 53, 54, 105, 106, 107, 'Lewis108', 109, 110, 111, NULL, NULL, 114, 115, 'Lewis116', 'Hamilton117');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.name, T2.points FROM races AS T1 INNER JOIN driverStandings AS T2 ON T2.raceId = T1.raceId INNER JOIN drivers AS T3 ON T3.driverId = T2.driverId WHERE T3.forename = 'Lewis' AND T3.surname = 'Hamilton' ORDER BY T1.year ASC, T1.raceid NULLS LAST, T2.driverstandingsid NULLS LAST, T3.driverid NULLS LAST LIMIT 1;

/*
Gold Result:
('Lewis68', 63.0)
*/

-- Prediction Query
SELECT races.year, results.points FROM results INNER JOIN drivers ON results.driverId = drivers.driverId INNER JOIN races ON results.raceId = races.raceId WHERE drivers.forename = 'Lewis' AND drivers.surname = 'Hamilton' ORDER BY races.date ASC, results.resultid NULLS LAST, drivers.driverid NULLS LAST, races.raceid NULLS LAST LIMIT 1;

/*
Prediction Result:
(120, 110.0)
*/