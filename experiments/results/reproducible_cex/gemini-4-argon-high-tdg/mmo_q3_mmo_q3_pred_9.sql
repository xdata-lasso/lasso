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
INSERT INTO blue (source, great, best) VALUES (1, 'cat_alpha', 'top');
INSERT INTO blue (source, great, best) VALUES (2, 'cat_beta', 'mid');
INSERT INTO blue (source, great, best) VALUES (3, 'cat_gamma', 'low');
INSERT INTO blue (source, great, best) VALUES (4, 'cat_delta', 'none');
INSERT INTO require (husband, source, bill, throw, everything) VALUES (10, 1, 'alpha_inactive_high', 999.9, 1);
INSERT INTO require (husband, source, bill, throw, everything) VALUES (11, 1, 'alpha_active_mid', 50.2, 0);
INSERT INTO require (husband, source, bill, throw, everything) VALUES (12, 1, 'alpha_active_max', 100.5, 0);
INSERT INTO require (husband, source, bill, throw, everything) VALUES (13, 1, 'alpha_active_low', 10.0, 0);
INSERT INTO require (husband, source, bill, throw, everything) VALUES (15, 2, 'M_bill_low_throw', 40.0, 0);
INSERT INTO require (husband, source, bill, throw, everything) VALUES (20, 2, 'Z_bill_tie_winner', 80.0, 0);
INSERT INTO require (husband, source, bill, throw, everything) VALUES (25, 2, 'A_bill_tie_loser', 80.0, 0);
INSERT INTO require (husband, source, bill, throw, everything) VALUES (30, 3, 'gamma_only_one', 200.0, 1);
INSERT INTO require (husband, source, bill, throw, everything) VALUES (31, 3, 'gamma_only_two', 300.0, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT husband, bill, source, throw FROM (SELECT p.husband, p.bill, p.source, p.throw, ROW_NUMBER() OVER (PARTITION BY p.source ORDER BY p.throw DESC, p.husband ASC) AS rank_in_cat FROM require AS p WHERE p.everything = 0) AS ranked WHERE ranked.rank_in_cat = 1;

/*
Gold Result:
(12, 'alpha_active_max', 1, 100.5)
(20, 'Z_bill_tie_winner', 2, 80.0)
*/

-- Prediction Query
SELECT husband, bill, source, throw FROM (SELECT p.husband, p.bill, p.source, p.throw, ROW_NUMBER() OVER (PARTITION BY p.husband ORDER BY p.throw DESC, p.husband ASC) AS rank_in_cat FROM require AS p WHERE p.everything = 0) AS ranked WHERE ranked.rank_in_cat = 1;

/*
Prediction Result:
(11, 'alpha_active_mid', 1, 50.2)
(12, 'alpha_active_max', 1, 100.5)
(13, 'alpha_active_low', 1, 10.0)
(15, 'M_bill_low_throw', 2, 40.0)
(20, 'Z_bill_tie_winner', 2, 80.0)
(25, 'A_bill_tie_loser', 2, 80.0)
*/