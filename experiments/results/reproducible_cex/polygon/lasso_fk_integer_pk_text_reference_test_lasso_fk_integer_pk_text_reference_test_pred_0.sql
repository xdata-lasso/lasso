-- Schema DDL
CREATE TABLE parent (id INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE child (child_id INTEGER PRIMARY KEY, parent_id TEXT, val INTEGER, FOREIGN KEY (parent_id) REFERENCES parent (id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "parent" ("id", "name") VALUES (6, '9');
INSERT INTO "parent" ("id", "name") VALUES (9, '9');
INSERT INTO "child" ("child_id", "parent_id", "val") VALUES (8, 9, 11);
INSERT INTO "child" ("child_id", "parent_id", "val") VALUES (7, 9, 10);
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