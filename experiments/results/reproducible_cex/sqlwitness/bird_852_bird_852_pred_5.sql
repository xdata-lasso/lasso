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
INSERT INTO seasons (year, url) VALUES (1, 'Singapore'), (2011, 'Belgium'), (2009, 'default1'), (2010, 'UK'), (0, 'France'), (2, 'Italy'), (3, 'China'), (4, 'Turkey'), (5, 'Monaco'), (6, '%Europe%');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (1, 'France', 'Azerbaijan', '%Europe%', 'UAE', 1.0, 2009.0, 2009, 'default2'), (2009, 'Azerbaijan', '%Europe%', 'Bahrain', 'Belgium', 2011.0, NULL, 2010, 'Monaco'), (0, 'Bahrain', 'Singapore', 'Korea', 'UAE', 2009.0, 2011.0, 0, 'Austria'), (2010, 'Austria', 'Singapore', 'Belgium', 'Monaco', 0.0, 2011.0, 0, 'UK'), (2011, '%Europe%', 'Monaco', 'Germany', 'Azerbaijan', 2009.0, 2011.0, 1, 'Japan'), (2, 'UAE', 'Austria', 'Korea', 'Malaysia', 2010.0, 2011.0, 0, 'Azerbaijan'), (3, 'default2', '%Europe%', 'Monaco', 'Japan', 1.0, 2011.0, 2010, 'Korea'), (4, 'UAE', 'Japan', 'UAE', '%Europe%', 0.0, 1.0, 0, 'China'), (5, 'Monaco', 'Belgium', 'Monaco', 'Azerbaijan', NULL, 2009.0, 2009, 'default1'), (6, 'Singapore', 'Belgium', 'Belgium', 'Malaysia', 2009.0, 2011.0, NULL, '%Europe%'), (7, 'Japan', 'Hungary', 'France', '%Asia%', NULL, 0.0, 2011, 'Germany'), (8, 'Singapore', 'default2', 'Spain', 'UK', 1.0, 2009.0, 1, 'UAE'), (9, 'Hungary', '%Europe%', 'Singapore', 'France', NULL, NULL, 2010, 'Turkey'), (10, 'Malaysia', 'Bahrain', 'Turkey', 'Malaysia', 2010.0, 1.0, 2011, 'Spain'), (11, 'Hungary', 'Japan', 'Belgium', 'UK', 2010.0, 2009.0, 2011, 'Belgium'), (12, '%Europe%', 'Austria', 'Monaco', 'Spain', 2010.0, 1.0, 2009, '%Asia%');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (2010, 4, 2011, 2009, 'Bahrain', '2023-01-02', 'Malaysia', '%Asia%'), (2011, 1, 10, 2010, 'default1', '2023-01-02', 'Belgium', 'default1'), (0, 2011, 2009, 0, 'Spain', '2023-01-01', 'Austria', 'Japan'), (1, 1, 7, 2011, 'default1', '2023-01-02', 'UK', 'Malaysia'), (2009, 2011, 2010, 2011, 'Singapore', '2023-01-02', 'Korea', 'Germany'), (2, 0, 2011, 2010, 'Germany', '2023-01-02', 'France', 'UAE'), (3, 0, 9, 1, 'France', '2023-01-01', 'Hungary', NULL), (4, 3, 9, 2009, 'Austria', '2023-01-01', '%Europe%', 'France'), (5, 4, 5, 1, 'Korea', '2023-01-01', 'China', '%Europe%'), (6, 3, 2, 2011, 'Germany', '2023-01-02', '%Asia%', 'Italy'), (7, 1, 6, 2010, 'UK', '2023-01-02', 'Austria', 'Singapore'), (8, 4, 1, 2011, '%Asia%', '2023-01-02', NULL, 'Monaco'), (9, 2010, 8, 2009, 'UAE', '2023-01-02', 'Italy', 'Turkey');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T3.raceId) FROM circuits AS T1 INNER JOIN races AS T3 ON T3.circuitID = T1.circuitId WHERE NOT T1.country IN ('Bahrain', 'China', 'Singapore', 'Japan', 'Korea', 'Turkey', 'UAE', 'Malaysia', 'Spain', 'Monaco', 'Azerbaijan', 'Austria', 'Belgium', 'France', 'Germany', 'Hungary', 'Italy', 'UK') AND T3.year = 2010;

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(*) FROM races AS T1 INNER JOIN circuits AS T2 ON T1.circuitId = T2.circuitId WHERE T1.year = 2010 AND T2.country NOT LIKE '%Asia%' AND T2.country NOT LIKE '%Europe%';

/*
Prediction Result:
(1,)
*/