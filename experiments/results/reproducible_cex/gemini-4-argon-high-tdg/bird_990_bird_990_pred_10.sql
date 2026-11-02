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
INSERT INTO seasons (year, url) VALUES (2008, 'http://en.wikipedia.org/wiki/2008_Formula_One_season');
INSERT INTO seasons (year, url) VALUES (2009, 'http://en.wikipedia.org/wiki/2009_Formula_One_season');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, url) VALUES (1, 'marina_bay', 'Marina Bay Street Circuit', 'Marina Bay', 'Singapore', 'http://en.wikipedia.org/wiki/Marina_Bay_Street_Circuit');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, url) VALUES (2, 'monza', 'Autodromo Nazionale di Monza', 'Monza', 'Italy', 'http://en.wikipedia.org/wiki/Autodromo_Nazionale_Monza');
INSERT INTO constructors (constructorId, constructorRef, name, nationality, url) VALUES (1, 'mclaren', 'McLaren', 'British', 'http://en.wikipedia.org/wiki/McLaren');
INSERT INTO constructors (constructorId, constructorRef, name, nationality, url) VALUES (2, 'toyota', 'Toyota', 'Japanese', 'http://en.wikipedia.org/wiki/Toyota_Racing');
INSERT INTO constructors (constructorId, constructorRef, name, nationality, url) VALUES (3, 'williams', 'Williams', 'British', 'http://en.wikipedia.org/wiki/Williams_Grand_Prix_Engineering');
INSERT INTO constructors (constructorId, constructorRef, name, nationality, url) VALUES (4, 'renault', 'Renault', 'French', 'http://en.wikipedia.org/wiki/Renault_F1');
INSERT INTO constructors (constructorId, constructorRef, name, nationality, url) VALUES (5, 'brawn', 'Brawn GP', 'British', 'http://en.wikipedia.org/wiki/Brawn_GP');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (1, 'hamilton', 'Lewis', 'Hamilton', 'http://en.wikipedia.org/wiki/Lewis_Hamilton');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (2, 'glock', 'Timo', 'Glock', 'http://en.wikipedia.org/wiki/Timo_Glock');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (3, 'rosberg', 'Nico', 'Rosberg', 'http://en.wikipedia.org/wiki/Nico_Rosberg');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (4, 'alonso', 'Fernando', 'Alonso', 'http://en.wikipedia.org/wiki/Fernando_Alonso');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (5, 'barrichello', 'Rubens', 'Barrichello', 'http://en.wikipedia.org/wiki/Rubens_Barrichello');
INSERT INTO status (statusId, status) VALUES (1, 'Finished');
INSERT INTO status (statusId, status) VALUES (2, 'Brakes');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (1, 2009, 14, 1, 'Singapore Grand Prix', '2009-09-27', '12:00:00', 'http://en.wikipedia.org/wiki/2009_Singapore_Grand_Prix');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (2, 2008, 15, 1, 'Singapore Grand Prix', '2008-09-28', '12:00:00', 'http://en.wikipedia.org/wiki/2008_Singapore_Grand_Prix');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (3, 2009, 13, 2, 'Italian Grand Prix', '2009-09-13', '12:00:00', 'http://en.wikipedia.org/wiki/2009_Italian_Grand_Prix');
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, position, positionText, positionOrder, points, laps, time, statusId) VALUES (1, 1, 1, 1, 1, 1, '1', 1, 10, 61, '1:56:06.337', 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, position, positionText, positionOrder, points, laps, time, statusId) VALUES (2, 1, 2, 2, 6, 2, '2', 2, 8, 61, '+9.634', 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, position, positionText, positionOrder, points, laps, time, statusId) VALUES (3, 1, 3, 3, 3, NULL, 'R', 18, 0, 15, NULL, 2);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, position, positionText, positionOrder, points, laps, time, statusId) VALUES (4, 2, 4, 4, 15, 1, '1', 1, 10, 61, '1:57:16.304', 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, position, positionText, positionOrder, points, laps, time, statusId) VALUES (5, 3, 5, 5, 5, 1, '1', 1, 10, 53, '1:16:21.706', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.constructorRef, T3.url FROM results AS T1 INNER JOIN races AS T2 ON T1.raceId = T2.raceId INNER JOIN constructors AS T3 ON T1.constructorId = T3.constructorId WHERE T2.name = 'Singapore Grand Prix' AND T2.year = 2009 AND T1.time LIKE '_:%:__.___';

/*
Gold Result:
('mclaren', 'http://en.wikipedia.org/wiki/McLaren')
*/

-- Prediction Query
SELECT c.constructorRef, c.url FROM constructorStandings AS cs JOIN races AS r ON cs.raceId = r.raceId JOIN constructors AS c ON cs.constructorId = c.constructorId WHERE r.year = 2009 AND r.name = 'Singapore Grand Prix' ORDER BY cs.points DESC, cs.constructorstandingsid NULLS LAST, r.raceid NULLS LAST, c.constructorid NULLS LAST LIMIT 1;

/*
Prediction Result:
*/