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
-- Tests basic functionality, filtering by race name 'Austrian Grand Prix', NULL handling in fastestLapTime, and composite join (raceId AND driverId) on pitStops.
INSERT INTO seasons (year, url) VALUES (2020, 'http://en.wikipedia.org/wiki/2020_Formula_One_World_Championship');
INSERT INTO circuits (circuitId, circuitRef, name, url) VALUES (1, 'red_bull_ring', 'Red Bull Ring', 'http://en.wikipedia.org/wiki/Red_Bull_Ring');
INSERT INTO circuits (circuitId, circuitRef, name, url) VALUES (2, 'silverstone', 'Silverstone Circuit', 'http://en.wikipedia.org/wiki/Silverstone_Circuit');
INSERT INTO constructors (constructorId, constructorRef, name, url) VALUES (1, 'mercedes', 'Mercedes', 'http://en.wikipedia.org/wiki/Mercedes-Benz_in_Formula_One');
INSERT INTO status (statusId, status) VALUES (1, 'Finished');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (1, 'hamilton', 'Lewis', 'Hamilton', 'http://en.wikipedia.org/wiki/Lewis_Hamilton');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (2, 'bottas', 'Valtteri', 'Bottas', 'http://en.wikipedia.org/wiki/Valtteri_Bottas');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (3, 'norris', 'Lando', 'Norris', 'http://en.wikipedia.org/wiki/Lando_Norris');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (101, 2020, 1, 1, 'Austrian Grand Prix', '2020-07-05', 'http://en.wikipedia.org/wiki/2020_Austrian_Grand_Prix');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (102, 2020, 2, 1, 'Styrian Grand Prix', '2020-07-12', 'http://en.wikipedia.org/wiki/2020_Styrian_Grand_Prix');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (103, 2020, 3, 2, 'British Grand Prix', '2020-08-02', 'http://en.wikipedia.org/wiki/2020_British_Grand_Prix');
-- Driver 3 has the fastest lap in Austrian GP (1:07.475 = 67.475s)
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionText, positionOrder, points, laps, fastestLapTime, statusId) VALUES (1, 101, 3, 1, 1, '1', 1, 25, 71, '1:07.475', 1);
-- Driver 2 has a slower lap in Austrian GP (1:07.800 = 67.800s)
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionText, positionOrder, points, laps, fastestLapTime, statusId) VALUES (2, 101, 2, 1, 2, '2', 2, 18, 71, '1:07.800', 1);
-- Driver 1 has NULL fastestLapTime in Austrian GP
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionText, positionOrder, points, laps, fastestLapTime, statusId) VALUES (3, 101, 1, 1, 3, '3', 3, 15, 71, NULL, 1);
-- Driver 1 has an overall faster lap (1:05.000 = 65.000s), but in Styrian GP (same circuit, wrong race name)
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionText, positionOrder, points, laps, fastestLapTime, statusId) VALUES (4, 102, 1, 1, 1, '1', 1, 25, 71, '1:05.000', 1);
-- Driver 2 has an even faster lap (1:04.000) in British GP
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionText, positionOrder, points, laps, fastestLapTime, statusId) VALUES (5, 103, 2, 1, 1, '1', 1, 25, 71, '1:04.000', 1);
-- Target pitStops for Driver 3 in Race 101 (multiple stops to test non-DISTINCT / multiplicity)
INSERT INTO pitStops (raceId, driverId, stop, lap, time, duration, milliseconds) VALUES (101, 3, 1, 20, '15:30:00', '21.543', 21543);
INSERT INTO pitStops (raceId, driverId, stop, lap, time, duration, milliseconds) VALUES (101, 3, 2, 50, '16:10:00', '22.100', 22100);
-- Decoy pitStop: Same race (101), different driver (2)
INSERT INTO pitStops (raceId, driverId, stop, lap, time, duration, milliseconds) VALUES (101, 2, 1, 21, '15:31:00', '23.999', 23999);
-- Decoy pitStop: Different race (102), same winning driver (3)
INSERT INTO pitStops (raceId, driverId, stop, lap, time, duration, milliseconds) VALUES (102, 3, 1, 25, '15:40:00', '24.888', 24888);
-- Decoy pitStop: Faster overall lap holder in wrong race (Driver 1 in Race 102)
INSERT INTO pitStops (raceId, driverId, stop, lap, time, duration, milliseconds) VALUES (102, 1, 1, 30, '15:45:00', '19.000', 19000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
WITH fastest_lap_times AS (SELECT T1.raceId, T1.driverId, T1.FastestLapTime, (CAST(SUBSTRING(T1.FastestLapTime, 1, INSTR(T1.FastestLapTime, ':') - 1) AS REAL) * 60) + (CAST(SUBSTRING(T1.FastestLapTime, INSTR(T1.FastestLapTime, ':') + 1, INSTR(T1.FastestLapTime, '.') - INSTR(T1.FastestLapTime, ':') - 1) AS REAL)) + (CAST(SUBSTRING(T1.FastestLapTime, INSTR(T1.FastestLapTime, '.') + 1) AS REAL) / 1000) AS time_in_seconds FROM results AS T1 WHERE NOT T1.FastestLapTime IS NULL), lap_record_race AS (SELECT T1.raceId, T1.driverId FROM results AS T1 INNER JOIN races AS T2 ON T1.raceId = T2.raceId INNER JOIN circuits AS T3 ON T2.circuitId = T3.circuitId INNER JOIN (SELECT MIN(fastest_lap_times.time_in_seconds) AS min_time_in_seconds FROM fastest_lap_times INNER JOIN races AS T2 ON fastest_lap_times.raceId = T2.raceId INNER JOIN circuits AS T3 ON T2.circuitId = T3.circuitId WHERE T2.name = 'Austrian Grand Prix') AS T4 ON (CAST(SUBSTRING(T1.FastestLapTime, 1, INSTR(T1.FastestLapTime, ':') - 1) AS REAL) * 60) + (CAST(SUBSTRING(T1.FastestLapTime, INSTR(T1.FastestLapTime, ':') + 1, INSTR(T1.FastestLapTime, '.') - INSTR(T1.FastestLapTime, ':') - 1) AS REAL)) + (CAST(SUBSTRING(T1.FastestLapTime, INSTR(T1.FastestLapTime, '.') + 1) AS REAL) / 1000) = T4.min_time_in_seconds WHERE T2.name = 'Austrian Grand Prix') SELECT T4.duration FROM lap_record_race INNER JOIN pitStops AS T4 ON lap_record_race.raceId = T4.raceId AND lap_record_race.driverId = T4.driverId;

/*
Gold Result:
('21.543',)
('22.100',)
*/

-- Prediction Query
SELECT "p"."duration" FROM "pitstops" AS "p" INNER JOIN "laptimes" AS "l" ON "p"."raceid" = "l"."raceid" AND "p"."driverid" = "l"."driverid" INNER JOIN "races" AS "r" ON "l"."raceid" = "r"."raceid" INNER JOIN "circuits" AS "c" ON "r"."circuitid" = "c"."circuitid" WHERE "c"."name" = 'Austrian Grand Prix Circuit' AND "l"."time" = (SELECT MIN("time") FROM "laptimes" WHERE "raceid" = "l"."raceid" AND "driverid" = "l"."driverid" AND "raceid" IN (SELECT "raceid" FROM "races" WHERE "circuitid" = "c"."circuitid"));

/*
Prediction Result:
*/