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
-- Tests basic positive match, DISTINCT (multiple laps in race 161 with '1:27%' for same driver),
-- raceId boundaries (160, 162), and LIKE pattern boundaries (exact '1:27', '1:26%', '1:28%', prefix before '1:27', NULL).
INSERT INTO seasons (year, url) VALUES (2020, 'http://seasons.com/2020');
INSERT INTO circuits (circuitId, circuitRef, name, url) VALUES (1, 'monza', 'Monza', 'http://circuits.com/1');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (160, 2020, 1, 1, 'Race 160', '2020-07-05', 'http://races.com/160');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (161, 2020, 2, 1, 'Race 161', '2020-07-12', 'http://races.com/161');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (162, 2020, 3, 1, 'Race 162', '2020-07-19', 'http://races.com/162');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (1, 'ham', 'Lewis', 'Hamilton', 'http://drivers.com/ham');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (2, 'ver', 'Max', 'Verstappen', 'http://drivers.com/ver');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (3, 'lec', 'Charles', 'Leclerc', 'http://drivers.com/lec');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (4, 'nor', 'Lando', 'Norris', 'http://drivers.com/nor');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (5, 'sai', 'Carlos', 'Sainz', 'http://drivers.com/sai');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (6, 'alo', 'Fernando', 'Alonso', 'http://drivers.com/alo');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (7, 'rus', 'George', 'Russell', 'http://drivers.com/rus');
-- Driver 1: Multiple matching laps in race 161 (tests DISTINCT)
INSERT INTO lapTimes (raceId, driverId, lap, position, time, milliseconds) VALUES (161, 1, 1, 1, '1:27.456', 87456);
INSERT INTO lapTimes (raceId, driverId, lap, position, time, milliseconds) VALUES (161, 1, 2, 1, '1:27.001', 87001);
-- Driver 2: Exact prefix match '1:27' without trailing characters
INSERT INTO lapTimes (raceId, driverId, lap, position, time, milliseconds) VALUES (161, 2, 1, 2, '1:27', 87000);
-- Driver 3: Matching time '1:27%' but in wrong raceIds (160 and 162)
INSERT INTO lapTimes (raceId, driverId, lap, position, time, milliseconds) VALUES (160, 3, 1, 1, '1:27.123', 87123);
INSERT INTO lapTimes (raceId, driverId, lap, position, time, milliseconds) VALUES (162, 3, 1, 1, '1:27.123', 87123);
-- Driver 4: Correct raceId 161, but times just outside '1:27%' range
INSERT INTO lapTimes (raceId, driverId, lap, position, time, milliseconds) VALUES (161, 4, 1, 3, '1:26.999', 86999);
INSERT INTO lapTimes (raceId, driverId, lap, position, time, milliseconds) VALUES (161, 4, 2, 3, '1:28.000', 88000);
-- Driver 5: Correct raceId 161, but '1:27' is not at the start of the string (tests '%1:27%' vs '1:27%')
INSERT INTO lapTimes (raceId, driverId, lap, position, time, milliseconds) VALUES (161, 5, 1, 4, '01:27.500', 87500);
INSERT INTO lapTimes (raceId, driverId, lap, position, time, milliseconds) VALUES (161, 5, 2, 4, '11:27.500', 687500);
-- Driver 6: Correct raceId 161, NULL time
INSERT INTO lapTimes (raceId, driverId, lap, position, time, milliseconds) VALUES (161, 6, 1, 5, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.forename, T2.surname, T2.url FROM lapTimes AS T1 INNER JOIN drivers AS T2 ON T2.driverId = T1.driverId WHERE T1.raceId = 161 AND T1.time LIKE '1:27%';

/*
Gold Result:
('Lewis', 'Hamilton', 'http://drivers.com/ham')
('Max', 'Verstappen', 'http://drivers.com/ver')
*/

-- Prediction Query
SELECT drivers.forename, drivers.surname, drivers.url FROM races INNER JOIN lapTimes ON races.raceId = lapTimes.raceId INNER JOIN drivers ON lapTimes.driverId = drivers.driverId WHERE races.raceId = 161 AND lapTimes.time LIKE '1:27.0%';

/*
Prediction Result:
('Lewis', 'Hamilton', 'http://drivers.com/ham')
*/