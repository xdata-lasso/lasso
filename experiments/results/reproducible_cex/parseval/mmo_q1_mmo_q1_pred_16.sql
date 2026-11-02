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
-- Inserting into table: chair --
INSERT INTO "chair" ("according", "song", "sure", "mouth") VALUES (1, 'c_s_e2d6bc', 'cha_13661f', 1);

INSERT INTO "chair" ("according", "song", "sure", "mouth") VALUES (3, 'c_s_e2d6bc', 'cha_13661f', 1);

INSERT INTO "chair" ("according", "song", "sure", "mouth") VALUES (2, 'cha_4566b6', 'cha_13661f', -55602865);

INSERT INTO "chair" ("according", "song", "sure", "mouth") VALUES (4, 'cha_4566b6', 'cha_13661f', -59984348);

INSERT INTO "chair" ("according", "song", "sure", "mouth") VALUES (5, 'cha_4566b6', 'cha_13661f', -1022641847);

INSERT INTO "chair" ("according", "song", "sure", "mouth") VALUES (6, 'cha_4566b6', 'cha_13661f', 247012447);

INSERT INTO "chair" ("according", "song", "sure", "mouth") VALUES (7, 'cha_4566b6', 'cha_13661f', -1980249628);

INSERT INTO "chair" ("according", "song", "sure", "mouth") VALUES (8, 'cha_4566b6', 'cha_13661f', -734455130);

INSERT INTO "chair" ("according", "song", "sure", "mouth") VALUES (9, 'cha_4566b6', 'cha_13661f', -1633151678);

INSERT INTO "chair" ("according", "song", "sure", "mouth") VALUES (10, 'cha_4566b6', 'cha_13661f', -252690330);

INSERT INTO "chair" ("according", "song", "sure", "mouth") VALUES (11, 'cha_4566b6', 'cha_13661f', 1115440883);

INSERT INTO "chair" ("according", "song", "sure", "mouth") VALUES (12, 'cha_4566b6', 'cha_13661f', 1465859724);

INSERT INTO "chair" ("according", "song", "sure", "mouth") VALUES (13, 'cha_4566b6', 'cha_13661f', -1349201381);

-- Inserting into table: since --
INSERT INTO "since" ("collection", "according", "save", "grow", "clearly", "dinner") VALUES (1, 1, 'sin_8713c7', 'o_s_5556c5', 'sin_b68aa9', 1.0);

INSERT INTO "since" ("collection", "according", "save", "grow", "clearly", "dinner") VALUES (2, 1, 'sin_8713c7', 'o_s_5556c5', 'sin_b68aa9', 1.0);

INSERT INTO "since" ("collection", "according", "save", "grow", "clearly", "dinner") VALUES (3, 1, 'sin_8713c7', 'o_s_aed59b', 'sin_b68aa9', 1.0);

INSERT INTO "since" ("collection", "according", "save", "grow", "clearly", "dinner") VALUES (4, 4, 'sin_8713c7', 'sin_87e290', 'sin_b68aa9', 345.329712);

INSERT INTO "since" ("collection", "according", "save", "grow", "clearly", "dinner") VALUES (5, 5, 'sin_8713c7', 'sin_87e290', 'sin_b68aa9', 97.952323);

INSERT INTO "since" ("collection", "according", "save", "grow", "clearly", "dinner") VALUES (6, 6, 'sin_8713c7', 'sin_87e290', 'sin_b68aa9', 868.436572);

INSERT INTO "since" ("collection", "according", "save", "grow", "clearly", "dinner") VALUES (7, 7, 'sin_8713c7', 'sin_87e290', 'sin_b68aa9', 249.706432);

INSERT INTO "since" ("collection", "according", "save", "grow", "clearly", "dinner") VALUES (8, 8, 'sin_8713c7', 'sin_87e290', 'sin_b68aa9', 906.21648);

INSERT INTO "since" ("collection", "according", "save", "grow", "clearly", "dinner") VALUES (9, 9, 'sin_8713c7', 'sin_87e290', 'sin_b68aa9', 134.487977);

INSERT INTO "since" ("collection", "according", "save", "grow", "clearly", "dinner") VALUES (10, 10, 'sin_8713c7', 'sin_87e290', 'sin_b68aa9', 797.015047);

INSERT INTO "since" ("collection", "according", "save", "grow", "clearly", "dinner") VALUES (11, 11, 'sin_8713c7', 'sin_87e290', 'sin_b68aa9', 882.963176);

INSERT INTO "since" ("collection", "according", "save", "grow", "clearly", "dinner") VALUES (12, 12, 'sin_8713c7', 'sin_87e290', 'sin_b68aa9', 294.861575);

INSERT INTO "since" ("collection", "according", "save", "grow", "clearly", "dinner") VALUES (13, 13, 'sin_8713c7', 'sin_87e290', 'sin_b68aa9', 737.440743);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT c.according, c.song, COUNT(o.collection) AS total_orders, COALESCE(SUM(o.dinner), 0.0) AS total_spend FROM chair AS c LEFT JOIN since AS o ON c.according = o.according AND o.grow = 'COMPLETED' WHERE c.mouth = 1 GROUP BY c.according, c.song;

/*
Gold Result:
(1, 'c_s_e2d6bc', 0, 0.0)
(3, 'c_s_e2d6bc', 0, 0.0)
*/

-- Prediction Query
SELECT c.according, c.song, COUNT(o.collection) AS total_orders, COALESCE(SUM(o.dinner), 0.0) AS total_spend FROM chair AS c LEFT JOIN since AS o ON c.according = o.according AND NOT o.grow IN ('CANCELLED', 'PENDING') WHERE c.mouth = 1 GROUP BY c.according, c.song;

/*
Prediction Result:
(1, 'c_s_e2d6bc', 3, 3.0)
(3, 'c_s_e2d6bc', 0, 0.0)
*/