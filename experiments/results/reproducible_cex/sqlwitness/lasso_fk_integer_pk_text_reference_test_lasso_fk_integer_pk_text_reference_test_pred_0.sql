-- Schema DDL
CREATE TABLE parent (id INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE child (child_id INTEGER PRIMARY KEY, parent_id TEXT, val INTEGER, FOREIGN KEY (parent_id) REFERENCES parent (id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO parent (id, name) VALUES (1, 'default1'), (11, 'default2'), (10, 'default2'), (0, NULL), (9, 'default1');
INSERT INTO child (child_id, parent_id, val) VALUES (9, 0, 11), (11, 0, 10), (10, 11, 0);
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
(11,)
(10,)
*/