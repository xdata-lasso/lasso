-- Schema DDL
CREATE TABLE t1 (id INTEGER PRIMARY KEY, category TEXT NOT NULL);

CREATE TABLE t2 (id INTEGER PRIMARY KEY, category TEXT NOT NULL, score INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO t1 (id, category) VALUES (1, 'A');
INSERT INTO t1 (id, category) VALUES (2, 'B');
INSERT INTO t1 (id, category) VALUES (3, 'C');
INSERT INTO t1 (id, category) VALUES (4, 'D');
INSERT INTO t2 (id, category, score) VALUES (10, 'A', 51);
INSERT INTO t2 (id, category, score) VALUES (11, 'B', 50);
INSERT INTO t2 (id, category, score) VALUES (12, 'C', NULL);
INSERT INTO t2 (id, category, score) VALUES (13, 'E', 100);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM t1 WHERE EXISTS(SELECT * FROM t2 WHERE t2.category = t1.category AND t2.score > 50);

/*
Gold Result:
(1, 'A')
*/

-- Prediction Query
SELECT * FROM t1 WHERE EXISTS(SELECT * FROM t2 WHERE t2.score > 50);

/*
Prediction Result:
(1, 'A')
(2, 'B')
(3, 'C')
(4, 'D')
*/