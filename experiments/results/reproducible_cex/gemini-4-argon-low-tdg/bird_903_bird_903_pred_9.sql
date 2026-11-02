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
-- Core dataset testing:
-- 1. SUM(wins) vs SUM(DISTINCT wins) (two rows with wins = 3)
-- 2. SUM(wins) vs COUNT(*), MAX(wins), MIN(wins), AVG(wins)
-- 3. Forename AND Surname conditions (testing Ralf Schumacher and Michael Andretti)
-- 4. Circuit name vs Race name vs Circuit location/ref
-- 5. Correct column selection (wins vs points vs position)
INSERT INTO seasons (year, url) VALUES (2000, 'http://en.wikipedia.org/wiki/2000_Formula_One_season');
INSERT INTO seasons (year, url) VALUES (2001, 'http://en.wikipedia.org/wiki/2001_Formula_One_season');
INSERT INTO seasons (year, url) VALUES (2002, 'http://en.wikipedia.org/wiki/2002_Formula_One_season');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, url) VALUES (1, 'sepang', 'Sepang International Circuit', 'Kuala Lumpur', 'Malaysia', 'http://en.wikipedia.org/wiki/Sepang_International_Circuit');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, url) VALUES (2, 'Sepang International Circuit', 'Monza Circuit', 'Sepang International Circuit', 'Italy', 'http://en.wikipedia.org/wiki/Autodromo_Nazionale_Monza');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (1, 'michael_schumacher', 'Michael', 'Schumacher', 'http://en.wikipedia.org/wiki/Michael_Schumacher');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (2, 'ralf_schumacher', 'Ralf', 'Schumacher', 'http://en.wikipedia.org/wiki/Ralf_Schumacher');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (3, 'andretti', 'Michael', 'Andretti', 'http://en.wikipedia.org/wiki/Michael_Andretti');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (10, 2000, 17, 1, 'Malaysian Grand Prix', '2000-10-22', 'http://en.wikipedia.org/wiki/2000_Malaysian_Grand_Prix');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (11, 2001, 2, 1, 'Malaysian Grand Prix', '2001-03-18', 'http://en.wikipedia.org/wiki/2001_Malaysian_Grand_Prix');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (12, 2002, 2, 1, 'Malaysian Grand Prix', '2002-03-17', 'http://en.wikipedia.org/wiki/2002_Malaysian_Grand_Prix');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (13, 2000, 14, 2, 'Sepang International Circuit', '2000-09-10', 'http://en.wikipedia.org/wiki/2000_Italian_Grand_Prix');
INSERT INTO driverStandings (driverStandingsId, raceId, driverId, points, position, wins) VALUES (100, 10, 1, 108.0, 1, 3);
INSERT INTO driverStandings (driverStandingsId, raceId, driverId, points, position, wins) VALUES (101, 11, 1, 20.0, 1, 3);
INSERT INTO driverStandings (driverStandingsId, raceId, driverId, points, position, wins) VALUES (102, 12, 1, 14.0, 1, 5);
INSERT INTO driverStandings (driverStandingsId, raceId, driverId, points, position, wins) VALUES (103, 10, 2, 24.0, 5, 10);
INSERT INTO driverStandings (driverStandingsId, raceId, driverId, points, position, wins) VALUES (104, 10, 3, 5.0, 10, 20);
INSERT INTO driverStandings (driverStandingsId, raceId, driverId, points, position, wins) VALUES (105, 13, 1, 80.0, 2, 50);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(T2.wins) FROM drivers AS T1 INNER JOIN driverStandings AS T2 ON T2.driverId = T1.driverId INNER JOIN races AS T3 ON T3.raceId = T2.raceId INNER JOIN circuits AS T4 ON T4.circuitId = T3.circuitId WHERE T1.forename = 'Michael' AND T1.surname = 'Schumacher' AND T4.name = 'Sepang International Circuit';

/*
Gold Result:
(11,)
*/

-- Prediction Query
SELECT COUNT(*) FROM results AS r JOIN races AS ra ON r.raceId = ra.raceId JOIN circuits AS c ON ra.circuitId = c.circuitId JOIN drivers AS d ON r.driverId = d.driverId WHERE c.name = 'Sepang International Circuit' AND d.forename = 'Michael' AND d.surname = 'Schumacher' AND r.position = 1;

/*
Prediction Result:
(0,)
*/