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
INSERT INTO seasons (year, url) VALUES (2009, 'http://en.wikipedia.org/wiki/2009_Formula_One_season');
INSERT INTO circuits (circuitId, circuitRef, name, url) VALUES (1, 'marina_bay', 'Marina Bay Street Circuit', 'http://en.wikipedia.org/wiki/Marina_Bay_Street_Circuit');
INSERT INTO constructors (constructorId, constructorRef, name, url) VALUES (1, 'c_match_std', 'Standard Match Team', 'http://example.com/c1');
INSERT INTO constructors (constructorId, constructorRef, name, url) VALUES (2, 'c_match_short_min', 'Single Digit Min Team', 'http://example.com/c2');
INSERT INTO constructors (constructorId, constructorRef, name, url) VALUES (3, 'c_match_empty_min', 'Zero Char Min Team', 'http://example.com/c3');
INSERT INTO constructors (constructorId, constructorRef, name, url) VALUES (4, 'c_fail_two_digit_hr', 'Two Digit Hour Team', 'http://example.com/c4');
INSERT INTO constructors (constructorId, constructorRef, name, url) VALUES (5, 'c_fail_one_digit_sec', 'One Digit Sec Team', 'http://example.com/c5');
INSERT INTO constructors (constructorId, constructorRef, name, url) VALUES (6, 'c_fail_two_digit_ms', 'Two Digit MS Team', 'http://example.com/c6');
INSERT INTO constructors (constructorId, constructorRef, name, url) VALUES (7, 'c_fail_four_digit_ms', 'Four Digit MS Team', 'http://example.com/c7');
INSERT INTO constructors (constructorId, constructorRef, name, url) VALUES (8, 'c_fail_one_colon', 'One Colon Team', 'http://example.com/c8');
INSERT INTO constructors (constructorId, constructorRef, name, url) VALUES (9, 'c_fail_no_dot', 'No Dot Team', 'http://example.com/c9');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (1, 'd1', 'Driver', 'One', 'http://example.com/d1');
INSERT INTO status (statusId, status) VALUES (1, 'Finished');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (1, 2009, 14, 1, 'Singapore Grand Prix', '2009-09-27', 'http://en.wikipedia.org/wiki/2009_Singapore_Grand_Prix');
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionText, positionOrder, points, laps, time, statusId) VALUES (1, 1, 1, 1, 1, '1', 1, 10, 61, '1:56:06.337', 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionText, positionOrder, points, laps, time, statusId) VALUES (2, 1, 1, 2, 2, '2', 2, 8, 61, '2:5:06.337', 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionText, positionOrder, points, laps, time, statusId) VALUES (3, 1, 1, 3, 3, '3', 3, 6, 61, '1::06.337', 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionText, positionOrder, points, laps, time, statusId) VALUES (4, 1, 1, 4, 4, '4', 4, 5, 61, '12:56:06.337', 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionText, positionOrder, points, laps, time, statusId) VALUES (5, 1, 1, 5, 5, '5', 5, 4, 61, '1:56:6.337', 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionText, positionOrder, points, laps, time, statusId) VALUES (6, 1, 1, 6, 6, '6', 6, 3, 61, '1:56:06.33', 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionText, positionOrder, points, laps, time, statusId) VALUES (7, 1, 1, 7, 7, '7', 7, 2, 61, '1:56:06.3370', 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionText, positionOrder, points, laps, time, statusId) VALUES (8, 1, 1, 8, 8, '8', 8, 1, 61, '1:56.337', 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionText, positionOrder, points, laps, time, statusId) VALUES (9, 1, 1, 9, 9, '9', 9, 0, 61, '1:56:06X337', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.constructorRef, T3.url FROM results AS T1 INNER JOIN races AS T2 ON T1.raceId = T2.raceId INNER JOIN constructors AS T3 ON T1.constructorId = T3.constructorId WHERE T2.name = 'Singapore Grand Prix' AND T2.year = 2009 AND T1.time LIKE '_:%:__.___';

/*
Gold Result:
('c_match_std', 'http://example.com/c1')
('c_match_short_min', 'http://example.com/c2')
('c_match_empty_min', 'http://example.com/c3')
*/

-- Prediction Query
SELECT "constructors"."constructorRef", "constructors"."url" FROM "results" INNER JOIN "races" ON "results"."raceId" = "races"."raceId" INNER JOIN "constructors" ON "results"."constructorId" = "constructors"."constructorId" WHERE "races"."year" = 2009 AND "races"."name" = 'Singapore Grand Prix' AND "results"."position" = 1;

/*
Prediction Result:
*/