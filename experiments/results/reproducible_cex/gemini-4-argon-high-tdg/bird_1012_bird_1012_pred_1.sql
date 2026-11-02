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
INSERT INTO seasons (year, url) VALUES (2020, 'http://en.wikipedia.org/wiki/2020_Formula_One_World_Championship');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, lat, lng, alt, url) VALUES (1, 'monza', 'Autodromo Nazionale di Monza', 'Monza', 'Italy', 45.6156, 9.28111, 162, 'http://en.wikipedia.org/wiki/Monza_Circuit');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (10, 2020, 1, 1, 'Italian Grand Prix', '2020-09-06', '13:10:00', 'http://en.wikipedia.org/wiki/2020_Italian_Grand_Prix');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (20, 2020, 2, 1, 'Tuscan Grand Prix', '2020-09-13', '13:10:00', 'http://en.wikipedia.org/wiki/2020_Tuscan_Grand_Prix');
INSERT INTO constructors (constructorId, constructorRef, name, nationality, url) VALUES (1, 'mercedes', 'Mercedes', 'German', 'http://en.wikipedia.org/wiki/Mercedes-Benz_in_Formula_One');
INSERT INTO status (statusId, status) VALUES (1, 'Finished');
INSERT INTO drivers (driverId, driverRef, number, code, forename, surname, dob, nationality, url) VALUES (7, 'hamilton', 44, 'HAM', 'Lewis', 'Hamilton', '1985-01-07', 'British', 'http://en.wikipedia.org/wiki/Lewis_Hamilton');
INSERT INTO lapTimes (raceId, driverId, lap, position, time, milliseconds) VALUES (20, 7, 3, 6, '01:15.000', 75000);
INSERT INTO lapTimes (raceId, driverId, lap, position, time, milliseconds) VALUES (10, 7, 1, 2, '1:12.000', 72000);
INSERT INTO lapTimes (raceId, driverId, lap, position, time, milliseconds) VALUES (10, 7, 2, 9, '1:19.000', 79000);
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, time, milliseconds, fastestLap, rank, fastestLapTime, fastestLapSpeed, statusId) VALUES (1, 10, 7, 1, 44, 1, 11, '11', 11, 0, 53, '1:20:00.000', 4800000, 1, 1, '1:12.000', '240.0', 1);
INSERT INTO qualifying (qualifyId, raceId, driverId, constructorId, number, position, q1, q2, q3) VALUES (1, 10, 7, 1, 44, 12, '1:11.000', '1:10.500', '1:10.000');
INSERT INTO driverStandings (driverStandingsId, raceId, driverId, points, position, positionText, wins) VALUES (1, 10, 7, 25, 13, '13', 1);
INSERT INTO pitStops (raceId, driverId, stop, lap, time, duration, milliseconds) VALUES (10, 7, 1, 15, '14:00:00', '21.000', 21000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.position FROM lapTimes AS T1 INNER JOIN drivers AS T2 ON T1.driverId = T2.driverId WHERE T2.forename = 'Lewis' AND T2.surname = 'Hamilton' ORDER BY T1.time ASC, T1.raceid NULLS LAST, T1.driverid NULLS LAST, T1.lap NULLS LAST, T2.driverid NULLS LAST LIMIT 1;

/*
Gold Result:
(6,)
*/

-- Prediction Query
SELECT "circuits"."name", "lapTimes"."position" FROM "lapTimes" INNER JOIN "drivers" ON "lapTimes"."driverId" = "drivers"."driverId" INNER JOIN "races" ON "lapTimes"."raceId" = "races"."raceId" INNER JOIN "circuits" ON "races"."circuitId" = "circuits"."circuitId" WHERE "drivers"."forename" = 'Lewis' AND "drivers"."surname" = 'Hamilton' ORDER BY "lapTimes"."milliseconds" ASC, lapTimes.raceid NULLS LAST, lapTimes.driverid NULLS LAST, lapTimes.lap NULLS LAST, drivers.driverid NULLS LAST, races.raceid NULLS LAST, circuits.circuitid NULLS LAST LIMIT 1;

/*
Prediction Result:
('Autodromo Nazionale di Monza', 2)
*/