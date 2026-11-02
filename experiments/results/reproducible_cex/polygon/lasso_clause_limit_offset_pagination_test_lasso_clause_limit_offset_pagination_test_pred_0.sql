-- Schema DDL
CREATE TABLE items (id INTEGER PRIMARY KEY, val REAL, score REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "items" ("id", "val", "score") VALUES (4, NULL, NULL);
INSERT INTO "items" ("id", "val", "score") VALUES (3, NULL, 8);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT val / 2.0 FROM items ORDER BY val DESC, items.id NULLS LAST LIMIT 2 OFFSET 5;

/*
Gold Result:
*/

-- Prediction Query
SELECT score FROM items ORDER BY val DESC, items.id NULLS LAST LIMIT 10 OFFSET 5;

/*
Prediction Result:
*/