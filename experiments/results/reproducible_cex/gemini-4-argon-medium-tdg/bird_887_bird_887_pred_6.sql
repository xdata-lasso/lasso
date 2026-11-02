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
INSERT INTO seasons (year, url) VALUES (1999, 'http://en.wikipedia.org/wiki/1999_Formula_One_season');
INSERT INTO seasons (year, url) VALUES (2000, 'http://en.wikipedia.org/wiki/2000_Formula_One_season');
INSERT INTO seasons (year, url) VALUES (2001, 'http://en.wikipedia.org/wiki/2001_Formula_One_season');
INSERT INTO seasons (year, url) VALUES (2016, 'http://en.wikipedia.org/wiki/2016_Formula_One_season');
INSERT INTO seasons (year, url) VALUES (2017, 'http://en.wikipedia.org/wiki/2017_Formula_One_season');
INSERT INTO seasons (year, url) VALUES (2018, 'http://en.wikipedia.org/wiki/2018_Formula_One_season');
INSERT INTO circuits (circuitId, circuitRef, name, url) VALUES (1, 'baku', 'Baku City Circuit', 'http://en.wikipedia.org/wiki/Baku_City_Circuit');
INSERT INTO circuits (circuitId, circuitRef, name, url) VALUES (2, 'monza', 'Autodromo Nazionale di Monza', 'http://en.wikipedia.org/wiki/Autodromo_Nazionale_Monza');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (1, 2017, 1, 1, 'Azerbaijan Grand Prix', '2017-06-25', 'http://example.com/race1');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (2, 2017, 2, 2, 'Azerbaijan Grand Prix', '2017-06-26', 'http://example.com/race2');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (3, 2017, 3, 2, 'Italian Grand Prix', '2017-09-03', 'http://example.com/race3');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (4, 2000, 1, 1, 'Italian Grand Prix', '2000-09-10', 'http://example.com/race4');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (5, 2000, 2, 2, 'San Marino Grand Prix', '2000-04-09', 'http://example.com/race5');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (6, 2016, 1, 1, 'Russian Grand Prix', '2016-05-01', 'http://example.com/race6');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (7, 2018, 1, 1, 'French Grand Prix', '2018-06-24', 'http://example.com/race7');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (8, 1999, 1, 1, 'Azerbaijan Grand Prix', '1999-06-25', 'http://example.com/race8');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (9, 2001, 1, 1, 'Azerbaijan Grand Prix', '2001-06-25', 'http://example.com/race9');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM races WHERE year = 2017 AND NOT name IN (SELECT name FROM races WHERE year = 2000);

/*
Gold Result:
('Azerbaijan Grand Prix',)
('Azerbaijan Grand Prix',)
*/

-- Prediction Query
SELECT name FROM races WHERE year = 2017 EXCEPT SELECT name FROM races WHERE year = 2000;

/*
Prediction Result:
('Azerbaijan Grand Prix',)
*/