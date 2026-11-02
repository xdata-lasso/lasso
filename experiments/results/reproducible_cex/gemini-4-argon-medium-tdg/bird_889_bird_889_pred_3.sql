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
-- Tests basic filtering (T1.name, T2.name), JOIN condition, LIMIT 1, and ORDER BY T2.year DESC vs ASC or ORDER BY T2.date DESC.
-- Notice how the row with max year (1986) has an alphabetically smaller date ('1985-12-31' for testing purposes) than an older year row (1984 with '1986-07-13'), catching mutants that order by date instead of year, or order by year ASC.
-- Also includes decoy rows that fail T1.name, T2.name, or JOIN conditions, but have a higher year (1990).
INSERT INTO seasons (year, url) VALUES (1982, 'http://example.com/s1982');
INSERT INTO seasons (year, url) VALUES (1984, 'http://example.com/s1984');
INSERT INTO seasons (year, url) VALUES (1986, 'http://example.com/s1986');
INSERT INTO seasons (year, url) VALUES (1990, 'http://example.com/s1990');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, url) VALUES (1, 'brands_hatch', 'Brands Hatch', 'Kent', 'UK', 'http://example.com/c1');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, url) VALUES (2, 'silverstone', 'Silverstone Circuit', 'Northamptonshire', 'UK', 'http://example.com/c2');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, url) VALUES (3, 'monza', 'Brands Hatch Extra', 'Kent', 'UK', 'http://example.com/c3');
-- Valid matching rows with distinct years and inverted dates/raceIds to test ORDER BY year DESC vs date DESC / raceId DESC / year ASC
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (10, 1986, 9, 1, 'British Grand Prix', '1980-01-01', 'http://example.com/r10');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (20, 1984, 10, 1, 'British Grand Prix', '1999-12-31', 'http://example.com/r20');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (30, 1982, 8, 1, 'British Grand Prix', '1985-05-05', 'http://example.com/r30');
-- Decoys: Wrong circuit name (Silverstone) but higher year (1990) and right race name
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (40, 1990, 8, 2, 'British Grand Prix', '1990-07-15', 'http://example.com/r40');
-- Decoys: Right circuit (Brands Hatch), higher year (1990), wrong race name ('European Grand Prix')
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (50, 1990, 11, 1, 'European Grand Prix', '1990-10-07', 'http://example.com/r50');
-- Decoys: Substring match trap on circuit name and race name
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (60, 1990, 12, 3, 'British Grand Prix 2', '1990-11-11', 'http://example.com/r60');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.date FROM circuits AS T1 INNER JOIN races AS T2 ON T2.circuitID = T1.circuitId WHERE T1.name = 'Brands Hatch' AND T2.name = 'British Grand Prix' ORDER BY T2.year DESC, T1.circuitid NULLS LAST, T2.raceid NULLS LAST LIMIT 1;

/*
Gold Result:
('1980-01-01',)
*/

-- Prediction Query
SELECT T1.year FROM races AS T1 INNER JOIN circuits AS T2 ON T1.circuitId = T2.circuitId WHERE T1.name = 'British Grand Prix' AND T2.name = 'Brands Hatch' ORDER BY T1.year DESC, T1.raceid NULLS LAST, T2.circuitid NULLS LAST LIMIT 1;

/*
Prediction Result:
(1986,)
*/