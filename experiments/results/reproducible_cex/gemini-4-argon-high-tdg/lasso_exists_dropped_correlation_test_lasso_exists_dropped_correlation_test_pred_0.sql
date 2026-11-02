-- Schema DDL
CREATE TABLE t1 (id INTEGER PRIMARY KEY, category TEXT NOT NULL);

CREATE TABLE t2 (id INTEGER PRIMARY KEY, category TEXT NOT NULL, score INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO t1 (id, category) VALUES (1, 'cat_51');
INSERT INTO t1 (id, category) VALUES (2, 'cat_50');
INSERT INTO t1 (id, category) VALUES (3, 'cat_49');
INSERT INTO t1 (id, category) VALUES (4, 'cat_null');
INSERT INTO t1 (id, category) VALUES (5, 'cat_none');
INSERT INTO t2 (id, category, score) VALUES (101, 'cat_51', 51);
INSERT INTO t2 (id, category, score) VALUES (102, 'cat_50', 50);
INSERT INTO t2 (id, category, score) VALUES (103, 'cat_49', 49);
INSERT INTO t2 (id, category, score) VALUES (104, 'cat_null', NULL);
INSERT INTO t2 (id, category, score) VALUES (105, 'cat_unmatched', 100);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM t1 WHERE EXISTS(SELECT * FROM t2 WHERE t2.category = t1.category AND t2.score > 50);

/*
Gold Result:
(1, 'cat_51')
*/

-- Prediction Query
SELECT * FROM t1 WHERE EXISTS(SELECT * FROM t2 WHERE t2.score > 50);

/*
Prediction Result:
(1, 'cat_51')
(2, 'cat_50')
(3, 'cat_49')
(4, 'cat_null')
(5, 'cat_none')
*/