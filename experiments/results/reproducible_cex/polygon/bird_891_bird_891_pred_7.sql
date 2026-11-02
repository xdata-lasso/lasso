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
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (45, 'Singapore Grand Prix81', 'Singapore Grand Prix81', 'Singapore Grand Prix81', 'Singapore Grand Prix81', 81, 81, 81, 'Singapore Grand Prix36');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (44, 'Singapore Grand Prix81', 'Singapore Grand Prix81', 'Singapore Grand Prix81', 'Singapore Grand Prix81', 81, 81, 81, 'Singapore Grand Prix35');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (82, 'Singapore Grand Prix81', 'Singapore Grand Prix38', 'Singapore Grand Prix81', 'Singapore Grand Prix81');
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (107, 'Singapore Grand Prix81', 'Singapore Grand Prix37', 'Singapore Grand Prix81', 'Singapore Grand Prix81');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (81, 'Singapore Grand Prix74', 75, 'Singapore Grand Prix76', 'Singapore Grand Prix122', 'Singapore Grand Prix123', '1000-03-19', 'Singapore Grand Prix78', 'Singapore Grand Prix79');
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (106, 'Singapore Grand Prix97', 98, 'Singapore Grand Prix99', 'Singapore Grand Prix100', 'Singapore Grand Prix101', '1000-04-13', 'Singapore Grand Prix103', 'Singapore Grand Prix104');
INSERT INTO "seasons" ("year", "url") VALUES (2010, 'Singapore Grand Prix81');
INSERT INTO "races" ("raceid", "year", "circuitid", "round", "name", "date", "time", "url") VALUES (43, 2010, 44, 56, 'Singapore Grand Prix', '1000-02-27', 'Singapore Grand Prix58', 'Singapore Grand Prix40');
INSERT INTO "races" ("raceid", "year", "circuitid", "round", "name", "date", "time", "url") VALUES (42, 2010, 45, 64, 'Singapore Grand Prix', '1000-03-07', 'Singapore Grand Prix66', 'Singapore Grand Prix39');
INSERT INTO "constructorResults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (47, 42, 82, 81, 'Singapore Grand Prix81');
INSERT INTO "constructorResults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (46, 43, 82, 81, 'Singapore Grand Prix81');
INSERT INTO "constructorStandings" ("constructorstandingsid", "raceid", "constructorid", "points", "position", "positiontext", "wins") VALUES (49, 42, 107, 81, 81, 'Singapore Grand Prix81', 81);
INSERT INTO "constructorStandings" ("constructorstandingsid", "raceid", "constructorid", "points", "position", "positiontext", "wins") VALUES (48, 42, 82, 81, 81, 'Singapore Grand Prix81', 81);
INSERT INTO "driverStandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (59, 43, 81, 60, NULL, 'Singapore Grand Prix62', 63);
INSERT INTO "driverStandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (67, 42, 81, 68, 69, 'Singapore Grand Prix70', 71);
INSERT INTO "lapTimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (43, 81, 81, 81, 'Singapore Grand Prix81', 81);
INSERT INTO "pitStops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (42, 81, 81, 81, 'Singapore Grand Prix81', 'Singapore Grand Prix81', 81);
INSERT INTO "pitStops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (43, 106, 81, 81, 'Singapore Grand Prix81', 'Singapore Grand Prix81', 81);
INSERT INTO "status" ("statusid", "status") VALUES (108, 'Singapore Grand Prix81');
INSERT INTO "status" ("statusid", "status") VALUES (83, 'Singapore Grand Prix81');
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "statusid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed") VALUES (105, 43, 106, 107, 108, 109, 110, 111, 'Singapore Grand Prix112', 113, 114, 115, 'Singapore Grand Prix116', 117, 118, 119, 'Singapore Grand Prix120', 'Singapore Grand Prix121');
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "statusid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed") VALUES (80, 42, 81, 82, 83, 84, 85, 86, 'Singapore Grand Prix87', 88, 89, 90, 'Singapore Grand Prix91', 92, 93, 94, 'Singapore Grand Prix95', 'Singapore Grand Prix96');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.forename, T3.surname FROM races AS T1 INNER JOIN driverStandings AS T2 ON T2.raceId = T1.raceId INNER JOIN drivers AS T3 ON T3.driverId = T2.driverId WHERE T1.name = 'Singapore Grand Prix' AND T1.year = 2010 ORDER BY T2.position ASC, T1.raceid NULLS LAST, T2.driverstandingsid NULLS LAST, T3.driverid NULLS LAST;

/*
Gold Result:
('Singapore Grand Prix122', 'Singapore Grand Prix123')
('Singapore Grand Prix122', 'Singapore Grand Prix123')
*/

-- Prediction Query
SELECT "drivers"."forename", "drivers"."surname" FROM "drivers" INNER JOIN "results" ON "drivers"."driverId" = "results"."driverId" INNER JOIN "races" ON "results"."raceId" = "races"."raceId" WHERE "races"."name" = 'Singapore Grand Prix' AND "races"."year" = 2010 ORDER BY "results"."positionOrder", drivers.driverid NULLS LAST, results.resultid NULLS LAST, races.raceid NULLS LAST;

/*
Prediction Result:
('Singapore Grand Prix122', 'Singapore Grand Prix123')
('Singapore Grand Prix100', 'Singapore Grand Prix101')
*/