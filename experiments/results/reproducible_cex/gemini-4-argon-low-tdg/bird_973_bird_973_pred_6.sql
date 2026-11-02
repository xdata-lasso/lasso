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
-- Tests predicate boundaries: nationality ('Spanish' vs others/NULL), dob ('1981-12-31' vs '1982-01-01' vs '1982-12-31' vs NULL), and INNER JOIN vs LEFT/RIGHT JOIN (drivers without pitStops)
INSERT INTO circuits (circuitId, circuitRef, name, url) VALUES (1, 'catalunya', 'Circuit de Barcelona-Catalunya', 'http://en.wikipedia.org/wiki/Circuit_de_Barcelona-Catalunya');
INSERT INTO seasons (year, url) VALUES (2020, 'http://en.wikipedia.org/wiki/2020_Formula_One_season');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (1, 2020, 1, 1, 'Spanish Grand Prix', '2020-08-16', 'http://en.wikipedia.org/wiki/2020_Spanish_Grand_Prix');
INSERT INTO drivers (driverId, driverRef, forename, surname, dob, nationality, url) VALUES (1, 'alonso', 'Fernando', 'Alonso', '1981-07-29', 'Spanish', 'http://url1');
INSERT INTO drivers (driverId, driverRef, forename, surname, dob, nationality, url) VALUES (2, 'boundary_valid', 'Pedro', 'de la Rosa', '1981-12-31', 'Spanish', 'http://url2');
INSERT INTO drivers (driverId, driverRef, forename, surname, dob, nationality, url) VALUES (3, 'boundary_invalid1', 'Marc', 'Gene', '1982-01-01', 'Spanish', 'http://url3');
INSERT INTO drivers (driverId, driverRef, forename, surname, dob, nationality, url) VALUES (4, 'boundary_invalid2', 'Carlos', 'Sainz', '1982-05-05', 'Spanish', 'http://url4');
INSERT INTO drivers (driverId, driverRef, forename, surname, dob, nationality, url) VALUES (5, 'wrong_nat', 'Alain', 'Prost', '1955-02-24', 'French', 'http://url5');
INSERT INTO drivers (driverId, driverRef, forename, surname, dob, nationality, url) VALUES (6, 'null_dob', 'Emilio', 'de Villota', NULL, 'Spanish', 'http://url6');
INSERT INTO drivers (driverId, driverRef, forename, surname, dob, nationality, url) VALUES (7, 'null_nat', 'Alfonso', 'de Portago', '1928-10-11', NULL, 'http://url7');
INSERT INTO drivers (driverId, driverRef, forename, surname, dob, nationality, url) VALUES (8, 'no_pitstops', 'Luis', 'Perez-Sala', '1959-05-15', 'Spanish', 'http://url8');
INSERT INTO pitStops (raceId, driverId, stop, lap, time, duration, milliseconds) VALUES (1, 1, 1, 10, '14:20:00', '22.5', 22500);
INSERT INTO pitStops (raceId, driverId, stop, lap, time, duration, milliseconds) VALUES (1, 2, 1, 12, '14:30:00', '23.0', 23000);
INSERT INTO pitStops (raceId, driverId, stop, lap, time, duration, milliseconds) VALUES (1, 3, 1, 15, '14:40:00', '21.0', 21000);
INSERT INTO pitStops (raceId, driverId, stop, lap, time, duration, milliseconds) VALUES (1, 4, 1, 16, '14:50:00', '25.0', 25000);
INSERT INTO pitStops (raceId, driverId, stop, lap, time, duration, milliseconds) VALUES (1, 5, 1, 18, '15:00:00', '24.0', 24000);
INSERT INTO pitStops (raceId, driverId, stop, lap, time, duration, milliseconds) VALUES (1, 6, 1, 19, '15:10:00', '24.0', 24000);
INSERT INTO pitStops (raceId, driverId, stop, lap, time, duration, milliseconds) VALUES (1, 7, 1, 20, '15:20:00', '24.0', 24000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.driverId FROM pitStops AS T1 INNER JOIN drivers AS T2 ON T1.driverId = T2.driverId WHERE T2.nationality = 'Spanish' AND STRFTIME('%Y', T2.dob) < '1982' ORDER BY T1.time DESC, T1.raceid NULLS LAST, T1.driverid NULLS LAST, T1.stop NULLS LAST, T2.driverid NULLS LAST LIMIT 10;

/*
Gold Result:
(2,)
(1,)
*/

-- Prediction Query
SELECT d.forename, d.surname FROM drivers AS d JOIN laptimes AS la ON d.driverId = la.driverId WHERE d.nationality = 'Spanish' AND STRFTIME('%Y', d.dob) < '1982' GROUP BY d.driverId ORDER BY MAX(la.time) DESC, d.forename NULLS LAST, d.surname NULLS LAST LIMIT 10;

/*
Prediction Result:
*/