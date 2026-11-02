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
-- DATASET 3
INSERT INTO circuits (circuitId, circuitRef, name, location, country, url) VALUES (1, 'marina_bay', 'Marina Bay Street Circuit', 'Marina Bay', 'Singapore', 'http://en.wikipedia.org/wiki/Marina_Bay_Street_Circuit');
INSERT INTO seasons (year, url) VALUES (2008, 'http://en.wikipedia.org/wiki/2008_Formula_One_season');
INSERT INTO constructors (constructorId, constructorRef, name, nationality, url) VALUES (1, 'bmw_sauber', 'BMW Sauber', 'German', 'http://en.wikipedia.org/wiki/BMW_Sauber');
INSERT INTO drivers (driverId, driverRef, number, code, forename, surname, dob, nationality, url) VALUES (1, 'kubica', 4, 'KUB', 'Robert', 'Kubica', '1984-12-07', 'Polish', 'http://en.wikipedia.org/wiki/Robert_Kubica');
INSERT INTO drivers (driverId, driverRef, number, code, forename, surname, dob, nationality, url) VALUES (2, 'heidfeld', 3, 'HEI', 'Nick', 'Heidfeld', '1977-05-10', 'German', 'http://en.wikipedia.org/wiki/Nick_Heidfeld');
INSERT INTO drivers (driverId, driverRef, number, code, forename, surname, dob, nationality, url) VALUES (3, 'glock', 12, 'GLO', 'Timo', 'Glock', '1982-03-18', 'German', 'http://en.wikipedia.org/wiki/Timo_Glock');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (1, 2008, 15, 1, 'Singapore Grand Prix', '2008-09-28', '12:00:00', 'http://en.wikipedia.org/wiki/2008_Singapore_Grand_Prix');
INSERT INTO qualifying (qualifyId, raceId, driverId, constructorId, number, position, q1, q2, q3) VALUES (1, 1, 3, 1, 12, 1, '1:45.000', '1:45.000', '10:00.000');
INSERT INTO qualifying (qualifyId, raceId, driverId, constructorId, number, position, q1, q2, q3) VALUES (2, 1, 2, 1, 3, 2, '1:45.000', '1:45.000', '1:45.100');
INSERT INTO qualifying (qualifyId, raceId, driverId, constructorId, number, position, q1, q2, q3) VALUES (3, 1, 1, 1, 4, 3, '1:45.000', '1:45.000', '1:9.500');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.forename, T2.surname FROM qualifying AS T1 INNER JOIN drivers AS T2 ON T1.driverId = T2.driverId INNER JOIN races AS T3 ON T1.raceid = T3.raceid WHERE NOT q3 IS NULL AND T3.year = 2008 AND T3.circuitId IN (SELECT circuitId FROM circuits WHERE name = 'Marina Bay Street Circuit') ORDER BY CAST(SUBSTRING(q3, 1, INSTR(q3, ':') - 1) AS INTEGER) * 60 + CAST(SUBSTRING(q3, INSTR(q3, ':') + 1, INSTR(q3, '.') - INSTR(q3, ':') - 1) AS REAL) + CAST(SUBSTRING(q3, INSTR(q3, '.') + 1) AS REAL) / 1000 ASC, T1.qualifyid NULLS LAST, T2.driverid NULLS LAST, T3.raceid NULLS LAST LIMIT 1;

/*
Gold Result:
('Robert', 'Kubica')
*/

-- Prediction Query
SELECT d.forename, d.surname FROM qualifying AS q JOIN races AS r ON q.raceId = r.raceId JOIN circuits AS c ON r.circuitId = c.circuitId JOIN drivers AS d ON q.driverId = d.driverId WHERE q.q3 = (SELECT MIN(q3) FROM qualifying WHERE raceId = r.raceId) AND r.year = 2008 AND c.name = 'Marina Bay Street Circuit';

/*
Prediction Result:
('Timo', 'Glock')
*/