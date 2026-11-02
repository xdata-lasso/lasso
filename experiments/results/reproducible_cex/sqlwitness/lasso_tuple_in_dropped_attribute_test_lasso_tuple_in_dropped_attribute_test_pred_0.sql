-- Schema DDL
CREATE TABLE t1 (id INTEGER PRIMARY KEY, a INTEGER NOT NULL, b INTEGER NOT NULL);

CREATE TABLE t2 (id INTEGER PRIMARY KEY, a INTEGER NOT NULL, b INTEGER NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO t2 (id, a, b) VALUES (0, 0, 0), (1, 0, 1), (2, 0, 1), (3, 0, 1), (4, 0, 1), (5, 0, 0), (6, 0, 0), (7, 0, 1);
INSERT INTO t1 (id, a, b) VALUES (0, 1, 1), (1, 0, 1), (2, 0, 1), (3, 0, 1), (4, 0, 1), (5, 1, 1), (6, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id FROM t1 WHERE (a, b) IN (SELECT a, b FROM t2);

/*
Gold Result:
(1,)
(2,)
(3,)
(4,)
*/

-- Prediction Query
SELECT id FROM t1 WHERE (b) IN (SELECT b FROM t2);

/*
Prediction Result:
(0,)
(1,)
(2,)
(3,)
(4,)
(5,)
(6,)
*/