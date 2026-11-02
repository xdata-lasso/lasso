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
INSERT INTO seasons (year, url) VALUES (2016, 'http://en.wikipedia.org/wiki/2016_Formula_One_season');
INSERT INTO seasons (year, url) VALUES (2017, 'http://en.wikipedia.org/wiki/2017_Formula_One_season');
INSERT INTO seasons (year, url) VALUES (2018, 'http://en.wikipedia.org/wiki/2018_Formula_One_season');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, lat, lng, alt, url) VALUES (1, 'shanghai', 'Shanghai International Circuit', 'Shanghai', 'China', 31.3389, 121.22, 5, 'http://en.wikipedia.org/wiki/Shanghai_International_Circuit');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, lat, lng, alt, url) VALUES (2, 'albert_park', 'Albert Park Grand Prix Circuit', 'Melbourne', 'Australia', -37.8497, 144.968, 10, 'http://en.wikipedia.org/wiki/Melbourne_Grand_Prix_Circuit');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (10, 2017, 2, 1, 'Chinese Grand Prix', '2017-04-09', '06:00:00', 'http://en.wikipedia.org/wiki/2017_Chinese_Grand_Prix');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (11, 2016, 3, 1, 'Chinese Grand Prix', '2016-04-17', '06:00:00', 'http://en.wikipedia.org/wiki/2016_Chinese_Grand_Prix');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (12, 2017, 1, 2, 'Australian Grand Prix', '2017-03-26', '05:00:00', 'http://en.wikipedia.org/wiki/2017_Australian_Grand_Prix');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (13, 2017, 3, 1, 'Chinese Grand Prix Sprint', '2017-04-10', '06:00:00', 'http://en.wikipedia.org/wiki/2017_Chinese_Grand_Prix_Sprint');
INSERT INTO drivers (driverId, driverRef, number, code, forename, surname, dob, nationality, url) VALUES (101, 'hamilton', 44, 'HAM', 'Lewis', 'Hamilton', '1985-01-07', 'British', 'http://en.wikipedia.org/wiki/Lewis_Hamilton');
INSERT INTO drivers (driverId, driverRef, number, code, forename, surname, dob, nationality, url) VALUES (102, 'vettel', 5, 'VET', 'Sebastian', 'Vettel', '1987-07-03', 'German', 'http://en.wikipedia.org/wiki/Sebastian_Vettel');
INSERT INTO drivers (driverId, driverRef, number, code, forename, surname, dob, nationality, url) VALUES (103, 'verstappen', 33, 'VER', 'Max', 'Verstappen', '1997-09-30', 'Dutch', 'http://en.wikipedia.org/wiki/Max_Verstappen');
INSERT INTO drivers (driverId, driverRef, number, code, forename, surname, dob, nationality, url) VALUES (104, 'bottas', 77, 'BOT', 'Valtteri', 'Bottas', '1989-08-28', 'Finnish', 'http://en.wikipedia.org/wiki/Valtteri_Bottas');
INSERT INTO drivers (driverId, driverRef, number, code, forename, surname, dob, nationality, url) VALUES (105, 'raikkonen', 7, 'RAI', 'Kimi', 'Raikkonen', '1979-10-17', 'Finnish', 'http://en.wikipedia.org/wiki/Kimi_Raikkonen');
INSERT INTO drivers (driverId, driverRef, number, code, forename, surname, dob, nationality, url) VALUES (106, 'rosberg', 6, 'ROS', 'Nico', 'Rosberg', '1985-06-27', 'German', 'http://en.wikipedia.org/wiki/Nico_Rosberg');
INSERT INTO driverStandings (driverStandingsId, raceId, driverId, points, position, positionText, wins) VALUES (1001, 10, 101, 43.0, 1, '1', 1);
INSERT INTO driverStandings (driverStandingsId, raceId, driverId, points, position, positionText, wins) VALUES (1002, 10, 102, 37.0, 2, '2', 1);
INSERT INTO driverStandings (driverStandingsId, raceId, driverId, points, position, positionText, wins) VALUES (1003, 10, 103, 25.0, 3, '3', 0);
INSERT INTO driverStandings (driverStandingsId, raceId, driverId, points, position, positionText, wins) VALUES (1004, 10, 104, 23.0, 4, '4', 0);
INSERT INTO driverStandings (driverStandingsId, raceId, driverId, points, position, positionText, wins) VALUES (1005, 10, 105, 22.0, 5, '5', 0);
INSERT INTO driverStandings (driverStandingsId, raceId, driverId, points, position, positionText, wins) VALUES (1006, 11, 106, 100.0, 1, '1', 3);
INSERT INTO driverStandings (driverStandingsId, raceId, driverId, points, position, positionText, wins) VALUES (1007, 12, 104, 90.0, 1, '1', 2);
INSERT INTO driverStandings (driverStandingsId, raceId, driverId, points, position, positionText, wins) VALUES (1008, 13, 105, 85.0, 1, '1', 2);
INSERT INTO constructors (constructorId, constructorRef, name, nationality, url) VALUES (1, 'mercedes', 'Mercedes', 'German', 'http://en.wikipedia.org/wiki/Mercedes-Benz_in_Formula_One');
INSERT INTO status (statusId, status) VALUES (1, 'Finished');
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, statusId) VALUES (501, 10, 105, 1, 7, 1, 1, '1', 1, 25.0, 56, 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, statusId) VALUES (502, 10, 104, 1, 77, 2, 2, '2', 2, 18.0, 56, 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, statusId) VALUES (503, 10, 103, 1, 33, 3, 3, '3', 3, 15.0, 56, 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, statusId) VALUES (504, 10, 102, 1, 5, 4, 4, '4', 4, 12.0, 56, 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, statusId) VALUES (505, 10, 101, 1, 44, 5, 5, '5', 5, 10.0, 56, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.forename, T3.surname, T2.points FROM races AS T1 INNER JOIN driverStandings AS T2 ON T2.raceId = T1.raceId INNER JOIN drivers AS T3 ON T3.driverId = T2.driverId WHERE T1.name = 'Chinese Grand Prix' AND T1.year = 2017 ORDER BY T2.points DESC, T1.raceid NULLS LAST, T2.driverstandingsid NULLS LAST, T3.driverid NULLS LAST LIMIT 3;

/*
Gold Result:
('Lewis', 'Hamilton', 43.0)
('Sebastian', 'Vettel', 37.0)
('Max', 'Verstappen', 25.0)
*/

-- Prediction Query
SELECT T1.forename, T1.surname, T2.points FROM drivers AS T1 INNER JOIN results AS T2 ON T1.driverId = T2.driverId INNER JOIN races AS T3 ON T2.raceId = T3.raceId WHERE T3.year = 2017 AND T3.name = 'Chinese Grand Prix' ORDER BY T2.points DESC, T1.driverid NULLS LAST, T2.resultid NULLS LAST, T3.raceid NULLS LAST LIMIT 3;

/*
Prediction Result:
('Kimi', 'Raikkonen', 25.0)
('Valtteri', 'Bottas', 18.0)
('Max', 'Verstappen', 15.0)
*/