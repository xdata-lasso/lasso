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
INSERT INTO seasons (year, url) VALUES (2004, 'http://en.wikipedia.org/wiki/2004_Formula_One_season');
INSERT INTO seasons (year, url) VALUES (2005, 'http://en.wikipedia.org/wiki/2005_Formula_One_season');
INSERT INTO seasons (year, url) VALUES (2006, 'http://en.wikipedia.org/wiki/2006_Formula_One_season');
INSERT INTO seasons (year, url) VALUES (2007, 'http://en.wikipedia.org/wiki/2007_Formula_One_season');
INSERT INTO seasons (year, url) VALUES (2008, 'http://en.wikipedia.org/wiki/2008_Formula_One_season');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, url) VALUES (1, 'shanghai_1', 'Shanghai International Circuit', 'Shanghai', 'China', 'http://url1.com');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, url) VALUES (2, 'shanghai_2', 'Shanghai Street Circuit', 'Shanghai', 'China', 'http://url2.com');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, url) VALUES (3, 'shanghai', 'Fake Shanghai', 'Beijing', 'Shanghai', 'http://url3.com');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, url) VALUES (4, 'other_ref', 'Shanghai', 'Tokyo', 'Japan', 'http://url4.com');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, url) VALUES (5, 'null_loc', 'Null Circuit', NULL, 'China', 'http://url5.com');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, url) VALUES (6, 'sub_loc', 'Sub Circuit', 'Shanghai District', 'China', 'http://url6.com');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, url) VALUES (7, 'case_loc', 'Case Circuit', 'shanghai', 'China', 'http://url7.com');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (10, 2004, 1, 1, 'Chinese GP 1', '2004-09-26', 'http://r1.com');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (11, 2004, 2, 1, 'Chinese GP 2', '2004-10-26', 'http://r2.com');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (12, 2005, 1, 1, 'Chinese GP 3', '2005-10-16', 'http://r3.com');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (13, 2006, 1, 3, 'Beijing GP', '2006-10-01', 'http://r4.com');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (14, 2007, 1, 4, 'Tokyo GP', '2007-10-07', 'http://r5.com');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (15, 2008, 1, 5, 'Null GP', '2008-10-19', 'http://r6.com');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (16, 2008, 2, 6, 'District GP', '2008-11-19', 'http://r7.com');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (17, 2008, 3, 7, 'Case GP', '2008-12-19', 'http://r8.com');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.year FROM circuits AS T1 INNER JOIN races AS T2 ON T2.circuitID = T1.circuitId WHERE T1.location = 'Shanghai';

/*
Gold Result:
(2004,)
(2004,)
(2005,)
*/

-- Prediction Query
SELECT DISTINCT r.year FROM races AS r JOIN circuits AS c ON r.circuitId = c.circuitId WHERE c.location = 'Shanghai';

/*
Prediction Result:
(2004,)
(2005,)
*/