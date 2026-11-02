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
-- DATASET 1
INSERT INTO circuits (circuitId, circuitRef, name, location, country, url) VALUES (1, 'marina_bay', 'Marina Bay Street Circuit', 'Marina Bay', 'Singapore', 'http://en.wikipedia.org/wiki/Marina_Bay_Street_Circuit');
INSERT INTO seasons (year, url) VALUES (2008, 'http://en.wikipedia.org/wiki/2008_Formula_One_season');
INSERT INTO constructors (constructorId, constructorRef, name, nationality, url) VALUES (1, 'ferrari', 'Ferrari', 'Italian', 'http://en.wikipedia.org/wiki/Scuderia_Ferrari');
INSERT INTO drivers (driverId, driverRef, number, code, forename, surname, dob, nationality, url) VALUES (1, 'massa', 19, 'MAS', 'Felipe', 'Massa', '1981-04-25', 'Brazilian', 'http://en.wikipedia.org/wiki/Felipe_Massa');
INSERT INTO drivers (driverId, driverRef, number, code, forename, surname, dob, nationality, url) VALUES (2, 'hamilton', 44, 'HAM', 'Lewis', 'Hamilton', '1985-01-07', 'British', 'http://en.wikipedia.org/wiki/Lewis_Hamilton');
INSERT INTO drivers (driverId, driverRef, number, code, forename, surname, dob, nationality, url) VALUES (3, 'raikkonen', 7, 'RAI', 'Kimi', 'Raikkonen', '1979-10-17', 'Finnish', 'http://en.wikipedia.org/wiki/Kimi_Raikkonen');
INSERT INTO drivers (driverId, driverRef, number, code, forename, surname, dob, nationality, url) VALUES (4, 'alonso', 14, 'ALO', 'Fernando', 'Alonso', '1981-07-29', 'Spanish', 'http://en.wikipedia.org/wiki/Fernando_Alonso');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (1, 2008, 15, 1, 'Singapore Grand Prix', '2008-09-28', '12:00:00', 'http://en.wikipedia.org/wiki/2008_Singapore_Grand_Prix');
INSERT INTO qualifying (qualifyId, raceId, driverId, constructorId, number, position, q1, q2, q3) VALUES (1, 1, 4, 1, 5, 1, '1:43.100', '1:43.200', NULL);
INSERT INTO qualifying (qualifyId, raceId, driverId, constructorId, number, position, q1, q2, q3) VALUES (2, 1, 2, 1, 22, 1, '1:44.100', '1:44.200', '1:45.465');
INSERT INTO qualifying (qualifyId, raceId, driverId, constructorId, number, position, q1, q2, q3) VALUES (3, 1, 1, 1, 2, 2, '1:46.000', '1:45.500', '1:44.801');
INSERT INTO qualifying (qualifyId, raceId, driverId, constructorId, number, position, q1, q2, q3) VALUES (4, 1, 3, 1, 1, 3, '1:47.000', '1:46.500', '1:48.999');
INSERT INTO status (statusId, status) VALUES (1, 'Finished');
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, time, milliseconds, fastestLap, rank, fastestLapTime, fastestLapSpeed, statusId) VALUES (1, 1, 2, 1, 22, 1, 1, '1', 1, 10.0, 61, '1:57:16.304', 7036304, 14, 1, '1:41.500', '179.000', 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, time, milliseconds, fastestLap, rank, fastestLapTime, fastestLapSpeed, statusId) VALUES (2, 1, 1, 1, 2, 2, 2, '2', 2, 8.0, 61, '+5.000', 7041304, 15, 2, '1:46.000', '175.000', 1);
INSERT INTO lapTimes (raceId, driverId, lap, position, time, milliseconds) VALUES (1, 2, 1, 1, '1:41.500', 101500);
INSERT INTO lapTimes (raceId, driverId, lap, position, time, milliseconds) VALUES (1, 1, 1, 2, '1:46.000', 106000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.forename, T2.surname FROM qualifying AS T1 INNER JOIN drivers AS T2 ON T1.driverId = T2.driverId INNER JOIN races AS T3 ON T1.raceid = T3.raceid WHERE NOT q3 IS NULL AND T3.year = 2008 AND T3.circuitId IN (SELECT circuitId FROM circuits WHERE name = 'Marina Bay Street Circuit') ORDER BY CAST(SUBSTRING(q3, 1, INSTR(q3, ':') - 1) AS INTEGER) * 60 + CAST(SUBSTRING(q3, INSTR(q3, ':') + 1, INSTR(q3, '.') - INSTR(q3, ':') - 1) AS REAL) + CAST(SUBSTRING(q3, INSTR(q3, '.') + 1) AS REAL) / 1000 ASC, T1.qualifyid NULLS LAST, T2.driverid NULLS LAST, T3.raceid NULLS LAST LIMIT 1;

/*
Gold Result:
('Felipe', 'Massa')
*/

-- Prediction Query
SELECT "drivers"."forename", "drivers"."surname" FROM "qualifying" INNER JOIN "races" ON "qualifying"."raceid" = "races"."raceid" INNER JOIN "circuits" ON "races"."circuitid" = "circuits"."circuitid" INNER JOIN "drivers" ON "qualifying"."driverid" = "drivers"."driverid" WHERE "races"."year" = 2008 AND "circuits"."name" = 'Marina Bay Street Circuit' ORDER BY "qualifying"."q3", qualifying.qualifyid NULLS LAST, races.raceid NULLS LAST, circuits.circuitid NULLS LAST, drivers.driverid NULLS LAST LIMIT 1;

/*
Prediction Result:
('Fernando', 'Alonso')
*/