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
-- Cardinality, DISTINCT, and NULL handling dataset: Tests multiple qualifying entries with identical q1 (kills erroneous DISTINCT), NULL q1 values, and swapped/substring name traps.
INSERT INTO circuits (circuitId, circuitRef, name, url) VALUES (1, 'monza', 'Monza', 'http://en.wikipedia.org/wiki/Monza');
INSERT INTO seasons (year, url) VALUES (2010, 'http://en.wikipedia.org/wiki/2010_Season');
INSERT INTO constructors (constructorId, constructorRef, name, url) VALUES (1, 'virgin', 'Virgin', 'http://en.wikipedia.org/wiki/Virgin');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (345, 2010, 14, 1, 'Italian GP', '2010-09-12', 'http://en.wikipedia.org/wiki/2010_Italian_GP');
-- Two distinct drivers with the exact name 'Lucas' 'di Grassi'
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (1, 'grassi_1', 'Lucas', 'di Grassi', 'http://en.wikipedia.org/wiki/Grassi_1');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (2, 'grassi_2', 'Lucas', 'di Grassi', 'http://en.wikipedia.org/wiki/Grassi_2');
-- Trap drivers: swapped forename/surname, driverRef='Lucas', prefix/suffix variations
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (3, 'swapped', 'di Grassi', 'Lucas', 'http://en.wikipedia.org/wiki/Swapped');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (4, 'Lucas', 'Pedro', 'di Grassi', 'http://en.wikipedia.org/wiki/RefTrap');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (5, 'prefix_trap', 'Lucas Jr', 'di Grassi', 'http://en.wikipedia.org/wiki/PrefixTrap');
-- Driver 1 has two entries with identical q1 (tests DISTINCT vs ALL) and Driver 2 has NULL q1 (tests IS NOT NULL mutants)
INSERT INTO qualifying (qualifyId, raceId, driverId, constructorId, number, position, q1, q2, q3) VALUES (1, 345, 1, 1, 25, 20, '1:25.000', '1:25.500', NULL);
INSERT INTO qualifying (qualifyId, raceId, driverId, constructorId, number, position, q1, q2, q3) VALUES (2, 345, 1, 1, 25, 21, '1:25.000', '1:26.000', NULL);
INSERT INTO qualifying (qualifyId, raceId, driverId, constructorId, number, position, q1, q2, q3) VALUES (3, 345, 2, 1, 26, 24, NULL, '1:27.000', '1:28.000');
-- Qualifying rows for trap drivers
INSERT INTO qualifying (qualifyId, raceId, driverId, constructorId, number, position, q1, q2, q3) VALUES (4, 345, 3, 1, 27, 22, '1:90.000', NULL, NULL);
INSERT INTO qualifying (qualifyId, raceId, driverId, constructorId, number, position, q1, q2, q3) VALUES (5, 345, 4, 1, 28, 23, '1:91.000', NULL, NULL);
INSERT INTO qualifying (qualifyId, raceId, driverId, constructorId, number, position, q1, q2, q3) VALUES (6, 345, 5, 1, 29, 19, '1:92.000', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.q1 FROM qualifying AS T1 INNER JOIN drivers AS T2 ON T2.driverId = T1.driverId WHERE T1.raceId = 345 AND T2.forename = 'Lucas' AND T2.surname = 'di Grassi';

/*
Gold Result:
('1:25.000',)
('1:25.000',)
(None,)
*/

-- Prediction Query
SELECT q1 FROM qualifying WHERE driverId = (SELECT driverId FROM drivers WHERE forename = 'Lucas' AND surname = 'di Grassi') AND raceId = 345;

/*
Prediction Result:
('1:25.000',)
('1:25.000',)
*/