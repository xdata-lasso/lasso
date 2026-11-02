-- Schema DDL
CREATE TABLE circuits (circuitId INTEGER PRIMARY KEY AUTOINCREMENT, circuitRef TEXT DEFAULT '' NOT NULL, name TEXT DEFAULT '' NOT NULL, url TEXT DEFAULT '' NOT NULL UNIQUE);

CREATE TABLE seasons (year INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, url TEXT DEFAULT '' NOT NULL UNIQUE);

CREATE TABLE races (raceId INTEGER PRIMARY KEY AUTOINCREMENT, year INTEGER DEFAULT 0 NOT NULL, round INTEGER DEFAULT 0 NOT NULL, circuitId INTEGER DEFAULT 0 NOT NULL, name TEXT DEFAULT '' NOT NULL, date DATE DEFAULT '0000-00-00' NOT NULL, time TEXT, url TEXT UNIQUE, FOREIGN KEY (year) REFERENCES seasons (year), FOREIGN KEY (circuitId) REFERENCES circuits (circuitId));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO circuits (circuitId, circuitRef, name, url) VALUES (1, 'c1', 'Circuit 1', 'http://c1');
INSERT INTO seasons (year, url) VALUES (2000, 'http://s2000');
INSERT INTO seasons (year, url) VALUES (2017, 'http://s2017');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (1, 2000, 1, 1, 'Race A', '2000-01-01', '12:00:00', 'http://r1');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (2, 2017, 1, 1, 'Race B', '2017-01-01', '12:00:00', 'http://r2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM races WHERE year = 2017 AND NOT name IN (SELECT name FROM races WHERE year = 2000);

/*
Gold Result:
('Race B',)
*/

-- Prediction Query
SELECT r.name FROM races AS r WHERE r.year = 2017 AND NOT r.circuitId IN (SELECT r2.circuitId FROM races AS r2 WHERE r2.year = 2000);

/*
Prediction Result:
*/