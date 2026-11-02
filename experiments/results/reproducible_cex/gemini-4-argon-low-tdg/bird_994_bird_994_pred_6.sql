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
-- Tests basic aggregation, WHERE filters (race name, year boundaries 1980 and 2010), and traps queries using constructorStandings or results instead of constructorResults, or circuits.name instead of races.name.
INSERT INTO circuits (circuitId, circuitRef, name, url) VALUES (1, 'monaco', 'Circuit de Monaco', 'http://c1');
INSERT INTO circuits (circuitId, circuitRef, name, url) VALUES (2, 'fake_monaco', 'Monaco Grand Prix', 'http://c2');
INSERT INTO seasons (year, url) VALUES (1979, 'http://s1979');
INSERT INTO seasons (year, url) VALUES (1980, 'http://s1980');
INSERT INTO seasons (year, url) VALUES (1995, 'http://s1995');
INSERT INTO seasons (year, url) VALUES (2010, 'http://s2010');
INSERT INTO seasons (year, url) VALUES (2011, 'http://s2011');
INSERT INTO constructors (constructorId, constructorRef, name, nationality, url) VALUES (1, 'mclaren', 'McLaren', 'British', 'http://con1');
INSERT INTO constructors (constructorId, constructorRef, name, nationality, url) VALUES (2, 'ferrari', 'Ferrari', 'Italian', 'http://con2');
INSERT INTO constructors (constructorId, constructorRef, name, nationality, url) VALUES (3, 'williams', 'Williams', 'British', 'http://con3');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (1, 'senna', 'Ayrton', 'Senna', 'http://d1');
INSERT INTO status (statusId, status) VALUES (1, 'Finished');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (1, 1979, 1, 1, 'Monaco Grand Prix', '1979-05-27', 'http://r1');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (2, 1980, 1, 1, 'Monaco Grand Prix', '1980-05-18', 'http://r2');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (3, 1995, 1, 1, 'Monaco Grand Prix', '1995-05-28', 'http://r3');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (4, 2010, 1, 1, 'Monaco Grand Prix', '2010-05-16', 'http://r4');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (5, 2011, 1, 1, 'Monaco Grand Prix', '2011-05-29', 'http://r5');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (6, 1995, 2, 2, 'French Grand Prix', '1995-07-02', 'http://r6');
-- McLaren: 10 (1980) + 10 (1995) + 10 (2010) = 30 valid points. (Plus 100 in 1979 and 100 in 2011 which must be excluded).
INSERT INTO constructorResults (constructorResultsId, raceId, constructorId, points) VALUES (1, 1, 1, 100.0);
INSERT INTO constructorResults (constructorResultsId, raceId, constructorId, points) VALUES (2, 2, 1, 10.0);
INSERT INTO constructorResults (constructorResultsId, raceId, constructorId, points) VALUES (3, 3, 1, 10.0);
INSERT INTO constructorResults (constructorResultsId, raceId, constructorId, points) VALUES (4, 4, 1, 10.0);
INSERT INTO constructorResults (constructorResultsId, raceId, constructorId, points) VALUES (5, 5, 1, 100.0);
-- Ferrari: 25 in 1995 Monaco = 25 valid points. Plus 100 in 1995 French GP (where circuit name is 'Monaco Grand Prix').
INSERT INTO constructorResults (constructorResultsId, raceId, constructorId, points) VALUES (6, 3, 2, 25.0);
INSERT INTO constructorResults (constructorResultsId, raceId, constructorId, points) VALUES (7, 6, 2, 100.0);
-- Williams: 15 + 12 in 1995 Monaco = 27 valid points (tests SUM vs MAX/AVG/COUNT).
INSERT INTO constructorResults (constructorResultsId, raceId, constructorId, points) VALUES (8, 3, 3, 15.0);
INSERT INTO constructorResults (constructorResultsId, raceId, constructorId, points) VALUES (9, 3, 3, 12.0);
-- Decoys in constructorStandings and results for Ferrari
INSERT INTO constructorStandings (constructorStandingsId, raceId, constructorId, points, wins) VALUES (1, 3, 2, 500.0, 10);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionText, positionOrder, points, laps, statusId) VALUES (1, 3, 1, 2, 1, '1', 1, 500.0, 78, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(T1.points), T2.name, T2.nationality FROM constructorResults AS T1 INNER JOIN constructors AS T2 ON T1.constructorId = T2.constructorId INNER JOIN races AS T3 ON T3.raceid = T1.raceid WHERE T3.name = 'Monaco Grand Prix' AND T3.year BETWEEN 1980 AND 2010 GROUP BY T2.name ORDER BY SUM(T1.points) DESC, T2.name NULLS LAST, T2.nationality NULLS LAST LIMIT 1;

/*
Gold Result:
(30.0, 'McLaren', 'British')
*/

-- Prediction Query
SELECT cs.points, c.name, c.nationality FROM races AS r INNER JOIN constructorStandings AS cs ON r.raceId = cs.raceId INNER JOIN constructors AS c ON cs.constructorId = c.constructorId WHERE r.name = 'Monaco Grand Prix' AND r.year BETWEEN 1980 AND 2010 ORDER BY cs.points DESC, r.raceid NULLS LAST, cs.constructorstandingsid NULLS LAST, c.constructorid NULLS LAST LIMIT 1;

/*
Prediction Result:
(500.0, 'Ferrari', 'Italian')
*/