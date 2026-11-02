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
-- 1. Numerical time parsing vs lexicographical string comparison ('1:09.500' vs '01:10.000' vs '10:00.000').
-- 2. Filtering by race name ('Austrian Grand Prix' vs other races with faster times).
-- 3. Handling of NULL fastestLapTime.
-- 4. Matching both raceId and driverId in pitStops (catching mutants that only join on raceId or only on driverId).
-- 5. Multiple pit stops for the winning driver (catching unwanted DISTINCT or LIMIT 1).
INSERT INTO seasons (year, url) VALUES (2020, 'http://en.wikipedia.org/wiki/2020_Formula_One_World_Championship');
INSERT INTO seasons (year, url) VALUES (2021, 'http://en.wikipedia.org/wiki/2021_Formula_One_World_Championship');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, url) VALUES (1, 'red_bull_ring', 'Red Bull Ring', 'Spielberg', 'Austria', 'http://en.wikipedia.org/wiki/Red_Bull_Ring');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, url) VALUES (2, 'monza', 'Autodromo Nazionale di Monza', 'Monza', 'Italy', 'http://en.wikipedia.org/wiki/Monza_Circuit');
INSERT INTO constructors (constructorId, constructorRef, name, nationality, url) VALUES (1, 'mercedes', 'Mercedes', 'German', 'http://en.wikipedia.org/wiki/Mercedes-Benz_in_Formula_One');
INSERT INTO status (statusId, status) VALUES (1, 'Finished');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (1, 'hamilton', 'Lewis', 'Hamilton', 'http://en.wikipedia.org/wiki/Lewis_Hamilton');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (2, 'bottas', 'Valtteri', 'Bottas', 'http://en.wikipedia.org/wiki/Valtteri_Bottas');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (3, 'verstappen', 'Max', 'Verstappen', 'http://en.wikipedia.org/wiki/Max_Verstappen');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (1, 2020, 1, 1, 'Austrian Grand Prix', '2020-07-05', 'http://en.wikipedia.org/wiki/2020_Austrian_Grand_Prix');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (2, 2021, 1, 1, 'Austrian Grand Prix', '2021-07-04', 'http://en.wikipedia.org/wiki/2021_Austrian_Grand_Prix');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (3, 2020, 2, 2, 'Italian Grand Prix', '2020-09-06', 'http://en.wikipedia.org/wiki/2020_Italian_Grand_Prix');
-- Driver 1 in Race 1 (Austrian GP): True fastest lap in Austrian GP (1:09.500 = 69.5s). Lexicographically > '01:10.000' and '10:00.000'.
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionText, positionOrder, points, laps, fastestLap, rank, fastestLapTime, statusId) VALUES (1, 1, 1, 1, 1, '1', 1, 25, 71, 65, 2, '1:09.500', 1);
-- Driver 2 in Race 1 (Austrian GP): Slower lap (01:10.000 = 70.0s), but lexicographically smaller than '1:09.500', and has rank = 1 to kill mutants using rank=1.
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionText, positionOrder, points, laps, fastestLap, rank, fastestLapTime, statusId) VALUES (2, 1, 2, 1, 2, '2', 2, 18, 71, 60, 1, '01:10.000', 1);
-- Driver 3 in Race 1 (Austrian GP): NULL fastestLapTime.
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionText, positionOrder, points, laps, fastestLap, rank, fastestLapTime, statusId) VALUES (3, 1, 3, 1, 3, '3', 3, 15, 71, NULL, 0, NULL, 1);
-- Driver 1 in Race 2 (Austrian GP): Slower lap (10:00.000 = 600.0s), lexicographically smaller than '1:09.500'.
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionText, positionOrder, points, laps, fastestLap, rank, fastestLapTime, statusId) VALUES (4, 2, 1, 1, 1, '1', 1, 25, 71, 50, 1, '10:00.000', 1);
-- Driver 2 in Race 3 (Italian GP): Overall fastest lap across all races (1:04.000 = 64.0s), but NOT Austrian GP.
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionText, positionOrder, points, laps, fastestLap, rank, fastestLapTime, statusId) VALUES (5, 3, 2, 1, 1, '1', 1, 25, 53, 40, 1, '1:04.000', 1);
-- Driver 2 in Race 2 (Austrian GP): happens to match the 64.0s time if someone forgets to filter T2.name = 'Austrian Grand Prix' in the subquery, wait: let's put Driver 3 in Race 3 with 1:04.000, and Driver 3 in Race 2 (Austrian GP) with 1:15.000. What if a mutant filters T2.name = 'Austrian Grand Prix' in the subquery, getting 69.5s, but forgets T2.name = 'Austrian Grand Prix' in the outer query of lap_record_race?
-- Let's add Driver 3 in Race 3 (Italian GP) having exact same time '1:09.500' (69.5s)! That kills mutants that omit `WHERE T2.name = 'Austrian Grand Prix'` in the outer query!
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionText, positionOrder, points, laps, fastestLap, rank, fastestLapTime, statusId) VALUES (6, 3, 3, 1, 2, '2', 2, 18, 53, 45, 2, '1:09.500', 1);
-- Target pit stops (Driver 1, Race 1): two stops with identical duration to test bag semantics (duplicate preservation) and multiple stops.
INSERT INTO pitStops (raceId, driverId, stop, lap, time, duration, milliseconds) VALUES (1, 1, 1, 20, '14:30:00', '21.500', 21500);
INSERT INTO pitStops (raceId, driverId, stop, lap, time, duration, milliseconds) VALUES (1, 1, 2, 45, '15:05:00', '21.500', 21500);
-- Decoy pit stops:
-- Same race (Race 1), different driver (Driver 2)
INSERT INTO pitStops (raceId, driverId, stop, lap, time, duration, milliseconds) VALUES (1, 2, 1, 21, '14:31:00', '22.999', 22999);
-- Same driver (Driver 1), different race (Race 2)
INSERT INTO pitStops (raceId, driverId, stop, lap, time, duration, milliseconds) VALUES (2, 1, 1, 25, '14:40:00', '23.888', 23888);
-- Decoy for outer filter omission (Driver 3, Race 3)
INSERT INTO pitStops (raceId, driverId, stop, lap, time, duration, milliseconds) VALUES (3, 3, 1, 15, '14:20:00', '24.777', 24777);
-- Decoy for inner filter omission (Driver 2, Race 3)
INSERT INTO pitStops (raceId, driverId, stop, lap, time, duration, milliseconds) VALUES (3, 2, 1, 16, '14:22:00', '25.666', 25666);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
WITH fastest_lap_times AS (SELECT T1.raceId, T1.driverId, T1.FastestLapTime, (CAST(SUBSTRING(T1.FastestLapTime, 1, INSTR(T1.FastestLapTime, ':') - 1) AS REAL) * 60) + (CAST(SUBSTRING(T1.FastestLapTime, INSTR(T1.FastestLapTime, ':') + 1, INSTR(T1.FastestLapTime, '.') - INSTR(T1.FastestLapTime, ':') - 1) AS REAL)) + (CAST(SUBSTRING(T1.FastestLapTime, INSTR(T1.FastestLapTime, '.') + 1) AS REAL) / 1000) AS time_in_seconds FROM results AS T1 WHERE NOT T1.FastestLapTime IS NULL), lap_record_race AS (SELECT T1.raceId, T1.driverId FROM results AS T1 INNER JOIN races AS T2 ON T1.raceId = T2.raceId INNER JOIN circuits AS T3 ON T2.circuitId = T3.circuitId INNER JOIN (SELECT MIN(fastest_lap_times.time_in_seconds) AS min_time_in_seconds FROM fastest_lap_times INNER JOIN races AS T2 ON fastest_lap_times.raceId = T2.raceId INNER JOIN circuits AS T3 ON T2.circuitId = T3.circuitId WHERE T2.name = 'Austrian Grand Prix') AS T4 ON (CAST(SUBSTRING(T1.FastestLapTime, 1, INSTR(T1.FastestLapTime, ':') - 1) AS REAL) * 60) + (CAST(SUBSTRING(T1.FastestLapTime, INSTR(T1.FastestLapTime, ':') + 1, INSTR(T1.FastestLapTime, '.') - INSTR(T1.FastestLapTime, ':') - 1) AS REAL)) + (CAST(SUBSTRING(T1.FastestLapTime, INSTR(T1.FastestLapTime, '.') + 1) AS REAL) / 1000) = T4.min_time_in_seconds WHERE T2.name = 'Austrian Grand Prix') SELECT T4.duration FROM lap_record_race INNER JOIN pitStops AS T4 ON lap_record_race.raceId = T4.raceId AND lap_record_race.driverId = T4.driverId;

/*
Gold Result:
('21.500',)
('21.500',)
*/

-- Prediction Query
SELECT T2.duration FROM races AS T1 JOIN pitStops AS T2 ON T1.raceId = T2.raceId WHERE T1.name = 'Austrian Grand Prix';

/*
Prediction Result:
('21.500',)
('21.500',)
('22.999',)
('23.888',)
*/