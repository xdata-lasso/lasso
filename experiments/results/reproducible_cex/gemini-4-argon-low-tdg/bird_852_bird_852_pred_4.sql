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
-- DATASET 3
-- Tests:
-- Exhaustive check of the second half of the excluded countries list ('Monaco', 'Azerbaijan', 'Austria', 'Belgium', 'France', 'Germany', 'Hungary', 'Italy', 'UK')
-- Reference query should return 0 for this dataset. Any mutant omitting one of these countries will return > 0.
INSERT INTO seasons (year, url) VALUES (2010, 'http://en.wikipedia.org/wiki/2010_Formula_One_season');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, url) VALUES (10, 'monaco', 'Circuit de Monaco', 'Monte-Carlo', 'Monaco', 'http://en.wikipedia.org/wiki/Circuit_de_Monaco');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, url) VALUES (11, 'baku', 'Baku City Circuit', 'Baku', 'Azerbaijan', 'http://en.wikipedia.org/wiki/Baku_City_Circuit');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, url) VALUES (12, 'red_bull_ring', 'Red Bull Ring', 'Spielberg', 'Austria', 'http://en.wikipedia.org/wiki/Red_Bull_Ring');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, url) VALUES (13, 'spa', 'Circuit de Spa-Francorchamps', 'Spa', 'Belgium', 'http://en.wikipedia.org/wiki/Circuit_de_Spa-Francorchamps');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, url) VALUES (14, 'magny_cours', 'Circuit de Nevers Magny-Cours', 'Magny Cours', 'France', 'http://en.wikipedia.org/wiki/Circuit_de_Nevers_Magny-Cours');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, url) VALUES (15, 'hockenheimring', 'Hockenheimring', 'Hockenheim', 'Germany', 'http://en.wikipedia.org/wiki/Hockenheimring');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, url) VALUES (16, 'hungaroring', 'Hungaroring', 'Budapest', 'Hungary', 'http://en.wikipedia.org/wiki/Hungaroring');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, url) VALUES (17, 'monza', 'Autodromo Nazionale di Monza', 'Monza', 'Italy', 'http://en.wikipedia.org/wiki/Autodromo_Nazionale_di_Monza');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, url) VALUES (18, 'silverstone', 'Silverstone Circuit', 'Silverstone', 'UK', 'http://en.wikipedia.org/wiki/Silverstone_Circuit');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (10, 2010, 10, 10, 'Monaco GP', '2010-05-16', 'http://en.wikipedia.org/wiki/2010_Monaco_GP');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (11, 2010, 11, 11, 'Azerbaijan GP', '2010-06-01', 'http://en.wikipedia.org/wiki/2010_Azerbaijan_GP');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (12, 2010, 12, 12, 'Austrian GP', '2010-06-15', 'http://en.wikipedia.org/wiki/2010_Austrian_GP');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (13, 2010, 13, 13, 'Belgian GP', '2010-08-29', 'http://en.wikipedia.org/wiki/2010_Belgian_GP');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (14, 2010, 14, 14, 'French GP', '2010-07-01', 'http://en.wikipedia.org/wiki/2010_French_GP');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (15, 2010, 15, 15, 'German GP', '2010-07-25', 'http://en.wikipedia.org/wiki/2010_German_GP');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (16, 2010, 16, 16, 'Hungarian GP', '2010-08-01', 'http://en.wikipedia.org/wiki/2010_Hungarian_GP');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (17, 2010, 17, 17, 'Italian GP', '2010-09-12', 'http://en.wikipedia.org/wiki/2010_Italian_GP');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (18, 2010, 18, 18, 'British GP', '2010-07-11', 'http://en.wikipedia.org/wiki/2010_British_GP');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T3.raceId) FROM circuits AS T1 INNER JOIN races AS T3 ON T3.circuitID = T1.circuitId WHERE NOT T1.country IN ('Bahrain', 'China', 'Singapore', 'Japan', 'Korea', 'Turkey', 'UAE', 'Malaysia', 'Spain', 'Monaco', 'Azerbaijan', 'Austria', 'Belgium', 'France', 'Germany', 'Hungary', 'Italy', 'UK') AND T3.year = 2010;

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(*) FROM races JOIN circuits ON races.circuitId = circuits.circuitId WHERE races.year = 2010 AND NOT circuits.country IN ('Malaysia', 'Bahrain', 'Singapore', 'Japan', 'China', 'UAE', 'Korea', 'India', 'Spain', 'Turkey', 'Monaco', 'France', 'UK', 'Germany', 'Hungary', 'Belgium', 'Italy', 'Portugal', 'Netherlands', 'Sweden', 'Switzerland', 'Russia', 'Azerbaijan');

/*
Prediction Result:
(1,)
*/