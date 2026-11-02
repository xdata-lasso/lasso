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
INSERT INTO seasons (year, url) VALUES (1988, 'http://en.wikipedia.org/wiki/1988_Formula_One_season');
INSERT INTO seasons (year, url) VALUES (1992, 'http://en.wikipedia.org/wiki/1992_Formula_One_season');
INSERT INTO seasons (year, url) VALUES (1996, 'http://en.wikipedia.org/wiki/1996_Formula_One_season');
INSERT INTO seasons (year, url) VALUES (2002, 'http://en.wikipedia.org/wiki/2002_Formula_One_season');
-- Two distinct circuitIds sharing the same circuit name (tests GROUP BY T1.name vs GROUP BY T1.circuitId and SELECT DISTINCT)
INSERT INTO circuits (circuitId, circuitRef, name, url) VALUES (10, 'shared_a', 'Shared Circuit Name', 'http://url10.com');
INSERT INTO circuits (circuitId, circuitRef, name, url) VALUES (11, 'shared_b', 'Shared Circuit Name', 'http://url11.com');
-- Two distinct circuitIds sharing another name, where each has 4 races (total 8 for the name)
INSERT INTO circuits (circuitId, circuitRef, name, url) VALUES (12, 'dup_a', 'Duplicate Four Circuit', 'http://url12.com');
INSERT INTO circuits (circuitId, circuitRef, name, url) VALUES (13, 'dup_b', 'Duplicate Four Circuit', 'http://url13.com');
-- Circuit where T2.year differs from STRFTIME('%Y', T2.date) (tests T2.year vs STRFTIME('%Y', T2.date))
INSERT INTO circuits (circuitId, circuitRef, name, url) VALUES (14, 'year_mismatch_1', 'Circuit Date In Year Out', 'http://url14.com');
INSERT INTO circuits (circuitId, circuitRef, name, url) VALUES (15, 'year_mismatch_2', 'Circuit Year In Date Out', 'http://url15.com');
-- Circuit with races sharing the same race name (tests COUNT(T2.raceId) vs COUNT(DISTINCT T2.name))
INSERT INTO circuits (circuitId, circuitRef, name, url) VALUES (16, 'same_race_name', 'Circuit Same Race Names', 'http://url16.com');
-- Shared Circuit Name: 2 races on circuit 10, 2 races on circuit 11 -> total 4 when grouped by T1.name
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (1001, 1992, 1, 10, 'GP 1', '1992-03-01', 'http://r1001.com');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (1002, 1992, 2, 10, 'GP 2', '1992-04-01', 'http://r1002.com');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (1003, 1996, 1, 11, 'GP 3', '1996-03-01', 'http://r1003.com');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (1004, 1996, 2, 11, 'GP 4', '1996-04-01', 'http://r1004.com');
-- Duplicate Four Circuit: 4 races on circuit 12, 4 races on circuit 13 -> 8 when grouped by T1.name, 4 if grouped by circuitId
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (1201, 1992, 1, 12, 'GP A1', '1992-05-01', 'http://r1201.com');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (1202, 1992, 2, 12, 'GP A2', '1992-06-01', 'http://r1202.com');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (1203, 1996, 1, 12, 'GP A3', '1996-05-01', 'http://r1203.com');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (1204, 1996, 2, 12, 'GP A4', '1996-06-01', 'http://r1204.com');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (1301, 1992, 3, 13, 'GP B1', '1992-07-01', 'http://r1301.com');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (1302, 1992, 4, 13, 'GP B2', '1992-08-01', 'http://r1302.com');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (1303, 1996, 3, 13, 'GP B3', '1996-07-01', 'http://r1303.com');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (1304, 1996, 4, 13, 'GP B4', '1996-08-01', 'http://r1304.com');
-- Circuit 14: T2.date is in 1990-2000, but T2.year is 1988/2002
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (1401, 1988, 1, 14, 'Mismatch 1', '1991-05-01', 'http://r1401.com');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (1402, 1988, 2, 14, 'Mismatch 2', '1993-05-01', 'http://r1402.com');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (1403, 2002, 1, 14, 'Mismatch 3', '1997-05-01', 'http://r1403.com');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (1404, 2002, 2, 14, 'Mismatch 4', '1999-05-01', 'http://r1404.com');
-- Circuit 15: T2.year is in 1990-2000 (1992, 1996), but T2.date is in 1988/2002
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (1501, 1992, 1, 15, 'Mismatch 5', '1988-05-01', 'http://r1501.com');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (1502, 1992, 2, 15, 'Mismatch 6', '1988-06-01', 'http://r1502.com');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (1503, 1996, 1, 15, 'Mismatch 7', '2002-05-01', 'http://r1503.com');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (1504, 1996, 2, 15, 'Mismatch 8', '2002-06-01', 'http://r1504.com');
-- Circuit 16: 4 races in range, all with the exact same T2.name and same T2.year
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (1601, 1992, 1, 16, 'Identical GP', '1992-01-10', 'http://r1601.com');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (1602, 1992, 1, 16, 'Identical GP', '1992-02-10', 'http://r1602.com');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (1603, 1992, 1, 16, 'Identical GP', '1992-03-10', 'http://r1603.com');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (1604, 1992, 1, 16, 'Identical GP', '1992-04-10', 'http://r1604.com');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.name FROM circuits AS T1 INNER JOIN races AS T2 ON T2.circuitID = T1.circuitId WHERE STRFTIME('%Y', T2.date) BETWEEN '1990' AND '2000' GROUP BY T1.name HAVING COUNT(T2.raceId) = 4;

/*
Gold Result:
('Circuit Date In Year Out',)
('Circuit Same Race Names',)
('Shared Circuit Name',)
*/

-- Prediction Query
SELECT c.name FROM circuits AS c JOIN races AS r ON c.circuitId = r.circuitId WHERE r.year BETWEEN 1990 AND 2000 GROUP BY c.circuitId HAVING COUNT(r.raceId) = 4;

/*
Prediction Result:
('Duplicate Four Circuit',)
('Duplicate Four Circuit',)
('Circuit Year In Date Out',)
('Circuit Same Race Names',)
*/