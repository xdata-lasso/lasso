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
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (34, '901', '901', '901', '901', 901, 901, 901, '21');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (33, '901', '901', '901', '901', 901, 901, 901, '20');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (27, '901', '901', '901', '901');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (30, '901', 901, '901', '901', '901', '1002-06-21', '901', '23');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (29, '901', 901, '901', '901', '901', '1002-06-21', '901', '22');
INSERT INTO "seasons" ("year", "url") VALUES (32, '24');
INSERT INTO "races" ("raceid", "year", "circuitid", "round", "name", "date", "time", "url") VALUES (31, 32, 33, 51, '52', '1000-02-23', NULL, NULL);
INSERT INTO "races" ("raceid", "year", "circuitid", "round", "name", "date", "time", "url") VALUES (901, 32, 34, 55, '56', '1000-02-27', '58', '25');
INSERT INTO "constructorResults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (901, 901, 27, 901, '901');
INSERT INTO "constructorStandings" ("constructorstandingsid", "raceid", "constructorid", "points", "position", "positiontext", "wins") VALUES (36, 901, 27, 901, 901, '901', 901);
INSERT INTO "constructorStandings" ("constructorstandingsid", "raceid", "constructorid", "points", "position", "positiontext", "wins") VALUES (35, 901, 27, 901, 901, '901', 901);
INSERT INTO "driverStandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (38, 901, 29, 901, 901, '901', 901);
INSERT INTO "lapTimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (901, 30, 901, 901, '901', 901);
INSERT INTO "lapTimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (901, 29, 901, 901, '901', 901);
INSERT INTO "pitStops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (901, 29, 40, 901, '901', '901', 901);
INSERT INTO "pitStops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (901, 29, 39, 901, '901', '901', 901);
INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (42, 901, 29, 27, 901, 901, '901', '901', '901');
INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (41, 901, 29, 27, 901, 901, '901', '901', '901');
INSERT INTO "status" ("statusid", "status") VALUES (43, '901');
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "statusid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed") VALUES (46, 901, 29, 27, 43, 901, 901, 901, '901', 901, 901, 901, '901', 901, 901, 901, '901', '901');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.url FROM races AS T1 INNER JOIN seasons AS T2 ON T2.year = T1.year WHERE T1.raceId = 901;

/*
Gold Result:
('24',)
*/

-- Prediction Query
SELECT year FROM races WHERE raceId = 901;

/*
Prediction Result:
(32,)
*/