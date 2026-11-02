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
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (31, 'Germany55', 'European Grand Prix56', NULL, NULL, NULL, NULL, NULL, 'Germany23');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (27, 'European Grand Prix30', 'European Grand Prix30', 'European Grand Prix30', 'European Grand Prix30');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (28, 'European Grand Prix30', 30, 'European Grand Prix30', 'European Grand Prix30', 'European Grand Prix30', '1000-01-31', 'European Grand Prix30', 'European Grand Prix30');
INSERT INTO "seasons" ("year", "url") VALUES (29, 'Germany25');
INSERT INTO "seasons" ("year", "url") VALUES (63, 'European Grand Prix24');
INSERT INTO "races" ("raceid", "year", "circuitid", "round", "name", "date", "time", "url") VALUES (62, 63, 31, 64, 'European Grand Prix', '1000-03-07', 'European Grand Prix66', 'Germany67');
INSERT INTO "races" ("raceid", "year", "circuitid", "round", "name", "date", "time", "url") VALUES (30, 63, 31, 51, 'European Grand Prix52', '1000-02-23', NULL, NULL);
INSERT INTO "constructorResults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (33, 30, 27, 30, 'European Grand Prix30');
INSERT INTO "constructorResults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (32, 30, 27, 30, 'European Grand Prix30');
INSERT INTO "constructorStandings" ("constructorstandingsid", "raceid", "constructorid", "points", "position", "positiontext", "wins") VALUES (35, 30, 27, 30, 30, 'European Grand Prix30', 30);
INSERT INTO "constructorStandings" ("constructorstandingsid", "raceid", "constructorid", "points", "position", "positiontext", "wins") VALUES (34, 30, 27, 30, 30, 'European Grand Prix30', 30);
INSERT INTO "driverStandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (37, 30, 28, 30, 30, 'European Grand Prix30', 30);
INSERT INTO "driverStandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (36, 30, 28, 30, 30, 'European Grand Prix30', 30);
INSERT INTO "lapTimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (30, 28, 39, 30, 'European Grand Prix30', 30);
INSERT INTO "lapTimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (30, 28, 38, 30, 'European Grand Prix30', 30);
INSERT INTO "pitStops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (30, 28, 41, 30, 'European Grand Prix30', 'European Grand Prix30', 30);
INSERT INTO "pitStops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (30, 28, 40, 30, 'European Grand Prix30', 'European Grand Prix30', 30);
INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (43, 30, 28, 27, 30, 30, 'European Grand Prix30', 'European Grand Prix30', 'European Grand Prix30');
INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (42, 30, 28, 27, 30, 30, 'European Grand Prix30', 'European Grand Prix30', 'European Grand Prix30');
INSERT INTO "status" ("statusid", "status") VALUES (44, 'European Grand Prix30');
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "statusid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed") VALUES (46, 30, 28, 27, 44, 30, 30, 30, 'European Grand Prix30', 30, 30, 30, 'European Grand Prix30', 30, 30, 30, 'European Grand Prix30', 'European Grand Prix30');
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "statusid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed") VALUES (45, 30, 28, 27, 44, 30, 30, 30, 'European Grand Prix30', 30, 30, 30, 'European Grand Prix30', 30, 30, 30, 'European Grand Prix30', 'European Grand Prix30');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(CASE WHEN T1.country = 'Germany' THEN T2.circuitID END) AS REAL) * 100 / COUNT(T2.circuitId) FROM circuits AS T1 INNER JOIN races AS T2 ON T2.circuitID = T1.circuitId WHERE T2.name = 'European Grand Prix';

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN T1.country = 'Germany' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(*) FROM circuits AS T1 INNER JOIN races AS T2 ON T1.circuitId = T2.circuitId WHERE T2.name = 'European Grand Prix';

/*
Prediction Result:
(0.0,)
*/