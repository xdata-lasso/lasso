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
INSERT INTO seasons (year, url) VALUES (2011, 'default2'), (2010, 'default1'), (0, 'Germany'), (1, 'Japan'), (2009, 'Hungary'), (2, 'Spain');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (1, 'Spain', 'Spain', 'Italy', 'Germany', 1.0, NULL, 2011, 'France'), (0, 'default2', 'Turkey', 'default2', 'Azerbaijan', NULL, NULL, 1, 'Japan'), (2010, 'Germany', 'Germany', 'Belgium', 'Korea', 1.0, 1.0, 1, 'Malaysia'), (2011, 'Azerbaijan', 'UAE', 'Monaco', 'Japan', 2009.0, 2011.0, 2010, 'default1'), (2009, 'Monaco', 'Belgium', 'default1', 'default1', NULL, 2009.0, 2010, 'Korea'), (2, 'China', 'Korea', 'UK', 'Austria', 2009.0, 2010.0, 2010, 'Belgium'), (3, 'Malaysia', 'Malaysia', 'Singapore', 'default2', 2010.0, 2011.0, 1, 'UAE'), (4, 'Hungary', 'Hungary', 'Japan', 'Hungary', NULL, NULL, 1, 'Italy'), (5, 'Malaysia', 'Germany', 'Turkey', 'Italy', 1.0, 1.0, 2011, 'Azerbaijan'), (6, 'UAE', 'Italy', 'default1', 'Monaco', 2009.0, NULL, 2010, 'Singapore'), (7, 'UK', 'France', 'Belgium', 'Malaysia', 2009.0, 1.0, 2009, 'Bahrain'), (8, 'Japan', 'default1', 'Hungary', 'default1', 0.0, 0.0, NULL, 'Asia'), (9, 'Italy', 'default1', 'Europe', 'Malaysia', 2011.0, 2009.0, 0, 'Monaco'), (10, 'Hungary', 'Belgium', 'Asia', 'Azerbaijan', NULL, 2009.0, 1, 'Europe'), (11, 'UK', 'Hungary', 'Monaco', 'UK', 1.0, NULL, 2011, 'Germany');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (2009, 0, 8, 0, 'Austria', '2023-01-02', 'Japan', 'Asia'), (1, 0, 2, 2011, 'Europe', '2023-01-01', 'Monaco', 'Bahrain'), (2010, 2011, 2009, 0, 'Europe', '2023-01-01', 'Korea', 'Germany'), (0, 2, 8, 2009, 'Belgium', '2023-01-02', 'Bahrain', 'Austria'), (2011, 2, 10, 1, 'UAE', '2023-01-02', 'Belgium', 'Italy'), (2, 2011, 2, 2010, 'Belgium', '2023-01-01', 'UAE', 'UAE'), (3, 1, 2010, 2009, 'Malaysia', '2023-01-02', 'UAE', 'Japan'), (4, 2009, 8, 2011, 'Azerbaijan', '2023-01-01', 'Malaysia', 'China'), (5, 2010, 5, 2011, 'Japan', '2023-01-02', 'Germany', 'Monaco'), (6, 0, 6, 0, 'Japan', '2023-01-01', 'Korea', 'Singapore'), (7, 0, 1, 2011, 'Europe', '2023-01-02', 'Korea', 'Hungary'), (8, 2011, 2009, 0, 'Austria', '2023-01-01', 'Azerbaijan', 'Europe'), (9, 0, 3, 1, 'Austria', '2023-01-01', NULL, 'Turkey'), (10, 1, 2011, 2011, 'Turkey', '2023-01-02', 'UAE', 'Spain'), (11, 2009, 10, 2009, 'Europe', '2023-01-02', 'UAE', 'Belgium'), (12, 2, 0, 2009, 'Bahrain', '2023-01-02', 'Turkey', 'UK'), (13, 2011, 2011, 2011, 'Korea', '2023-01-02', 'default2', 'Azerbaijan');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T3.raceId) FROM circuits AS T1 INNER JOIN races AS T3 ON T3.circuitID = T1.circuitId WHERE NOT T1.country IN ('Bahrain', 'China', 'Singapore', 'Japan', 'Korea', 'Turkey', 'UAE', 'Malaysia', 'Spain', 'Monaco', 'Azerbaijan', 'Austria', 'Belgium', 'France', 'Germany', 'Hungary', 'Italy', 'UK') AND T3.year = 2010;

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(raceId) FROM races INNER JOIN circuits ON races.circuitId = circuits.circuitId WHERE year = 2010 AND NOT (circuits.location IN ('Asia', 'Europe'));

/*
Prediction Result:
(1,)
*/