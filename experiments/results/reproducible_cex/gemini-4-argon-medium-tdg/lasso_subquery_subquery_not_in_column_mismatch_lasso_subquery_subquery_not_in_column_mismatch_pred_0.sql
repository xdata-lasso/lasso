-- Schema DDL
CREATE TABLE circuits (circuitId INTEGER PRIMARY KEY AUTOINCREMENT, circuitRef TEXT DEFAULT '' NOT NULL, name TEXT DEFAULT '' NOT NULL, url TEXT DEFAULT '' NOT NULL UNIQUE);

CREATE TABLE seasons (year INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, url TEXT DEFAULT '' NOT NULL UNIQUE);

CREATE TABLE races (raceId INTEGER PRIMARY KEY AUTOINCREMENT, year INTEGER DEFAULT 0 NOT NULL, round INTEGER DEFAULT 0 NOT NULL, circuitId INTEGER DEFAULT 0 NOT NULL, name TEXT DEFAULT '' NOT NULL, date DATE DEFAULT '0000-00-00' NOT NULL, time TEXT, url TEXT UNIQUE, FOREIGN KEY (year) REFERENCES seasons (year), FOREIGN KEY (circuitId) REFERENCES circuits (circuitId));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic set difference, boundary years (1999, 2001, 2016, 2018), and circuitId vs name anti-join mutations.
INSERT INTO circuits (circuitId, circuitRef, name, url) VALUES (1, 'albert_park', 'Albert Park', 'http://url1');
INSERT INTO circuits (circuitId, circuitRef, name, url) VALUES (2, 'sepang', 'Sepang', 'http://url2');
INSERT INTO circuits (circuitId, circuitRef, name, url) VALUES (3, 'bahrain', 'Bahrain', 'http://url3');
INSERT INTO seasons (year, url) VALUES (1999, 'http://s1999');
INSERT INTO seasons (year, url) VALUES (2000, 'http://s2000');
INSERT INTO seasons (year, url) VALUES (2001, 'http://s2001');
INSERT INTO seasons (year, url) VALUES (2016, 'http://s2016');
INSERT INTO seasons (year, url) VALUES (2017, 'http://s2017');
INSERT INTO seasons (year, url) VALUES (2018, 'http://s2018');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (1, 2017, 1, 1, 'Australian GP', '2017-03-26', '05:00:00', 'http://r1');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (2, 2000, 1, 2, 'Australian GP', '2000-03-12', '03:00:00', 'http://r2');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (3, 2017, 2, 1, 'Chinese GP', '2017-04-09', '06:00:00', 'http://r3');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (4, 2000, 2, 1, 'Brazilian GP', '2000-03-26', '17:00:00', 'http://r4');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (5, 2016, 1, 3, 'Bahrain GP', '2016-04-03', '15:00:00', 'http://r5');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (6, 2018, 1, 3, 'Russian GP', '2018-09-30', '11:10:00', 'http://r6');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (7, 2017, 3, 2, 'Monaco GP', '2017-05-28', '12:00:00', 'http://r7');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (8, 1999, 3, 2, 'Monaco GP', '1999-05-16', '12:00:00', 'http://r8');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (9, 2017, 4, 3, 'Canadian GP', '2017-06-11', '18:00:00', 'http://r9');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (10, 2001, 4, 3, 'Canadian GP', '2001-06-10', '17:00:00', 'http://r10');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM races WHERE year = 2017 AND NOT name IN (SELECT name FROM races WHERE year = 2000);

/*
Gold Result:
('Chinese GP',)
('Monaco GP',)
('Canadian GP',)
*/

-- Prediction Query
SELECT r.name FROM races AS r WHERE r.year = 2017 AND NOT r.circuitId IN (SELECT r2.circuitId FROM races AS r2 WHERE r2.year = 2000);

/*
Prediction Result:
('Canadian GP',)
*/