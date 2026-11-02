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
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1490, 'half', 'Renee Wolfe', '657 Beverly Parkways
Lake Lori, CA 78081', 'Chad', 1493.5, 1497.5, 1501, 'http://www.garcia-leon.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1491, 'provide', 'Sarah Acosta', '234 Rosales Unions Suite 557
Jesusborough, DC 77139', 'Korea', 1506.5, 1512.5, 1518.0, 'http://www.anderson.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1492, 'those', 'Joseph Allen', '77561 Oconnell Fords
Parkerview, PR 16218', 'Moldova', 1519.5, 1527.5, 1535.0, 'http://johnson.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1517, 'rule', 'Anthony Shea DDS', '903 Hernandez Station Apt. 568
Lake Kentburgh, AK 53505', 'San Marino', 1532.5, 1542.5, 1552.0, 'https://www.stein.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1489, 'through', 'Tiffany Smith', '70103 Andrew Neck Apt. 593
West Jennifer, PW 42914', 'Timor-Leste', 1494.5, 1498.5, 1502, 'https://baker.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1518, 'consumer', 'Alyssa Haynes', '218 Yu Landing
Willismouth, ME 42785', 'North Macedonia', 1534.5, 1540.5, 1546.0, 'https://le.biz/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1519, 'control', 'Kristy Hart', '675 Jasmine Points
Jeffreyshire, GU 23484', 'Turks and Caicos Islands', 1547.5, 1555.5, 1563.0, 'https://wilkerson.biz/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1520, 'economic', 'William Keith', '20969 Ian Island Apt. 917
West Julie, IA 45958', 'Benin', 1560.5, 1570.5, 1580.0, 'https://poole.com/');
INSERT INTO "seasons" ("year", "url") VALUES (1505, 'http://jackson.biz/');
INSERT INTO "seasons" ("year", "url") VALUES (1506, 'https://reyes.com/');
INSERT INTO "seasons" ("year", "url") VALUES (1507, 'https://www.hill.com/');
INSERT INTO "seasons" ("year", "url") VALUES (1508, 'http://www.phillips.com/');
INSERT INTO "seasons" ("year", "url") VALUES (1533, 'http://lloyd.com/');
INSERT INTO "seasons" ("year", "url") VALUES (1534, 'http://lynn-jones.com/');
INSERT INTO "seasons" ("year", "url") VALUES (1535, 'https://www.jones.com/');
INSERT INTO "seasons" ("year", "url") VALUES (1536, 'https://www.dunlap-martin.biz/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1509, 1505, 1513, 1490, 'James Barnes', '1984-07-07', 'guy', 'https://white-flores.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1511, 1505, 1520.0, 1490, 'Rebecca Wright', '1980-03-24', 'while', 'http://stokes.net/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1512, 1505, 1527.0, 1490, 'Kimberly Smith MD', '1980-03-25', 'others', 'https://www.garcia.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1537, 1505, 1534.0, 1490, 'Karen Harrington', '1980-03-26', 'morning', 'https://www.johnston.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1510, 1533, 1541, 1489, 'Brian Harris', '1984-07-07', 'though', 'https://www.miller-colon.org/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1538, 1533, 1548.0, 1489, 'Michael Bowen', '1984-07-05', 'military', 'https://www.johnson.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1539, 1533, 1555.0, 1489, 'Deborah Campbell', '1984-07-06', 'class', 'http://parker.info/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1540, 1533, 1562.0, 1489, 'Anthony Armstrong', '1980-03-23', 'arm', 'https://may.com/');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.location FROM circuits AS T1 INNER JOIN races AS T2 ON T1.circuitId = T2.circuitId ORDER BY T2.date DESC, T1.circuitid NULLS LAST, T2.raceid NULLS LAST LIMIT 1;

/*
Gold Result:
('70103 Andrew Neck Apt. 593\nWest Jennifer, PW 42914',)
*/

-- Prediction Query
SELECT circuitId, location, country FROM circuits WHERE circuitId IN (SELECT circuitId FROM races ORDER BY date DESC, races.raceid NULLS LAST LIMIT 1);

/*
Prediction Result:
(1490, '657 Beverly Parkways\nLake Lori, CA 78081', 'Chad')
*/