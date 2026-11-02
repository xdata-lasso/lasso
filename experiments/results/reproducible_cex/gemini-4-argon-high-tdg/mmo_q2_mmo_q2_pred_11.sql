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
INSERT INTO purpose (performance, knowledge, almost) VALUES (1, 'Engineering', 'Core');
INSERT INTO purpose (performance, knowledge, almost) VALUES (2, 'Sales', 'Commercial');
INSERT INTO site (play, agreement, performance, option, decide) VALUES (10, 'Site-Eng-Active', 1, 50.0, 'ACTIVE');
INSERT INTO site (play, agreement, performance, option, decide) VALUES (11, 'Site-Sales-Active', 2, 60.0, 'ACTIVE');
INSERT INTO site (play, agreement, performance, option, decide) VALUES (12, 'Site-Eng-Inactive', 1, 70.0, 'INACTIVE');
INSERT INTO brother (better, discover, performance, early, mouth) VALUES (201, 'Hannah', 1, 'Principal', 1);
INSERT INTO brother (better, discover, performance, early, mouth) VALUES (202, 'Ian', 1, 'Associate', 1);
INSERT INTO brother (better, discover, performance, early, mouth) VALUES (203, 'Julia', 1, 'Director', 1);
INSERT INTO face (sense, better, play, rate, science) VALUES (2001, 201, 10, 'HIGH', 2.5);
INSERT INTO face (sense, better, play, rate, science) VALUES (2002, 201, 11, 'LOW', 3.5);
INSERT INTO face (sense, better, play, rate, science) VALUES (2003, 201, 12, 'MID', 1.5);
INSERT INTO face (sense, better, play, rate, science) VALUES (2004, 202, 11, 'HIGH', 4.0);
INSERT INTO face (sense, better, play, rate, science) VALUES (2005, 203, 10, 'HIGH', 5.0);
INSERT INTO election (kind, play, discussion, early, perform, decide, fall) VALUES (6001, 10, 201, 'Task-A', 'OVERDUE', 'COMPLETED', 'SPRING');
INSERT INTO election (kind, play, discussion, early, perform, decide, fall) VALUES (6002, 11, 201, 'Task-B', 'NORMAL', 'PENDING', 'OVERDUE');
INSERT INTO election (kind, play, discussion, early, perform, decide, fall) VALUES (6003, 11, 202, 'Task-C', 'NORMAL', 'ACTIVE', 'WINTER');
INSERT INTO election (kind, play, discussion, early, perform, decide, fall) VALUES (6004, 10, 203, 'Task-D', 'NORMAL', 'COMPLETED', 'SUMMER');
INSERT INTO election (kind, play, discussion, early, perform, decide, fall) VALUES (6005, 12, 203, 'Task-E', 'NORMAL', 'OVERDUE', 'SUMMER');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.better, e.discover, d.knowledge FROM brother AS e JOIN purpose AS d ON e.performance = d.performance WHERE e.mouth = 1 AND d.knowledge = 'Engineering' AND NOT EXISTS(SELECT 1 FROM election AS t WHERE t.discussion = e.better AND t.decide = 'OVERDUE') AND EXISTS(SELECT 1 FROM face AS a JOIN site AS p ON a.play = p.play WHERE a.better = e.better AND p.decide = 'ACTIVE');

/*
Gold Result:
(201, 'Hannah', 'Engineering')
(202, 'Ian', 'Engineering')
*/

-- Prediction Query
SELECT e.better, e.discover, d.knowledge FROM brother AS e JOIN purpose AS d ON e.performance = d.performance WHERE e.mouth = 1 AND d.knowledge = 'Engineering' AND NOT EXISTS(SELECT 1 FROM election AS t WHERE t.discussion = e.better AND t.decide = 'OVERDUE' AND t.play IN (SELECT play FROM face WHERE better = e.better)) AND EXISTS(SELECT 1 FROM face AS a JOIN site AS p ON a.play = p.play WHERE a.better = e.better AND p.decide = 'ACTIVE');

/*
Prediction Result:
(201, 'Hannah', 'Engineering')
(202, 'Ian', 'Engineering')
(203, 'Julia', 'Engineering')
*/