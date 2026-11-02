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
-- Tests strict boundary years ('1990' and '2000') vs exclusive bounds (< '2000', > '1990')
-- Also tests discrepancy between T2.year and STRFTIME('%Y', T2.date).
INSERT INTO seasons (year, url) VALUES (1989, 'http://s.com/1989');
INSERT INTO seasons (year, url) VALUES (1990, 'http://s.com/1990');
INSERT INTO seasons (year, url) VALUES (1995, 'http://s.com/1995');
INSERT INTO seasons (year, url) VALUES (2000, 'http://s.com/2000');
INSERT INTO seasons (year, url) VALUES (2001, 'http://s.com/2001');
-- Circuit A: Relies on 1990 and 2000 being inclusive to reach 4 races.
INSERT INTO circuits (circuitId, circuitRef, name, url) VALUES (1, 'ca', 'Boundary Inclusive Circuit', 'http://c.com/1');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (1, 1990, 1, 1, 'R1', '1990-01-01', 'http://r.com/1');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (2, 1995, 1, 1, 'R2', '1995-06-01', 'http://r.com/2');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (3, 1995, 2, 1, 'R3', '1995-07-01', 'http://r.com/3');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (4, 2000, 1, 1, 'R4', '2000-12-31', 'http://r.com/4');
-- Circuit B: Has 4 races strictly inside (1991-1999), plus 1 in 1990 -> Total = 5 (NO MATCH, catches > '1990' mutant)
INSERT INTO circuits (circuitId, circuitRef, name, url) VALUES (2, 'cb', 'Lower Bound Trap Circuit', 'http://c.com/2');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (5, 1990, 2, 2, 'R5', '1990-05-01', 'http://r.com/5');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (6, 1995, 3, 2, 'R6', '1995-01-01', 'http://r.com/6');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (7, 1995, 4, 2, 'R7', '1995-02-01', 'http://r.com/7');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (8, 1995, 5, 2, 'R8', '1995-03-01', 'http://r.com/8');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (9, 1995, 6, 2, 'R9', '1995-04-01', 'http://r.com/9');
-- Circuit C: Has T2.year in 1995 (4 times), but T2.date is in 1989 -> STRFTIME('%Y', date) is '1989' (NO MATCH, catches T2.year BETWEEN 1990 AND 2000)
INSERT INTO circuits (circuitId, circuitRef, name, url) VALUES (3, 'cc', 'Date Vs Year Column Trap', 'http://c.com/3');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (10, 1995, 7, 3, 'R10', '1989-05-01', 'http://r.com/10');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (11, 1995, 8, 3, 'R11', '1989-06-01', 'http://r.com/11');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (12, 1995, 9, 3, 'R12', '1989-07-01', 'http://r.com/12');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (13, 1995, 10, 3, 'R13', '1989-08-01', 'http://r.com/13');
-- Circuit D: Has T2.year = 1989, but T2.date in '1995-xx-xx' (4 times) -> STRFTIME('%Y', date) is '1995' (MATCH, catches T2.year mutants)
INSERT INTO circuits (circuitId, circuitRef, name, url) VALUES (4, 'cd', 'Date Valid Year Invalid', 'http://c.com/4');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (14, 1989, 1, 4, 'R14', '1995-05-01', 'http://r.com/14');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (15, 1989, 2, 4, 'R15', '1995-06-01', 'http://r.com/15');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (16, 1989, 3, 4, 'R16', '1995-07-01', 'http://r.com/16');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (17, 1989, 4, 4, 'R17', '1995-08-01', 'http://r.com/17');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.name FROM circuits AS T1 INNER JOIN races AS T2 ON T2.circuitID = T1.circuitId WHERE STRFTIME('%Y', T2.date) BETWEEN '1990' AND '2000' GROUP BY T1.name HAVING COUNT(T2.raceId) = 4;

/*
Gold Result:
('Boundary Inclusive Circuit',)
('Date Valid Year Invalid',)
*/

-- Prediction Query
SELECT T2.name FROM races AS T1 INNER JOIN circuits AS T2 ON T1.circuitId = T2.circuitId WHERE T1.year BETWEEN 1990 AND 2000 GROUP BY T2.name HAVING COUNT(T2.name) = 4;

/*
Prediction Result:
('Boundary Inclusive Circuit',)
('Date Vs Year Column Trap',)
*/