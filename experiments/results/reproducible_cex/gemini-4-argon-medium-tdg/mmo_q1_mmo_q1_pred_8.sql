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
-- DATASET 1
-- Tests LEFT JOIN behavior, COALESCE on NULL sums, COUNT(o.collection) vs COUNT(*), ON condition o.grow = 'COMPLETED' vs WHERE clause filtering, and c.mouth = 1 filtering.
INSERT INTO chair (according, song, sure, mouth) VALUES (1, 'Alpha', 'YES', 1);
INSERT INTO chair (according, song, sure, mouth) VALUES (2, 'Beta', 'YES', 1);
INSERT INTO chair (according, song, sure, mouth) VALUES (3, 'Gamma', 'NO', 1);
INSERT INTO chair (according, song, sure, mouth) VALUES (4, 'Delta', 'YES', 0);
INSERT INTO chair (according, song, sure, mouth) VALUES (5, 'Epsilon', 'NO', 2);
INSERT INTO since (collection, according, save, grow, clearly, dinner) VALUES (101, 2, '2023-01-01', 'PENDING', 'STANDARD', 50.0);
INSERT INTO since (collection, according, save, grow, clearly, dinner) VALUES (102, 3, '2023-01-02', 'COMPLETED', 'STANDARD', 100.0);
INSERT INTO since (collection, according, save, grow, clearly, dinner) VALUES (103, 3, '2023-01-03', 'COMPLETED', 'STANDARD', 150.0);
INSERT INTO since (collection, according, save, grow, clearly, dinner) VALUES (104, 3, '2023-01-04', 'CANCELLED', 'STANDARD', 75.0);
INSERT INTO since (collection, according, save, grow, clearly, dinner) VALUES (105, 4, '2023-01-05', 'COMPLETED', 'STANDARD', 200.0);
INSERT INTO since (collection, according, save, grow, clearly, dinner) VALUES (106, 5, '2023-01-06', 'COMPLETED', 'STANDARD', 300.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT c.according, c.song, COUNT(o.collection) AS total_orders, COALESCE(SUM(o.dinner), 0.0) AS total_spend FROM chair AS c LEFT JOIN since AS o ON c.according = o.according AND o.grow = 'COMPLETED' WHERE c.mouth = 1 GROUP BY c.according, c.song;

/*
Gold Result:
(1, 'Alpha', 0, 0.0)
(2, 'Beta', 0, 0.0)
(3, 'Gamma', 2, 250.0)
*/

-- Prediction Query
SELECT c.according, c.song, COUNT(o.collection) AS total_orders, COALESCE(AVG(o.dinner), 0.0) AS total_spend FROM chair AS c LEFT JOIN since AS o ON c.according = o.according AND o.grow = 'COMPLETED' WHERE c.mouth = 1 GROUP BY c.according, c.song;

/*
Prediction Result:
(1, 'Alpha', 0, 0.0)
(2, 'Beta', 0, 0.0)
(3, 'Gamma', 2, 125.0)
*/