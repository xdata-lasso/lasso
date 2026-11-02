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
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1001, 'purpose', 'Daniel Doyle', '79402 Peterson Drives Apt. 511
Davisstad, PA 35172', 'Germany', 1005.5, 1009.5, 1013, 'https://baker.net/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1002, 'brother', 'Stephanie Miller', '161 Calderon River Suite 931
Lake Jeremyport, CO 31013', 'Croatia', 1018.5, 1024.5, 1030.0, 'https://ross.net/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1003, 'ago', 'Allen Robinson', '7525 Clark Grove Apt. 928
East Steven, KY 84387', 'Palau', 1031.5, 1039.5, 1047.0, 'https://www.callahan.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1004, 'site', 'Alyssa Gonzalez', '503 Linda Locks
Carlshire, FM 94599', 'Luxembourg', 1044.5, 1054.5, 1064.0, 'https://www.james-ferrell.net/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (1017, 'enter', 'Nathan Maldonado', 'Macao', 'http://romero.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (1018, 'on', 'Debra Davidson', 'Serbia', 'http://smith-hickman.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (1019, 'traditional', 'Jeffrey Chavez', 'Christmas Island', 'http://www.humphrey.com/');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (1020, 'yes', 'Sherri Baker', 'Madagascar', 'https://www.cannon.net/');
INSERT INTO "seasons" ("year", "url") VALUES (1980, 'http://brennan.net/');
INSERT INTO "seasons" ("year", "url") VALUES (1021, 'http://carney-santos.info/');
INSERT INTO "seasons" ("year", "url") VALUES (1022, 'https://www.walker.com/');
INSERT INTO "seasons" ("year", "url") VALUES (1023, 'http://www.jones.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1024, 1980, 1028, 1001, 'Monaco Grand Prix', '1970-01-01', 'drop', 'https://www.young.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1025, 1980, 1035.0, 1001, 'Monaco Grand Prix', '1970-01-02', 'author', 'https://www.aguirre-lee.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1026, 1980, 1042.0, 1001, 'Monaco Grand Prix', '1970-01-03', 'western', 'https://jenkins-shields.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1027, 1980, 1049.0, 1001, 'Monaco Grand Prix', '1970-01-04', 'almost', 'http://www.chandler-mcbride.com/');
INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (1032, 1024, 1017, 1036.5, 'energy');
INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (1033, 1024, 1017, 1045.5, 'dark');
INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (1034, 1024, 1017, 1054.5, 'customer');
INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (1035, 1024, 1017, 1063.5, 'not');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(T1.points), T2.name, T2.nationality FROM constructorResults AS T1 INNER JOIN constructors AS T2 ON T1.constructorId = T2.constructorId INNER JOIN races AS T3 ON T3.raceid = T1.raceid WHERE T3.name = 'Monaco Grand Prix' AND T3.year BETWEEN 1980 AND 2010 GROUP BY T2.name ORDER BY SUM(T1.points) DESC, T2.name NULLS LAST, T2.nationality NULLS LAST LIMIT 1;

/*
Gold Result:
(4200.0, 'Nathan Maldonado', 'Macao')
*/

-- Prediction Query
SELECT T1.points, T2.name, T2.nationality FROM constructorResults AS T1 INNER JOIN constructors AS T2 ON T1.constructorId = T2.constructorId INNER JOIN races AS T3 ON T1.raceId = T3.raceId WHERE T3.name = 'Monaco Grand Prix' AND T3.year BETWEEN 1980 AND 2010 ORDER BY T1.points DESC, T1.constructorresultsid NULLS LAST, T2.constructorid NULLS LAST, T3.raceid NULLS LAST LIMIT 1;

/*
Prediction Result:
(1063.5, 'Nathan Maldonado', 'Macao')
*/