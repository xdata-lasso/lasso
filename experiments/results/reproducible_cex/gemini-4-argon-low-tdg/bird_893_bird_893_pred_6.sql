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
-- 1. WHERE predicates: T1.name = 'Chinese Grand Prix' AND T1.year = 2017 (kills OR, missing year, missing name, wrong constants)
-- 2. ORDER BY T2.points DESC vs ASC, and vs T2.position or T2.wins
-- 3. LIMIT 3 (5 valid entries inserted)
-- 4. Table confusion: driverStandings vs results (results has completely different points/drivers)
-- 5. Column projections: forename vs surname vs driverRef vs code
INSERT INTO circuits (circuitId, circuitRef, name, url) VALUES (1, 'shanghai', 'Shanghai International Circuit', 'http://en.wikipedia.org/wiki/Shanghai_International_Circuit');
INSERT INTO seasons (year, url) VALUES (2016, 'http://en.wikipedia.org/wiki/2016_Formula_One_season');
INSERT INTO seasons (year, url) VALUES (2017, 'http://en.wikipedia.org/wiki/2017_Formula_One_season');
INSERT INTO seasons (year, url) VALUES (2018, 'http://en.wikipedia.org/wiki/2018_Formula_One_season');
INSERT INTO constructors (constructorId, constructorRef, name, url) VALUES (1, 'mercedes', 'Mercedes', 'http://en.wikipedia.org/wiki/Mercedes-Benz_in_Formula_One');
INSERT INTO status (statusId, status) VALUES (1, 'Finished');
INSERT INTO drivers (driverId, driverRef, code, forename, surname, url) VALUES (1, 'hamilton', 'HAM', 'Lewis', 'Hamilton', 'http://en.wikipedia.org/wiki/Lewis_Hamilton');
INSERT INTO drivers (driverId, driverRef, code, forename, surname, url) VALUES (2, 'vettel', 'VET', 'Sebastian', 'Vettel', 'http://en.wikipedia.org/wiki/Sebastian_Vettel');
INSERT INTO drivers (driverId, driverRef, code, forename, surname, url) VALUES (3, 'verstappen', 'VER', 'Max', 'Verstappen', 'http://en.wikipedia.org/wiki/Max_Verstappen');
INSERT INTO drivers (driverId, driverRef, code, forename, surname, url) VALUES (4, 'ricciardo', 'RIC', 'Daniel', 'Ricciardo', 'http://en.wikipedia.org/wiki/Daniel_Ricciardo');
INSERT INTO drivers (driverId, driverRef, code, forename, surname, url) VALUES (5, 'raikkonen', 'RAI', 'Kimi', 'Räikkönen', 'http://en.wikipedia.org/wiki/Kimi_R%C3%A4ikk%C3%B6nen');
INSERT INTO drivers (driverId, driverRef, code, forename, surname, url) VALUES (6, 'bottas', 'BOT', 'Valtteri', 'Bottas', 'http://en.wikipedia.org/wiki/Valtteri_Bottas');
-- Target race: Chinese Grand Prix 2017
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (10, 2017, 2, 1, 'Chinese Grand Prix', '2017-04-09', 'http://en.wikipedia.org/wiki/2017_Chinese_Grand_Prix');
-- Distractor races: wrong year or wrong name
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (11, 2016, 3, 1, 'Chinese Grand Prix', '2016-04-17', 'http://en.wikipedia.org/wiki/2016_Chinese_Grand_Prix');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (12, 2018, 3, 1, 'Chinese Grand Prix', '2018-04-15', 'http://en.wikipedia.org/wiki/2018_Chinese_Grand_Prix');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (13, 2017, 1, 1, 'Australian Grand Prix', '2017-03-26', 'http://en.wikipedia.org/wiki/2017_Australian_Grand_Prix');
-- Standings for target race (raceId = 10)
-- Deliberately anti-correlating points with position and wins to catch mutants ordering by position or wins
INSERT INTO driverStandings (driverStandingsId, raceId, driverId, points, position, positionText, wins) VALUES (101, 10, 1, 43.0, 5, '5', 0);
INSERT INTO driverStandings (driverStandingsId, raceId, driverId, points, position, positionText, wins) VALUES (102, 10, 2, 40.5, 4, '4', 1);
INSERT INTO driverStandings (driverStandingsId, raceId, driverId, points, position, positionText, wins) VALUES (103, 10, 3, 25.0, 3, '3', 2);
INSERT INTO driverStandings (driverStandingsId, raceId, driverId, points, position, positionText, wins) VALUES (104, 10, 4, 18.0, 2, '2', 3);
INSERT INTO driverStandings (driverStandingsId, raceId, driverId, points, position, positionText, wins) VALUES (105, 10, 5, 15.0, 1, '1', 4);
-- Standings for distractor races with higher points (so if WHERE is wrong, top 3 changes)
INSERT INTO driverStandings (driverStandingsId, raceId, driverId, points, position, positionText, wins) VALUES (106, 11, 6, 100.0, 1, '1', 5);
INSERT INTO driverStandings (driverStandingsId, raceId, driverId, points, position, positionText, wins) VALUES (107, 12, 6, 95.0, 1, '1', 5);
INSERT INTO driverStandings (driverStandingsId, raceId, driverId, points, position, positionText, wins) VALUES (108, 13, 6, 90.0, 1, '1', 5);
-- Distractor results table rows (if mutant queries results instead of driverStandings)
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, position, positionText, positionOrder, points, laps, statusId) VALUES (1, 10, 6, 1, 1, 1, '1', 1, 99.0, 56, 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, position, positionText, positionOrder, points, laps, statusId) VALUES (2, 10, 5, 1, 2, 2, '2', 2, 88.0, 56, 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, position, positionText, positionOrder, points, laps, statusId) VALUES (3, 10, 4, 1, 3, 3, '3', 3, 77.0, 56, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.forename, T3.surname, T2.points FROM races AS T1 INNER JOIN driverStandings AS T2 ON T2.raceId = T1.raceId INNER JOIN drivers AS T3 ON T3.driverId = T2.driverId WHERE T1.name = 'Chinese Grand Prix' AND T1.year = 2017 ORDER BY T2.points DESC, T1.raceid NULLS LAST, T2.driverstandingsid NULLS LAST, T3.driverid NULLS LAST LIMIT 3;

/*
Gold Result:
('Lewis', 'Hamilton', 43.0)
('Sebastian', 'Vettel', 40.5)
('Max', 'Verstappen', 25.0)
*/

-- Prediction Query
SELECT T1.forename, T1.surname, T2.points FROM drivers AS T1 INNER JOIN results AS T2 ON T1.driverId = T2.driverId INNER JOIN races AS T3 ON T2.raceId = T3.raceId WHERE T3.year = 2017 AND T3.name = 'Chinese Grand Prix' ORDER BY T2.points DESC, T1.driverid NULLS LAST, T2.resultid NULLS LAST, T3.raceid NULLS LAST LIMIT 3;

/*
Prediction Result:
('Valtteri', 'Bottas', 99.0)
('Kimi', 'Räikkönen', 88.0)
('Daniel', 'Ricciardo', 77.0)
*/