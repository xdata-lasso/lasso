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
-- Core logic, DISTINCT check, and basic boundary conditions for year and month
INSERT INTO seasons (year, url) VALUES (2004, 'http://example.com/2004');
INSERT INTO seasons (year, url) VALUES (2005, 'http://example.com/2005');
INSERT INTO seasons (year, url) VALUES (2006, 'http://example.com/2006');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, url) VALUES (1, 'monza', 'Autodromo Nazionale di Monza', 'Monza', 'Italy', 'http://example.com/monza');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, url) VALUES (2, 'spa', 'Circuit de Spa-Francorchamps', 'Spa', 'Belgium', 'http://example.com/spa');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, url) VALUES (3, 'interlagos', 'Autodromo Jose Carlos Pace', 'Sao Paulo', 'Brazil', 'http://example.com/interlagos');
-- Exact match: Year 2005, Month 09
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (101, 2005, 15, 1, 'Italian Grand Prix', '2005-09-04', 'http://example.com/r101');
-- Duplicate output row to test DISTINCT (same circuit, same race name, same year and month, different day)
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (102, 2005, 16, 1, 'Italian Grand Prix', '2005-09-11', 'http://example.com/r102');
-- Boundary fail: Year 2004, Month 09
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (103, 2004, 15, 2, 'Belgian Grand Prix', '2004-09-05', 'http://example.com/r103');
-- Boundary fail: Year 2006, Month 09
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (104, 2006, 15, 2, 'Belgian Grand Prix', '2006-09-10', 'http://example.com/r104');
-- Boundary fail: Year 2005, Month 08 (End of August)
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (105, 2005, 14, 3, 'Brazilian Grand Prix', '2005-08-31', 'http://example.com/r105');
-- Boundary fail: Year 2005, Month 10 (Start of October)
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (106, 2005, 17, 3, 'Brazilian Grand Prix', '2005-10-01', 'http://example.com/r106');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.name, T1.name, T1.location FROM circuits AS T1 INNER JOIN races AS T2 ON T2.circuitID = T1.circuitId WHERE T2.year = 2005 AND STRFTIME('%m', T2.date) = '09';

/*
Gold Result:
('Italian Grand Prix', 'Autodromo Nazionale di Monza', 'Monza')
*/

-- Prediction Query
SELECT races.name AS race_name, circuits.name AS circuit_name, circuits.location AS circuit_location FROM races INNER JOIN circuits ON races.circuitid = circuits.circuitid WHERE STRFTIME('%Y-%m', races.date) = '2005-09';

/*
Prediction Result:
('Italian Grand Prix', 'Autodromo Nazionale di Monza', 'Monza')
('Italian Grand Prix', 'Autodromo Nazionale di Monza', 'Monza')
*/