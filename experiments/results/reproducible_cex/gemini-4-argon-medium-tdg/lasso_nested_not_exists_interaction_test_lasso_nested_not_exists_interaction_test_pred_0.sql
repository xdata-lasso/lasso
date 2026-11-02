-- Schema DDL
CREATE TABLE t1 (id INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE t2 (id INTEGER PRIMARY KEY, t1_id INTEGER REFERENCES t1 (id), year INTEGER);

CREATE TABLE t3 (id INTEGER PRIMARY KEY, year INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests behavior when t3 has 2020 (all t1 rows should be returned regardless of t2)
-- Includes t1 with matching t2 (1:1 and 1:many), t1 without t2, NULL t1_id, NULL name, and t2.year = 2020 vs != 2020.
INSERT INTO t1 (id, name) VALUES (1, 'Alice');
INSERT INTO t1 (id, name) VALUES (2, 'Bob');
INSERT INTO t1 (id, name) VALUES (3, 'Charlie');
INSERT INTO t1 (id, name) VALUES (4, NULL);
INSERT INTO t2 (id, t1_id, year) VALUES (10, 1, 2020);
INSERT INTO t2 (id, t1_id, year) VALUES (20, 2, 2019);
INSERT INTO t2 (id, t1_id, year) VALUES (21, 2, 2021);
INSERT INTO t2 (id, t1_id, year) VALUES (30, NULL, 2020);
INSERT INTO t2 (id, t1_id, year) VALUES (40, 4, 2018);
INSERT INTO t3 (id, year) VALUES (100, 2020);
INSERT INTO t3 (id, year) VALUES (101, 2019);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM t1 WHERE NOT EXISTS(SELECT * FROM t2 WHERE t2.t1_id = t1.id AND NOT EXISTS(SELECT * FROM t3 WHERE t3.year = 2020));

/*
Gold Result:
('Alice',)
('Bob',)
('Charlie',)
(None,)
*/

-- Prediction Query
SELECT name FROM t1 WHERE NOT EXISTS(SELECT * FROM t2 WHERE t2.t1_id = t1.id AND NOT EXISTS(SELECT * FROM t3 WHERE t3.year > 2020));

/*
Prediction Result:
('Charlie',)
*/