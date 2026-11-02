-- Schema DDL
CREATE TABLE items (id INTEGER PRIMARY KEY, score INTEGER, val REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: items --
INSERT INTO "items" ("id", "score", "val") VALUES (1, -55602865, 1.0);

INSERT INTO "items" ("id", "score", "val") VALUES (-2147483647, -59984348, 1.0);

INSERT INTO "items" ("id", "score", "val") VALUES (-2147483646, 0, 1.0);

INSERT INTO "items" ("id", "score", "val") VALUES (-2147483645, -1, 1.0);

INSERT INTO "items" ("id", "score", "val") VALUES (-2147483644, 0, 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT val FROM items ORDER BY score DESC, items.id NULLS LAST LIMIT 1;

/*
Gold Result:
(1.0,)
*/

-- Prediction Query
SELECT val FROM items WHERE score = (SELECT MAX(score) FROM items);

/*
Prediction Result:
(1.0,)
(1.0,)
*/