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
INSERT INTO circuits (circuitId, circuitRef, name, location, country, lat, lng, alt, url) VALUES (1, 'magny_cours', 'Circuit de Nevers Magny-Cours', 'Magny Cours', 'France', 46.8642, 3.16361, 228, 'http://en.wikipedia.org/wiki/Circuit_de_Nevers_Magny-Cours');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, lat, lng, alt, url) VALUES (2, 'silverstone', 'Silverstone Circuit', 'Silverstone', 'UK', 52.0786, -1.01694, 153, 'http://en.wikipedia.org/wiki/Silverstone_Circuit');
INSERT INTO seasons (year, url) VALUES (2021, 'http://en.wikipedia.org/wiki/2021_Formula_One_season');
INSERT INTO drivers (driverId, driverRef, number, code, forename, surname, dob, nationality, url) VALUES (101, 'alonso', 14, 'ALO', 'Fernando', 'Alonso', '1981-07-29', 'Spanish', 'http://en.wikipedia.org/wiki/Fernando_Alonso');
INSERT INTO drivers (driverId, driverRef, number, code, forename, surname, dob, nationality, url) VALUES (102, 'vettel', 5, 'VET', 'Sebastian', 'Vettel', '1987-07-03', 'German', 'http://en.wikipedia.org/wiki/Sebastian_Vettel');
INSERT INTO drivers (driverId, driverRef, number, code, forename, surname, dob, nationality, url) VALUES (103, 'hamilton', 44, 'HAM', 'Lewis', 'Hamilton', '1985-01-07', 'British', 'http://en.wikipedia.org/wiki/Lewis_Hamilton');
INSERT INTO drivers (driverId, driverRef, number, code, forename, surname, dob, nationality, url) VALUES (104, 'verstappen', 33, 'VER', 'Max', 'Verstappen', '1997-09-30', 'Dutch', 'http://en.wikipedia.org/wiki/Max_Verstappen');
INSERT INTO drivers (driverId, driverRef, number, code, forename, surname, dob, nationality, url) VALUES (105, 'leclerc', 16, 'LEC', 'Charles', 'Leclerc', '1997-10-16', 'Monegasque', 'http://en.wikipedia.org/wiki/Charles_Leclerc');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (10, 2021, 7, 1, 'French Grand Prix', '2021-06-20', '13:00:00', 'http://en.wikipedia.org/wiki/2021_French_Grand_Prix');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (20, 2021, 3, 2, 'British Grand Prix', '2021-07-18', '14:00:00', 'http://en.wikipedia.org/wiki/2021_British_Grand_Prix');
INSERT INTO lapTimes (raceId, driverId, lap, position, time, milliseconds) VALUES (10, 101, 3, 2, '2:05.000', 200000);
INSERT INTO lapTimes (raceId, driverId, lap, position, time, milliseconds) VALUES (10, 102, 3, 3, '1:55.000', 300000);
INSERT INTO lapTimes (raceId, driverId, lap, position, time, milliseconds) VALUES (10, 103, 3, 1, '1:15.000', 100000);
INSERT INTO lapTimes (raceId, driverId, lap, position, time, milliseconds) VALUES (10, 104, 2, 3, '9:59.999', 599999);
INSERT INTO lapTimes (raceId, driverId, lap, position, time, milliseconds) VALUES (10, 105, 4, 3, '9:58.999', 598999);
INSERT INTO lapTimes (raceId, driverId, lap, position, time, milliseconds) VALUES (20, 104, 3, 1, '9:59.999', 599999);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.driverId FROM lapTimes AS T1 INNER JOIN races AS T2 ON T1.raceId = T2.raceId WHERE T2.name = 'French Grand Prix' AND T1.lap = 3 ORDER BY T1.time DESC, T1.raceid NULLS LAST, T1.driverid NULLS LAST, T1.lap NULLS LAST, T2.raceid NULLS LAST LIMIT 1;

/*
Gold Result:
(101,)
*/

-- Prediction Query
SELECT "drivers"."forename", "drivers"."surname" FROM "drivers" INNER JOIN "lapTimes" ON "drivers"."driverId" = "lapTimes"."driverId" INNER JOIN "races" ON "lapTimes"."raceId" = "races"."raceId" WHERE "races"."name" = 'French Grand Prix' AND "lapTimes"."lap" = 3 ORDER BY "lapTimes"."time" DESC, drivers.driverid NULLS LAST, lapTimes.raceid NULLS LAST, lapTimes.driverid NULLS LAST, lapTimes.lap NULLS LAST, races.raceid NULLS LAST LIMIT 1;

/*
Prediction Result:
('Fernando', 'Alonso')
*/