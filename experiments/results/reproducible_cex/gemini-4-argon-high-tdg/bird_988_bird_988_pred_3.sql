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
INSERT INTO seasons (year, url) VALUES (2012, 'http://en.wikipedia.org/wiki/2012_Formula_One_season');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, url) VALUES (1, 'hockenheimring', 'Hockenheimring', 'Hockenheim', 'Germany', 'http://en.wikipedia.org/wiki/Hockenheimring');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (10, 2012, 10, 1, 'German Grand Prix', '2012-07-22', '12:00:00', 'http://en.wikipedia.org/wiki/2012_German_Grand_Prix');
INSERT INTO drivers (driverId, driverRef, forename, surname, dob, nationality, url) VALUES (1, 'glock', 'Timo', 'Glock', '1982-03-18', 'German', 'http://en.wikipedia.org/wiki/Timo_Glock');
INSERT INTO drivers (driverId, driverRef, forename, surname, dob, nationality, url) VALUES (2, 'sutil', 'Adrian', 'Sutil', '1983-01-11', 'German', 'http://en.wikipedia.org/wiki/Adrian_Sutil');
INSERT INTO drivers (driverId, driverRef, forename, surname, dob, nationality, url) VALUES (3, 'rosberg', 'Nico', 'Rosberg', '1985-06-27', 'German', 'http://en.wikipedia.org/wiki/Nico_Rosberg');
INSERT INTO drivers (driverId, driverRef, forename, surname, dob, nationality, url) VALUES (4, 'button', 'Jenson', 'Button', '1980-01-19', 'British', 'http://en.wikipedia.org/wiki/Jenson_Button');
INSERT INTO drivers (driverId, driverRef, forename, surname, dob, nationality, url) VALUES (5, 'heidfeld', 'Nick', 'Heidfeld', '1977-05-10', 'German', 'http://en.wikipedia.org/wiki/Nick_Heidfeld');
INSERT INTO drivers (driverId, driverRef, forename, surname, dob, nationality, url) VALUES (6, 'vettel', 'Sebastian', 'Vettel', '1987-07-03', 'German', 'http://en.wikipedia.org/wiki/Sebastian_Vettel');
INSERT INTO pitStops (raceId, driverId, stop, lap, time, duration, milliseconds) VALUES (10, 1, 3, 40, '14:50:00', '25.000', 10000);
INSERT INTO pitStops (raceId, driverId, stop, lap, time, duration, milliseconds) VALUES (10, 2, 2, 20, '14:30:00', '20.000', 80000);
INSERT INTO pitStops (raceId, driverId, stop, lap, time, duration, milliseconds) VALUES (10, 2, 4, 30, '14:40:00', '22.000', 90000);
INSERT INTO pitStops (raceId, driverId, stop, lap, time, duration, milliseconds) VALUES (10, 3, 1, 10, '14:10:00', '10.000', 50000);
INSERT INTO pitStops (raceId, driverId, stop, lap, time, duration, milliseconds) VALUES (10, 3, 2, 15, '14:15:00', '30.000', 50000);
INSERT INTO pitStops (raceId, driverId, stop, lap, time, duration, milliseconds) VALUES (10, 3, 3, 25, '14:25:00', '32.000', 50000);
INSERT INTO pitStops (raceId, driverId, stop, lap, time, duration, milliseconds) VALUES (10, 4, 1, 12, '14:12:00', '12.000', 12000);
INSERT INTO pitStops (raceId, driverId, stop, lap, time, duration, milliseconds) VALUES (10, 5, 1, 14, '14:14:00', '11.000', 11000);
INSERT INTO pitStops (raceId, driverId, stop, lap, time, duration, milliseconds) VALUES (10, 6, 1, 16, '14:16:00', '13.000', 13000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.forename, T2.surname FROM pitStops AS T1 INNER JOIN drivers AS T2 ON T1.driverId = T2.driverId WHERE T2.nationality = 'German' AND STRFTIME('%Y', T2.dob) BETWEEN '1980' AND '1985' GROUP BY T2.forename, T2.surname ORDER BY AVG(T1.duration), T2.forename NULLS LAST, T2.surname NULLS LAST LIMIT 5;

/*
Gold Result:
('Adrian', 'Sutil')
('Nico', 'Rosberg')
('Timo', 'Glock')
*/

-- Prediction Query
SELECT d.forename || ' ' || d.surname AS full_name, AVG(CAST(p.duration AS REAL)) AS avg_duration FROM drivers AS d JOIN pitStops AS p ON d.driverId = p.driverId WHERE d.nationality = 'German' AND STRFTIME('%Y', d.dob) BETWEEN '1980' AND '1985' GROUP BY d.driverId ORDER BY avg_duration ASC, full_name NULLS LAST LIMIT 3;

/*
Prediction Result:
('Adrian Sutil', 21.0)
('Nico Rosberg', 24.0)
('Timo Glock', 25.0)
*/