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
-- Tests basic partitioning by 'source', ordering by 'throw' DESC, and filtering by 'everything = 0'.
-- Catches mutants that omit PARTITION BY, reverse 'throw' order to ASC, omit 'everything = 0' filter, or change 'rank_in_cat = 1' to > 1 or >= 1.
INSERT INTO blue (source, great, best) VALUES (1, 'Category_A', 'Best_A');
INSERT INTO blue (source, great, best) VALUES (2, 'Category_B', 'Best_B');
-- For source 1: husband 10 has highest throw (500.0) among everything=0. Husband 12 has higher throw (999.0) but everything=1.
INSERT INTO require (husband, source, bill, throw, everything) VALUES (10, 1, 'Bill_10', 500.0, 0);
INSERT INTO require (husband, source, bill, throw, everything) VALUES (11, 1, 'Bill_11', 300.0, 0);
INSERT INTO require (husband, source, bill, throw, everything) VALUES (12, 1, 'Bill_12', 999.0, 1);
INSERT INTO require (husband, source, bill, throw, everything) VALUES (13, 1, 'Bill_13', 999.0, -1);
-- For source 2: husband 21 has highest throw (250.5) among everything=0.
INSERT INTO require (husband, source, bill, throw, everything) VALUES (20, 2, 'Bill_20', 100.0, 0);
INSERT INTO require (husband, source, bill, throw, everything) VALUES (21, 2, 'Bill_21', 250.5, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT husband, bill, source, throw FROM (SELECT p.husband, p.bill, p.source, p.throw, ROW_NUMBER() OVER (PARTITION BY p.source ORDER BY p.throw DESC, p.husband ASC) AS rank_in_cat FROM require AS p WHERE p.everything = 0) AS ranked WHERE ranked.rank_in_cat = 1;

/*
Gold Result:
(10, 'Bill_10', 1, 500.0)
(21, 'Bill_21', 2, 250.5)
*/

-- Prediction Query
SELECT husband, bill, source, throw FROM (SELECT p.husband, p.bill, p.source, p.throw, ROW_NUMBER() OVER (PARTITION BY p.source ORDER BY p.throw DESC, p.husband ASC) AS rank_in_cat FROM require AS p WHERE p.everything = 1) AS ranked WHERE ranked.rank_in_cat = 1;

/*
Prediction Result:
(12, 'Bill_12', 1, 999.0)
*/