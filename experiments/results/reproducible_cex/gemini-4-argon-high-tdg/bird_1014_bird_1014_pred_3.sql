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
INSERT INTO circuits (circuitId, circuitRef, name, location, country, lat, lng, alt, url) VALUES (1, 'catalunya', 'Circuit de Barcelona-Catalunya', 'Italy', 'Spain', 41.57, 2.26, 100, 'http://en.wikipedia.org/wiki/Circuit_de_Barcelona-Catalunya');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, lat, lng, alt, url) VALUES (2, 'monza', 'Autodromo Nazionale di Monza', 'Monza', 'Italy', 45.61, 9.28, 162, 'http://en.wikipedia.org/wiki/Autodromo_Nazionale_Monza');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, lat, lng, alt, url) VALUES (3, 'imola', 'Autodromo Enzo e Dino Ferrari', 'Imola', 'Italy', 44.34, 11.71, 37, 'http://en.wikipedia.org/wiki/Autodromo_Enzo_e_Dino_Ferrari');
INSERT INTO constructors (constructorId, constructorRef, name, nationality, url) VALUES (1, 'ferrari', 'Ferrari', 'Italian', 'http://en.wikipedia.org/wiki/Scuderia_Ferrari');
INSERT INTO constructors (constructorId, constructorRef, name, nationality, url) VALUES (2, 'mclaren', 'McLaren', 'British', 'http://en.wikipedia.org/wiki/McLaren');
INSERT INTO drivers (driverId, driverRef, number, code, forename, surname, dob, nationality, url) VALUES (1, 'leclerc', 16, 'LEC', 'Charles', 'Leclerc', '1997-10-16', 'Monegasque', 'http://en.wikipedia.org/wiki/Charles_Leclerc');
INSERT INTO drivers (driverId, driverRef, number, code, forename, surname, dob, nationality, url) VALUES (2, 'norris', 4, 'NOR', 'Lando', 'Norris', '1999-11-13', 'British', 'http://en.wikipedia.org/wiki/Lando_Norris');
INSERT INTO drivers (driverId, driverRef, number, code, forename, surname, dob, nationality, url) VALUES (3, 'sainz', 55, 'SAI', 'Carlos', 'Sainz', '1994-09-01', 'Spanish', 'http://en.wikipedia.org/wiki/Carlos_Sainz_Jr.');
INSERT INTO drivers (driverId, driverRef, number, code, forename, surname, dob, nationality, url) VALUES (4, 'piastri', 81, 'PIA', 'Oscar', 'Piastri', '2001-04-06', 'Australian', 'http://en.wikipedia.org/wiki/Oscar_Piastri');
INSERT INTO seasons (year, url) VALUES (2023, 'http://en.wikipedia.org/wiki/2023_Formula_One_World_Championship');
INSERT INTO status (statusId, status) VALUES (1, 'Finished');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (1, 2023, 1, 1, 'Spanish Grand Prix', '2023-06-04', '13:00:00', 'http://en.wikipedia.org/wiki/2023_Spanish_Grand_Prix');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (2, 2023, 2, 2, 'Italian Grand Prix', '2023-09-03', '13:00:00', 'http://en.wikipedia.org/wiki/2023_Italian_Grand_Prix');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (3, 2023, 3, 3, 'Emilia Romagna Grand Prix', '2023-05-21', '13:00:00', 'http://en.wikipedia.org/wiki/2023_Emilia_Romagna_Grand_Prix');
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, time, milliseconds, fastestLap, rank, fastestLapTime, fastestLapSpeed, statusId) VALUES (1, 1, 1, 1, 16, 1, 1, '1', 1, 25.0, 66, '1:27:57.940', 5277940, 60, 1, '1:10.100', '235.000', 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, time, milliseconds, fastestLap, rank, fastestLapTime, fastestLapSpeed, statusId) VALUES (2, 2, 1, 1, 16, 1, 1, '1', 1, 25.0, 51, '1:10:00.000', 1000000, 1, 1, NULL, '260.000', 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, time, milliseconds, fastestLap, rank, fastestLapTime, fastestLapSpeed, statusId) VALUES (3, 2, 2, 2, 4, 2, 1, '1', 1, 25.0, 51, '1:13:00.000', 3000000, 5, 1, '1:25.500', '200.000', 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, time, milliseconds, fastestLap, rank, fastestLapTime, fastestLapSpeed, statusId) VALUES (4, 2, 3, 1, 55, 10, 10, '10', 10, 0.0, 51, '1:23:20.000', 5000000, 50, 10, '1:30.200', '250.000', 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, time, milliseconds, fastestLap, rank, fastestLapTime, fastestLapSpeed, statusId) VALUES (5, 3, 4, 2, 81, 4, 4, '4', 4, 10.0, 63, '1:06:40.000', 4000000, 25, 3, '1:18.300', '225.000', 1);
INSERT INTO lapTimes (raceId, driverId, lap, position, time, milliseconds) VALUES (2, 2, 5, 1, '1:12.000', 72000);
INSERT INTO qualifying (qualifyId, raceId, driverId, constructorId, number, position, q1, q2, q3) VALUES (1, 2, 2, 2, 4, 1, '1:12.000', '1:11.500', '1:11.000');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
WITH fastest_lap_times AS (SELECT T1.raceId, T1.FastestLapTime, (CAST(SUBSTRING(T1.FastestLapTime, 1, INSTR(T1.FastestLapTime, ':') - 1) AS REAL) * 60) + (CAST(SUBSTRING(T1.FastestLapTime, INSTR(T1.FastestLapTime, ':') + 1, INSTR(T1.FastestLapTime, '.') - INSTR(T1.FastestLapTime, ':') - 1) AS REAL)) + (CAST(SUBSTRING(T1.FastestLapTime, INSTR(T1.FastestLapTime, '.') + 1) AS REAL) / 1000) AS time_in_seconds FROM results AS T1 WHERE NOT T1.FastestLapTime IS NULL) SELECT T1.FastestLapTime AS lap_record FROM results AS T1 INNER JOIN races AS T2 ON T1.raceId = T2.raceId INNER JOIN circuits AS T3 ON T2.circuitId = T3.circuitId INNER JOIN (SELECT MIN(fastest_lap_times.time_in_seconds) AS min_time_in_seconds FROM fastest_lap_times INNER JOIN races AS T2 ON fastest_lap_times.raceId = T2.raceId INNER JOIN circuits AS T3 ON T2.circuitId = T3.circuitId WHERE T3.country = 'Italy') AS T4 ON (CAST(SUBSTRING(T1.FastestLapTime, 1, INSTR(T1.FastestLapTime, ':') - 1) AS REAL) * 60) + (CAST(SUBSTRING(T1.FastestLapTime, INSTR(T1.FastestLapTime, ':') + 1, INSTR(T1.FastestLapTime, '.') - INSTR(T1.FastestLapTime, ':') - 1) AS REAL)) + (CAST(SUBSTRING(T1.FastestLapTime, INSTR(T1.FastestLapTime, '.') + 1) AS REAL) / 1000) = T4.min_time_in_seconds LIMIT 1;

/*
Gold Result:
('1:18.300',)
*/

-- Prediction Query
SELECT T3.circuitId, MIN(T1.time) AS fastest_lap_time FROM lapTimes AS T1 INNER JOIN races AS T2 ON T1.raceId = T2.raceId INNER JOIN circuits AS T3 ON T2.circuitId = T3.circuitId WHERE T3.country = 'Italy' GROUP BY T3.circuitId;

/*
Prediction Result:
(2, '1:12.000')
*/