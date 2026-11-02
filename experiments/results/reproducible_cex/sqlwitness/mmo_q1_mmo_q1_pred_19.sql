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
INSERT INTO chair (according, song, sure, mouth) VALUES (2, 'default1', 'default1', 3), (3, 'COMPLETED', 'default1', 1), (1, 'default2', 'COMPLETED', 2), (0, 'COMPLETED', 'COMPLETED', 2);
INSERT INTO since (collection, according, save, grow, clearly, dinner) VALUES (0, 2, 'default1', 'COMPLETED', 'COMPLETED', 0.0), (1, 1, 'default2', 'default2', 'default1', 2.0), (2, 2, 'default1', 'default1', 'default2', -1.0), (3, 0, 'COMPLETED', 'COMPLETED', 'default1', 1.0), (4, 3, 'default1', 'default1', 'default2', 1.0), (5, 1, 'default1', 'COMPLETED', 'default1', 0.0), (6, 2, 'default1', 'default1', 'default1', 3.0), (7, 1, 'default1', 'default1', 'default2', 1.0), (8, 1, 'default1', 'COMPLETED', 'default1', 1.0), (9, 2, 'default2', 'default1', 'default2', -1.0), (10, 1, 'default1', 'COMPLETED', 'default1', 1.0), (11, 1, 'default1', 'COMPLETED', 'default1', 1.0), (12, 2, 'COMPLETED', 'default1', 'default1', 0.0), (13, 3, 'default2', 'default1', 'COMPLETED', 2.0), (14, 1, 'default1', 'default1', 'default1', 1.0), (15, 3, 'COMPLETED', 'default1', 'COMPLETED', 2.0), (16, 1, 'default2', 'default2', 'default1', 1.0), (17, 1, 'default2', 'default1', 'default2', 1.0), (18, 3, 'default1', 'default2', 'default2', 3.0), (19, 3, 'default2', 'COMPLETED', 'default2', 0.0), (20, 0, 'COMPLETED', 'COMPLETED', 'COMPLETED', 2.0), (21, 1, 'COMPLETED', 'default2', 'default2', 2.0), (22, 1, 'COMPLETED', 'COMPLETED', 'default1', 3.0), (23, 2, 'default1', 'default1', 'COMPLETED', 1.0), (24, 2, 'default2', 'COMPLETED', 'default1', 3.0), (25, 1, 'default1', 'COMPLETED', 'default2', 1.0), (26, 3, 'default2', 'default1', 'default2', 1.0), (27, 3, 'default2', 'default1', 'default2', 0.0), (28, 3, 'COMPLETED', 'COMPLETED', 'default1', -1.0), (29, 3, 'COMPLETED', 'COMPLETED', 'COMPLETED', 3.0), (30, 3, 'COMPLETED', 'COMPLETED', 'default1', -1.0), (31, 2, 'default1', 'default2', 'COMPLETED', -1.0), (32, 1, 'default2', 'default2', 'default1', 3.0), (33, 2, 'COMPLETED', 'COMPLETED', 'COMPLETED', 1.0), (34, 2, 'COMPLETED', 'default2', 'COMPLETED', 3.0), (35, 2, 'COMPLETED', 'default2', 'COMPLETED', 0.0), (36, 3, 'default1', 'COMPLETED', 'default1', 2.0), (37, 1, 'default2', 'default2', 'default2', 3.0), (38, 1, 'default1', 'default1', 'default2', 0.0), (39, 3, 'default2', 'default1', 'default2', 0.0), (40, 0, 'default2', 'default2', 'default1', 1.0), (41, 3, 'default1', 'default1', 'default1', 2.0), (42, 1, 'default2', 'COMPLETED', 'COMPLETED', 3.0), (43, 2, 'COMPLETED', 'default1', 'default2', -1.0), (44, 2, 'COMPLETED', 'default2', 'COMPLETED', 2.0), (45, 3, 'default2', 'COMPLETED', 'default1', 3.0), (46, 3, 'default2', 'COMPLETED', 'COMPLETED', 3.0), (47, 1, 'COMPLETED', 'COMPLETED', 'default2', 0.0), (48, 2, 'COMPLETED', 'default1', 'COMPLETED', 3.0), (49, 0, 'COMPLETED', 'default2', 'default1', 3.0), (50, 0, 'default2', 'COMPLETED', 'default2', 1.0), (51, 1, 'COMPLETED', 'COMPLETED', 'default1', 1.0), (52, 3, 'COMPLETED', 'COMPLETED', 'default1', 2.0), (53, 2, 'COMPLETED', 'default2', 'default1', 3.0), (54, 3, 'default1', 'default2', 'COMPLETED', -1.0), (55, 2, 'default1', 'COMPLETED', 'COMPLETED', 1.0), (56, 0, 'default2', 'default2', 'COMPLETED', 0.0), (57, 2, 'default1', 'default1', 'COMPLETED', 2.0), (58, 1, 'default2', 'default2', 'default1', 2.0), (59, 3, 'default1', 'default1', 'default1', 2.0), (60, 2, 'COMPLETED', 'default1', 'COMPLETED', -1.0), (61, 3, 'COMPLETED', 'default1', 'COMPLETED', 3.0), (62, 0, 'default1', 'COMPLETED', 'default2', 0.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT c.according, c.song, COUNT(o.collection) AS total_orders, COALESCE(SUM(o.dinner), 0.0) AS total_spend FROM chair AS c LEFT JOIN since AS o ON c.according = o.according AND o.grow = 'COMPLETED' WHERE c.mouth = 1 GROUP BY c.according, c.song;

/*
Gold Result:
(3, 'COMPLETED', 8, 11.0)
*/

-- Prediction Query
SELECT c.according, c.song, COUNT(o.collection) AS total_orders, COALESCE(SUM(o.dinner), 0.0) AS total_spend FROM chair AS c LEFT JOIN since AS o ON c.according = o.according AND o.grow = 'COMPLETED' WHERE c.mouth = 1 GROUP BY c.according, c.song HAVING COUNT(o.collection) <= 2;

/*
Prediction Result:
*/