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
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (31, 'Circuit de Barcelona-Catalunya66', 'Circuit de Barcelona-Catalunya66', 'Circuit de Barcelona-Catalunya66', 'Circuit de Barcelona-Catalunya66', 66, 66, 66, 'Circuit de Barcelona-Catalunya24');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (66, 'Circuit de Barcelona-Catalunya57', 'Circuit de Barcelona-Catalunya', 'Circuit de Barcelona-Catalunya58', 'Circuit de Barcelona-Catalunya59', 60, 61, 62, 'Circuit de Barcelona-Catalunya63');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (33, 'Circuit de Barcelona-Catalunya66', 'Circuit de Barcelona-Catalunya26', 'Circuit de Barcelona-Catalunya66', 'Circuit de Barcelona-Catalunya66');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (32, 'Circuit de Barcelona-Catalunya66', 'Circuit de Barcelona-Catalunya25', 'Circuit de Barcelona-Catalunya66', 'Circuit de Barcelona-Catalunya66');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (35, 'Circuit de Barcelona-Catalunya66', 66, 'Circuit de Barcelona-Catalunya66', 'Circuit de Barcelona-Catalunya66', 'Circuit de Barcelona-Catalunya66', '1000-03-08', 'Circuit de Barcelona-Catalunya66', 'Circuit de Barcelona-Catalunya28');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (34, 'Circuit de Barcelona-Catalunya66', 66, 'Circuit de Barcelona-Catalunya66', 'Circuit de Barcelona-Catalunya66', 'Circuit de Barcelona-Catalunya66', '1000-03-08', 'Circuit de Barcelona-Catalunya66', 'Circuit de Barcelona-Catalunya27');
INSERT INTO "seasons" ("year", "url") VALUES (36, 'Circuit de Barcelona-Catalunya30');
INSERT INTO "seasons" ("year", "url") VALUES (65, 'Circuit de Barcelona-Catalunya29');
INSERT INTO "races" ("raceid", "year", "circuitid", "round", "name", "date", "time", "url") VALUES (52, 65, 66, 53, 'Circuit de Barcelona-Catalunya54', '1000-02-25', 'Circuit de Barcelona-Catalunya56', 'Circuit de Barcelona-Catalunya71');
INSERT INTO "races" ("raceid", "year", "circuitid", "round", "name", "date", "time", "url") VALUES (64, 65, 66, 67, 'Circuit de Barcelona-Catalunya68', '1000-03-11', 'Circuit de Barcelona-Catalunya70', 'Circuit de Barcelona-Catalunya72');
INSERT INTO "constructorResults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (38, 64, 32, 66, 'Circuit de Barcelona-Catalunya66');
INSERT INTO "constructorResults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (37, 64, 32, 66, 'Circuit de Barcelona-Catalunya66');
INSERT INTO "constructorStandings" ("constructorstandingsid", "raceid", "constructorid", "points", "position", "positiontext", "wins") VALUES (40, 64, 32, 66, 66, 'Circuit de Barcelona-Catalunya66', 66);
INSERT INTO "constructorStandings" ("constructorstandingsid", "raceid", "constructorid", "points", "position", "positiontext", "wins") VALUES (39, 64, 32, 66, 66, 'Circuit de Barcelona-Catalunya66', 66);
INSERT INTO "driverStandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (42, 64, 34, 66, 66, 'Circuit de Barcelona-Catalunya66', 66);
INSERT INTO "driverStandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (41, 64, 34, 66, 66, 'Circuit de Barcelona-Catalunya66', 66);
INSERT INTO "lapTimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (64, 34, 66, 66, 'Circuit de Barcelona-Catalunya66', 66);
INSERT INTO "lapTimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (64, 35, 66, 66, 'Circuit de Barcelona-Catalunya66', 66);
INSERT INTO "pitStops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (52, 35, 66, 66, 'Circuit de Barcelona-Catalunya66', 'Circuit de Barcelona-Catalunya66', 66);
INSERT INTO "pitStops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (64, 34, 66, 66, 'Circuit de Barcelona-Catalunya66', 'Circuit de Barcelona-Catalunya66', 66);
INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (44, 64, 34, 32, 66, 66, 'Circuit de Barcelona-Catalunya66', 'Circuit de Barcelona-Catalunya66', 'Circuit de Barcelona-Catalunya66');
INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (43, 52, 34, 32, 66, 66, 'Circuit de Barcelona-Catalunya66', 'Circuit de Barcelona-Catalunya66', 'Circuit de Barcelona-Catalunya66');
INSERT INTO "status" ("statusid", "status") VALUES (45, 'Circuit de Barcelona-Catalunya66');
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "statusid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed") VALUES (47, 64, 34, 32, 45, 66, 66, 66, 'Circuit de Barcelona-Catalunya66', 66, 66, 66, 'Circuit de Barcelona-Catalunya66', 66, 66, 66, 'Circuit de Barcelona-Catalunya66', 'Circuit de Barcelona-Catalunya66');
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "statusid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed") VALUES (46, 64, 34, 32, 45, 66, 66, 66, 'Circuit de Barcelona-Catalunya66', 66, 66, 66, 'Circuit de Barcelona-Catalunya66', 66, 66, 66, 'Circuit de Barcelona-Catalunya66', 'Circuit de Barcelona-Catalunya66');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.url FROM circuits AS T1 INNER JOIN races AS T2 ON T2.circuitID = T1.circuitId WHERE T1.name = 'Circuit de Barcelona-Catalunya';

/*
Gold Result:
('Circuit de Barcelona-Catalunya63',)
*/

-- Prediction Query
SELECT T2.url FROM circuits AS T1 INNER JOIN races AS T2 ON T1.circuitId = T2.circuitId WHERE T1.name = 'Circuit de Barcelona-Catalunya';

/*
Prediction Result:
('Circuit de Barcelona-Catalunya71',)
('Circuit de Barcelona-Catalunya72',)
*/