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
-- Tests: First half of the excluded country list ('Bahrain', 'China', 'Singapore', 'Japan', 'Korea', 'Turkey', 'UAE', 'Malaysia', 'Spain') in year 2010, plus one valid country ('Argentina') to verify exact filtering of the IN list.
INSERT INTO seasons (year, url) VALUES (2010, 'http://en.wikipedia.org/wiki/2010_Formula_One_season');
INSERT INTO circuits (circuitId, circuitRef, name, country, url) VALUES (1, 'c_bahrain', 'Bahrain Circuit', 'Bahrain', 'http://example.com/c1');
INSERT INTO circuits (circuitId, circuitRef, name, country, url) VALUES (2, 'c_china', 'China Circuit', 'China', 'http://example.com/c2');
INSERT INTO circuits (circuitId, circuitRef, name, country, url) VALUES (3, 'c_singapore', 'Singapore Circuit', 'Singapore', 'http://example.com/c3');
INSERT INTO circuits (circuitId, circuitRef, name, country, url) VALUES (4, 'c_japan', 'Japan Circuit', 'Japan', 'http://example.com/c4');
INSERT INTO circuits (circuitId, circuitRef, name, country, url) VALUES (5, 'c_korea', 'Korea Circuit', 'Korea', 'http://example.com/c5');
INSERT INTO circuits (circuitId, circuitRef, name, country, url) VALUES (6, 'c_turkey', 'Turkey Circuit', 'Turkey', 'http://example.com/c6');
INSERT INTO circuits (circuitId, circuitRef, name, country, url) VALUES (7, 'c_uae', 'UAE Circuit', 'UAE', 'http://example.com/c7');
INSERT INTO circuits (circuitId, circuitRef, name, country, url) VALUES (8, 'c_malaysia', 'Malaysia Circuit', 'Malaysia', 'http://example.com/c8');
INSERT INTO circuits (circuitId, circuitRef, name, country, url) VALUES (9, 'c_spain', 'Spain Circuit', 'Spain', 'http://example.com/c9');
INSERT INTO circuits (circuitId, circuitRef, name, country, url) VALUES (10, 'c_argentina', 'Argentina Circuit', 'Argentina', 'http://example.com/c10');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (1, 2010, 1, 1, 'R1', '2010-03-01', 'http://example.com/r1');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (2, 2010, 2, 2, 'R2', '2010-03-08', 'http://example.com/r2');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (3, 2010, 3, 3, 'R3', '2010-03-15', 'http://example.com/r3');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (4, 2010, 4, 4, 'R4', '2010-03-22', 'http://example.com/r4');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (5, 2010, 5, 5, 'R5', '2010-03-29', 'http://example.com/r5');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (6, 2010, 6, 6, 'R6', '2010-04-05', 'http://example.com/r6');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (7, 2010, 7, 7, 'R7', '2010-04-12', 'http://example.com/r7');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (8, 2010, 8, 8, 'R8', '2010-04-19', 'http://example.com/r8');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (9, 2010, 9, 9, 'R9', '2010-04-26', 'http://example.com/r9');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (10, 2010, 10, 10, 'R10', '2010-05-03', 'http://example.com/r10');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T3.raceId) FROM circuits AS T1 INNER JOIN races AS T3 ON T3.circuitID = T1.circuitId WHERE NOT T1.country IN ('Bahrain', 'China', 'Singapore', 'Japan', 'Korea', 'Turkey', 'UAE', 'Malaysia', 'Spain', 'Monaco', 'Azerbaijan', 'Austria', 'Belgium', 'France', 'Germany', 'Hungary', 'Italy', 'UK') AND T3.year = 2010;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM races AS r INNER JOIN circuits AS c ON r.circuitId = c.circuitId WHERE r.year = 2010 AND c.lat <> 0 AND (c.country <> 'Asia' AND c.country <> 'Europe');

/*
Prediction Result:
(0,)
*/