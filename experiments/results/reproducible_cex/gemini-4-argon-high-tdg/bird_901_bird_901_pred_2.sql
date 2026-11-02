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
INSERT INTO seasons (year, url) VALUES (2005, 'http://en.wikipedia.org/wiki/2005_Formula_One_season');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, lat, lng, alt, url) VALUES (1, 'monza', 'Autodromo Nazionale di Monza', 'Monza', 'Italy', 45.6156, 9.28111, 162, 'http://en.wikipedia.org/wiki/Autodromo_Nazionale_Monza');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, lat, lng, alt, url) VALUES (2, 'spa', 'Circuit de Spa-Francorchamps', 'Spa', 'Belgium', 50.4372, 5.97139, 401, 'http://en.wikipedia.org/wiki/Circuit_de_Spa-Francorchamps');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, lat, lng, alt, url) VALUES (3, 'nurburgring_gp', 'Nurburgring', 'Nurburg', 'Germany', 50.3356, 6.9475, 578, 'http://en.wikipedia.org/wiki/Nurburgring_GP');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, lat, lng, alt, url) VALUES (4, 'nurburgring_north', 'Nurburgring', 'Nurburg', 'Germany', 50.3356, 6.9475, 578, 'http://en.wikipedia.org/wiki/Nurburgring_Nordschleife');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (10, 2005, 15, 1, 'Italian Grand Prix', '2005-09-04', '14:00:00', 'http://en.wikipedia.org/wiki/2005_Italian_Grand_Prix_1');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (11, 2005, 16, 1, 'Italian Grand Prix', '2005-09-18', '14:00:00', 'http://en.wikipedia.org/wiki/2005_Italian_Grand_Prix_2');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (12, 2005, 17, 2, 'Belgian Grand Prix', '2005-09-11', '14:00:00', 'http://en.wikipedia.org/wiki/2005_Belgian_Grand_Prix');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (13, 2005, 18, 2, 'Ardennes Grand Prix', '2005-09-25', '14:00:00', 'http://en.wikipedia.org/wiki/2005_Ardennes_Grand_Prix');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (14, 2005, 19, 3, 'European Grand Prix', '2005-09-07', '14:00:00', 'http://en.wikipedia.org/wiki/2005_European_Grand_Prix_1');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (15, 2005, 20, 4, 'European Grand Prix', '2005-09-21', '14:00:00', 'http://en.wikipedia.org/wiki/2005_European_Grand_Prix_2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.name, T1.name, T1.location FROM circuits AS T1 INNER JOIN races AS T2 ON T2.circuitID = T1.circuitId WHERE T2.year = 2005 AND STRFTIME('%m', T2.date) = '09';

/*
Gold Result:
('Italian Grand Prix', 'Autodromo Nazionale di Monza', 'Monza')
('Belgian Grand Prix', 'Circuit de Spa-Francorchamps', 'Spa')
('Ardennes Grand Prix', 'Circuit de Spa-Francorchamps', 'Spa')
('European Grand Prix', 'Nurburgring', 'Nurburg')
*/

-- Prediction Query
SELECT T1.name, T2.name, T2.location FROM races AS T1 INNER JOIN circuits AS T2 ON T1.circuitId = T2.circuitId WHERE T1.year = 2005 AND SUBSTRING(T1.date, 6, 2) = '09';

/*
Prediction Result:
('Italian Grand Prix', 'Autodromo Nazionale di Monza', 'Monza')
('Italian Grand Prix', 'Autodromo Nazionale di Monza', 'Monza')
('Belgian Grand Prix', 'Circuit de Spa-Francorchamps', 'Spa')
('Ardennes Grand Prix', 'Circuit de Spa-Francorchamps', 'Spa')
('European Grand Prix', 'Nurburgring', 'Nurburg')
('European Grand Prix', 'Nurburgring', 'Nurburg')
*/