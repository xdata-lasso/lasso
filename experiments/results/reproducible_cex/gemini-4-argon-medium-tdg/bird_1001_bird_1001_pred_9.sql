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
-- DATASET 1
INSERT INTO seasons (year, url) VALUES (2008, 'http://en.wikipedia.org/wiki/2008_Formula_One_season');
INSERT INTO seasons (year, url) VALUES (2009, 'http://en.wikipedia.org/wiki/2009_Formula_One_season');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, url) VALUES (1, 'marina_bay', 'Marina Bay Street Circuit', 'Marina Bay', 'Singapore', 'http://en.wikipedia.org/wiki/Marina_Bay_Street_Circuit');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, url) VALUES (2, 'monza', 'Autodromo Nazionale di Monza', 'Monza', 'Italy', 'http://en.wikipedia.org/wiki/Monza_Circuit');
INSERT INTO constructors (constructorId, constructorRef, name, nationality, url) VALUES (1, 'ferrari', 'Ferrari', 'Italian', 'http://en.wikipedia.org/wiki/Scuderia_Ferrari');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (1, 'massa', 'Felipe', 'Massa', 'http://en.wikipedia.org/wiki/Felipe_Massa');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (2, 'hamilton', 'Lewis', 'Hamilton', 'http://en.wikipedia.org/wiki/Lewis_Hamilton');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (3, 'alonso', 'Fernando', 'Alonso', 'http://en.wikipedia.org/wiki/Fernando_Alonso');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (4, 'raikkonen', 'Kimi', 'Räikkönen', 'http://en.wikipedia.org/wiki/Kimi_R%C3%A4ikk%C3%B6nen');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (5, 'vettel', 'Sebastian', 'Vettel', 'http://en.wikipedia.org/wiki/Sebastian_Vettel');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (10, 2008, 15, 1, 'Singapore Grand Prix', '2008-09-28', 'http://en.wikipedia.org/wiki/2008_Singapore_Grand_Prix');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (11, 2009, 14, 1, 'Singapore Grand Prix', '2009-09-27', 'http://en.wikipedia.org/wiki/2009_Singapore_Grand_Prix');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (12, 2008, 14, 2, 'Italian Grand Prix', '2008-09-14', 'http://en.wikipedia.org/wiki/2008_Italian_Grand_Prix');
-- Driver 3: NULL q3 in target race, but fastest q1/q2 and position 1 (tests NOT q3 IS NULL and q3 vs q1/q2/position)
INSERT INTO qualifying (qualifyId, raceId, driverId, constructorId, number, position, q1, q2, q3) VALUES (1, 10, 3, 1, 5, 1, '1:40.100', '1:40.100', NULL);
-- Driver 2: Slower q3 in target race, but faster q1/q2 (tests ORDER BY q3 ASC vs DESC and q3 vs q1/q2)
INSERT INTO qualifying (qualifyId, raceId, driverId, constructorId, number, position, q1, q2, q3) VALUES (2, 10, 2, 1, 22, 2, '1:41.000', '1:41.000', '1:45.465');
-- Driver 1: Fastest q3 in target race, despite position = 3 and slower q1/q2 (Expected Winner)
INSERT INTO qualifying (qualifyId, raceId, driverId, constructorId, number, position, q1, q2, q3) VALUES (3, 10, 1, 1, 2, 3, '1:46.000', '1:46.000', '1:44.801');
-- Driver 4: Faster q3, but in year 2009 on same circuit (tests year = 2008 filter)
INSERT INTO qualifying (qualifyId, raceId, driverId, constructorId, number, position, q1, q2, q3) VALUES (4, 11, 4, 1, 4, 1, '1:40.000', '1:40.000', '1:38.100');
-- Driver 5: Faster q3 in 2008, but on different circuit (tests circuit name filter)
INSERT INTO qualifying (qualifyId, raceId, driverId, constructorId, number, position, q1, q2, q3) VALUES (5, 12, 5, 1, 15, 1, '1:35.000', '1:35.000', '1:35.500');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.forename, T2.surname FROM qualifying AS T1 INNER JOIN drivers AS T2 ON T1.driverId = T2.driverId INNER JOIN races AS T3 ON T1.raceid = T3.raceid WHERE NOT q3 IS NULL AND T3.year = 2008 AND T3.circuitId IN (SELECT circuitId FROM circuits WHERE name = 'Marina Bay Street Circuit') ORDER BY CAST(SUBSTRING(q3, 1, INSTR(q3, ':') - 1) AS INTEGER) * 60 + CAST(SUBSTRING(q3, INSTR(q3, ':') + 1, INSTR(q3, '.') - INSTR(q3, ':') - 1) AS REAL) + CAST(SUBSTRING(q3, INSTR(q3, '.') + 1) AS REAL) / 1000 ASC, T1.qualifyid NULLS LAST, T2.driverid NULLS LAST, T3.raceid NULLS LAST LIMIT 1;

/*
Gold Result:
('Felipe', 'Massa')
*/

-- Prediction Query
SELECT d.forename, d.surname FROM circuits AS c JOIN races AS r ON c.circuitId = r.circuitId JOIN qualifying AS q ON r.raceId = q.raceId JOIN drivers AS d ON q.driverId = d.driverId WHERE c.name = 'Marina Bay Street Circuit' AND r.year = 2008 AND q.position = 1 AND q.q3 = (SELECT MIN(q3) FROM qualifying WHERE raceId = r.raceId) ORDER BY q.position, c.circuitid NULLS LAST, r.raceid NULLS LAST, q.qualifyid NULLS LAST, d.driverid NULLS LAST LIMIT 1;

/*
Prediction Result:
*/