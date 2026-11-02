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
INSERT INTO seasons (year, url) VALUES (2010, 'http://en.wikipedia.org/wiki/2010_Formula_One_season');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, url) VALUES (1, 'c_bahrain', 'Bahrain Circuit', 'Sakhir', 'Bahrain', 'http://example.com/c1');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, url) VALUES (2, 'c_china', 'Shanghai Circuit', 'Shanghai', 'China', 'http://example.com/c2');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, url) VALUES (3, 'c_singapore', 'Marina Bay', 'Singapore', 'Singapore', 'http://example.com/c3');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, url) VALUES (4, 'c_japan', 'Suzuka Circuit', 'Suzuka', 'Japan', 'http://example.com/c4');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, url) VALUES (5, 'c_korea', 'Korean Circuit', 'Yeongam', 'Korea', 'http://example.com/c5');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, url) VALUES (6, 'c_turkey', 'Istanbul Park', 'Istanbul', 'Turkey', 'http://example.com/c6');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, url) VALUES (7, 'c_uae', 'Yas Marina', 'Abu Dhabi', 'UAE', 'http://example.com/c7');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, url) VALUES (8, 'c_malaysia', 'Sepang Circuit', 'Kuala Lumpur', 'Malaysia', 'http://example.com/c8');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, url) VALUES (9, 'c_azerbaijan', 'Baku Circuit', 'Baku', 'Azerbaijan', 'http://example.com/c9');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, url) VALUES (10, 'c_australia', 'Albert Park', 'Melbourne', 'Australia', 'http://example.com/c10');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (201, 2010, 1, 1, 'R1', '2010-03-14', 'http://example.com/r201');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (202, 2010, 2, 2, 'R2', '2010-04-18', 'http://example.com/r202');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (203, 2010, 3, 3, 'R3', '2010-09-26', 'http://example.com/r203');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (204, 2010, 4, 4, 'R4', '2010-10-10', 'http://example.com/r204');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (205, 2010, 5, 5, 'R5', '2010-10-24', 'http://example.com/r205');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (206, 2010, 6, 6, 'R6', '2010-05-30', 'http://example.com/r206');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (207, 2010, 7, 7, 'R7', '2010-11-14', 'http://example.com/r207');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (208, 2010, 8, 8, 'R8', '2010-04-04', 'http://example.com/r208');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (209, 2010, 9, 9, 'R9', '2010-06-20', 'http://example.com/r209');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (210, 2010, 10, 10, 'R10', '2010-03-28', 'http://example.com/r210');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T3.raceId) FROM circuits AS T1 INNER JOIN races AS T3 ON T3.circuitID = T1.circuitId WHERE NOT T1.country IN ('Bahrain', 'China', 'Singapore', 'Japan', 'Korea', 'Turkey', 'UAE', 'Malaysia', 'Spain', 'Monaco', 'Azerbaijan', 'Austria', 'Belgium', 'France', 'Germany', 'Hungary', 'Italy', 'UK') AND T3.year = 2010;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM "races" AS r INNER JOIN "circuits" AS c ON r."circuitid" = c."circuitid" WHERE r."year" = 2010 AND r."name" LIKE '%Grand Prix%' AND NOT c."country" IN ('Asia', 'Europe');

/*
Prediction Result:
(0,)
*/