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
INSERT INTO seasons (year, url) VALUES (2020, 'http://en.wikipedia.org/wiki/2020_Formula_One_World_Championship');
INSERT INTO seasons (year, url) VALUES (2021, 'http://en.wikipedia.org/wiki/2021_Formula_One_World_Championship');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, url) VALUES (10, 'silverstone', 'Silverstone Circuit', 'Silverstone', 'UK', 'http://en.wikipedia.org/wiki/Silverstone_Circuit');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, url) VALUES (20, 'monza', 'Autodromo Nazionale di Monza', 'Monza', 'Italy', 'http://en.wikipedia.org/wiki/Autodromo_Nazionale_di_Monza');
INSERT INTO constructors (constructorId, constructorRef, name, nationality, url) VALUES (10, 'mercedes', 'Mercedes', 'German', 'http://en.wikipedia.org/wiki/Mercedes-Benz_in_Formula_One');
INSERT INTO status (statusId, status) VALUES (1, 'Finished');
INSERT INTO status (statusId, status) VALUES (2, '+1 Lap');
INSERT INTO drivers (driverId, driverRef, number, code, forename, surname, nationality, url) VALUES (1, 'lewis_hamilton', 44, 'HAM', 'Lewis', 'Hamilton', 'British', 'http://en.wikipedia.org/wiki/Lewis_Hamilton');
INSERT INTO drivers (driverId, driverRef, number, code, forename, surname, nationality, url) VALUES (2, 'clark', 12, 'CLA', 'Lewis', 'Clark', 'British', 'http://en.wikipedia.org/wiki/Lewis_Clark');
INSERT INTO drivers (driverId, driverRef, number, code, forename, surname, nationality, url) VALUES (3, 'hamilton', 99, 'DHM', 'Duncan', 'Hamilton', 'British', 'http://en.wikipedia.org/wiki/Duncan_Hamilton');
INSERT INTO drivers (driverId, driverRef, number, code, forename, surname, nationality, url) VALUES (4, 'verstappen', 33, 'VER', 'Max', 'Verstappen', 'Dutch', 'http://en.wikipedia.org/wiki/Max_Verstappen');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (101, 2020, 4, 10, 'British Grand Prix', '2020-08-02', 'http://en.wikipedia.org/wiki/2020_British_Grand_Prix');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (102, 2020, 8, 20, 'Italian Grand Prix', '2020-09-06', 'http://en.wikipedia.org/wiki/2020_Italian_Grand_Prix');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (103, 2021, 8, 10, 'Styrian Grand Prix', '2021-06-27', 'http://en.wikipedia.org/wiki/2021_Styrian_Grand_Prix');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (104, 2021, 13, 20, 'Dutch Grand Prix', '2021-09-05', 'http://en.wikipedia.org/wiki/2021_Dutch_Grand_Prix');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (105, 2021, 7, 10, 'French Grand Prix', '2021-06-20', 'http://en.wikipedia.org/wiki/2021_French_Grand_Prix');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (106, 2021, 12, 20, 'Belgian Grand Prix', '2021-08-29', 'http://en.wikipedia.org/wiki/2021_Belgian_Grand_Prix');
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, fastestLap, rank, statusId) VALUES (1, 101, 1, 10, 44, 2, 2, '2', 2, 18.0, 52, 45, 1, 2);
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, fastestLap, rank, statusId) VALUES (2, 102, 1, 10, 44, 4, 3, '3', 3, 15.0, 53, 40, 1, 2);
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, fastestLap, rank, statusId) VALUES (3, 103, 1, 10, 1, 1, 1, '1', 1, 1.0, 1, 1, 2, 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, fastestLap, rank, statusId) VALUES (4, 104, 2, 10, 12, 1, 1, '1', 1, 25.0, 72, 50, 1, 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, fastestLap, rank, statusId) VALUES (5, 105, 3, 10, 99, 1, 1, '1', 1, 25.0, 53, 30, 1, 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, fastestLap, rank, statusId) VALUES (6, 106, 4, 10, 33, 1, 1, '1', 1, 25.0, 44, 10, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM races WHERE raceId IN (SELECT raceId FROM results WHERE rank = 1 AND driverId = (SELECT driverId FROM drivers WHERE forename = 'Lewis' AND surname = 'Hamilton'));

/*
Gold Result:
('British Grand Prix',)
('Italian Grand Prix',)
*/

-- Prediction Query
SELECT "races"."name" FROM "drivers" INNER JOIN "results" ON "drivers"."driverid" = "results"."driverid" INNER JOIN "races" ON "results"."raceid" = "races"."raceid" WHERE "drivers"."forename" = 'Lewis' AND "drivers"."surname" = 'Hamilton' ORDER BY "results"."rank" ASC, drivers.driverid NULLS LAST, results.resultid NULLS LAST, races.raceid NULLS LAST LIMIT 1;

/*
Prediction Result:
('British Grand Prix',)
*/