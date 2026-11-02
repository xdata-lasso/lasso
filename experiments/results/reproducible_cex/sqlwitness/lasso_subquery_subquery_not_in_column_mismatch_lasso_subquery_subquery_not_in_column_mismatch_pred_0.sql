-- Schema DDL
CREATE TABLE circuits (circuitId INTEGER PRIMARY KEY AUTOINCREMENT, circuitRef TEXT DEFAULT '' NOT NULL, name TEXT DEFAULT '' NOT NULL, url TEXT DEFAULT '' NOT NULL UNIQUE);

CREATE TABLE seasons (year INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, url TEXT DEFAULT '' NOT NULL UNIQUE);

CREATE TABLE races (raceId INTEGER PRIMARY KEY AUTOINCREMENT, year INTEGER DEFAULT 0 NOT NULL, round INTEGER DEFAULT 0 NOT NULL, circuitId INTEGER DEFAULT 0 NOT NULL, name TEXT DEFAULT '' NOT NULL, date DATE DEFAULT '0000-00-00' NOT NULL, time TEXT, url TEXT UNIQUE, FOREIGN KEY (year) REFERENCES seasons (year), FOREIGN KEY (circuitId) REFERENCES circuits (circuitId));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO seasons (year, url) VALUES (1999, 'default2'), (2017, 'default1'), (0, 'unique_2'), (2000, 'unique_3'), (2018, 'unique_4'), (2016, 'unique_5'), (2001, 'unique_6'), (1, 'unique_7'), (2, 'unique_8'), (3, 'unique_9'), (4, 'unique_10'), (5, 'unique_11'), (6, 'unique_12');
INSERT INTO circuits (circuitid, circuitref, name, url) VALUES (1, 'default2', 'default2', 'default2'), (2001, 'default1', 'default1', 'default1'), (2017, 'default2', 'default1', 'unique_2'), (2018, 'default2', 'default1', 'unique_3'), (2016, 'default2', 'default2', 'unique_4'), (1999, 'default1', 'default2', 'unique_5'), (2000, 'default1', 'default1', 'unique_6'), (0, 'default1', 'default2', 'unique_7'), (2, 'default2', 'default2', 'unique_8');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (2001, 0, 2, 2016, 'default1', '2023-01-02', 'default1', NULL), (2016, 6, 1, 2001, 'default2', '2023-01-02', 'default1', 'default1'), (1999, 2000, 2017, 2018, 'default2', '2023-01-02', 'default1', 'default2'), (2017, 2016, 1, 0, 'default1', '2023-01-01', 'default2', 'unique_3'), (1, 2017, 1999, 2000, 'default2', '2023-01-02', 'default1', 'unique_4'), (2000, 2, 2017, 2018, 'default2', '2023-01-01', 'default1', 'unique_5'), (0, 4, 1999, 2018, 'default1', '2023-01-02', NULL, 'unique_6'), (2018, 2000, 1, 0, 'default1', '2023-01-02', 'default2', 'unique_7'), (2, 2017, 2016, 2016, 'default2', '2023-01-02', 'default1', 'unique_8'), (3, 1999, 2, 2000, 'default1', '2023-01-02', 'default2', 'unique_9'), (4, 2000, 2016, 0, 'default2', '2023-01-01', NULL, 'unique_10'), (5, 1, 2017, 2000, 'default1', '2023-01-01', 'default1', 'unique_11'), (6, 6, 2001, 1, 'default2', '2023-01-01', 'default1', 'unique_12'), (7, 2018, 2, 2017, 'default1', '2023-01-01', 'default2', 'unique_13');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM races WHERE year = 2017 AND NOT name IN (SELECT name FROM races WHERE year = 2000);

/*
Gold Result:
*/

-- Prediction Query
SELECT r.name FROM races AS r WHERE r.year = 2017 AND NOT r.circuitId IN (SELECT r2.circuitId FROM races AS r2 WHERE r2.year = 2000);

/*
Prediction Result:
('default2',)
*/