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
-- Inserting into table: races --
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (-2147483648, -2147483648, 2122220075, -2147483648, 'p6luhvdlttil', '2020-04-02', 'nprmdposii', 'url_1');

-- Inserting into table: constructors --
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (1, '5k5swwqcgs', 'name_1', 'British', '9n8');

INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (2, '4', 'name_2', 'British', 'ecigce376n');

INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (3, 'm52zbu', 'name_3', '4nrq', 'rofqyp5s5b');

INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (4, '5k5swwqcgs', 'name_4', 'British', '9n8');

INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (6, '4', 'name_5', 'British', 'gu7v');

INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (8, 'bnp', 'name_6', 'British', 'mdpos');

INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (10, 'ie5', 'name_7', 'British', 'nw6klf');

INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (5, 'fqyp', 'name_8', NULL, 's5bbp02e');

INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (7, '5k5swwqcgs', 'name_9', 'British', '9n8');

INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (9, 'hsrwbbp', 'name_10', 'British', 'luhvdltti');

INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (11, 'ie5', 'name_11', 'British', 'nw6klf');

INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (12, 'm52zbu', 'name_12', 'British', '4nrq');

-- Inserting into table: circuits --
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (-2147483648, '4', 'gu7v', 'e4', 'hria2ypuzhs', 663.049759, 711.020062, 1908028688, 'url_1');

-- Inserting into table: seasons --
INSERT INTO "seasons" ("year", "url") VALUES (-2147483648, 'url_1');

-- Inserting into table: constructorstandings --
INSERT INTO "constructorstandings" ("constructorstandingsid", "raceid", "constructorid", "points", "position", "positiontext", "wins") VALUES (-2147483648, -2147483648, 1, 75.403642, -1209887326, 'klfa9000t', 1408123494);

INSERT INTO "constructorstandings" ("constructorstandingsid", "raceid", "constructorid", "points", "position", "positiontext", "wins") VALUES (-2147483647, -2147483648, 3, 22.720462, 2107872094, '02eutliqa11r', 2137741668);

INSERT INTO "constructorstandings" ("constructorstandingsid", "raceid", "constructorid", "points", "position", "positiontext", "wins") VALUES (-2147483646, -2147483648, 3, 300.875654, -188151580, 'hl72klex1', -74849714);

INSERT INTO "constructorstandings" ("constructorstandingsid", "raceid", "constructorid", "points", "position", "positiontext", "wins") VALUES (-2147483645, -2147483648, 3, 598.409165, -453362185, 'au2dwyrq13', 2142703426);

INSERT INTO "constructorstandings" ("constructorstandingsid", "raceid", "constructorid", "points", "position", "positiontext", "wins") VALUES (-2147483644, -2147483648, 3, 326.912005, 244829661, 'jsl', -346339240);

INSERT INTO "constructorstandings" ("constructorstandingsid", "raceid", "constructorid", "points", "position", "positiontext", "wins") VALUES (2, -2147483648, 1, 884.000446, -1116181514, 'i2rkf', 222415430);

INSERT INTO "constructorstandings" ("constructorstandingsid", "raceid", "constructorid", "points", "position", "positiontext", "wins") VALUES (3, -2147483648, 1, 604.643336, 537874887, 'z0f8jegd21vy', -792092619);

INSERT INTO "constructorstandings" ("constructorstandingsid", "raceid", "constructorid", "points", "position", "positiontext", "wins") VALUES (5, -2147483648, 6, 1.0, 1744686505, 'hria2ypu', 1644814318);

INSERT INTO "constructorstandings" ("constructorstandingsid", "raceid", "constructorid", "points", "position", "positiontext", "wins") VALUES (7, -2147483648, 3, 1.0, 700293388, 'wbbp6luhvdlt', -841692980);

INSERT INTO "constructorstandings" ("constructorstandingsid", "raceid", "constructorid", "points", "position", "positiontext", "wins") VALUES (9, -2147483648, 10, 1.0, 1419861592, '4ecigce376n', 1313172851);

INSERT INTO "constructorstandings" ("constructorstandingsid", "raceid", "constructorid", "points", "position", "positiontext", "wins") VALUES (11, -2147483648, 2, 1.0, 283598170, 'zbuo4nrq', 418417917);

INSERT INTO "constructorstandings" ("constructorstandingsid", "raceid", "constructorid", "points", "position", "positiontext", "wins") VALUES (4, -2147483648, 5, 297.722676, -1068298341, '1ryytoo', 1644911394);

INSERT INTO "constructorstandings" ("constructorstandingsid", "raceid", "constructorid", "points", "position", "positiontext", "wins") VALUES (6, -2147483648, 7, 475.173408, 1871297066, 'u7vfe4hria2y', 1115440883);

INSERT INTO "constructorstandings" ("constructorstandingsid", "raceid", "constructorid", "points", "position", "positiontext", "wins") VALUES (8, -2147483648, 9, 22.535764, 429706943, 'rmdp', 2026480202);

INSERT INTO "constructorstandings" ("constructorstandingsid", "raceid", "constructorid", "points", "position", "positiontext", "wins") VALUES (10, -2147483648, 11, 587.783596, 1419861592, '4ecigce376n', 1313172851);

INSERT INTO "constructorstandings" ("constructorstandingsid", "raceid", "constructorid", "points", "position", "positiontext", "wins") VALUES (12, -2147483648, 12, 220.906948, -1031969798, '5s5b', 2107872094);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(T1.points) FROM constructorStandings AS T1 INNER JOIN constructors AS T2 ON T1.constructorId = T2.constructorId WHERE T2.nationality = 'British';

/*
Gold Result:
(287.344714,)
*/

-- Prediction Query
SELECT MAX(points) FROM constructors JOIN constructorResults ON constructors.constructorId = constructorResults.constructorId WHERE nationality = 'British';

/*
Prediction Result:
(None,)
*/