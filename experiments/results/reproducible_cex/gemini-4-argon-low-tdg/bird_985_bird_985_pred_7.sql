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
-- Tests basic filtering (race name, lap = 3), ORDER BY T1.time DESC vs ASC, and T1.time vs T1.milliseconds/position/T2.time
INSERT INTO circuits (circuitId, circuitRef, name, url) VALUES (1, 'magny_cours', 'Circuit de Nevers Magny-Cours', 'http://en.wikipedia.org/wiki/Circuit_de_Nevers_Magny-Cours');
INSERT INTO seasons (year, url) VALUES (2020, 'http://en.wikipedia.org/wiki/2020_Formula_One_season');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (10, 'gasly', 'Pierre', 'Gasly', 'http://en.wikipedia.org/wiki/Pierre_Gasly');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (20, 'ocon', 'Esteban', 'Ocon', 'http://en.wikipedia.org/wiki/Esteban_Ocon');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (30, 'prost', 'Alain', 'Prost', 'http://en.wikipedia.org/wiki/Alain_Prost');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (40, 'senna', 'Ayrton', 'Senna', 'http://en.wikipedia.org/wiki/Ayrton_Senna');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (50, 'mansell', 'Nigel', 'Mansell', 'http://en.wikipedia.org/wiki/Nigel_Mansell');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (100, 2020, 1, 1, 'French Grand Prix', '2020-07-01', '14:00:00', 'http://en.wikipedia.org/wiki/2020_French_Grand_Prix_1');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (101, 2020, 2, 1, 'French Grand Prix', '2020-07-08', '16:00:00', 'http://en.wikipedia.org/wiki/2020_French_Grand_Prix_2');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (102, 2020, 3, 1, 'British Grand Prix', '2020-07-15', '15:00:00', 'http://en.wikipedia.org/wiki/2020_British_Grand_Prix');
-- Target Winner: French GP, lap 3, highest T1.time ('01:40.000'), deliberately given lower milliseconds and lower race time to catch column confusion mutants
INSERT INTO lapTimes (raceId, driverId, lap, position, time, milliseconds) VALUES (100, 10, 3, 2, '01:40.000', 80000);
-- Lower T1.time ('01:35.000'), higher milliseconds, higher race time ('16:00:00')
INSERT INTO lapTimes (raceId, driverId, lap, position, time, milliseconds) VALUES (101, 20, 3, 1, '01:35.000', 95000);
-- Wrong race ('British Grand Prix'), but lap 3 and even higher T1.time ('01:59.000')
INSERT INTO lapTimes (raceId, driverId, lap, position, time, milliseconds) VALUES (102, 30, 3, 3, '01:59.000', 119000);
-- Wrong lap (lap 2), French GP, higher T1.time ('01:58.000')
INSERT INTO lapTimes (raceId, driverId, lap, position, time, milliseconds) VALUES (100, 40, 2, 4, '01:58.000', 118000);
-- Wrong lap (lap 4), French GP, higher T1.time ('01:57.000')
INSERT INTO lapTimes (raceId, driverId, lap, position, time, milliseconds) VALUES (100, 50, 4, 5, '01:57.000', 117000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.driverId FROM lapTimes AS T1 INNER JOIN races AS T2 ON T1.raceId = T2.raceId WHERE T2.name = 'French Grand Prix' AND T1.lap = 3 ORDER BY T1.time DESC, T1.raceid NULLS LAST, T1.driverid NULLS LAST, T1.lap NULLS LAST, T2.raceid NULLS LAST LIMIT 1;

/*
Gold Result:
(10,)
*/

-- Prediction Query
SELECT T2.forename, T2.surname FROM races AS T1 JOIN lapTimes AS T3 ON T1.raceId = T3.raceId JOIN drivers AS T2 ON T3.driverId = T2.driverId WHERE T1.name = 'French Grand Prix' AND T3.lap = 3 ORDER BY T3.time DESC, T1.raceid NULLS LAST, T3.raceid NULLS LAST, T3.driverid NULLS LAST, T3.lap NULLS LAST, T2.driverid NULLS LAST LIMIT 1;

/*
Prediction Result:
('Pierre', 'Gasly')
*/