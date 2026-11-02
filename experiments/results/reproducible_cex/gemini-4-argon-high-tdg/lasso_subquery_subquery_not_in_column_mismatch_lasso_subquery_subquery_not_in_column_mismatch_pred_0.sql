-- Schema DDL
CREATE TABLE circuits (circuitId INTEGER PRIMARY KEY AUTOINCREMENT, circuitRef TEXT DEFAULT '' NOT NULL, name TEXT DEFAULT '' NOT NULL, url TEXT DEFAULT '' NOT NULL UNIQUE);

CREATE TABLE seasons (year INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, url TEXT DEFAULT '' NOT NULL UNIQUE);

CREATE TABLE races (raceId INTEGER PRIMARY KEY AUTOINCREMENT, year INTEGER DEFAULT 0 NOT NULL, round INTEGER DEFAULT 0 NOT NULL, circuitId INTEGER DEFAULT 0 NOT NULL, name TEXT DEFAULT '' NOT NULL, date DATE DEFAULT '0000-00-00' NOT NULL, time TEXT, url TEXT UNIQUE, FOREIGN KEY (year) REFERENCES seasons (year), FOREIGN KEY (circuitId) REFERENCES circuits (circuitId));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO circuits (circuitId, circuitRef, name, url) VALUES (1, 'silverstone', 'Silverstone Circuit', 'http://en.wikipedia.org/wiki/Silverstone_Circuit');
INSERT INTO circuits (circuitId, circuitRef, name, url) VALUES (2, 'brands_hatch', 'Brands Hatch', 'http://en.wikipedia.org/wiki/Brands_Hatch');
INSERT INTO seasons (year, url) VALUES (2000, 'http://en.wikipedia.org/wiki/2000_Formula_One_season');
INSERT INTO seasons (year, url) VALUES (2017, 'http://en.wikipedia.org/wiki/2017_Formula_One_season');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (1, 2000, 4, 1, 'British Grand Prix', '2000-04-23', '12:00:00', 'http://en.wikipedia.org/wiki/2000_British_Grand_Prix');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (2, 2017, 10, 2, 'British Grand Prix', '2017-07-16', '12:00:00', 'http://en.wikipedia.org/wiki/2017_British_Grand_Prix');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (3, 2017, 11, 1, '70th Anniversary Grand Prix', '2017-07-23', '12:00:00', 'http://en.wikipedia.org/wiki/2017_70th_Anniversary_Grand_Prix');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM races WHERE year = 2017 AND NOT name IN (SELECT name FROM races WHERE year = 2000);

/*
Gold Result:
('70th Anniversary Grand Prix',)
*/

-- Prediction Query
SELECT r.name FROM races AS r WHERE r.year = 2017 AND NOT r.circuitId IN (SELECT r2.circuitId FROM races AS r2 WHERE r2.year = 2000);

/*
Prediction Result:
('British Grand Prix',)
*/