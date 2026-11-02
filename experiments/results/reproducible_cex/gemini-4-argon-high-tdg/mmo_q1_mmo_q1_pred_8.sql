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
INSERT INTO chair (according, song, sure, mouth) VALUES (1, 'Inactive Alice', 'BRONZE', 0);
INSERT INTO chair (according, song, sure, mouth) VALUES (2, 'Active Bob', 'GOLD', 1);
INSERT INTO chair (according, song, sure, mouth) VALUES (3, 'Pending Carol', 'SILVER', 1);
INSERT INTO chair (according, song, sure, mouth) VALUES (4, 'NoOrder Dave', 'BRONZE', 1);
INSERT INTO since (collection, according, save, grow, clearly, dinner) VALUES (101, 1, '2023-01-10', 'COMPLETED', 'STANDARD', 99.95);
INSERT INTO since (collection, according, save, grow, clearly, dinner) VALUES (102, 2, '2023-02-01', 'COMPLETED', 'STANDARD', 15.50);
INSERT INTO since (collection, according, save, grow, clearly, dinner) VALUES (103, 2, '2023-02-15', 'COMPLETED', 'EXPRESS', 24.75);
INSERT INTO since (collection, according, save, grow, clearly, dinner) VALUES (104, 2, '2023-02-20', 'PENDING', 'STANDARD', 100.00);
INSERT INTO since (collection, according, save, grow, clearly, dinner) VALUES (105, 3, '2023-03-05', 'CANCELLED', 'STANDARD', 50.00);
INSERT INTO since (collection, according, save, grow, clearly, dinner) VALUES (106, 3, '2023-03-06', 'PENDING', 'EXPRESS', 75.00);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT c.according, c.song, COUNT(o.collection) AS total_orders, COALESCE(SUM(o.dinner), 0.0) AS total_spend FROM chair AS c LEFT JOIN since AS o ON c.according = o.according AND o.grow = 'COMPLETED' WHERE c.mouth = 1 GROUP BY c.according, c.song;

/*
Gold Result:
(2, 'Active Bob', 2, 40.25)
(3, 'Pending Carol', 0, 0.0)
(4, 'NoOrder Dave', 0, 0.0)
*/

-- Prediction Query
SELECT c.according, c.song, COUNT(o.collection) AS total_orders, COALESCE(AVG(o.dinner), 0.0) AS total_spend FROM chair AS c LEFT JOIN since AS o ON c.according = o.according AND o.grow = 'COMPLETED' WHERE c.mouth = 1 GROUP BY c.according, c.song;

/*
Prediction Result:
(2, 'Active Bob', 2, 20.125)
(3, 'Pending Carol', 0, 0.0)
(4, 'NoOrder Dave', 0, 0.0)
*/