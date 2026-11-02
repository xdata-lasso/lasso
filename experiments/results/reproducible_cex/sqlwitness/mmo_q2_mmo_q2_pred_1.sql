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
INSERT INTO purpose (performance, knowledge, almost) VALUES (0, 'default1', 'OVERDUE'), (2, 'default2', 'Engineering'), (1, 'Engineering', 'Engineering'), (3, 'OVERDUE', 'ACTIVE'), (4, 'ACTIVE', 'default2'), (5, 'unique_5', 'Engineering'), (6, 'unique_6', 'default1'), (7, 'unique_7', 'OVERDUE'), (8, 'unique_8', 'ACTIVE'), (9, 'unique_9', 'OVERDUE'), (10, 'unique_10', 'Engineering');
INSERT INTO site (play, performance, agreement, option, decide) VALUES (1, 6, 'default1', 2.0, 'ACTIVE'), (0, 3, 'default2', 2.0, 'default1'), (2, 0, 'Engineering', 1.0, 'OVERDUE'), (3, 4, 'OVERDUE', 1.0, 'OVERDUE'), (4, 4, 'ACTIVE', 1.0, 'default1'), (5, 0, 'unique_5', 1.0, 'Engineering'), (6, 10, 'unique_6', 1.0, 'Engineering'), (7, 1, 'unique_7', 0.0, 'Engineering'), (8, 8, 'unique_8', 2.0, 'default2'), (9, 8, 'unique_9', 1.0, 'default1'), (10, 0, 'unique_10', 2.0, 'ACTIVE');
INSERT INTO brother (better, performance, discover, early, mouth) VALUES (0, 8, 'default1', 'OVERDUE', 0), (2, 9, 'ACTIVE', 'ACTIVE', 2), (1, 1, 'ACTIVE', 'OVERDUE', 1), (3, 8, 'Engineering', 'Engineering', 1), (4, 9, 'Engineering', 'Engineering', 0), (5, 9, 'default2', 'ACTIVE', 0), (6, 7, 'Engineering', 'default1', 1), (7, 4, 'Engineering', 'default2', 2), (8, 4, 'default2', 'OVERDUE', 2), (9, 10, 'OVERDUE', 'OVERDUE', 2);
INSERT INTO election (kind, play, discussion, early, perform, decide, fall) VALUES (0, 8, 9, 'ACTIVE', 'default1', 'OVERDUE', 'default1'), (1, 2, 6, 'default2', 'default1', 'default1', 'Engineering'), (2, 9, 0, 'Engineering', 'default1', 'ACTIVE', 'default2');
INSERT INTO face (sense, better, play, rate, science) VALUES (1, 0, 1, 'ACTIVE', 2.0), (2, 1, 2, 'OVERDUE', 2.0), (0, 2, 1, 'OVERDUE', 2.0), (3, 1, 1, 'OVERDUE', 0.0), (4, 0, 2, 'default1', 1.0), (5, 2, 2, 'default1', 0.0), (6, 1, 0, 'Engineering', 2.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.better, e.discover, d.knowledge FROM brother AS e JOIN purpose AS d ON e.performance = d.performance WHERE e.mouth = 1 AND d.knowledge = 'Engineering' AND NOT EXISTS(SELECT 1 FROM election AS t WHERE t.discussion = e.better AND t.decide = 'OVERDUE') AND EXISTS(SELECT 1 FROM face AS a JOIN site AS p ON a.play = p.play WHERE a.better = e.better AND p.decide = 'ACTIVE');

/*
Gold Result:
(1, 'ACTIVE', 'Engineering')
*/

-- Prediction Query
SELECT e.better, e.discover, d.knowledge FROM brother AS e JOIN purpose AS d ON e.performance = d.performance WHERE e.mouth = 1 AND d.knowledge = 'Engineering' AND NOT EXISTS(SELECT 1 FROM election AS t WHERE t.discussion = e.better AND t.decide = 'OVERDUE') AND NOT EXISTS(SELECT 1 FROM face AS a JOIN site AS p ON a.play = p.play WHERE a.better = e.better AND p.decide = 'ACTIVE');

/*
Prediction Result:
*/