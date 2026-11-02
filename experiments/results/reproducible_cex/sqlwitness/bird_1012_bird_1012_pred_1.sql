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
INSERT INTO seasons (year, url) VALUES (0, 'Lewis'), (2, 'default1'), (1, 'default2'), (3, 'Hamilton'), (4, 'unique_4'), (5, 'unique_5'), (6, 'unique_6'), (7, 'unique_7');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (1, 'default1', NULL, 'Lewis', 'Lewis', 'default2', '2023-01-02', 'Lewis', 'default1'), (0, 'Lewis', 0, 'default1', 'Lewis', 'Hamilton', '2023-01-02', 'default2', 'default2'), (2, 'default2', 0, 'Hamilton', 'default1', 'Hamilton', NULL, 'default1', 'Hamilton'), (3, 'Hamilton', 1, 'Hamilton', 'default2', 'default1', '2023-01-01', 'Lewis', 'Lewis'), (4, 'default2', 1, NULL, 'Hamilton', 'Hamilton', '2023-01-01', NULL, 'unique_4'), (5, 'Hamilton', 0, 'default2', 'default2', 'Hamilton', NULL, 'default1', 'unique_5'), (6, 'default2', 0, NULL, 'default1', 'Hamilton', NULL, NULL, 'unique_6');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (1, 'Lewis', 'Lewis', 'Lewis', NULL, NULL, 2.0, 1, 'Lewis'), (2, 'Lewis', 'Hamilton', 'Hamilton', NULL, 0.0, 1.0, 0, 'default1'), (0, 'default2', 'Hamilton', NULL, NULL, NULL, 1.0, 1, 'Hamilton'), (3, 'default1', 'Hamilton', NULL, 'default1', NULL, 0.0, 0, 'default2'), (4, 'default1', 'Hamilton', 'default1', 'default1', 0.0, 0.0, 2, 'unique_4'), (5, 'default2', 'Lewis', 'default2', 'Lewis', 1.0, 1.0, NULL, 'unique_5'), (6, 'Hamilton', 'default2', NULL, 'Hamilton', 0.0, 0.0, 0, 'unique_6'), (7, 'Lewis', 'default1', 'default2', 'default2', 0.0, 0.0, 2, 'unique_7'), (8, 'default2', 'default1', 'default1', NULL, 0.0, 1.0, 2, 'unique_8'), (9, 'Hamilton', 'default1', 'default2', 'default1', NULL, 2.0, 0, 'unique_9');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (1, 3, 2, 2, 'default2', '2023-01-01', NULL, 'default2'), (0, 5, 3, 2, 'Hamilton', '2023-01-01', 'Lewis', 'default1'), (2, 4, 5, 1, 'Hamilton', '2023-01-01', 'default1', 'Lewis'), (3, 6, 2, 2, 'default1', '2023-01-02', 'Hamilton', NULL);
INSERT INTO laptimes (raceid, driverid, lap, position, time, milliseconds) VALUES (0, 0, 2, 2, 'Lewis', 0), (1, 6, 0, 2, NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.position FROM lapTimes AS T1 INNER JOIN drivers AS T2 ON T1.driverId = T2.driverId WHERE T2.forename = 'Lewis' AND T2.surname = 'Hamilton' ORDER BY T1.time ASC, T1.raceid NULLS LAST, T1.driverid NULLS LAST, T1.lap NULLS LAST, T2.driverid NULLS LAST LIMIT 1;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT "circuits"."name", "lapTimes"."position" FROM "lapTimes" INNER JOIN "drivers" ON "lapTimes"."driverId" = "drivers"."driverId" INNER JOIN "races" ON "lapTimes"."raceId" = "races"."raceId" INNER JOIN "circuits" ON "races"."circuitId" = "circuits"."circuitId" WHERE "drivers"."forename" = 'Lewis' AND "drivers"."surname" = 'Hamilton' ORDER BY "lapTimes"."milliseconds" ASC, lapTimes.raceid NULLS LAST, lapTimes.driverid NULLS LAST, lapTimes.lap NULLS LAST, drivers.driverid NULLS LAST, races.raceid NULLS LAST, circuits.circuitid NULLS LAST LIMIT 1;

/*
Prediction Result:
('Hamilton', 2)
*/