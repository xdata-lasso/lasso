-- Schema DDL
CREATE TABLE parent (id INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE child (child_id INTEGER PRIMARY KEY, parent_id TEXT, val INTEGER, FOREIGN KEY (parent_id) REFERENCES parent (id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "parent" ("id", "name") VALUES (1004, 'Noah Rhodes');
INSERT INTO "child" ("child_id", "parent_id", "val") VALUES (1005, 1004, 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT val FROM child WHERE val > 10;

/*
Gold Result:
*/

-- Prediction Query
SELECT val FROM child WHERE val >= 10;

/*
Prediction Result:
(10,)
*/