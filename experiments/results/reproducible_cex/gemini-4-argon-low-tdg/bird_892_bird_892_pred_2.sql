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
-- DATASET 2
-- Tests tie-breakers in ORDER BY (T2.points DESC, T1.raceId ASC, T2.driverStandingsId ASC, T3.driverId ASC).
INSERT INTO seasons (year, url) VALUES (2021, 'http://s2021');
INSERT INTO circuits (circuitId, circuitRef, name, url) VALUES (1, 'c1', 'Circuit 1', 'http://c1');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (10, 'd10', 'Fernando', 'Alonso', 'http://d10');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (20, 'd20', 'Sebastian', 'Vettel', 'http://d20');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (30, 'd30', 'Kimi', 'Raikkonen', 'http://d30');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (10, 2021, 1, 1, 'Race 10', '2021-03-28', 'http://r10');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (20, 2021, 2, 1, 'Race 20', '2021-04-18', 'http://r20');
-- All rows have tied max points (50.0).
-- Row 1: raceId 20 (loses on T1.raceId ASC tie-breaker, even though it has smallest driverStandingsId = 1 and smallest driverId = 10)
INSERT INTO driverStandings (driverStandingsId, raceId, driverId, points, position, positionText, wins) VALUES (1, 20, 10, 50.0, 1, '1', 2);
-- Row 2: raceId 10, driverStandingsId 50, driverId 30 (wins on T1.raceId = 10 and T2.driverStandingsId = 50)
INSERT INTO driverStandings (driverStandingsId, raceId, driverId, points, position, positionText, wins) VALUES (50, 10, 30, 50.0, 1, '1', 2);
-- Row 3: raceId 10, driverStandingsId 60, driverId 20 (loses on T2.driverStandingsId ASC tie-breaker despite smaller driverId = 20)
INSERT INTO driverStandings (driverStandingsId, raceId, driverId, points, position, positionText, wins) VALUES (60, 10, 20, 50.0, 1, '1', 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.forename, T3.surname, T2.points FROM races AS T1 INNER JOIN driverStandings AS T2 ON T2.raceId = T1.raceId INNER JOIN drivers AS T3 ON T3.driverId = T2.driverId ORDER BY T2.points DESC, T1.raceid NULLS LAST, T2.driverstandingsid NULLS LAST, T3.driverid NULLS LAST LIMIT 1;

/*
Gold Result:
('Kimi', 'Raikkonen', 50.0)
*/

-- Prediction Query
SELECT "drivers"."forename", "drivers"."surname", "driverStandings"."points" FROM "driverStandings" INNER JOIN "drivers" ON "driverStandings"."driverId" = "drivers"."driverId" ORDER BY "driverStandings"."points" DESC, driverStandings.driverstandingsid NULLS LAST, drivers.driverid NULLS LAST LIMIT 1;

/*
Prediction Result:
('Fernando', 'Alonso', 50.0)
*/