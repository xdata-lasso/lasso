-- Schema DDL
CREATE TABLE t1 (id INTEGER PRIMARY KEY, a INTEGER NOT NULL, b INTEGER NOT NULL);

CREATE TABLE t2 (id INTEGER PRIMARY KEY, a INTEGER NOT NULL, b INTEGER NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO t1 (id, a, b) VALUES (1, 1, 1);
INSERT INTO t2 (id, a, b) VALUES (1, 2, 1);
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