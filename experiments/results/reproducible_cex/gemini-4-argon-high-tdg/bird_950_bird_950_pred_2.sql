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
INSERT INTO seasons (year, url) VALUES (2009, 'http://en.wikipedia.org/wiki/2009_Formula_One_season');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, lat, lng, alt, url) VALUES (1, 'albert_park', 'Albert Park Grand Prix Circuit', 'Melbourne', 'Australia', -37.8497, 144.968, 10, 'http://en.wikipedia.org/wiki/Melbourne_Grand_Prix_Circuit');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (290, 2009, 1, 1, 'Australian Grand Prix', '2009-03-29', '06:00:00', 'http://en.wikipedia.org/wiki/2009_Australian_Grand_Prix');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (291, 2009, 2, 1, 'Malaysian Grand Prix', '2009-04-05', '09:00:00', 'http://en.wikipedia.org/wiki/2009_Malaysian_Grand_Prix');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (292, 2009, 3, 1, 'Chinese Grand Prix', '2009-04-19', '07:00:00', 'http://en.wikipedia.org/wiki/2009_Chinese_Grand_Prix');
INSERT INTO constructors (constructorId, constructorRef, name, nationality, url) VALUES (1, 'ferrari_ref', 'Ferrari', 'Italian', 'http://en.wikipedia.org/wiki/Scuderia_Ferrari');
INSERT INTO constructors (constructorId, constructorRef, name, nationality, url) VALUES (2, 'force_india_ref', 'Force India', 'Indian', 'http://en.wikipedia.org/wiki/Force_India');
INSERT INTO constructors (constructorId, constructorRef, name, nationality, url) VALUES (3, 'brawn_ref', 'Brawn', 'British', 'http://en.wikipedia.org/wiki/Brawn_GP');
INSERT INTO constructors (constructorId, constructorRef, name, nationality, url) VALUES (4, 'toro_rosso_ref', 'Toro Rosso', 'Italian', 'http://en.wikipedia.org/wiki/Scuderia_Toro_Rosso');
INSERT INTO constructors (constructorId, constructorRef, name, nationality, url) VALUES (5, 'mclaren_ref', 'McLaren', 'British', 'http://en.wikipedia.org/wiki/McLaren');
INSERT INTO constructors (constructorId, constructorRef, name, nationality, url) VALUES (6, 'williams_ref', 'Williams', 'British', 'http://en.wikipedia.org/wiki/Williams_Grand_Prix_Engineering');
INSERT INTO constructors (constructorId, constructorRef, name, nationality, url) VALUES (7, 'renault_ref', 'Renault', 'French', 'http://en.wikipedia.org/wiki/Renault_in_Formula_One');
INSERT INTO constructorStandings (constructorStandingsId, raceId, constructorId, points, position, positionText, wins) VALUES (1, 291, 1, 0.0, 9, '9', 0);
INSERT INTO constructorStandings (constructorStandingsId, raceId, constructorId, points, position, positionText, wins) VALUES (2, 291, 2, 0.0, 10, '10', 0);
INSERT INTO constructorStandings (constructorStandingsId, raceId, constructorId, points, position, positionText, wins) VALUES (3, 291, 3, 15.0, 1, '1', 2);
INSERT INTO constructorStandings (constructorStandingsId, raceId, constructorId, points, position, positionText, wins) VALUES (4, 291, 4, 0.5, 8, '8', 0);
INSERT INTO constructorStandings (constructorStandingsId, raceId, constructorId, points, position, positionText, wins) VALUES (5, 291, 5, -5.0, 11, '11', 0);
INSERT INTO constructorStandings (constructorStandingsId, raceId, constructorId, points, position, positionText, wins) VALUES (6, 291, 6, 4.0, 0, '0', 0);
INSERT INTO constructorStandings (constructorStandingsId, raceId, constructorId, points, position, positionText, wins) VALUES (7, 290, 7, 0.0, 7, '7', 0);
INSERT INTO constructorStandings (constructorStandingsId, raceId, constructorId, points, position, positionText, wins) VALUES (8, 292, 3, 0.0, 6, '6', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.name FROM constructorStandings AS T1 INNER JOIN constructors AS T2 ON T1.constructorId = T2.constructorId WHERE T1.points = 0 AND T1.raceId = 291;

/*
Gold Result:
('Ferrari',)
('Force India',)
*/

-- Prediction Query
SELECT "constructors"."name" FROM "constructors" INNER JOIN "constructorresults" ON "constructors"."constructorid" = "constructorresults"."constructorid" WHERE "constructorresults"."points" = 0 AND "constructorresults"."raceid" = 291;

/*
Prediction Result:
*/