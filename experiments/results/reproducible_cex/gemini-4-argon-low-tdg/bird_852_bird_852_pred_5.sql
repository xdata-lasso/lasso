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
-- Tests:
-- Exhaustive check of the first half of the excluded countries list ('Bahrain', 'China', 'Singapore', 'Japan', 'Korea', 'Turkey', 'UAE', 'Malaysia', 'Spain')
-- Also tests IN vs NOT IN, AND vs OR between country filter and year filter.
-- Reference query should return 0 for this dataset. Any mutant omitting one of these countries or flipping NOT IN to IN will return > 0.
INSERT INTO seasons (year, url) VALUES (2010, 'http://en.wikipedia.org/wiki/2010_Formula_One_season');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, url) VALUES (1, 'bahrain', 'Bahrain International Circuit', 'Sakhir', 'Bahrain', 'http://en.wikipedia.org/wiki/Bahrain_International_Circuit');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, url) VALUES (2, 'shanghai', 'Shanghai International Circuit', 'Shanghai', 'China', 'http://en.wikipedia.org/wiki/Shanghai_International_Circuit');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, url) VALUES (3, 'marina_bay', 'Marina Bay Street Circuit', 'Marina Bay', 'Singapore', 'http://en.wikipedia.org/wiki/Marina_Bay_Street_Circuit');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, url) VALUES (4, 'suzuka', 'Suzuka Circuit', 'Suzuka', 'Japan', 'http://en.wikipedia.org/wiki/Suzuka_Circuit');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, url) VALUES (5, 'yeongam', 'Korean International Circuit', 'Yeongam County', 'Korea', 'http://en.wikipedia.org/wiki/Korean_International_Circuit');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, url) VALUES (6, 'istanbul', 'Istanbul Park', 'Istanbul', 'Turkey', 'http://en.wikipedia.org/wiki/Istanbul_Park');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, url) VALUES (7, 'yas_marina', 'Yas Marina Circuit', 'Abu Dhabi', 'UAE', 'http://en.wikipedia.org/wiki/Yas_Marina_Circuit');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, url) VALUES (8, 'sepang', 'Sepang International Circuit', 'Kuala Lumpur', 'Malaysia', 'http://en.wikipedia.org/wiki/Sepang_International_Circuit');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, url) VALUES (9, 'catalunya', 'Circuit de Barcelona-Catalunya', 'Montmelo', 'Spain', 'http://en.wikipedia.org/wiki/Circuit_de_Barcelona-Catalunya');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (1, 2010, 1, 1, 'Bahrain GP', '2010-03-14', 'http://en.wikipedia.org/wiki/2010_Bahrain_GP');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (2, 2010, 2, 2, 'Chinese GP', '2010-04-18', 'http://en.wikipedia.org/wiki/2010_Chinese_GP');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (3, 2010, 3, 3, 'Singapore GP', '2010-09-26', 'http://en.wikipedia.org/wiki/2010_Singapore_GP');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (4, 2010, 4, 4, 'Japanese GP', '2010-10-10', 'http://en.wikipedia.org/wiki/2010_Japanese_GP');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (5, 2010, 5, 5, 'Korean GP', '2010-10-24', 'http://en.wikipedia.org/wiki/2010_Korean_GP');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (6, 2010, 6, 6, 'Turkish GP', '2010-05-30', 'http://en.wikipedia.org/wiki/2010_Turkish_GP');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (7, 2010, 7, 7, 'Abu Dhabi GP', '2010-11-14', 'http://en.wikipedia.org/wiki/2010_Abu_Dhabi_GP');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (8, 2010, 8, 8, 'Malaysian GP', '2010-04-04', 'http://en.wikipedia.org/wiki/2010_Malaysian_GP');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (9, 2010, 9, 9, 'Spanish GP', '2010-05-09', 'http://en.wikipedia.org/wiki/2010_Spanish_GP');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T3.raceId) FROM circuits AS T1 INNER JOIN races AS T3 ON T3.circuitID = T1.circuitId WHERE NOT T1.country IN ('Bahrain', 'China', 'Singapore', 'Japan', 'Korea', 'Turkey', 'UAE', 'Malaysia', 'Spain', 'Monaco', 'Azerbaijan', 'Austria', 'Belgium', 'France', 'Germany', 'Hungary', 'Italy', 'UK') AND T3.year = 2010;

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(*) FROM races AS T1 INNER JOIN circuits AS T2 ON T1.circuitId = T2.circuitId WHERE T1.year = 2010 AND T2.country NOT LIKE '%Asia%' AND T2.country NOT LIKE '%Europe%';

/*
Prediction Result:
(9,)
*/