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
-- DATASET 3
INSERT INTO seasons (year, url) VALUES (2010, 'http://en.wikipedia.org/wiki/2010_Formula_One_season');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, url) VALUES (11, 'c_spain', 'Catalunya', 'Barcelona', 'Spain', 'http://example.com/c11');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, url) VALUES (12, 'c_monaco', 'Monte Carlo', 'Monte-Carlo', 'Monaco', 'http://example.com/c12');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, url) VALUES (13, 'c_austria', 'Red Bull Ring', 'Spielberg', 'Austria', 'http://example.com/c13');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, url) VALUES (14, 'c_belgium', 'Spa-Francorchamps', 'Spa', 'Belgium', 'http://example.com/c14');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, url) VALUES (15, 'c_france', 'Magny-Cours', 'Nevers', 'France', 'http://example.com/c15');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, url) VALUES (16, 'c_germany', 'Hockenheimring', 'Hockenheim', 'Germany', 'http://example.com/c16');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, url) VALUES (17, 'c_hungary', 'Hungaroring', 'Budapest', 'Hungary', 'http://example.com/c17');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, url) VALUES (18, 'c_italy', 'Monza', 'Monza', 'Italy', 'http://example.com/c18');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, url) VALUES (19, 'c_uk', 'Silverstone', 'Silverstone', 'UK', 'http://example.com/c19');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, url) VALUES (20, 'c_brazil', 'Interlagos', 'Sao Paulo', 'Brazil', 'http://example.com/c20');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (301, 2010, 1, 11, 'R11', '2010-05-09', 'http://example.com/r301');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (302, 2010, 2, 12, 'R12', '2010-05-16', 'http://example.com/r302');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (303, 2010, 3, 13, 'R13', '2010-07-04', 'http://example.com/r303');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (304, 2010, 4, 14, 'R14', '2010-08-29', 'http://example.com/r304');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (305, 2010, 5, 15, 'R15', '2010-06-27', 'http://example.com/r305');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (306, 2010, 6, 16, 'R16', '2010-07-25', 'http://example.com/r306');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (307, 2010, 7, 17, 'R17', '2010-08-01', 'http://example.com/r307');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (308, 2010, 8, 18, 'R18', '2010-09-12', 'http://example.com/r308');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (309, 2010, 9, 19, 'R19', '2010-07-11', 'http://example.com/r309');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (310, 2010, 10, 20, 'R20', '2010-11-07', 'http://example.com/r310');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T3.raceId) FROM circuits AS T1 INNER JOIN races AS T3 ON T3.circuitID = T1.circuitId WHERE NOT T1.country IN ('Bahrain', 'China', 'Singapore', 'Japan', 'Korea', 'Turkey', 'UAE', 'Malaysia', 'Spain', 'Monaco', 'Azerbaijan', 'Austria', 'Belgium', 'France', 'Germany', 'Hungary', 'Italy', 'UK') AND T3.year = 2010;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM races JOIN circuits ON races.circuitId = circuits.circuitId WHERE races.year = 2010 AND NOT circuits.country IN ('Malaysia', 'Bahrain', 'Singapore', 'Japan', 'China', 'UAE', 'Korea', 'India', 'Spain', 'Turkey', 'Monaco', 'France', 'UK', 'Germany', 'Hungary', 'Belgium', 'Italy', 'Portugal', 'Netherlands', 'Sweden', 'Switzerland', 'Russia', 'Azerbaijan');

/*
Prediction Result:
(2,)
*/