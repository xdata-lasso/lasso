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
INSERT INTO seasons (year, url) VALUES (2021, 'http://en.wikipedia.org/wiki/2021_Formula_One_World_Championship');
INSERT INTO circuits (circuitId, circuitRef, name, url) VALUES (1, 'silverstone', 'Silverstone Circuit', 'http://en.wikipedia.org/wiki/Silverstone_Circuit');
INSERT INTO constructors (constructorId, constructorRef, name, url) VALUES (1, 'mercedes', 'Mercedes', 'http://en.wikipedia.org/wiki/Mercedes-Benz_in_Formula_One');
INSERT INTO status (statusId, status) VALUES (1, 'Finished');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (1, 'hamilton', 'Lewis', 'Hamilton', 'http://en.wikipedia.org/wiki/Lewis_Hamilton');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (2, 'lewis_other', 'Lewis', 'Verstappen', 'http://en.wikipedia.org/wiki/Lewis_V');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (3, 'hamilton_other', 'Max', 'Hamilton', 'http://en.wikipedia.org/wiki/Max_H');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (4, 'verstappen', 'Max', 'Verstappen', 'http://en.wikipedia.org/wiki/Max_Verstappen');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (1, 2021, 1, 1, 'British Grand Prix', '2021-07-18', 'http://en.wikipedia.org/wiki/2021_British_Grand_Prix');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (2, 2021, 2, 1, 'Monaco Grand Prix', '2021-05-23', 'http://en.wikipedia.org/wiki/2021_Monaco_Grand_Prix');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (3, 2021, 3, 1, 'Italian Grand Prix', '2021-09-12', 'http://en.wikipedia.org/wiki/2021_Italian_Grand_Prix');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (4, 2021, 4, 1, 'Dutch Grand Prix', '2021-09-05', 'http://en.wikipedia.org/wiki/2021_Dutch_Grand_Prix');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (5, 2021, 5, 1, 'Belgian Grand Prix', '2021-08-29', 'http://en.wikipedia.org/wiki/2021_Belgian_Grand_Prix');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (6, 2021, 6, 1, 'Spanish Grand Prix', '2021-05-09', 'http://en.wikipedia.org/wiki/2021_Spanish_Grand_Prix');
-- Race 1: Lewis Hamilton has rank = 1, but position/grid/points/positionOrder/fastestLap are NOT 1 (tests column confusion and positive match)
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, fastestLap, rank, statusId) VALUES (1, 1, 1, 1, 44, 2, 2, '2', 2, 18.0, 52, 50, 1, 1);
-- Race 2: Lewis Hamilton has position = 1, grid = 1, positionOrder = 1, points = 1, fastestLap = 1, number = 1, laps = 1, but rank = 2 (tests column confusion & rank != 1)
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, fastestLap, rank, statusId) VALUES (2, 2, 1, 1, 1, 1, 1, '1', 1, 1.0, 1, 1, 2, 1);
-- Race 3: Forename = 'Lewis', Surname != 'Hamilton', rank = 1 (tests AND vs OR on driver name)
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, fastestLap, rank, statusId) VALUES (3, 3, 2, 1, 33, 1, 1, '1', 1, 25.0, 50, 45, 1, 1);
-- Race 4: Forename != 'Lewis', Surname = 'Hamilton', rank = 1 (tests AND vs OR on driver name)
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, fastestLap, rank, statusId) VALUES (4, 4, 3, 1, 11, 1, 1, '1', 1, 25.0, 72, 60, 1, 1);
-- Race 5: Max Verstappen has rank = 1, Lewis Hamilton has rank = 0 (tests missing join/filter on driverId or rank=0 boundary)
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, fastestLap, rank, statusId) VALUES (5, 5, 4, 1, 33, 1, 1, '1', 1, 25.0, 44, 10, 1, 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, fastestLap, rank, statusId) VALUES (6, 5, 1, 1, 44, 2, 2, '2', 2, 18.0, 44, 12, 0, 1);
-- Race 6: Lewis Hamilton has rank IS NULL (tests NULL handling)
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, fastestLap, rank, statusId) VALUES (7, 6, 1, 1, 44, 1, 1, '1', 1, 25.0, 66, 55, NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM races WHERE raceId IN (SELECT raceId FROM results WHERE rank = 1 AND driverId = (SELECT driverId FROM drivers WHERE forename = 'Lewis' AND surname = 'Hamilton'));

/*
Gold Result:
('British Grand Prix',)
*/

-- Prediction Query
SELECT T2.name FROM results AS T1 INNER JOIN races AS T2 ON T1.raceId = T2.raceId INNER JOIN drivers AS T3 ON T1.driverId = T3.driverId WHERE T3.forename = 'Lewis' AND T3.surname = 'Hamilton' ORDER BY T1.rank ASC, T1.resultid NULLS LAST, T2.raceid NULLS LAST, T3.driverid NULLS LAST LIMIT 1;

/*
Prediction Result:
('Spanish Grand Prix',)
*/