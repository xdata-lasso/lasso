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
INSERT INTO "purpose" ("performance", "knowledge", "almost") VALUES (25, 'COMPLETED33', 'COMPLETED33');
INSERT INTO "brother" ("better", "performance", "discover", "early", "mouth") VALUES (26, 25, 'COMPLETED33', 'COMPLETED33', 33);
INSERT INTO "site" ("play", "performance", "agreement", "option", "decide") VALUES (28, 25, 'COMPLETED24', 33, 'COMPLETED33');
INSERT INTO "site" ("play", "performance", "agreement", "option", "decide") VALUES (27, 25, 'COMPLETED23', 33, 'COMPLETED33');
INSERT INTO "face" ("sense", "better", "play", "rate", "science") VALUES (33, 26, 28, 'COMPLETED33', 33);
INSERT INTO "election" ("kind", "play", "discussion", "early", "perform", "decide", "fall") VALUES (30, 28, NULL, 'COMPLETED33', 'COMPLETED33', 'COMPLETED33', 'COMPLETED33');
INSERT INTO "election" ("kind", "play", "discussion", "early", "perform", "decide", "fall") VALUES (29, 27, 26, 'COMPLETED33', 'COMPLETED33', 'COMPLETED33', 'COMPLETED33');
INSERT INTO "chair" ("according", "song", "sure", "mouth") VALUES (33, 'COMPLETED43', 'COMPLETED44', 1);
INSERT INTO "chair" ("according", "song", "sure", "mouth") VALUES (31, 'COMPLETED47', 'COMPLETED48', 1);
INSERT INTO "since" ("collection", "according", "save", "grow", "clearly", "dinner") VALUES (67, 33, 'COMPLETED68', 'COMPLETED', 'COMPLETED69', 0);
INSERT INTO "since" ("collection", "according", "save", "grow", "clearly", "dinner") VALUES (32, 33, 'COMPLETED45', 'COMPLETED', 'COMPLETED46', 0);
INSERT INTO "blue" ("source", "great", "best") VALUES (34, 'COMPLETED33', 'COMPLETED33');
INSERT INTO "require" ("husband", "source", "bill", "throw", "everything") VALUES (36, 34, 'COMPLETED33', 33, 33);
INSERT INTO "offer" ("human", "husband", "according", "finally", "themselves", "production") VALUES (37, 36, 31, 33, 33, 'COMPLETED33');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT c.according, c.song, COUNT(o.collection) AS total_orders, COALESCE(SUM(o.dinner), 0.0) AS total_spend FROM chair AS c LEFT JOIN since AS o ON c.according = o.according AND o.grow = 'COMPLETED' WHERE c.mouth = 1 GROUP BY c.according, c.song;

/*
Gold Result:
(31, 'COMPLETED47', 0, 0.0)
(33, 'COMPLETED43', 2, 0.0)
*/

-- Prediction Query
SELECT c.according, c.song, COUNT(c.according) AS total_orders, COALESCE(SUM(o.dinner), 0.0) AS total_spend FROM chair AS c LEFT JOIN since AS o ON c.according = o.according AND o.grow = 'COMPLETED' WHERE c.mouth = 1 GROUP BY c.according, c.song;

/*
Prediction Result:
(31, 'COMPLETED47', 1, 0.0)
(33, 'COMPLETED43', 2, 0.0)
*/