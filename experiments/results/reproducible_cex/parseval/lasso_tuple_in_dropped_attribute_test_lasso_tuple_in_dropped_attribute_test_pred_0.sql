-- Schema DDL
CREATE TABLE t1 (id INTEGER PRIMARY KEY, a INTEGER NOT NULL, b INTEGER NOT NULL);

CREATE TABLE t2 (id INTEGER PRIMARY KEY, a INTEGER NOT NULL, b INTEGER NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: t1 --
INSERT INTO "t1" ("id", "a", "b") VALUES (1, -55602865, 1);

INSERT INTO "t1" ("id", "a", "b") VALUES (2, -55602865, 2);

-- Inserting into table: t2 --
INSERT INTO "t2" ("id", "a", "b") VALUES (-2147483648, -59984348, 1);

INSERT INTO "t2" ("id", "a", "b") VALUES (-2147483647, -664303813, 1);

INSERT INTO "t2" ("id", "a", "b") VALUES (-2147483646, -1022641847, 1);

INSERT INTO "t2" ("id", "a", "b") VALUES (-2147483645, -59984348, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id FROM t1 WHERE (a, b) IN (SELECT a, b FROM t2);

/*
Gold Result:
*/

-- Prediction Query
SELECT id FROM t1 WHERE (b) IN (SELECT b FROM t2);

/*
Prediction Result:
(1,)
*/