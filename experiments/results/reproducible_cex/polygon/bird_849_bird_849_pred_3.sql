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
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (66, 'Circuit de Barcelona-Catalunya67', 'Circuit de Barcelona-Catalunya', 'Circuit de Barcelona-Catalunya68', 'Circuit de Barcelona-Catalunya69', 70, 71, 72, 'Circuit de Barcelona-Catalunya73');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (31, 'Circuit de Barcelona-Catalunya66', 'Circuit de Barcelona-Catalunya25', 'Circuit de Barcelona-Catalunya66', 'Circuit de Barcelona-Catalunya66');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (30, 'Circuit de Barcelona-Catalunya66', 'Circuit de Barcelona-Catalunya24', 'Circuit de Barcelona-Catalunya66', 'Circuit de Barcelona-Catalunya66');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (33, 'Circuit de Barcelona-Catalunya66', 66, 'Circuit de Barcelona-Catalunya66', 'Circuit de Barcelona-Catalunya66', 'Circuit de Barcelona-Catalunya66', '1000-03-08', 'Circuit de Barcelona-Catalunya66', 'Circuit de Barcelona-Catalunya27');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (32, 'Circuit de Barcelona-Catalunya66', 66, 'Circuit de Barcelona-Catalunya66', 'Circuit de Barcelona-Catalunya66', 'Circuit de Barcelona-Catalunya66', '1000-03-08', 'Circuit de Barcelona-Catalunya66', 'Circuit de Barcelona-Catalunya26');
INSERT INTO "seasons" ("year", "url") VALUES (34, 'Circuit de Barcelona-Catalunya29');
INSERT INTO "seasons" ("year", "url") VALUES (61, 'Circuit de Barcelona-Catalunya28');
INSERT INTO "races" ("raceid", "year", "circuitid", "round", "name", "date", "time", "url") VALUES (55, 61, 66, 56, 'Circuit de Barcelona-Catalunya57', '1000-02-28', 'Circuit de Barcelona-Catalunya59', 'Circuit de Barcelona-Catalunya74');
INSERT INTO "races" ("raceid", "year", "circuitid", "round", "name", "date", "time", "url") VALUES (60, 61, 66, 62, 'Circuit de Barcelona-Catalunya63', '1000-03-06', 'Circuit de Barcelona-Catalunya65', 'Circuit de Barcelona-Catalunya75');
INSERT INTO "constructorResults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (36, 60, 30, 66, 'Circuit de Barcelona-Catalunya66');
INSERT INTO "constructorResults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (35, 60, 30, 66, 'Circuit de Barcelona-Catalunya66');
INSERT INTO "constructorStandings" ("constructorstandingsid", "raceid", "constructorid", "points", "position", "positiontext", "wins") VALUES (38, 60, 30, 66, 66, 'Circuit de Barcelona-Catalunya66', 66);
INSERT INTO "constructorStandings" ("constructorstandingsid", "raceid", "constructorid", "points", "position", "positiontext", "wins") VALUES (37, 60, 30, 66, 66, 'Circuit de Barcelona-Catalunya66', 66);
INSERT INTO "driverStandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (40, 60, 32, 66, 66, 'Circuit de Barcelona-Catalunya66', 66);
INSERT INTO "driverStandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (39, 60, 32, 66, 66, 'Circuit de Barcelona-Catalunya66', 66);
INSERT INTO "lapTimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (60, 32, 42, 66, 'Circuit de Barcelona-Catalunya66', 66);
INSERT INTO "lapTimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (60, 32, 41, 66, 'Circuit de Barcelona-Catalunya66', 66);
INSERT INTO "pitStops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (60, 32, 44, 66, 'Circuit de Barcelona-Catalunya66', 'Circuit de Barcelona-Catalunya66', 66);
INSERT INTO "pitStops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (60, 32, 43, 66, 'Circuit de Barcelona-Catalunya66', 'Circuit de Barcelona-Catalunya66', 66);
INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (46, 60, 32, 30, 66, 66, 'Circuit de Barcelona-Catalunya66', 'Circuit de Barcelona-Catalunya66', 'Circuit de Barcelona-Catalunya66');
INSERT INTO "status" ("statusid", "status") VALUES (47, 'Circuit de Barcelona-Catalunya66');
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "statusid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed") VALUES (50, 60, 32, 30, 47, 66, 66, 66, 'Circuit de Barcelona-Catalunya66', 66, 66, 66, 'Circuit de Barcelona-Catalunya66', 66, 66, 66, 'Circuit de Barcelona-Catalunya66', 'Circuit de Barcelona-Catalunya66');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.url FROM circuits AS T1 INNER JOIN races AS T2 ON T2.circuitID = T1.circuitId WHERE T1.name = 'Circuit de Barcelona-Catalunya';

/*
Gold Result:
('Circuit de Barcelona-Catalunya73',)
*/

-- Prediction Query
SELECT T1.url FROM races AS T1 INNER JOIN circuits AS T2 ON T1.circuitId = T2.circuitId WHERE T2.name = 'Circuit de Barcelona-Catalunya';

/*
Prediction Result:
('Circuit de Barcelona-Catalunya74',)
('Circuit de Barcelona-Catalunya75',)
*/