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
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1349, 'several', 'Nichole Lane', '6766 Felicia Shore Apt. 512
Ricebury, MP 00956', 'Japan', 1353.5, 1357.5, 1361, 'https://flores.biz/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1350, 'age', 'Gregory Brown', '8686 John Key Apt. 431
Port Donnatown, IA 27512', 'Moldova', 1366.5, 1372.5, 1378.0, 'http://atkinson.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1351, 'individual', 'Taylor Jones DVM', '9030 Gonzales Plains
Port Michelle, AR 18868', 'Lithuania', 1379.5, 1387.5, 1395.0, 'https://www.gutierrez.biz/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1352, 'environmental', 'Jason Mack', '95995 Kevin Divide Apt. 644
New Stacyburgh, SC 89466', 'Australia', 1392.5, 1402.5, 1412.0, 'http://rivera.info/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1377, 'quality', 'Robert Jackson', '2312 Jeffery Motorway
Brucefort, TN 64445', 'United Arab Emirates', 1381.5, 1385.5, 1389, 'http://www.smith-clark.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1378, 'sister', 'Katherine Stark', '08484 Wayne Square Suite 211
East James, NC 33585', 'Mayotte', 1394.5, 1400.5, 1406.0, 'https://www.martin-allen.biz/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1379, 'military', 'Maria Brown', '1567 Veronica Fork Suite 101
Grayside, NJ 07856', 'Mongolia', 1407.5, 1415.5, 1423.0, 'https://taylor.net/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1380, 'magazine', 'Ryan Landry', '76591 Jerry Ways
Nelsonland, TX 37250', 'Palestinian Territory', 1420.5, 1430.5, 1440.0, 'https://www.kim.com/');
INSERT INTO "seasons" ("year", "url") VALUES (1365, 'https://www.hardy.org/');
INSERT INTO "seasons" ("year", "url") VALUES (1366, 'http://www.ballard.net/');
INSERT INTO "seasons" ("year", "url") VALUES (1367, 'http://booth.com/');
INSERT INTO "seasons" ("year", "url") VALUES (1368, 'http://www.hayden.info/');
INSERT INTO "seasons" ("year", "url") VALUES (1393, 'https://walters.info/');
INSERT INTO "seasons" ("year", "url") VALUES (1394, 'http://pugh.biz/');
INSERT INTO "seasons" ("year", "url") VALUES (1395, 'http://marquez.com/');
INSERT INTO "seasons" ("year", "url") VALUES (1396, 'http://bowers.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1369, 1365, 1401, 1349, 'Melissa Padilla', '%Y', 'man', 'https://wood.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1370, 1365, 1380.0, 1349, 'David Morris', '2099-12-31', 'billion', 'http://www.green.org/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1371, 1365, 1387.0, 1349, 'John Wong', '2099-12-31', 'suggest', 'https://gonzalez.biz/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1372, 1365, 1394.0, 1349, 'Ian Andrade', '2099-12-31', 'seven', 'http://pena.info/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1397, 1393, 1373, 1377, 'Aaron Parker', '2021-01-01', 'better', 'https://carter.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1398, 1393, 1408.0, 1377, 'Derrick Anderson', '2099-12-31', 'picture', 'http://www.james.info/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1399, 1393, 1415.0, 1377, 'Jerry Peters', '2099-12-31', 'piece', 'http://www.hamilton.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1400, 1393, 1422.0, 1377, 'Alexander Gomez', '2099-12-31', 'still', 'https://www.king-wright.info/');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM races WHERE STRFTIME('%Y', date) = (SELECT STRFTIME('%Y', date) FROM races ORDER BY date ASC, races.raceid NULLS LAST LIMIT 1) AND STRFTIME('%m', date) = (SELECT STRFTIME('%m', date) FROM races ORDER BY date ASC, races.raceid NULLS LAST LIMIT 1);

/*
Gold Result:
*/

-- Prediction Query
SELECT name FROM races WHERE year = (SELECT MIN(year) FROM races) AND STRFTIME('%m', date) = (SELECT MIN(STRFTIME('%m', date)) FROM races WHERE year = (SELECT MIN(year) FROM races));

/*
Prediction Result:
('David Morris',)
('John Wong',)
('Ian Andrade',)
*/