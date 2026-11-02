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
INSERT INTO seasons (year, url) VALUES (2005, 'http://example.com/s/2005');
INSERT INTO seasons (year, url) VALUES (2006, 'http://example.com/s/2006');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, url) VALUES (1, 'dallas', 'Fair Park', 'Dallas', 'USA', 'http://example.com/c/1');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, url) VALUES (2, 'fake_usa_loc', 'Border Circuit', 'USA', 'Canada', 'http://example.com/c/2');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, url) VALUES (3, 'detroit', 'Detroit Street Circuit', 'Detroit', 'US', 'http://example.com/c/3');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, url) VALUES (4, 'long_beach', 'Long Beach', 'California', 'USA-West', 'http://example.com/c/4');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, url) VALUES (5, 'vegas', 'Caesars Palace', 'Las Vegas', 'usa', 'http://example.com/c/5');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (10, 2006, 1, 1, 'Dallas Grand Prix', '0000-00-00', 'http://example.com/r/10');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (11, 2005, 19, 1, 'Delayed Dallas GP', '2006-01-15', 'http://example.com/r/11');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (12, 2006, 2, 2, 'Canadian Border GP', '2006-06-25', 'http://example.com/r/12');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (13, 2006, 3, 3, 'Detroit Grand Prix', '2006-07-09', 'http://example.com/r/13');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (14, 2006, 4, 4, 'US West Grand Prix', '2006-07-16', 'http://example.com/r/14');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (15, 2006, 5, 5, 'Las Vegas Grand Prix', '2006-07-23', 'http://example.com/r/15');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.name, T1.location, T2.name FROM circuits AS T1 INNER JOIN races AS T2 ON T2.circuitID = T1.circuitId WHERE T1.country = 'USA' AND T2.year = 2006;

/*
Gold Result:
('Fair Park', 'Dallas', 'Dallas Grand Prix')
*/

-- Prediction Query
SELECT "circuits"."name", "circuits"."location", "races"."name" FROM "circuits" INNER JOIN "races" ON "circuits"."circuitId" = "races"."circuitId" WHERE "circuits"."country" = 'USA' AND STRFTIME('%Y', "races"."date") = '2006';

/*
Prediction Result:
('Fair Park', 'Dallas', 'Delayed Dallas GP')
*/