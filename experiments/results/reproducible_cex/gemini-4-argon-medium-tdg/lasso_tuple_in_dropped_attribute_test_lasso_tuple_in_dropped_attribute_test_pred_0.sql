-- Schema DDL
CREATE TABLE t1 (id INTEGER PRIMARY KEY, a INTEGER NOT NULL, b INTEGER NOT NULL);

CREATE TABLE t2 (id INTEGER PRIMARY KEY, a INTEGER NOT NULL, b INTEGER NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO t2 (id, a, b) VALUES (1, 10, 20);
INSERT INTO t2 (id, a, b) VALUES (2, 10, 20);
INSERT INTO t2 (id, a, b) VALUES (3, 30, 40);
INSERT INTO t1 (id, a, b) VALUES (1, 10, 20);
INSERT INTO t1 (id, a, b) VALUES (2, 10, 40);
INSERT INTO t1 (id, a, b) VALUES (3, 20, 10);
INSERT INTO t1 (id, a, b) VALUES (4, 10, 99);
INSERT INTO t1 (id, a, b) VALUES (5, 99, 20);
INSERT INTO t1 (id, a, b) VALUES (6, 99, 99);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id FROM t1 WHERE (a, b) IN (SELECT a, b FROM t2);

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT id FROM t1 WHERE (b) IN (SELECT b FROM t2);

/*
Prediction Result:
(1,)
(2,)
(5,)
*/