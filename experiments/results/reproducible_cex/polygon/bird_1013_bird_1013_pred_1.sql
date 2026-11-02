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
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (33, 'Austrian Grand Prix80', 'Austrian Grand Prix81', 'Austrian Grand Prix82', 'Austrian Grand Prix83', 84, 85, 86, 'Austrian Grand Prix26');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (35, 'Austrian Grand Prix102', 'Austrian Grand Prix28', 'Austrian Grand Prix102', 'Austrian Grand Prix102');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (34, 'Austrian Grand Prix102', 'Austrian Grand Prix27', 'Austrian Grand Prix102', 'Austrian Grand Prix102');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (47, 'Austrian Grand Prix102', 102, 'Austrian Grand Prix102', 'Austrian Grand Prix102', 'Austrian Grand Prix102', '1000-04-13', 'Austrian Grand Prix102', 'Austrian Grand Prix30');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (36, 'Austrian Grand Prix102', 102, 'Austrian Grand Prix102', 'Austrian Grand Prix102', 'Austrian Grand Prix102', '1000-04-13', 'Austrian Grand Prix102', 'Austrian Grand Prix29');
INSERT INTO "seasons" ("year", "url") VALUES (94, 'Austrian Grand Prix32');
INSERT INTO "seasons" ("year", "url") VALUES (103, 'Austrian Grand Prix31');
INSERT INTO "races" ("raceid", "year", "circuitid", "round", "name", "date", "time", "url") VALUES (93, 94, 33, 95, 'Austrian Grand Prix', '1000-04-07', 'Austrian Grand Prix97', 'Austrian Grand Prix98');
INSERT INTO "races" ("raceid", "year", "circuitid", "round", "name", "date", "time", "url") VALUES (102, 103, 33, 104, 'Austrian Grand Prix', '1000-04-16', 'Austrian Grand Prix106', 'Austrian Grand Prix107');
INSERT INTO "constructorResults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (38, 93, 34, 102, 'Austrian Grand Prix102');
INSERT INTO "constructorResults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (37, 102, 34, 102, 'Austrian Grand Prix102');
INSERT INTO "constructorStandings" ("constructorstandingsid", "raceid", "constructorid", "points", "position", "positiontext", "wins") VALUES (40, 102, 34, 102, 102, 'Austrian Grand Prix102', 102);
INSERT INTO "constructorStandings" ("constructorstandingsid", "raceid", "constructorid", "points", "position", "positiontext", "wins") VALUES (39, 102, 35, 102, 102, 'Austrian Grand Prix102', 102);
INSERT INTO "driverStandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (42, 102, 36, 102, 102, 'Austrian Grand Prix102', 102);
INSERT INTO "driverStandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (41, 93, 36, 102, 102, 'Austrian Grand Prix102', 102);
INSERT INTO "lapTimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (93, 47, 90, 91, 'Austrian Grand Prix-777', 92);
INSERT INTO "lapTimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (102, 36, 99, 100, 'Austrian Grand Prix-777', 101);
INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (44, 102, 36, 35, 102, 102, 'Austrian Grand Prix102', 'Austrian Grand Prix102', 'Austrian Grand Prix102');
INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (43, 102, 36, 34, 102, 102, 'Austrian Grand Prix102', 'Austrian Grand Prix102', 'Austrian Grand Prix102');
INSERT INTO "status" ("statusid", "status") VALUES (49, 'Austrian Grand Prix102');
INSERT INTO "status" ("statusid", "status") VALUES (48, 'Austrian Grand Prix102');
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "statusid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed") VALUES (46, 93, 36, 34, 48, 52, 53, 54, 'Austrian Grand Prix55', 56, 57, 58, 'Austrian Grand Prix59', 60, 61, 62, 'Austrian Grand Prix-122', 'Austrian Grand Prix63');
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "statusid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed") VALUES (45, 102, 47, 34, 49, 64, 65, 66, 'Austrian Grand Prix67', 68, 69, 70, 'Austrian Grand Prix71', 72, 73, 74, 'Austrian Grand Prix-777', 'Austrian Grand Prix75');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
WITH fastest_lap_times AS (SELECT T1.raceId, T1.fastestLapTime FROM results AS T1 WHERE NOT T1.FastestLapTime IS NULL) SELECT MIN(fastest_lap_times.fastestLapTime) AS lap_record FROM fastest_lap_times INNER JOIN races AS T2 ON fastest_lap_times.raceId = T2.raceId INNER JOIN circuits AS T3 ON T2.circuitId = T3.circuitId WHERE T2.name = 'Austrian Grand Prix';

/*
Gold Result:
('Austrian Grand Prix-122',)
*/

-- Prediction Query
SELECT lapTimes.time FROM lapTimes JOIN races ON lapTimes.raceId = races.raceId WHERE races.name = 'Austrian Grand Prix' ORDER BY lapTimes.milliseconds, lapTimes.raceid NULLS LAST, lapTimes.driverid NULLS LAST, lapTimes.lap NULLS LAST, races.raceid NULLS LAST LIMIT 1;

/*
Prediction Result:
('Austrian Grand Prix-777',)
*/