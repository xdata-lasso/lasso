-- Schema DDL
CREATE TABLE circuits (circuitId INTEGER PRIMARY KEY AUTOINCREMENT, circuitRef TEXT DEFAULT '' NOT NULL, name TEXT DEFAULT '' NOT NULL, url TEXT DEFAULT '' NOT NULL UNIQUE);

CREATE TABLE seasons (year INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, url TEXT DEFAULT '' NOT NULL UNIQUE);

CREATE TABLE races (raceId INTEGER PRIMARY KEY AUTOINCREMENT, year INTEGER DEFAULT 0 NOT NULL, round INTEGER DEFAULT 0 NOT NULL, circuitId INTEGER DEFAULT 0 NOT NULL, name TEXT DEFAULT '' NOT NULL, date DATE DEFAULT '0000-00-00' NOT NULL, time TEXT, url TEXT UNIQUE, FOREIGN KEY (year) REFERENCES seasons (year), FOREIGN KEY (circuitId) REFERENCES circuits (circuitId));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "url") VALUES (1019, 'avoid', 'Diana Washington', 'http://mueller.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "url") VALUES (1022, 'avoid', 'Diana Washington', 'https://www.pearson.com/');
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "url") VALUES (1025, 'director', 'Lauren Daniels', 'https://www.silva.net/');
INSERT INTO "seasons" ("year", "url") VALUES (2017, 'http://www.jordan.com/');
INSERT INTO "seasons" ("year", "url") VALUES (1023, 'https://www.gray.com/');
INSERT INTO "seasons" ("year", "url") VALUES (2000, 'http://www.miller.com/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1020, 2017, 1021, 1019, 'Victoria Garcia', '1973-04-04', 'interesting', 'https://www.lee.info/');
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1024, 2017, 1021, 1019, 'Katelyn Lee', '1973-04-04', 'interesting', NULL);
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1026, 2000, 1027, 1025, 'Victoria Garcia', '1974-05-05', 'international', 'http://www.wheeler.org/');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM races WHERE year = 2017 AND NOT name IN (SELECT name FROM races WHERE year = 2000);

/*
Gold Result:
('Katelyn Lee',)
*/

-- Prediction Query
SELECT r.name FROM races AS r WHERE r.year = 2017 AND NOT r.circuitId IN (SELECT r2.circuitId FROM races AS r2 WHERE r2.year = 2000);

/*
Prediction Result:
('Victoria Garcia',)
('Katelyn Lee',)
*/