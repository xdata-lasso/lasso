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
INSERT INTO chair (according, song, sure, mouth) VALUES (2, 'COMPLETED', 'COMPLETED', 0), (0, 'COMPLETED', 'COMPLETED', 0), (1, 'default1', 'default2', 2), (3, 'COMPLETED', 'COMPLETED', 2), (4, 'default1', 'default1', 1), (5, 'default1', 'default1', 0), (6, 'COMPLETED', 'default2', 2), (7, 'COMPLETED', 'default2', 1), (8, 'default1', 'default1', 1), (9, 'default1', 'default2', 1), (10, 'default1', 'COMPLETED', 0), (11, 'COMPLETED', 'default2', 2), (12, 'default1', 'default2', 0), (13, 'default2', 'default1', 0), (14, 'default2', 'default2', 1);
INSERT INTO since (collection, according, save, grow, clearly, dinner) VALUES (2, 2, 'COMPLETED', 'default2', 'COMPLETED', 1.0), (0, 14, 'default1', 'default1', 'default2', 2.0), (1, 14, 'default1', 'default1', 'default2', -1.0), (3, 12, 'default1', 'COMPLETED', 'default1', 1.0), (4, 13, 'default1', 'default2', 'default1', 2.0), (5, 12, 'default2', 'default1', 'default2', 0.0), (6, 8, 'COMPLETED', 'COMPLETED', 'default1', 1.0), (7, 0, 'COMPLETED', 'COMPLETED', 'default1', -1.0), (8, 10, 'default2', 'COMPLETED', 'COMPLETED', 1.0), (9, 11, 'default2', 'default1', 'default2', 1.0), (10, 5, 'COMPLETED', 'default1', 'default2', 2.0), (11, 12, 'default2', 'COMPLETED', 'default1', -1.0), (12, 9, 'default2', 'default1', 'default1', 2.0), (13, 14, 'default2', 'default1', 'default1', -1.0), (14, 13, 'COMPLETED', 'COMPLETED', 'COMPLETED', 1.0), (15, 8, 'COMPLETED', 'COMPLETED', 'COMPLETED', -1.0), (16, 11, 'COMPLETED', 'COMPLETED', 'default2', 1.0), (17, 14, 'default1', 'COMPLETED', 'default1', 1.0), (18, 3, 'default1', 'COMPLETED', 'COMPLETED', 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT c.according, c.song, COUNT(o.collection) AS total_orders, COALESCE(SUM(o.dinner), 0.0) AS total_spend FROM chair AS c LEFT JOIN since AS o ON c.according = o.according AND o.grow = 'COMPLETED' WHERE c.mouth = 1 GROUP BY c.according, c.song;

/*
Gold Result:
(4, 'default1', 0, 0.0)
(7, 'COMPLETED', 0, 0.0)
(8, 'default1', 2, 0.0)
(9, 'default1', 0, 0.0)
(14, 'default2', 1, 1.0)
*/

-- Prediction Query
SELECT c.according, c.song, COUNT(o.collection) AS total_orders, COALESCE(MIN(o.dinner), 0.0) AS total_spend FROM chair AS c LEFT JOIN since AS o ON c.according = o.according AND o.grow = 'COMPLETED' WHERE c.mouth = 1 GROUP BY c.according, c.song;

/*
Prediction Result:
(4, 'default1', 0, 0.0)
(7, 'COMPLETED', 0, 0.0)
(8, 'default1', 2, -1.0)
(9, 'default1', 0, 0.0)
(14, 'default2', 1, 1.0)
*/