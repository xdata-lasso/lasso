-- Schema DDL
CREATE TABLE parent (id INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE child (child_id INTEGER PRIMARY KEY, parent_id TEXT, val INTEGER, FOREIGN KEY (parent_id) REFERENCES parent (id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Boundary value testing around 10, negative numbers, zero, and NULLs in val
INSERT INTO parent (id, name) VALUES (1, 'Parent A');
INSERT INTO child (child_id, parent_id, val) VALUES (1, '1', 9);
INSERT INTO child (child_id, parent_id, val) VALUES (2, '1', 10);
INSERT INTO child (child_id, parent_id, val) VALUES (3, '1', 11);
INSERT INTO child (child_id, parent_id, val) VALUES (4, '1', 0);
INSERT INTO child (child_id, parent_id, val) VALUES (5, '1', -15);
INSERT INTO child (child_id, parent_id, val) VALUES (6, '1', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT val FROM child WHERE val > 10;

/*
Gold Result:
(11,)
*/

-- Prediction Query
SELECT val FROM child WHERE val >= 10;

/*
Prediction Result:
(10,)
(11,)
*/