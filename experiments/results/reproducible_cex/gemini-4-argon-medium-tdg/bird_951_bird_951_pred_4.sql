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
-- Tests basic matching, HAVING boundary conditions (< 2, = 2, > 2), WHERE vs HAVING filtering (points != 0), nationality filtering, and multiple matching groups vs no GROUP BY.
INSERT INTO circuits (circuitId, circuitRef, name, url) VALUES (1, 'suzuka', 'Suzuka', 'http://suzuka');
INSERT INTO seasons (year, url) VALUES (2020, 'http://2020');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (1, 2020, 1, 1, 'R1', '2020-01-01', 'http://r1');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (2, 2020, 2, 1, 'R2', '2020-01-08', 'http://r2');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (3, 2020, 3, 1, 'R3', '2020-01-15', 'http://r3');
INSERT INTO constructors (constructorId, constructorRef, name, nationality, url) VALUES (1, 'c1', 'Honda', 'Japanese', 'http://c1');
INSERT INTO constructors (constructorId, constructorRef, name, nationality, url) VALUES (2, 'c2', 'Toyota', 'Japanese', 'http://c2');
INSERT INTO constructors (constructorId, constructorRef, name, nationality, url) VALUES (3, 'c3', 'SuperAguri', 'Japanese', 'http://c3');
INSERT INTO constructors (constructorId, constructorRef, name, nationality, url) VALUES (4, 'c4', 'Kojima', 'Japanese', 'http://c4');
INSERT INTO constructors (constructorId, constructorRef, name, nationality, url) VALUES (5, 'c5', 'Maki', 'Japanese', 'http://c5');
INSERT INTO constructors (constructorId, constructorRef, name, nationality, url) VALUES (6, 'c6', 'Ferrari', 'Italian', 'http://c6');
-- Constructor 1: Japanese, 2 races with 0 points, 1 race with 5 points (Matches: count = 2)
INSERT INTO constructorStandings (constructorStandingsId, raceId, constructorId, points, position, wins) VALUES (1, 1, 1, 0, 10, 0);
INSERT INTO constructorStandings (constructorStandingsId, raceId, constructorId, points, position, wins) VALUES (2, 2, 1, 0, 9, 0);
INSERT INTO constructorStandings (constructorStandingsId, raceId, constructorId, points, position, wins) VALUES (3, 3, 1, 5, 5, 0);
-- Constructor 2: Japanese, 2 races with 0 points (Matches: count = 2, tests multiple output rows)
INSERT INTO constructorStandings (constructorStandingsId, raceId, constructorId, points, position, wins) VALUES (4, 1, 2, 0, 11, 0);
INSERT INTO constructorStandings (constructorStandingsId, raceId, constructorId, points, position, wins) VALUES (5, 2, 2, 0, 12, 0);
-- Constructor 3: Japanese, 1 race with 0 points, 1 race with 10 points (Fails HAVING: 0-point count = 1, total count = 2)
INSERT INTO constructorStandings (constructorStandingsId, raceId, constructorId, points, position, wins) VALUES (6, 1, 3, 0, 13, 0);
INSERT INTO constructorStandings (constructorStandingsId, raceId, constructorId, points, position, wins) VALUES (7, 2, 3, 10, 2, 0);
-- Constructor 4: Japanese, 3 races with 0 points (Fails HAVING: count = 3)
INSERT INTO constructorStandings (constructorStandingsId, raceId, constructorId, points, position, wins) VALUES (8, 1, 4, 0, 14, 0);
INSERT INTO constructorStandings (constructorStandingsId, raceId, constructorId, points, position, wins) VALUES (9, 2, 4, 0, 14, 0);
INSERT INTO constructorStandings (constructorStandingsId, raceId, constructorId, points, position, wins) VALUES (10, 3, 4, 0, 14, 0);
-- Constructor 5: Japanese, 1 race with 0 points (Fails HAVING: count = 1)
INSERT INTO constructorStandings (constructorStandingsId, raceId, constructorId, points, position, wins) VALUES (11, 1, 5, 0, 15, 0);
-- Constructor 6: Italian, 2 races with 0 points (Fails WHERE nationality)
INSERT INTO constructorStandings (constructorStandingsId, raceId, constructorId, points, position, wins) VALUES (12, 1, 6, 0, 16, 0);
INSERT INTO constructorStandings (constructorStandingsId, raceId, constructorId, points, position, wins) VALUES (13, 2, 6, 0, 16, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.raceId) FROM constructorStandings AS T1 INNER JOIN constructors AS T2 ON T1.constructorId = T2.constructorId WHERE T1.points = 0 AND T2.nationality = 'Japanese' GROUP BY T1.constructorId HAVING COUNT(raceId) = 2;

/*
Gold Result:
(2,)
(2,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT cr.constructorId) FROM constructorResults AS cr JOIN constructors AS c ON cr.constructorId = c.constructorId WHERE c.nationality = 'Japanese' AND cr.points = 0 GROUP BY cr.constructorId HAVING COUNT(DISTINCT cr.raceId) = 2;

/*
Prediction Result:
*/