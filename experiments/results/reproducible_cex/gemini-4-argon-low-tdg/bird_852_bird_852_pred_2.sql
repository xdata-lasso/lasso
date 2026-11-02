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
-- DATASET 4
-- Tests:
-- 1. Incorrect join condition (e.g. T3.raceId = T1.circuitId instead of T3.circuitId = T1.circuitId, or cross join)
-- 2. Column confusion (e.g., filtering T1.location or T1.name instead of T1.country)
-- 3. Unnecessary joins with child tables (e.g., results, qualifying, lapTimes) which could either multiply rows or filter out races without results.
INSERT INTO seasons (year, url) VALUES (2010, 'http://en.wikipedia.org/wiki/2010_Formula_One_season');
-- Circuit 1: Excluded country ('UK'), but ID=1
INSERT INTO circuits (circuitId, circuitRef, name, location, country, url) VALUES (1, 'silverstone', 'Silverstone', 'USA', 'UK', 'http://en.wikipedia.org/wiki/Silverstone');
-- Circuit 2: Allowed country ('USA'), but location and name are 'Spain' (an excluded country name)
INSERT INTO circuits (circuitId, circuitRef, name, location, country, url) VALUES (2, 'indy', 'Spain', 'Spain', 'USA', 'http://en.wikipedia.org/wiki/Indy');
-- Race 1: Has raceId = 2 (matches Circuit 2's ID!), but its actual circuitId = 1 (Excluded 'UK').
-- If a mutant joins on T3.raceId = T1.circuitId, it will match Race 1 with Circuit 2 ('USA') and count it!
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (2, 2010, 1, 1, 'British GP', '2010-07-11', 'http://en.wikipedia.org/wiki/2010_British_GP');
-- Race 2: Has raceId = 1 (matches Circuit 1's ID!), but its actual circuitId = 2 (Allowed 'USA').
-- Note: This race has NO rows in `results`, `qualifying`, or `driverStandings`.
-- If a mutant inner-joins `results`, this valid race will be dropped!
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (1, 2010, 2, 2, 'US GP', '2010-06-13', 'http://en.wikipedia.org/wiki/2010_US_GP');
-- Race 3: Another valid race on Circuit 2 ('USA'), with multiple rows in `results`.
-- If a mutant joins `results` without DISTINCT, this race will be counted multiple times!
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (3, 2010, 3, 2, 'US GP West', '2010-06-20', 'http://en.wikipedia.org/wiki/2010_US_GP_West');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (1, 'hamilton', 'Lewis', 'Hamilton', 'http://en.wikipedia.org/wiki/Lewis_Hamilton');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (2, 'button', 'Jenson', 'Button', 'http://en.wikipedia.org/wiki/Jenson_Button');
INSERT INTO constructors (constructorId, constructorRef, name, url) VALUES (1, 'mclaren', 'McLaren', 'http://en.wikipedia.org/wiki/McLaren');
INSERT INTO status (statusId, status) VALUES (1, 'Finished');
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionText, positionOrder, points, laps, statusId) VALUES (1, 3, 1, 1, 1, '1', 1, 25, 50, 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionText, positionOrder, points, laps, statusId) VALUES (2, 3, 2, 1, 2, '2', 2, 18, 50, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T3.raceId) FROM circuits AS T1 INNER JOIN races AS T3 ON T3.circuitID = T1.circuitId WHERE NOT T1.country IN ('Bahrain', 'China', 'Singapore', 'Japan', 'Korea', 'Turkey', 'UAE', 'Malaysia', 'Spain', 'Monaco', 'Azerbaijan', 'Austria', 'Belgium', 'France', 'Germany', 'Hungary', 'Italy', 'UK') AND T3.year = 2010;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(*) FROM "races" AS r INNER JOIN "circuits" AS c ON r."circuitid" = c."circuitid" WHERE r."year" = 2010 AND r."name" LIKE '%Grand Prix%' AND NOT c."country" IN ('Asia', 'Europe');

/*
Prediction Result:
(0,)
*/