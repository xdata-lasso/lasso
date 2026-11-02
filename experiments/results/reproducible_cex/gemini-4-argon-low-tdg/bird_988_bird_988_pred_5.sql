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
-- 1. LIMIT 5 boundary (7 valid groups, testing exact cutoff at 5).
-- 2. Tie-breaking in ORDER BY: identical AVG(duration), broken by forename ASC, then surname ASC.
-- 3. Grouping by (forename, surname) vs grouping by driverId (two distinct driverIds sharing the same forename and surname).
-- 4. Grouping by BOTH (forename, surname) vs ONLY forename or ONLY surname.
-- 5. AVG(duration) with NULL duration values.
INSERT INTO circuits (circuitId, circuitRef, name, url) VALUES (1, 'spa', 'Spa', 'http://spa.com');
INSERT INTO seasons (year, url) VALUES (2021, 'http://2021.com');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (1, 2021, 1, 1, 'Belgian GP', '2021-08-29', 'http://belgp.com');
-- Group 1 & 2 share forename 'Alpha', have tied AVG(duration) = 20.0. Tests tie-breaking on surname ('A_Surname' vs 'B_Surname') and GROUP BY forename only.
INSERT INTO drivers (driverId, driverRef, forename, surname, dob, nationality, url) VALUES (1, 'd1', 'Alpha', 'B_Surname', '1981-05-05', 'German', 'http://d1.com');
INSERT INTO drivers (driverId, driverRef, forename, surname, dob, nationality, url) VALUES (2, 'd2', 'Alpha', 'A_Surname', '1982-05-05', 'German', 'http://d2.com');
-- Group 3 shares surname 'A_Surname' with Driver 2, also tied AVG(duration) = 20.0. Tests tie-breaking on forename ('Alpha' vs 'Beta') and GROUP BY surname only.
INSERT INTO drivers (driverId, driverRef, forename, surname, dob, nationality, url) VALUES (3, 'd3', 'Beta', 'A_Surname', '1983-05-05', 'German', 'http://d3.com');
-- Group 4: Two different driverIds (4 and 5) with the EXACT SAME forename and surname ('Gamma', 'SameName').
-- Driver 4 has duration 10.0, Driver 5 has duration 20.0.
-- Combined AVG for ('Gamma', 'SameName') is 15.0 (ranks 1st overall!).
-- If grouped by driverId instead of (forename, surname), Driver 4 gets 10.0 and Driver 5 gets 20.0, producing duplicate ('Gamma', 'SameName') in output and shifting the LIMIT 5 cutoff.
INSERT INTO drivers (driverId, driverRef, forename, surname, dob, nationality, url) VALUES (4, 'd4', 'Gamma', 'SameName', '1980-06-06', 'German', 'http://d4.com');
INSERT INTO drivers (driverId, driverRef, forename, surname, dob, nationality, url) VALUES (5, 'd5', 'Gamma', 'SameName', '1984-06-06', 'German', 'http://d5.com');
-- Group 5: Driver 6 with AVG(duration) = 25.0 (one stop is 25.0, one stop is NULL; if NULL treated as 0, AVG is 12.5, jumping to 1st place).
INSERT INTO drivers (driverId, driverRef, forename, surname, dob, nationality, url) VALUES (6, 'd6', 'Delta', 'NullTest', '1985-01-01', 'German', 'http://d6.com');
-- Group 6: Driver 7 with AVG(duration) = 30.0 (6th place, excluded by LIMIT 5).
INSERT INTO drivers (driverId, driverRef, forename, surname, dob, nationality, url) VALUES (7, 'd7', 'Epsilon', 'Sixth', '1982-02-02', 'German', 'http://d7.com');
-- Group 7: Driver 8 with AVG(duration) = 40.0 (7th place, excluded by LIMIT 5).
INSERT INTO drivers (driverId, driverRef, forename, surname, dob, nationality, url) VALUES (8, 'd8', 'Zeta', 'Seventh', '1983-03-03', 'German', 'http://d8.com');
INSERT INTO pitStops (raceId, driverId, stop, lap, time, duration, milliseconds) VALUES (1, 1, 1, 10, '14:00:00', '20.0', 20000);
INSERT INTO pitStops (raceId, driverId, stop, lap, time, duration, milliseconds) VALUES (1, 2, 1, 10, '14:00:00', '20.0', 20000);
INSERT INTO pitStops (raceId, driverId, stop, lap, time, duration, milliseconds) VALUES (1, 3, 1, 10, '14:00:00', '20.0', 20000);
INSERT INTO pitStops (raceId, driverId, stop, lap, time, duration, milliseconds) VALUES (1, 4, 1, 10, '14:00:00', '10.0', 10000);
INSERT INTO pitStops (raceId, driverId, stop, lap, time, duration, milliseconds) VALUES (1, 5, 1, 10, '14:00:00', '20.0', 20000);
INSERT INTO pitStops (raceId, driverId, stop, lap, time, duration, milliseconds) VALUES (1, 6, 1, 10, '14:00:00', '25.0', 25000);
INSERT INTO pitStops (raceId, driverId, stop, lap, time, duration, milliseconds) VALUES (1, 6, 2, 20, '14:20:00', NULL, 25000);
INSERT INTO pitStops (raceId, driverId, stop, lap, time, duration, milliseconds) VALUES (1, 7, 1, 10, '14:00:00', '30.0', 30000);
INSERT INTO pitStops (raceId, driverId, stop, lap, time, duration, milliseconds) VALUES (1, 8, 1, 10, '14:00:00', '40.0', 40000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.forename, T2.surname FROM pitStops AS T1 INNER JOIN drivers AS T2 ON T1.driverId = T2.driverId WHERE T2.nationality = 'German' AND STRFTIME('%Y', T2.dob) BETWEEN '1980' AND '1985' GROUP BY T2.forename, T2.surname ORDER BY AVG(T1.duration), T2.forename NULLS LAST, T2.surname NULLS LAST LIMIT 5;

/*
Gold Result:
('Gamma', 'SameName')
('Alpha', 'A_Surname')
('Alpha', 'B_Surname')
('Beta', 'A_Surname')
('Delta', 'NullTest')
*/

-- Prediction Query
SELECT d.forename, d.surname, AVG(ps.duration) AS avg_duration FROM drivers AS d INNER JOIN pitstops AS ps ON d.driverId = ps.driverId WHERE d.dob BETWEEN '1980-01-01' AND '1985-12-31' AND d.nationality = 'German' GROUP BY d.forename, d.surname ORDER BY avg_duration ASC, d.forename NULLS LAST, d.surname NULLS LAST LIMIT 3;

/*
Prediction Result:
('Gamma', 'SameName', 15.0)
('Alpha', 'A_Surname', 20.0)
('Alpha', 'B_Surname', 20.0)
*/