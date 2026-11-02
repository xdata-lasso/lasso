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
-- Tests tie-breaking on 'throw' using 'husband ASC', and tests ROW_NUMBER() vs RANK() / DENSE_RANK().
-- Also tests SQLite's non-standard GROUP BY min/max quirk if a mutant replaces window function with GROUP BY source HAVING MAX(throw).
INSERT INTO blue (source, great, best) VALUES (10, 'Tie_Cat_1', 'Best_1');
INSERT INTO blue (source, great, best) VALUES (20, 'Tie_Cat_2', 'Best_2');
-- Source 10: Tie at max throw (50.0) between husband 101 and 105.
-- Inserted with 105 first so simple scan / GROUP BY might pick 105, while ORDER BY husband ASC picks 101.
INSERT INTO require (husband, source, bill, throw, everything) VALUES (105, 10, 'Bill_105_TieHighId', 50.0, 0);
INSERT INTO require (husband, source, bill, throw, everything) VALUES (101, 10, 'Bill_101_TieLowId', 50.0, 0);
INSERT INTO require (husband, source, bill, throw, everything) VALUES (100, 10, 'Bill_100_LowerThrow', 40.0, 0);
-- Source 20: Tie at max throw (0.0) with negative throws present, and a tie at everything != 0.
INSERT INTO require (husband, source, bill, throw, everything) VALUES (201, 20, 'Bill_201_Excluded', 0.0, 1);
INSERT INTO require (husband, source, bill, throw, everything) VALUES (205, 20, 'Bill_205_ZeroThrow_A', 0.0, 0);
INSERT INTO require (husband, source, bill, throw, everything) VALUES (202, 20, 'Bill_202_ZeroThrow_B', 0.0, 0);
INSERT INTO require (husband, source, bill, throw, everything) VALUES (200, 20, 'Bill_200_NegThrow', -10.5, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT husband, bill, source, throw FROM (SELECT p.husband, p.bill, p.source, p.throw, ROW_NUMBER() OVER (PARTITION BY p.source ORDER BY p.throw DESC, p.husband ASC) AS rank_in_cat FROM require AS p WHERE p.everything = 0) AS ranked WHERE ranked.rank_in_cat = 1;

/*
Gold Result:
(101, 'Bill_101_TieLowId', 10, 50.0)
(202, 'Bill_202_ZeroThrow_B', 20, 0.0)
*/

-- Prediction Query
SELECT p.husband, p.bill, p.source, p.throw FROM require AS p WHERE p.everything = 0 AND p.throw = (SELECT MAX(p2.throw) FROM require AS p2 WHERE p2.source = p.source AND p2.everything = 0);

/*
Prediction Result:
(101, 'Bill_101_TieLowId', 10, 50.0)
(105, 'Bill_105_TieHighId', 10, 50.0)
(202, 'Bill_202_ZeroThrow_B', 20, 0.0)
(205, 'Bill_205_ZeroThrow_A', 20, 0.0)
*/