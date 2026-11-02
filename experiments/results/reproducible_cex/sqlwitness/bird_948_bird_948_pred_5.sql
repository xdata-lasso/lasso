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
INSERT INTO seasons (year, url) VALUES (1, 'default2');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (1, 'default1', 'default1', NULL, 'default2'), (0, 'British', 'British', 'British', 'British'), (2, 'default1', 'default2', 'default2', 'British'), (3, 'default2', 'unique_3', 'default2', 'British'), (4, 'British', 'unique_4', 'British', 'default2'), (5, 'default2', 'unique_5', 'British', 'British'), (6, 'default1', 'unique_6', 'default2', 'British');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (0, 'default2', 'default2', 'default1', 'British', 1.0, 0.0, 0, 'British'), (1, 'default2', 'default1', 'default2', NULL, NULL, 0.0, 1, 'default2'), (2, 'default2', 'British', 'British', 'British', 0.0, NULL, NULL, 'default1'), (3, 'British', 'default1', 'default1', 'British', 0.0, NULL, NULL, 'unique_3'), (4, 'default1', 'default1', 'default2', 'British', 1.0, 1.0, 0, 'unique_4'), (5, 'default2', 'default1', 'default2', 'British', 1.0, 0.0, 1, 'unique_5'), (6, 'default2', 'British', 'British', 'default1', 1.0, NULL, 1, 'unique_6'), (7, 'default2', 'default1', 'British', NULL, 0.0, 1.0, NULL, 'unique_7'), (8, 'British', 'British', NULL, 'default1', 1.0, 0.0, 0, 'unique_8'), (9, 'British', 'default1', NULL, 'default2', 1.0, 0.0, 0, 'unique_9'), (10, 'British', 'default1', 'British', 'British', 0.0, 0.0, NULL, 'unique_10'), (11, 'default2', 'default1', 'British', 'default2', 0.0, 1.0, 0, 'unique_11'), (12, 'British', 'British', NULL, 'default1', 1.0, 1.0, 1, 'unique_12'), (13, 'British', 'default1', 'British', NULL, 1.0, NULL, 1, 'unique_13');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (1, 1, 13, 1, 'British', '2023-01-01', 'default2', 'default1'), (0, 1, 0, 0, 'default2', '2023-01-01', 'default2', 'British'), (2, 1, 0, 0, 'default2', '2023-01-01', NULL, NULL), (3, 1, 10, 1, 'default1', '2023-01-02', 'default1', 'default2'), (4, 1, 12, 1, 'default1', '2023-01-02', 'British', 'unique_4'), (5, 1, 12, 1, 'default2', '2023-01-02', 'default1', 'unique_5');
INSERT INTO constructorstandings (constructorstandingsid, raceid, constructorid, points, position, positiontext, wins) VALUES (1, 4, 5, 1.0, 0, 'British', 1), (0, 4, 4, 1.0, NULL, NULL, 0), (2, 5, 4, 0.0, 1, 'default1', 1), (3, 0, 0, 1.0, NULL, 'default1', 1), (4, 5, 5, 0.0, 0, 'default1', 1), (5, 0, 0, 1.0, 1, NULL, 0), (6, 1, 0, 0.0, 0, NULL, 1), (7, 5, 2, 1.0, 1, 'British', 1), (8, 1, 1, 0.0, NULL, 'default2', 0), (9, 2, 6, 1.0, 0, 'default1', 0), (10, 3, 4, 0.0, 0, 'default2', 0), (11, 2, 0, 1.0, NULL, 'British', 1), (12, 2, 5, 0.0, 0, 'default1', 1), (13, 0, 6, 1.0, 1, NULL, 1), (14, 1, 0, 1.0, 0, 'default2', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(T1.points) FROM constructorStandings AS T1 INNER JOIN constructors AS T2 ON T1.constructorId = T2.constructorId WHERE T2.nationality = 'British';

/*
Gold Result:
(0.5454545454545454,)
*/

-- Prediction Query
SELECT MAX(cs.points) AS max_points FROM constructors AS c INNER JOIN constructorStandings AS cs ON c.constructorId = cs.constructorId WHERE c.nationality = 'British';

/*
Prediction Result:
(1.0,)
*/