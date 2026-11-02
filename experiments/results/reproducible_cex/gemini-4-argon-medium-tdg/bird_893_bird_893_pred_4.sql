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
INSERT INTO circuits (circuitId, circuitRef, name, url) VALUES (1, 'shanghai', 'Shanghai International Circuit', 'http://url1');
INSERT INTO seasons (year, url) VALUES (2016, 'http://s2016');
INSERT INTO seasons (year, url) VALUES (2017, 'http://s2017');
INSERT INTO seasons (year, url) VALUES (2018, 'http://s2018');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (1, 'ham', 'Lewis', 'Hamilton', 'http://d1');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (2, 'vet', 'Sebastian', 'Vettel', 'http://d2');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (3, 'ver', 'Max', 'Verstappen', 'http://d3');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (4, 'ric', 'Daniel', 'Ricciardo', 'http://d4');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (5, 'bot', 'Valtteri', 'Bottas', 'http://d5');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (6, 'rai', 'Kimi', 'Raikkonen', 'http://d6');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (7, 'alo', 'Fernando', 'Alonso', 'http://d7');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (8, 'mas', 'Felipe', 'Massa', 'http://d8');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (1, 2017, 2, 1, 'Chinese Grand Prix', '2017-04-09', 'http://r1');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (2, 2016, 3, 1, 'Chinese Grand Prix', '2016-04-17', 'http://r2');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (3, 2018, 3, 1, 'Chinese Grand Prix', '2018-04-15', 'http://r3');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (4, 2017, 1, 1, 'Australian Grand Prix', '2017-03-26', 'http://r4');
INSERT INTO driverStandings (driverStandingsId, raceId, driverId, points, position, wins) VALUES (1, 1, 1, 43.0, 1, 1);
INSERT INTO driverStandings (driverStandingsId, raceId, driverId, points, position, wins) VALUES (2, 1, 2, 43.0, 2, 1);
INSERT INTO driverStandings (driverStandingsId, raceId, driverId, points, position, wins) VALUES (3, 1, 3, 25.0, 3, 0);
INSERT INTO driverStandings (driverStandingsId, raceId, driverId, points, position, wins) VALUES (4, 1, 4, 12.0, 4, 0);
INSERT INTO driverStandings (driverStandingsId, raceId, driverId, points, position, wins) VALUES (5, 1, 5, 8.0, 5, 0);
INSERT INTO driverStandings (driverStandingsId, raceId, driverId, points, position, wins) VALUES (6, 2, 6, 100.0, 1, 2);
INSERT INTO driverStandings (driverStandingsId, raceId, driverId, points, position, wins) VALUES (7, 3, 7, 100.0, 1, 2);
INSERT INTO driverStandings (driverStandingsId, raceId, driverId, points, position, wins) VALUES (8, 4, 8, 100.0, 1, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.forename, T3.surname, T2.points FROM races AS T1 INNER JOIN driverStandings AS T2 ON T2.raceId = T1.raceId INNER JOIN drivers AS T3 ON T3.driverId = T2.driverId WHERE T1.name = 'Chinese Grand Prix' AND T1.year = 2017 ORDER BY T2.points DESC, T1.raceid NULLS LAST, T2.driverstandingsid NULLS LAST, T3.driverid NULLS LAST LIMIT 3;

/*
Gold Result:
('Lewis', 'Hamilton', 43.0)
('Sebastian', 'Vettel', 43.0)
('Max', 'Verstappen', 25.0)
*/

-- Prediction Query
SELECT d.forename, d.surname, r.points FROM drivers AS d INNER JOIN results AS r ON d.driverid = r.driverid INNER JOIN races AS ra ON r.raceid = ra.raceid WHERE ra.year = 2017 AND ra.name = 'Chinese Grand Prix' ORDER BY r.points DESC, d.driverid NULLS LAST, r.resultid NULLS LAST, ra.raceid NULLS LAST LIMIT 3;

/*
Prediction Result:
*/