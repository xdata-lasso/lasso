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
-- Core dataset testing:
-- 1. T2.name = 'Austrian Grand Prix' vs T3.name / T3.country / LIKE '%Austrian Grand Prix%'
-- 2. MIN(fastestLapTime) vs MAX, LIMIT 1 (without ORDER BY), or missing aggregation
-- 3. Filtering by rank = 1, position = 1, or statusId = 1 (Winner does NOT have the fastest lap)
-- 4. Confusing results.fastestLapTime with results.time, results.fastestLapSpeed, lapTimes.time, or qualifying.q1/q2/q3
-- 5. Confusing join keys (e.g., joining on resultId = raceId or circuitId = raceId)
INSERT INTO seasons (year, url) VALUES (2021, 'http://en.wikipedia.org/wiki/2021_F1');
INSERT INTO seasons (year, url) VALUES (2022, 'http://en.wikipedia.org/wiki/2022_F1');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, lat, lng, alt, url) VALUES (10, 'red_bull_ring', 'Red Bull Ring', 'Spielberg', 'Austria', 47.2197, 14.7647, 678, 'http://en.wikipedia.org/wiki/Red_Bull_Ring');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, lat, lng, alt, url) VALUES (20, 'austrian_circuit', 'Austrian Grand Prix', 'Vienna', 'Austria', 48.2082, 16.3738, 151, 'http://en.wikipedia.org/wiki/Vienna_Circuit');
INSERT INTO constructors (constructorId, constructorRef, name, nationality, url) VALUES (1, 'red_bull', 'Red Bull', 'Austrian', 'http://en.wikipedia.org/wiki/Red_Bull_Racing');
INSERT INTO constructors (constructorId, constructorRef, name, nationality, url) VALUES (2, 'mercedes', 'Mercedes', 'German', 'http://en.wikipedia.org/wiki/Mercedes_F1');
INSERT INTO drivers (driverId, driverRef, number, code, forename, surname, dob, nationality, url) VALUES (1, 'verstappen', 33, 'VER', 'Max', 'Verstappen', '1997-09-30', 'Dutch', 'http://en.wikipedia.org/wiki/Max_Verstappen');
INSERT INTO drivers (driverId, driverRef, number, code, forename, surname, dob, nationality, url) VALUES (2, 'hamilton', 44, 'HAM', 'Lewis', 'Hamilton', '1985-01-07', 'British', 'http://en.wikipedia.org/wiki/Lewis_Hamilton');
INSERT INTO drivers (driverId, driverRef, number, code, forename, surname, dob, nationality, url) VALUES (3, 'norris', 4, 'NOR', 'Lando', 'Norris', '1999-11-13', 'British', 'http://en.wikipedia.org/wiki/Lando_Norris');
INSERT INTO status (statusId, status) VALUES (1, 'Finished');
INSERT INTO status (statusId, status) VALUES (2, '+1 Lap');
INSERT INTO status (statusId, status) VALUES (3, 'Engine');
-- Race 100: Target race ('Austrian Grand Prix' at circuit 10 'Red Bull Ring')
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (100, 2021, 9, 10, 'Austrian Grand Prix', '2021-07-04', '13:00:00', 'http://en.wikipedia.org/wiki/2021_Austrian_GP');
-- Race 101: Another target race ('Austrian Grand Prix' in a different year)
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (101, 2022, 11, 10, 'Austrian Grand Prix', '2022-07-10', '13:00:00', 'http://en.wikipedia.org/wiki/2022_Austrian_GP');
-- Race 102: Decoy race on the same circuit (Tests filtering by circuitId or country = 'Austria' instead of race name)
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (102, 2021, 8, 10, 'Styrian Grand Prix', '2021-06-27', '13:00:00', 'http://en.wikipedia.org/wiki/2021_Styrian_GP');
-- Race 103: Decoy race where circuit.name is 'Austrian Grand Prix' and race.name starts with 'Austrian Grand Prix' (Tests T3.name vs T2.name and LIKE vs =)
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (103, 2021, 10, 20, 'Austrian Grand Prix Qualifying', '2021-07-18', '13:00:00', 'http://en.wikipedia.org/wiki/2021_Other_GP');
-- Results for Race 100 (Austrian Grand Prix 2021)
-- Result 1: Inserted first, slower fastestLapTime ('1:07.500'), winner (position=1, rank=2)
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, time, milliseconds, fastestLap, rank, fastestLapTime, fastestLapSpeed, statusId) VALUES (1, 100, 1, 1, 33, 1, 1, '1', 1, 25.0, 71, '1:23:54.543', 5034543, 60, 2, '1:07.500', '220.500', 1);
-- Result 2: NULL fastestLapTime
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, time, milliseconds, fastestLap, rank, fastestLapTime, fastestLapSpeed, statusId) VALUES (2, 100, 2, 2, 44, 2, NULL, 'R', 20, 0.0, 10, NULL, NULL, NULL, 0, NULL, NULL, 3);
-- Result 3: The true minimum fastestLapTime ('1:06.123'), NOT the race winner (position=4), rank=2 (in case mutant filters rank=1), statusId=2
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, time, milliseconds, fastestLap, rank, fastestLapTime, fastestLapSpeed, statusId) VALUES (3, 100, 3, 1, 4, 3, 4, '4', 4, 12.0, 70, '1:01.000', 61000, 62, 2, '1:06.123', '230.100', 2);
-- Results for Race 101 (Austrian Grand Prix 2022)
-- Result 4: rank=1, position=1, but slower fastestLapTime ('1:06.800') than Result 3 ('1:06.123')
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, time, milliseconds, fastestLap, rank, fastestLapTime, fastestLapSpeed, statusId) VALUES (4, 101, 1, 1, 33, 1, 1, '1', 1, 26.0, 71, '1:24:00.000', 5040000, 55, 1, '1:06.800', '228.000', 1);
-- Results for Decoy Race 102 (Styrian Grand Prix at Red Bull Ring) - Has a faster lap ('1:04.000') to kill circuit/country mutants
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, time, milliseconds, fastestLap, rank, fastestLapTime, fastestLapSpeed, statusId) VALUES (5, 102, 1, 1, 33, 1, 1, '1', 1, 25.0, 71, '1:22:00.000', 4920000, 68, 1, '1:04.000', '235.000', 1);
-- Results for Decoy Race 103 ('Austrian Grand Prix Qualifying' at circuit 'Austrian Grand Prix') - Has faster lap ('1:03.000') to kill T3.name and LIKE mutants
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, time, milliseconds, fastestLap, rank, fastestLapTime, fastestLapSpeed, statusId) VALUES (6, 103, 2, 2, 44, 1, 1, '1', 1, 25.0, 71, '1:21:00.000', 4860000, 70, 1, '1:03.000', '240.000', 1);
-- Decoy lapTimes and qualifying for Race 100 (To kill mutants querying lapTimes.time or qualifying.q1/q2/q3 instead of results.fastestLapTime)
INSERT INTO lapTimes (raceId, driverId, lap, position, time, milliseconds) VALUES (100, 1, 1, 1, '1:05.000', 65000);
INSERT INTO qualifying (qualifyId, raceId, driverId, constructorId, number, position, q1, q2, q3) VALUES (1, 100, 1, 1, 33, 1, '1:04.500', '1:04.200', '1:03.999');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
WITH fastest_lap_times AS (SELECT T1.raceId, T1.fastestLapTime FROM results AS T1 WHERE NOT T1.FastestLapTime IS NULL) SELECT MIN(fastest_lap_times.fastestLapTime) AS lap_record FROM fastest_lap_times INNER JOIN races AS T2 ON fastest_lap_times.raceId = T2.raceId INNER JOIN circuits AS T3 ON T2.circuitId = T3.circuitId WHERE T2.name = 'Austrian Grand Prix';

/*
Gold Result:
('1:06.123',)
*/

-- Prediction Query
SELECT MIN(COALESCE(T1.milliseconds, 999999)) FROM lapTimes AS T1 INNER JOIN races AS T2 ON T1.raceId = T2.raceId INNER JOIN circuits AS T3 ON T2.circuitId = T3.circuitId WHERE T3.name = 'Red Bull Ring';

/*
Prediction Result:
(65000,)
*/