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
INSERT INTO status (statusid, status) VALUES (50, 'default1'), (1, 'default2'), (51, 'default2'), (49, 'default1'), (0, 'default2'), (2, 'default2'), (3, 'default1'), (4, 'default2'), (5, 'default1');
INSERT INTO seasons (year, url) VALUES (49, 'default2'), (0, 'French'), (50, 'default1'), (1, 'unique_3'), (51, 'unique_4'), (2, 'unique_5'), (3, 'unique_6'), (4, 'unique_7'), (5, 'unique_8'), (6, 'unique_9'), (7, 'unique_10'), (8, 'unique_11'), (9, 'unique_12'), (10, 'unique_13'), (11, 'unique_14');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (51, 'French', 49, 'French', 'French', 'default1', NULL, NULL, 'default2'), (50, 'default2', NULL, 'default2', 'default1', 'French', '2023-01-01', 'default1', 'default1');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (51, 'default1', 'French', 'default2', 'French'), (0, 'French', 'default2', NULL, 'French'), (50, 'French', 'default1', 'French', 'French'), (49, 'default1', 'unique_3', 'French', 'default1'), (1, 'French', 'unique_4', 'default2', 'French');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (50, 'French', 'French', 'default2', 'French', 49.0, 49.0, 1, 'default2'), (51, 'default2', 'default1', 'default1', 'default1', 1.0, 0.0, 49, 'default1'), (1, 'French', 'French', 'French', NULL, 49.0, 1.0, NULL, 'French'), (49, 'default2', 'French', NULL, 'default1', 49.0, 51.0, 50, 'unique_3'), (0, 'default2', 'default2', 'default2', 'French', 0.0, 1.0, 51, 'unique_4'), (2, 'French', 'French', 'default1', 'French', 50.0, 0.0, 51, 'unique_5'), (3, 'default2', 'French', 'default1', NULL, NULL, 1.0, 1, 'unique_6'), (4, 'default2', 'French', NULL, 'default1', 0.0, 0.0, 1, 'unique_7'), (5, 'French', 'default2', 'default2', NULL, 49.0, NULL, 49, 'unique_8'), (6, 'default2', 'default1', 'default1', 'default2', 0.0, 1.0, 49, 'unique_9'), (7, 'default2', 'French', 'default2', 'default1', 49.0, 50.0, NULL, 'unique_10'), (8, 'default1', 'default2', 'default1', NULL, 50.0, 0.0, 51, 'unique_11');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (50, 8, 4, 0, 'French', '2023-01-02', 'default1', 'default2'), (49, 1, 8, 51, 'French', '2023-01-02', 'default2', NULL), (0, 50, 51, 1, 'default1', '2023-01-02', NULL, 'French');
INSERT INTO results (resultid, raceid, driverid, constructorid, statusid, number, grid, position, positiontext, positionorder, points, laps, time, milliseconds, fastestlap, rank, fastestlaptime, fastestlapspeed) VALUES (0, 0, 50, 50, 3, 51, 50, 50, 'default2', 1, 50.0, 1, 'default2', 51, NULL, 50, NULL, 'default2'), (49, 50, 50, 1, 49, 1, 0, 49, 'French', 51, 49.0, 50, NULL, 50, 49, 0, NULL, NULL), (50, 49, 50, 1, 51, 0, 50, 50, 'French', 0, 51.0, 51, 'French', 49, 0, 0, 'default2', NULL), (1, 0, 51, 0, 5, 51, 0, 0, 'French', 0, 1.0, 1, NULL, NULL, 50, 51, 'default2', 'default1'), (51, 0, 50, 1, 51, 49, 0, 50, 'default1', 51, 1.0, 49, 'default2', 1, NULL, 49, 'French', 'French'), (2, 0, 51, 51, 5, 1, 50, 51, 'default2', 1, 50.0, 50, 'default2', 49, 1, 49, 'default1', 'default1'), (3, 0, 50, 1, 0, 1, 0, 51, 'default2', 50, 0.0, 0, 'default2', 51, 49, NULL, NULL, 'default1'), (4, 0, 51, 49, 5, 1, 1, 1, 'French', 49, 49.0, 0, 'French', 51, 49, 50, 'French', 'default2'), (5, 50, 51, 51, 51, 0, 49, 1, 'default2', 51, 51.0, 1, 'French', NULL, NULL, 49, 'French', 'default1'), (6, 50, 51, 50, 5, 1, 50, 51, 'default2', 51, 1.0, 0, 'French', NULL, 49, 50, 'default1', NULL), (7, 49, 51, 49, 5, 50, 1, 50, 'default1', 0, 50.0, 49, NULL, 1, 50, 51, 'French', 'French'), (8, 0, 50, 50, 3, 0, 49, 1, 'default2', 49, 51.0, 0, NULL, 1, NULL, 0, 'French', NULL), (9, 0, 50, 1, 49, 51, 51, 0, 'default1', 50, 1.0, 50, NULL, 50, 0, NULL, NULL, NULL), (10, 50, 50, 0, 3, 49, 51, NULL, 'default1', 51, 51.0, 51, 'French', 1, 1, 0, NULL, NULL);
INSERT INTO constructorstandings (constructorstandingsid, raceid, constructorid, points, position, positiontext, wins) VALUES (51, 50, 0, 49.0, 51, 'default1', 1), (49, 49, 1, 51.0, NULL, 'French', 51), (50, 50, 49, 49.0, 51, 'French', 50), (0, 50, 50, 50.0, 49, 'default2', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T2.constructorId) FROM results AS T1 INNER JOIN constructors AS T2 ON T1.constructorId = T2.constructorId WHERE T1.laps > 50 AND T2.nationality = 'French';

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT c.constructorId) AS FrenchConstructorsWithLapsOver50 FROM constructors AS c JOIN constructorStandings AS cs ON c.constructorId = cs.constructorId JOIN results AS r ON cs.raceId = r.raceId WHERE c.nationality = 'French' AND r.laps > 50;

/*
Prediction Result:
(2,)
*/