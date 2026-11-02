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
INSERT INTO seasons (year, url) VALUES (2, 'default2');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (2, '1980-01-01', 4, '1990-12-31', 'German', '1990-12-31', '1990-12-30', 'German', '1990-12-31'), (3, 'default1', 4, 'default2', 'German', 'German', '1990-12-30', '%Y', '%Y'), (1, 'default2', 3, '%Y', '1980', '1990-12-31', '1979-12-31', '1980', 'German'), (4, '1990-12-31', NULL, '1990-12-31', 'German', 'default1', '1979-12-31', '%Y', '1980-01-01'), (0, 'default2', 4, '1990', '1980', '1980', NULL, '%Y', 'default2'), (5, '1980', NULL, '1980', '1990-12-31', '%Y', '1990-10-27', 'default2', '1980'), (6, '1990', 0, '1980', '1990-12-31', '%Y', '2023-01-01', NULL, '1990'), (7, '1980-01-01', 2, '1990-12-31', '%Y', '1980-01-01', '1979-12-31', 'default2', 'default1'), (8, '1980', 1, '1980', '1980', '1980-01-01', '1980-01-02', 'German', 'unique_8');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (0, 'default2', '1990-12-31', '1980-01-01', 'default1', NULL, 2.0, 2, '1990-12-31'), (3, '1980', 'German', 'default2', 'default2', 0.0, 1.0, 3, 'default2'), (4, '1990-12-31', '1980', '1980', '%Y', 1.0, 2.0, 0, '%Y');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (0, 2, 0, 2, '1980-01-01', '1990-12-30', 'default1', NULL), (2, 2, 3, 3, '1980-01-01', '1979-12-31', '1990', 'default1'), (1, 2, 4, 1, '1990-12-31', '1991-01-01', 'German', 'German'), (3, 2, 3, 0, '1980-01-01', '2023-01-01', '1980-01-01', '1990'), (4, 2, 0, 1, '1980-01-01', '1980-01-02', '1980', '1980'), (5, 2, 4, 2, '1980-01-01', '2023-01-02', '1980-01-01', '1990-12-31');
INSERT INTO pitstops (raceid, driverid, stop, lap, time, duration, milliseconds) VALUES (2, 7, 1, 3, '1990', '1990-12-31', 3), (5, 2, 4, 0, 'German', 'default2', 2), (0, 1, 0, 0, 'default2', NULL, NULL), (0, 5, 2, 3, 'default1', '1990-12-31', 2), (3, 5, 2, 1, '1990', '1990-12-31', 4), (1, 7, 3, 0, '1990', NULL, 2);
INSERT INTO laptimes (raceid, driverid, lap, position, time, milliseconds) VALUES (4, 3, 3, 3, '1980-01-01', 4), (5, 8, 3, 1, 'default1', 3), (2, 7, 1, NULL, '1990-12-31', 4), (3, 5, 4, 1, '1990-12-31', 0), (1, 7, 3, 2, '1990', 1), (0, 0, 1, NULL, 'German', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.driverId FROM pitStops AS T1 INNER JOIN drivers AS T2 ON T1.driverId = T2.driverId WHERE T2.nationality = 'German' AND STRFTIME('%Y', T2.dob) BETWEEN '1980' AND '1990' ORDER BY T1.time, T1.raceid NULLS LAST, T1.driverid NULLS LAST, T1.stop NULLS LAST, T2.driverid NULLS LAST LIMIT 3;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT "drivers"."forename", "drivers"."surname", MIN("lapTimes"."time") AS "earliest_lap_time" FROM "drivers" INNER JOIN "lapTimes" ON "drivers"."driverId" = "lapTimes"."driverId" WHERE "drivers"."dob" BETWEEN '1980-01-01' AND '1990-12-31' AND "drivers"."nationality" = 'German' GROUP BY "drivers"."driverId" ORDER BY "earliest_lap_time" ASC, "drivers"."forename" NULLS LAST, "drivers"."surname" NULLS LAST, earliest_lap_time NULLS LAST LIMIT 3;

/*
Prediction Result:
('1980', '1980-01-01', 'default1')
*/