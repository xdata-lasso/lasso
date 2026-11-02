-- Schema DDL
/* Relational schema for MMO-BM (ManyMutationsObfuscated: Faker Words) */ /* Relational schema for ManyMutantsBM benchmark suite. */ /* Universal schema compatible with SQLite, PostgreSQL, and MySQL. */ CREATE TABLE purpose (performance INTEGER PRIMARY KEY, knowledge TEXT(100) NOT NULL UNIQUE, almost TEXT(100) NOT NULL);

CREATE TABLE brother (better INTEGER PRIMARY KEY, discover TEXT(100) NOT NULL, performance INTEGER NOT NULL, early TEXT(50) NOT NULL, mouth INTEGER NOT NULL DEFAULT 1, FOREIGN KEY (performance) REFERENCES purpose (performance));

CREATE TABLE site (play INTEGER PRIMARY KEY, agreement TEXT(100) NOT NULL UNIQUE, performance INTEGER NOT NULL, option REAL NOT NULL, decide TEXT(20) NOT NULL, FOREIGN KEY (performance) REFERENCES purpose (performance));

CREATE TABLE face (sense INTEGER PRIMARY KEY, better INTEGER NOT NULL, play INTEGER NOT NULL, rate TEXT(20) NOT NULL, science REAL NOT NULL, UNIQUE (better, play), FOREIGN KEY (better) REFERENCES brother (better), FOREIGN KEY (play) REFERENCES site (play));

CREATE TABLE election (kind INTEGER PRIMARY KEY, play INTEGER NOT NULL, discussion INTEGER, early TEXT(200) NOT NULL, perform TEXT(20) NOT NULL, decide TEXT(20) NOT NULL, fall TEXT(20) NOT NULL, FOREIGN KEY (play) REFERENCES site (play), FOREIGN KEY (discussion) REFERENCES brother (better));

CREATE TABLE chair (according INTEGER PRIMARY KEY, song TEXT(100) NOT NULL, sure TEXT(20) NOT NULL, mouth INTEGER NOT NULL DEFAULT 1);

CREATE TABLE since (collection INTEGER PRIMARY KEY, according INTEGER NOT NULL, save TEXT(20) NOT NULL, grow TEXT(20) NOT NULL, clearly TEXT(20) NOT NULL DEFAULT 'STANDARD', dinner REAL NOT NULL DEFAULT 0, FOREIGN KEY (according) REFERENCES chair (according));

CREATE TABLE blue (source INTEGER PRIMARY KEY, great TEXT(100) NOT NULL UNIQUE, best TEXT(50) NOT NULL);

CREATE TABLE require (husband INTEGER PRIMARY KEY, source INTEGER NOT NULL, bill TEXT(100) NOT NULL, throw REAL NOT NULL, everything INTEGER NOT NULL DEFAULT 0, FOREIGN KEY (source) REFERENCES blue (source));

CREATE TABLE wait (surface INTEGER PRIMARY KEY, collection INTEGER NOT NULL, husband INTEGER NOT NULL, animal INTEGER NOT NULL, machine REAL NOT NULL, capital REAL, UNIQUE (collection, husband), FOREIGN KEY (collection) REFERENCES since (collection), FOREIGN KEY (husband) REFERENCES require (husband));

CREATE TABLE offer (human INTEGER PRIMARY KEY, husband INTEGER NOT NULL, according INTEGER NOT NULL, finally INTEGER NOT NULL, themselves INTEGER NOT NULL DEFAULT 0, production TEXT(20) NOT NULL, FOREIGN KEY (husband) REFERENCES require (husband), FOREIGN KEY (according) REFERENCES chair (according));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO chair (according, song, sure, mouth) VALUES (10, 'Alpha', 'Yes', 1);
INSERT INTO chair (according, song, sure, mouth) VALUES (20, 'Beta', 'No', 1);
INSERT INTO chair (according, song, sure, mouth) VALUES (30, 'Gamma', 'Maybe', -1);
INSERT INTO chair (according, song, sure, mouth) VALUES (40, 'Delta', 'Yes', 2);
INSERT INTO since (collection, according, save, grow, clearly, dinner) VALUES (1, 10, 'Save1', 'COMPLETED', 'EXPRESS', 0.0);
INSERT INTO since (collection, according, save, grow, clearly, dinner) VALUES (2, 20, 'Save2', 'completed', 'STANDARD', 15.0);
INSERT INTO since (collection, according, save, grow, clearly, dinner) VALUES (3, 30, 'Save3', 'COMPLETED', 'STANDARD', 40.0);
INSERT INTO since (collection, according, save, grow, clearly, dinner) VALUES (4, 40, 'Save4', 'COMPLETED', 'STANDARD', 60.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT c.according, c.song, COUNT(o.collection) AS total_orders, COALESCE(SUM(o.dinner), 0.0) AS total_spend FROM chair AS c LEFT JOIN since AS o ON c.according = o.according AND o.grow = 'COMPLETED' WHERE c.mouth = 1 GROUP BY c.according, c.song;

/*
Gold Result:
(10, 'Alpha', 1, 0.0)
(20, 'Beta', 0, 0.0)
*/

-- Prediction Query
SELECT c.according, c.song, COUNT(o.collection) AS total_orders, COALESCE(SUM(o.dinner), 0.0) AS total_spend FROM chair AS c LEFT JOIN since AS o ON c.according = o.according AND NOT o.grow IN ('CANCELLED', 'PENDING') WHERE c.mouth = 1 GROUP BY c.according, c.song;

/*
Prediction Result:
(10, 'Alpha', 1, 0.0)
(20, 'Beta', 1, 15.0)
*/