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
INSERT INTO purpose (performance, knowledge, almost) VALUES (1, 'Engineering', 'Department A');
INSERT INTO purpose (performance, knowledge, almost) VALUES (2, 'Marketing', 'Engineering');
INSERT INTO site (play, agreement, performance, option, decide) VALUES (10, 'Agreement-Active', 1, 100.0, 'ACTIVE');
INSERT INTO site (play, agreement, performance, option, decide) VALUES (20, 'Agreement-Inactive', 1, 200.0, 'INACTIVE');
INSERT INTO brother (better, discover, performance, early, mouth) VALUES (101, 'Alice', 1, 'Senior', 1);
INSERT INTO brother (better, discover, performance, early, mouth) VALUES (102, 'Bob', 1, 'Junior', 0);
INSERT INTO brother (better, discover, performance, early, mouth) VALUES (103, 'Charlie', 1, 'Mid', 2);
INSERT INTO brother (better, discover, performance, early, mouth) VALUES (104, 'Diana', 2, 'Senior', 1);
INSERT INTO brother (better, discover, performance, early, mouth) VALUES (105, 'Evan', 1, 'Lead', 1);
INSERT INTO brother (better, discover, performance, early, mouth) VALUES (106, 'Fiona', 1, 'Staff', 1);
INSERT INTO brother (better, discover, performance, early, mouth) VALUES (107, 'George', 1, 'Intern', 1);
INSERT INTO face (sense, better, play, rate, science) VALUES (1001, 101, 10, 'STANDARD', 1.0);
INSERT INTO face (sense, better, play, rate, science) VALUES (1002, 102, 10, 'STANDARD', 1.0);
INSERT INTO face (sense, better, play, rate, science) VALUES (1003, 103, 10, 'STANDARD', 1.0);
INSERT INTO face (sense, better, play, rate, science) VALUES (1004, 104, 10, 'STANDARD', 1.0);
INSERT INTO face (sense, better, play, rate, science) VALUES (1005, 105, 10, 'STANDARD', 1.0);
INSERT INTO face (sense, better, play, rate, science) VALUES (1006, 106, 20, 'ACTIVE', 1.0);
INSERT INTO election (kind, play, discussion, early, perform, decide, fall) VALUES (5001, 10, 105, 'Review-1', 'NORMAL', 'OVERDUE', 'AUTUMN');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.better, e.discover, d.knowledge FROM brother AS e JOIN purpose AS d ON e.performance = d.performance WHERE e.mouth = 1 AND d.knowledge = 'Engineering' AND NOT EXISTS(SELECT 1 FROM election AS t WHERE t.discussion = e.better AND t.decide = 'OVERDUE') AND EXISTS(SELECT 1 FROM face AS a JOIN site AS p ON a.play = p.play WHERE a.better = e.better AND p.decide = 'ACTIVE');

/*
Gold Result:
(101, 'Alice', 'Engineering')
*/

-- Prediction Query
SELECT e.better, e.discover, d.knowledge FROM brother AS e JOIN purpose AS d ON e.performance = d.performance WHERE e.mouth = 1 AND d.knowledge = 'Engineering' AND NOT EXISTS(SELECT 1 FROM election AS t WHERE t.discussion = e.better AND t.decide = 'OVERDUE') AND EXISTS(SELECT 1 FROM face AS a JOIN site AS p ON a.play = p.play WHERE a.better = e.better AND p.decide = 'ACTIVE' AND p.option >= 5000.0);

/*
Prediction Result:
*/