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
-- Tests GROUP BY T1.name vs GROUP BY T1.circuitId (two circuits sharing the exact same name)
-- Also tests T1.name vs T2.name (race name vs circuit name).
INSERT INTO seasons (year, url) VALUES (1992, 'http://s.com/1992');
INSERT INTO seasons (year, url) VALUES (1996, 'http://s.com/1996');
-- Two distinct circuits with the SAME name, each having 2 races in range -> Combined by T1.name = 4 (MATCH)
INSERT INTO circuits (circuitId, circuitRef, name, url) VALUES (10, 'ref_a', 'Shared Circuit Name', 'http://c.com/10');
INSERT INTO circuits (circuitId, circuitRef, name, url) VALUES (20, 'ref_b', 'Shared Circuit Name', 'http://c.com/20');
-- Two distinct circuits with the SAME name, each having 4 races in range -> Combined by T1.name = 8 (NO MATCH, catches GROUP BY circuitId)
INSERT INTO circuits (circuitId, circuitRef, name, url) VALUES (30, 'ref_c', 'Overloaded Circuit Name', 'http://c.com/30');
INSERT INTO circuits (circuitId, circuitRef, name, url) VALUES (40, 'ref_d', 'Overloaded Circuit Name', 'http://c.com/40');
-- Races for circuit 10 and 20 (2 + 2 = 4)
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (1, 1992, 1, 10, 'GP Alpha', '1992-03-01', 'http://r.com/1');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (2, 1996, 1, 10, 'GP Alpha', '1996-03-01', 'http://r.com/2');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (3, 1992, 2, 20, 'GPAlpha2', '1992-04-01', 'http://r.com/3');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (4, 1996, 2, 20, 'GPAlpha2', '1996-04-01', 'http://r.com/4');
-- Races for circuit 30 and 40 (4 + 4 = 8)
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (5, 1992, 3, 30, 'Same Race Name', '1992-05-01', 'http://r.com/5');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (6, 1992, 4, 30, 'Same Race Name', '1992-06-01', 'http://r.com/6');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (7, 1996, 3, 30, 'Same Race Name', '1996-05-01', 'http://r.com/7');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (8, 1996, 4, 30, 'Same Race Name', '1996-06-01', 'http://r.com/8');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (9, 1992, 5, 40, 'Diff Race Name 1', '1992-07-01', 'http://r.com/9');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (10, 1992, 6, 40, 'Diff Race Name 2', '1992-08-01', 'http://r.com/10');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (11, 1996, 5, 40, 'Diff Race Name 3', '1996-07-01', 'http://r.com/11');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (12, 1996, 6, 40, 'Diff Race Name 4', '1996-08-01', 'http://r.com/12');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.name FROM circuits AS T1 INNER JOIN races AS T2 ON T2.circuitID = T1.circuitId WHERE STRFTIME('%Y', T2.date) BETWEEN '1990' AND '2000' GROUP BY T1.name HAVING COUNT(T2.raceId) = 4;

/*
Gold Result:
('Shared Circuit Name',)
*/

-- Prediction Query
SELECT T1.name FROM circuits AS T1 INNER JOIN races AS T2 ON T1.circuitId = T2.circuitId WHERE T2.year BETWEEN 1990 AND 2000 GROUP BY T1.circuitId HAVING COUNT(T2.raceId) = 4;

/*
Prediction Result:
('Overloaded Circuit Name',)
('Overloaded Circuit Name',)
*/