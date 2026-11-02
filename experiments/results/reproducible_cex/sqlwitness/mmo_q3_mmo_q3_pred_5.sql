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
INSERT INTO blue (source, great, best) VALUES (0, 'default1', 'default2'), (2, 'default2', 'default1'), (1, 'unique_2', 'default1'), (3, 'unique_3', 'default1'), (-1, 'unique_4', 'default1'), (4, 'unique_5', 'default1'), (5, 'unique_6', 'default2'), (6, 'unique_7', 'default2'), (7, 'unique_8', 'default1'), (8, 'unique_9', 'default2'), (9, 'unique_10', 'default1'), (10, 'unique_11', 'default2'), (11, 'unique_12', 'default2'), (12, 'unique_13', 'default2'), (13, 'unique_14', 'default1'), (14, 'unique_15', 'default2'), (15, 'unique_16', 'default2'), (16, 'unique_17', 'default2'), (17, 'unique_18', 'default1'), (18, 'unique_19', 'default2'), (19, 'unique_20', 'default1'), (20, 'unique_21', 'default1'), (21, 'unique_22', 'default1');
INSERT INTO require (husband, source, bill, throw, everything) VALUES (-1, 2, 'default2', 1.0, -1), (1, 11, 'default1', 3.0, -1), (2, 11, 'default1', -1.0, 2), (0, 17, 'default2', -1.0, 3), (3, 3, 'default1', 3.0, -1), (4, 3, 'default1', 2.0, 3), (5, 0, 'default1', 1.0, 2), (6, 15, 'default1', 0.0, -1), (7, 1, 'default2', 1.0, 0), (8, 5, 'default2', 0.0, 3), (9, 20, 'default2', 2.0, 0), (10, 1, 'default1', 3.0, 3), (11, 21, 'default1', 3.0, 0), (12, 12, 'default2', 1.0, -1), (13, 6, 'default2', 0.0, 1), (14, 20, 'default2', 2.0, 0), (15, 5, 'default1', 1.0, 3), (16, 10, 'default1', 1.0, 0), (17, 3, 'default2', 3.0, 3), (18, 17, 'default1', -1.0, -1), (19, -1, 'default2', 0.0, 3), (20, 21, 'default2', 2.0, 0), (21, 7, 'default2', 0.0, 0), (22, 3, 'default2', 2.0, 3), (23, 12, 'default2', 3.0, 3), (24, 15, 'default1', 2.0, 2), (25, 10, 'default1', -1.0, -1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT husband, bill, source, throw FROM (SELECT p.husband, p.bill, p.source, p.throw, ROW_NUMBER() OVER (PARTITION BY p.source ORDER BY p.throw DESC, p.husband ASC) AS rank_in_cat FROM require AS p WHERE p.everything = 0) AS ranked WHERE ranked.rank_in_cat = 1;

/*
Gold Result:
(7, 'default2', 1, 1.0)
(21, 'default2', 7, 0.0)
(16, 'default1', 10, 1.0)
(9, 'default2', 20, 2.0)
(11, 'default1', 21, 3.0)
*/

-- Prediction Query
SELECT husband, bill, source, throw FROM (SELECT p.husband, p.bill, p.source, p.throw, ROW_NUMBER() OVER (PARTITION BY p.source ORDER BY p.throw DESC, p.husband ASC) AS rank_in_cat FROM require AS p WHERE p.everything = 0) AS ranked WHERE ranked.rank_in_cat <= 2;

/*
Prediction Result:
(7, 'default2', 1, 1.0)
(21, 'default2', 7, 0.0)
(16, 'default1', 10, 1.0)
(9, 'default2', 20, 2.0)
(14, 'default2', 20, 2.0)
(11, 'default1', 21, 3.0)
(20, 'default2', 21, 2.0)
*/