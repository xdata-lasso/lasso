-- Schema DDL
CREATE TABLE circuits (circuitId INTEGER PRIMARY KEY AUTOINCREMENT, circuitRef TEXT DEFAULT '' NOT NULL, name TEXT DEFAULT '' NOT NULL, url TEXT DEFAULT '' NOT NULL UNIQUE);

CREATE TABLE seasons (year INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, url TEXT DEFAULT '' NOT NULL UNIQUE);

CREATE TABLE races (raceId INTEGER PRIMARY KEY AUTOINCREMENT, year INTEGER DEFAULT 0 NOT NULL, round INTEGER DEFAULT 0 NOT NULL, circuitId INTEGER DEFAULT 0 NOT NULL, name TEXT DEFAULT '' NOT NULL, date DATE DEFAULT '0000-00-00' NOT NULL, time TEXT, url TEXT UNIQUE, FOREIGN KEY (year) REFERENCES seasons (year), FOREIGN KEY (circuitId) REFERENCES circuits (circuitId));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic set difference, boundary years (1999, 2001, 2016, 2018), and circuits.name vs races.name confusion.
INSERT INTO circuits (circuitId, circuitRef, name, url) VALUES (1, 'albert_park', 'Australian Grand Prix', 'http://en.wikipedia.org/wiki/Melbourne_Grand_Prix_Circuit');
INSERT INTO circuits (circuitId, circuitRef, name, url) VALUES (2, 'sepang', 'Russian Grand Prix', 'http://en.wikipedia.org/wiki/Sepang_International_Circuit');
INSERT INTO circuits (circuitId, circuitRef, name, url) VALUES (3, 'bahrain', 'Bahrain Circuit', 'http://en.wikipedia.org/wiki/Bahrain_International_Circuit');
INSERT INTO seasons (year, url) VALUES (1999, 'http://en.wikipedia.org/wiki/1999_Formula_One_season');
INSERT INTO seasons (year, url) VALUES (2000, 'http://en.wikipedia.org/wiki/2000_Formula_One_season');
INSERT INTO seasons (year, url) VALUES (2001, 'http://en.wikipedia.org/wiki/2001_Formula_One_season');
INSERT INTO seasons (year, url) VALUES (2016, 'http://en.wikipedia.org/wiki/2016_Formula_One_season');
INSERT INTO seasons (year, url) VALUES (2017, 'http://en.wikipedia.org/wiki/2017_Formula_One_season');
INSERT INTO seasons (year, url) VALUES (2018, 'http://en.wikipedia.org/wiki/2018_Formula_One_season');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (1, 2017, 1, 2, 'Russian Grand Prix', '2017-04-30', '12:00:00', 'http://en.wikipedia.org/wiki/2017_Russian_Grand_Prix');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (2, 2017, 2, 1, 'Australian Grand Prix', '2017-03-26', '05:00:00', 'http://en.wikipedia.org/wiki/2017_Australian_Grand_Prix');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (3, 2000, 1, 1, 'Australian Grand Prix', '2000-03-12', '03:00:00', 'http://en.wikipedia.org/wiki/2000_Australian_Grand_Prix');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (4, 2000, 2, 2, 'Malaysian Grand Prix', '2000-10-22', '07:00:00', 'http://en.wikipedia.org/wiki/2000_Malaysian_Grand_Prix');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (5, 2016, 1, 3, 'Bahrain Grand Prix', '2016-04-03', '15:00:00', 'http://en.wikipedia.org/wiki/2016_Bahrain_Grand_Prix');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (6, 2018, 1, 3, 'Azerbaijan Grand Prix', '2018-04-29', '12:10:00', 'http://en.wikipedia.org/wiki/2018_Azerbaijan_Grand_Prix');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (7, 1999, 1, 2, 'Russian Grand Prix', '1999-05-02', '12:00:00', 'http://en.wikipedia.org/wiki/1999_Russian_Grand_Prix');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (8, 2001, 1, 2, 'Russian Grand Prix', '2001-05-02', '12:00:00', 'http://en.wikipedia.org/wiki/2001_Russian_Grand_Prix');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM races WHERE year = 2017 AND NOT name IN (SELECT name FROM races WHERE year = 2000);

/*
Gold Result:
('Russian Grand Prix',)
*/

-- Prediction Query
SELECT r.name FROM races AS r WHERE r.year = 2017 AND NOT r.circuitId IN (SELECT r2.circuitId FROM races AS r2 WHERE r2.year = 2000);

/*
Prediction Result:
*/