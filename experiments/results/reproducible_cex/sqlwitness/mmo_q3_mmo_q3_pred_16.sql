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
INSERT INTO blue (source, great, best) VALUES (0, 'default1', 'default2'), (3, 'default2', 'default2'), (-1, 'unique_2', 'default1'), (1, 'unique_3', 'default2'), (2, 'unique_4', 'default1'), (4, 'unique_5', 'default1'), (5, 'unique_6', 'default1'), (6, 'unique_7', 'default2'), (7, 'unique_8', 'default1');
INSERT INTO require (husband, source, bill, throw, everything) VALUES (2, 5, 'default2', 1.0, -1), (1, 3, 'default1', 1.0, 2), (-1, 2, 'default2', 0.0, -1), (3, 1, 'default1', 0.0, 0), (0, 1, 'default2', 0.0, -1), (4, 4, 'default1', 0.0, 0), (5, 7, 'default1', 1.0, 0), (6, 2, 'default1', -1.0, 0), (7, 7, 'default2', 3.0, 2), (8, 7, 'default2', -1.0, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT husband, bill, source, throw FROM (SELECT p.husband, p.bill, p.source, p.throw, ROW_NUMBER() OVER (PARTITION BY p.source ORDER BY p.throw DESC, p.husband ASC) AS rank_in_cat FROM require AS p WHERE p.everything = 0) AS ranked WHERE ranked.rank_in_cat = 1;

/*
Gold Result:
(3, 'default1', 1, 0.0)
(6, 'default1', 2, -1.0)
(4, 'default1', 4, 0.0)
(5, 'default1', 7, 1.0)
*/

-- Prediction Query
SELECT husband, bill, source, throw FROM (SELECT p.husband, p.bill, p.source, p.throw, ROW_NUMBER() OVER (PARTITION BY p.source ORDER BY p.throw DESC, p.husband ASC) AS rank_in_cat FROM require AS p WHERE p.everything = 0 AND p.source <= 2) AS ranked WHERE ranked.rank_in_cat = 1;

/*
Prediction Result:
(3, 'default1', 1, 0.0)
(6, 'default1', 2, -1.0)
*/