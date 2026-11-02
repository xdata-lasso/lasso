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
-- 1. Nationality predicate ('German' vs 'British', 'german', NULL).
-- 2. DOB year boundary conditions (1979, 1980, 1985, 1986, NULL).
-- 3. INNER JOIN vs LEFT JOIN (valid driver with NO pitStops).
-- 4. AVG(duration) vs SUM(duration), MIN(duration), MAX(duration), COUNT(*).
-- 5. AVG(duration) vs AVG(milliseconds) (inversely correlated values).
-- 6. GROUP BY without HAVING vs no GROUP BY (duplicate rows).
INSERT INTO circuits (circuitId, circuitRef, name, url) VALUES (1, 'monza', 'Monza', 'http://monza.com');
INSERT INTO seasons (year, url) VALUES (2020, 'http://2020.com');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (1, 2020, 1, 1, 'Italian GP', '2020-09-06', 'http://itgp.com');
-- Driver 1: Valid (1980 boundary), 3 pitStops -> SUM=30.0, AVG=10.0, MIN=10.0, MAX=10.0. Milliseconds AVG=50000 (high).
INSERT INTO drivers (driverId, driverRef, forename, surname, dob, nationality, url) VALUES (1, 'd1', 'Nick', 'Heidfeld', '1980-01-01', 'German', 'http://d1.com');
-- Driver 2: Valid (1985 boundary), 2 pitStops -> SUM=24.0, AVG=12.0, MIN=2.0, MAX=22.0. Milliseconds AVG=10000 (low).
-- Note: Driver 1 vs Driver 2 kills AVG vs SUM (10 < 12, but 30 > 24), AVG vs MIN (10 > 2), AVG vs COUNT (3 > 2), and duration vs milliseconds (10 < 12, but 50000 > 10000).
INSERT INTO drivers (driverId, driverRef, forename, surname, dob, nationality, url) VALUES (2, 'd2', 'Nico', 'Rosberg', '1985-12-31', 'German', 'http://d2.com');
-- Driver 3: Valid (1983), 1 pitStop -> SUM=15.0, AVG=15.0, MIN=15.0, MAX=15.0.
-- Kills AVG vs MAX when compared with Driver 2 (AVG: D2(12) < D3(15), MAX: D2(22) > D3(15)).
INSERT INTO drivers (driverId, driverRef, forename, surname, dob, nationality, url) VALUES (3, 'd3', 'Adrian', 'Sutil', '1983-05-15', 'German', 'http://d3.com');
-- Driver 4: Invalid nationality ('British'), valid DOB (1982), very fast pitStop (duration=1.0).
INSERT INTO drivers (driverId, driverRef, forename, surname, dob, nationality, url) VALUES (4, 'd4', 'Jenson', 'Button', '1982-01-19', 'British', 'http://d4.com');
-- Driver 5: Invalid DOB (1979-12-31, just below 1980), valid nationality ('German'), fast pitStop (duration=1.0).
INSERT INTO drivers (driverId, driverRef, forename, surname, dob, nationality, url) VALUES (5, 'd5', 'Ralf', 'Schumacher', '1979-12-31', 'German', 'http://d5.com');
-- Driver 6: Invalid DOB (1986-01-01, just above 1985), valid nationality ('German'), fast pitStop (duration=1.0).
INSERT INTO drivers (driverId, driverRef, forename, surname, dob, nationality, url) VALUES (6, 'd6', 'Sebastian', 'Vettel', '1986-01-01', 'German', 'http://d6.com');
-- Driver 7: Valid German & DOB (1981), but NO pitStops (kills LEFT JOIN on drivers).
INSERT INTO drivers (driverId, driverRef, forename, surname, dob, nationality, url) VALUES (7, 'd7', 'Timo', 'Glock', '1981-03-18', 'German', 'http://d7.com');
-- Driver 8: NULL nationality and NULL dob.
INSERT INTO drivers (driverId, driverRef, forename, surname, dob, nationality, url) VALUES (8, 'd8', 'Unknown', 'Driver', NULL, NULL, 'http://d8.com');
INSERT INTO pitStops (raceId, driverId, stop, lap, time, duration, milliseconds) VALUES (1, 1, 1, 10, '14:00:00', '10.0', 50000);
INSERT INTO pitStops (raceId, driverId, stop, lap, time, duration, milliseconds) VALUES (1, 1, 2, 20, '14:20:00', '10.0', 50000);
INSERT INTO pitStops (raceId, driverId, stop, lap, time, duration, milliseconds) VALUES (1, 1, 3, 30, '14:40:00', '10.0', 50000);
INSERT INTO pitStops (raceId, driverId, stop, lap, time, duration, milliseconds) VALUES (1, 2, 1, 10, '14:00:00', '2.0', 10000);
INSERT INTO pitStops (raceId, driverId, stop, lap, time, duration, milliseconds) VALUES (1, 2, 2, 20, '14:20:00', '22.0', 10000);
INSERT INTO pitStops (raceId, driverId, stop, lap, time, duration, milliseconds) VALUES (1, 3, 1, 15, '14:10:00', '15.0', 15000);
INSERT INTO pitStops (raceId, driverId, stop, lap, time, duration, milliseconds) VALUES (1, 4, 1, 10, '14:00:00', '1.0', 1000);
INSERT INTO pitStops (raceId, driverId, stop, lap, time, duration, milliseconds) VALUES (1, 5, 1, 10, '14:00:00', '1.0', 1000);
INSERT INTO pitStops (raceId, driverId, stop, lap, time, duration, milliseconds) VALUES (1, 6, 1, 10, '14:00:00', '1.0', 1000);
INSERT INTO pitStops (raceId, driverId, stop, lap, time, duration, milliseconds) VALUES (1, 8, 1, 10, '14:00:00', '1.0', 1000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.forename, T2.surname FROM pitStops AS T1 INNER JOIN drivers AS T2 ON T1.driverId = T2.driverId WHERE T2.nationality = 'German' AND STRFTIME('%Y', T2.dob) BETWEEN '1980' AND '1985' GROUP BY T2.forename, T2.surname ORDER BY AVG(T1.duration), T2.forename NULLS LAST, T2.surname NULLS LAST LIMIT 5;

/*
Gold Result:
('Nick', 'Heidfeld')
('Nico', 'Rosberg')
('Adrian', 'Sutil')
*/

-- Prediction Query
SELECT d.forename, d.surname FROM drivers AS d JOIN pitStops AS ps ON d.driverId = ps.driverId JOIN races AS r ON ps.raceId = r.raceId JOIN results AS rs ON r.raceId = rs.raceId WHERE d.nationality = 'German' AND d.dob BETWEEN '1980-01-01' AND '1985-12-31' GROUP BY d.driverId ORDER BY AVG(ps.duration) ASC, d.forename NULLS LAST, d.surname NULLS LAST LIMIT 3;

/*
Prediction Result:
*/