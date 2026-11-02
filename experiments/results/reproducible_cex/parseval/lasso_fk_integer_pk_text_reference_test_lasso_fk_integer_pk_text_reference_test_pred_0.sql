-- Schema DDL
CREATE TABLE parent (id INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE child (child_id INTEGER PRIMARY KEY, parent_id TEXT, val INTEGER, FOREIGN KEY (parent_id) REFERENCES parent (id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: parent --
INSERT INTO "parent" ("id", "name") VALUES (-2147483648, '5k5swwqcgs');

-- Inserting into table: child --
INSERT INTO "child" ("child_id", "parent_id", "val") VALUES (-2147483648, '-2147483648', 11);

INSERT INTO "child" ("child_id", "parent_id", "val") VALUES (2, '-2147483648', 11);

INSERT INTO "child" ("child_id", "parent_id", "val") VALUES (3, '-2147483648', 11);

INSERT INTO "child" ("child_id", "parent_id", "val") VALUES (-2147483645, '-2147483648', 10);

INSERT INTO "child" ("child_id", "parent_id", "val") VALUES (-2147483644, '-2147483648', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT val FROM child WHERE val > 10;

/*
Gold Result:
(11,)
(11,)
(11,)
*/

-- Prediction Query
SELECT val FROM child WHERE val >= 10;

/*
Prediction Result:
(11,)
(10,)
(11,)
(11,)
*/