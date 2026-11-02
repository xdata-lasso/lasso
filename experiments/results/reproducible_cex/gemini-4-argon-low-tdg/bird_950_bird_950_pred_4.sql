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
-- Core predicate, column confusion, and table confusion tests (constructorStandings vs constructorResults vs results)
INSERT INTO circuits (circuitId, circuitRef, name, url) VALUES (1, 'monza', 'Monza', 'http://url1');
INSERT INTO seasons (year, url) VALUES (2008, 'http://s2008');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (290, 2008, 1, 1, 'Race 290', '2008-03-16', 'http://r290');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (291, 2008, 2, 1, 'Race 291', '2008-03-23', 'http://r291');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (292, 2008, 3, 1, 'Race 292', '2008-04-06', 'http://r292');
INSERT INTO constructors (constructorId, constructorRef, name, nationality, url) VALUES (1, 'ref_target_1', 'Target Constructor 1', 'British', 'http://c1');
INSERT INTO constructors (constructorId, constructorRef, name, nationality, url) VALUES (2, 'ref_wrong_pts_pos', 'Wrong Points Pos', 'Italian', 'http://c2');
INSERT INTO constructors (constructorId, constructorRef, name, nationality, url) VALUES (3, 'ref_wrong_pts_neg', 'Wrong Points Neg', 'German', 'http://c3');
INSERT INTO constructors (constructorId, constructorRef, name, nationality, url) VALUES (4, 'ref_wrong_race_low', 'Wrong Race 290', 'French', 'http://c4');
INSERT INTO constructors (constructorId, constructorRef, name, nationality, url) VALUES (5, 'ref_wrong_race_high', 'Wrong Race 292', 'Spanish', 'http://c5');
INSERT INTO constructors (constructorId, constructorRef, name, nationality, url) VALUES (6, 'ref_only_results', 'Only In ConstructorResults', 'Japanese', 'http://c6');
INSERT INTO constructors (constructorId, constructorRef, name, nationality, url) VALUES (7, 'ref_no_standings', 'Unreferenced Constructor', 'American', 'http://c7');
INSERT INTO constructors (constructorId, constructorRef, name, nationality, url) VALUES (291, 'ref_id_291', 'Constructor With ID 291', 'Swiss', 'http://c291');
-- Exact match: raceId = 291, points = 0 (with non-zero wins and position to catch column swaps like wins = 0 or position = 0)
INSERT INTO constructorStandings (constructorStandingsId, raceId, constructorId, points, position, positionText, wins) VALUES (10, 291, 1, 0, 5, '5', 2);
-- Wrong points (> 0), but wins = 0 and position = 0 to kill mutants checking wins=0 or position=0
INSERT INTO constructorStandings (constructorStandingsId, raceId, constructorId, points, position, positionText, wins) VALUES (11, 291, 2, 1, 0, '0', 0);
-- Wrong points (< 0) to kill mutants using points <= 0
INSERT INTO constructorStandings (constructorStandingsId, raceId, constructorId, points, position, positionText, wins) VALUES (12, 291, 3, -1, 6, '6', 1);
-- Wrong raceId (290 and 292) with points = 0 to kill boundary mutants (raceId <= 291, raceId >= 291, OR instead of AND)
INSERT INTO constructorStandings (constructorStandingsId, raceId, constructorId, points, position, positionText, wins) VALUES (13, 290, 4, 0, 7, '7', 0);
INSERT INTO constructorStandings (constructorStandingsId, raceId, constructorId, points, position, positionText, wins) VALUES (14, 292, 5, 0, 8, '8', 0);
-- Swapped IDs: constructorStandingsId = 291 or constructorId = 291 with wrong raceId/points
INSERT INTO constructorStandings (constructorStandingsId, raceId, constructorId, points, position, positionText, wins) VALUES (291, 290, 291, 10, 1, '1', 1);
-- Table confusion: constructorResults has raceId = 291 and points = 0 for Constructor 6, while constructorStandings has points = 15
INSERT INTO constructorStandings (constructorStandingsId, raceId, constructorId, points, position, positionText, wins) VALUES (15, 291, 6, 15, 2, '2', 0);
INSERT INTO constructorResults (constructorResultsId, raceId, constructorId, points, status) VALUES (1, 291, 6, 0, 'DNF');
INSERT INTO constructorResults (constructorResultsId, raceId, constructorId, points, status) VALUES (2, 291, 1, 10, 'Finished');
-- Table confusion: results table has raceId = 291 and points = 0 for Constructor 2
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (1, 'hamilton', 'Lewis', 'Hamilton', 'http://d1');
INSERT INTO status (statusId, status) VALUES (1, 'Finished');
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionText, positionOrder, points, laps, statusId) VALUES (1, 291, 1, 2, 1, '10', 10, 0, 50, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.name FROM constructorStandings AS T1 INNER JOIN constructors AS T2 ON T1.constructorId = T2.constructorId WHERE T1.points = 0 AND T1.raceId = 291;

/*
Gold Result:
('Target Constructor 1',)
*/

-- Prediction Query
SELECT constructors.name FROM constructorResults JOIN constructors ON constructorResults.constructorId = constructors.constructorId WHERE constructorResults.raceId = 291 AND constructorResults.points = 0;

/*
Prediction Result:
('Only In ConstructorResults',)
*/