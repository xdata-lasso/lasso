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
INSERT INTO seasons (year, url) VALUES (3, 'default1'), (2, '%Y'), (6, 'default2'), (1, '1985'), (5, 'German'), (4, '1980'), (0, 'unique_6'), (7, 'unique_7'), (8, 'unique_8'), (9, 'unique_9'), (10, 'unique_10'), (11, 'unique_11'), (12, 'unique_12'), (13, 'unique_13'), (14, 'unique_14'), (15, 'unique_15'), (16, 'unique_16'), (17, 'unique_17'), (18, 'unique_18'), (19, 'unique_19'), (20, 'unique_20'), (21, 'unique_21'), (22, 'unique_22'), (23, 'unique_23'), (24, 'unique_24'), (25, 'unique_25'), (26, 'unique_26'), (27, 'unique_27'), (28, 'unique_28'), (29, 'unique_29'), (30, 'unique_30'), (31, 'unique_31'), (32, 'unique_32'), (33, 'unique_33'), (34, 'unique_34'), (35, 'unique_35'), (36, 'unique_36'), (37, 'unique_37'), (38, 'unique_38'), (39, 'unique_39');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (3, 'German', 6, '1985', 'default1', 'default2', '2023-01-02', 'default2', 'German'), (5, 'German', 6, '%Y', 'German', 'default1', '1985-10-27', 'German', 'default1'), (1, '1980', 1, 'default2', 'German', 'default2', '2023-01-02', 'default2', 'default2'), (4, 'German', 3, NULL, 'German', 'default1', NULL, '%Y', '%Y'), (2, '1985', 2, NULL, '1980', 'German', '2023-01-01', '1980', '1985');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (3, '1980', 'default1', '1985', 'German', 2.0, 0.0, 3, 'default1'), (5, 'German', '1980', 'German', NULL, 3.0, 3.0, 2, '1985'), (1, '%Y', 'German', 'German', 'default1', 2.0, 1.0, 1, '1980'), (0, 'German', 'German', 'default1', 'default2', 1.0, 4.0, 3, 'German'), (4, '1980', '1985', 'default1', '1985', 5.0, 1.0, 3, 'default2'), (2, 'German', 'default1', 'German', '%Y', 0.0, NULL, 4, '%Y'), (6, '1985', '%Y', NULL, '1985', 5.0, 2.0, 1, 'unique_6'), (7, '1980', '%Y', 'default2', '1985', 0.0, 3.0, 5, 'unique_7');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (5, 10, 5, 0, '1980', '1980-10-27', 'default1', '%Y'), (2, 16, 2, 0, 'German', '1980-10-27', '1980', 'default2'), (3, 1, 5, 5, '%Y', '2023-01-02', '1980', '1980'), (4, 15, 2, 2, 'default2', '1985-10-27', '1980', 'default1'), (6, 10, 5, 1, 'German', '2023-01-02', '%Y', 'German'), (0, 32, 2, 1, '%Y', '2023-01-01', 'default1', '1985'), (1, 31, 3, 2, '%Y', '2023-01-02', '1980', NULL), (7, 7, 0, 1, '1985', '1985-10-27', '%Y', 'unique_7'), (8, 29, 5, 5, 'default1', '1980-10-27', NULL, 'unique_8'), (9, 17, 5, 4, 'default2', '2023-01-02', NULL, 'unique_9'), (10, 11, 1, 5, '1985', '1985-10-27', '%Y', 'unique_10');
INSERT INTO pitstops (raceid, driverid, stop, lap, time, duration, milliseconds) VALUES (4, 1, 4, 5, 'default2', NULL, 0), (1, 2, 3, 1, '%Y', '1985', 4), (4, 3, 6, 1, 'default1', NULL, NULL), (5, 5, 1, 1, 'default1', '%Y', 4), (3, 4, 3, 5, 'default1', 'default1', 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.forename, T2.surname FROM pitStops AS T1 INNER JOIN drivers AS T2 ON T1.driverId = T2.driverId WHERE T2.nationality = 'German' AND STRFTIME('%Y', T2.dob) BETWEEN '1980' AND '1985' GROUP BY T2.forename, T2.surname ORDER BY AVG(T1.duration), T2.forename NULLS LAST, T2.surname NULLS LAST LIMIT 5;

/*
Gold Result:
('German', 'default1')
*/

-- Prediction Query
SELECT d.forename, d.surname, AVG(p.duration) AS avg_duration FROM drivers AS d INNER JOIN pitStops AS p ON d.driverId = p.driverId WHERE d.nationality = 'German' AND STRFTIME('%Y', d.dob) BETWEEN '1980' AND '1985' GROUP BY d.driverId ORDER BY avg_duration ASC, d.forename NULLS LAST, d.surname NULLS LAST LIMIT 3;

/*
Prediction Result:
('German', 'default1', 0.0)
*/