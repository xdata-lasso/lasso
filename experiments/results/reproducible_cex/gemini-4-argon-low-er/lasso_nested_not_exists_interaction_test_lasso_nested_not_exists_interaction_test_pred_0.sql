-- Schema DDL
CREATE TABLE t1 (id INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE t2 (id INTEGER PRIMARY KEY, t1_id INTEGER REFERENCES t1 (id), year INTEGER);

CREATE TABLE t3 (id INTEGER PRIMARY KEY, year INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO t1 (id, name) VALUES (1, 'Alice');
INSERT INTO t2 (id, t1_id, year) VALUES (1, 1, 2020);
INSERT INTO t3 (id, year) VALUES (1, 2020);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM t1 WHERE NOT EXISTS(SELECT * FROM t2 WHERE t2.t1_id = t1.id AND NOT EXISTS(SELECT * FROM t3 WHERE t3.year = 2020));

/*
Gold Result:
('Alice',)
*/

-- Prediction Query
SELECT name FROM t1 WHERE NOT EXISTS(SELECT * FROM t2 WHERE t2.t1_id = t1.id AND NOT EXISTS(SELECT * FROM t3 WHERE t3.year > 2020));

/*
Prediction Result:
*/