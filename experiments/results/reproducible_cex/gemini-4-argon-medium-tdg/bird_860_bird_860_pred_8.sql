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
-- Tests:
-- 1. DISTINCT vs non-DISTINCT (multiple qualifying records for race 355 and q2 LIKE '1:40%' sharing 'British' nationality).
-- 2. Exact match '1:40' vs prefix '1:40%' ('British' vs 'German').
-- 3. Wrong column check: q1 or q3 LIKE '1:40%' when q2 does not match ('French', 'Italian').
-- 4. Substring vs Prefix match: '%1:40%' vs '1:40%' ('Spanish').
-- 5. Boundary raceId values: 354 and 356 vs 355 ('Dutch', 'Brazilian').
-- 6. Wrong table column projection: constructors.nationality vs drivers.nationality.
-- 7. Wrong join key: joining on qualifyId = driverId or number = driverId ('Australian').
INSERT INTO seasons (year, url) VALUES (2010, 'http://en.wikipedia.org/wiki/2010_Formula_One_season');
INSERT INTO circuits (circuitId, circuitRef, name, url) VALUES (1, 'valencia', 'Valencia Street Circuit', 'http://en.wikipedia.org/wiki/Valencia_Street_Circuit');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (354, 2010, 7, 1, 'Race 354', '2010-05-30', 'http://race354');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (355, 2010, 8, 1, 'Race 355', '2010-06-27', 'http://race355');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (356, 2010, 9, 1, 'Race 356', '2010-07-11', 'http://race356');
INSERT INTO constructors (constructorId, constructorRef, name, nationality, url) VALUES (1, 'mclaren', 'McLaren', 'Constructor_Nationality_1', 'http://mclaren');
INSERT INTO constructors (constructorId, constructorRef, name, nationality, url) VALUES (2, 'ferrari', 'Ferrari', 'Constructor_Nationality_2', 'http://ferrari');
INSERT INTO drivers (driverId, driverRef, number, forename, surname, nationality, url) VALUES (1, 'hamilton', 2, 'Lewis', 'Hamilton', 'British', 'http://hamilton');
INSERT INTO drivers (driverId, driverRef, number, forename, surname, nationality, url) VALUES (2, 'button', 1, 'Jenson', 'Button', 'British', 'http://button');
INSERT INTO drivers (driverId, driverRef, number, forename, surname, nationality, url) VALUES (3, 'vettel', 5, 'Sebastian', 'Vettel', 'German', 'http://vettel');
INSERT INTO drivers (driverId, driverRef, number, forename, surname, nationality, url) VALUES (4, 'alonso', 8, 'Fernando', 'Alonso', 'Spanish', 'http://alonso');
INSERT INTO drivers (driverId, driverRef, number, forename, surname, nationality, url) VALUES (5, 'massa', 7, 'Felipe', 'Massa', 'Brazilian', 'http://massa');
INSERT INTO drivers (driverId, driverRef, number, forename, surname, nationality, url) VALUES (6, 'prost', 9, 'Alain', 'Prost', 'French', 'http://prost');
INSERT INTO drivers (driverId, driverRef, number, forename, surname, nationality, url) VALUES (7, 'trulli', 18, 'Jarno', 'Trulli', 'Italian', 'http://trulli');
INSERT INTO drivers (driverId, driverRef, number, forename, surname, nationality, url) VALUES (8, 'verstappen', 33, 'Max', 'Verstappen', 'Dutch', 'http://verstappen');
INSERT INTO drivers (driverId, driverRef, number, forename, surname, nationality, url) VALUES (99, 'webber', 6, 'Mark', 'Webber', 'Australian', 'http://webber');
-- Valid matches (Duplicate 'British' tests DISTINCT; '1:40.123' tests prefix wildcard; '1:40' tests exact boundary)
INSERT INTO qualifying (qualifyId, raceId, driverId, constructorId, number, position, q1, q2, q3) VALUES (10, 355, 1, 1, 99, 1, '1:41.000', '1:40.123', '1:39.500');
INSERT INTO qualifying (qualifyId, raceId, driverId, constructorId, number, position, q1, q2, q3) VALUES (11, 355, 2, 1, 2, 2, '1:41.200', '1:40.456', '1:39.800');
INSERT INTO qualifying (qualifyId, raceId, driverId, constructorId, number, position, q1, q2, q3) VALUES (12, 355, 3, 2, 5, 3, '1:41.300', '1:40', '1:39.900');
-- Invalid q2 prefix (tests '%1:40%' vs '1:40%' and '1:4%' vs '1:40%')
INSERT INTO qualifying (qualifyId, raceId, driverId, constructorId, number, position, q1, q2, q3) VALUES (13, 355, 4, 2, 8, 4, '1:41.400', '01:40.123', '1:40.000');
-- Wrong raceId (356 and 354)
INSERT INTO qualifying (qualifyId, raceId, driverId, constructorId, number, position, q1, q2, q3) VALUES (14, 356, 5, 2, 7, 1, '1:40.100', '1:40.200', '1:40.300');
INSERT INTO qualifying (qualifyId, raceId, driverId, constructorId, number, position, q1, q2, q3) VALUES (15, 354, 8, 1, 33, 1, '1:40.100', '1:40.200', '1:40.300');
-- Wrong q column (q1 or q3 matches '1:40%', but q2 does not)
INSERT INTO qualifying (qualifyId, raceId, driverId, constructorId, number, position, q1, q2, q3) VALUES (16, 355, 6, 1, 9, 5, '1:40.111', '1:41.222', '1:42.333');
INSERT INTO qualifying (qualifyId, raceId, driverId, constructorId, number, position, q1, q2, q3) VALUES (17, 355, 7, 2, 18, 6, '1:41.111', '1:41.222', '1:40.333');
-- Trap for wrong join condition (qualifyId = 99 -> driverId 99 'Australian', while actual driverId is 1 'British')
INSERT INTO qualifying (qualifyId, raceId, driverId, constructorId, number, position, q1, q2, q3) VALUES (99, 355, 1, 1, 99, 7, '1:41.000', '1:40.999', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.nationality FROM qualifying AS T1 INNER JOIN drivers AS T2 ON T2.driverId = T1.driverId WHERE T1.raceId = 355 AND T1.q2 LIKE '1:40%';

/*
Gold Result:
('British',)
('German',)
*/

-- Prediction Query
SELECT T2.nationality FROM qualifying AS T1 INNER JOIN drivers AS T2 ON T1.driverId = T2.driverId WHERE T1.q2 = '0:01:40' AND T1.raceId = 355 LIMIT 1;

/*
Prediction Result:
*/