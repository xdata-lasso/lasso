-- Schema DDL
CREATE TABLE t1 (id INTEGER PRIMARY KEY, category TEXT NOT NULL);

CREATE TABLE t2 (id INTEGER PRIMARY KEY, category TEXT NOT NULL, score INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: t1 --
INSERT INTO "t1" ("id", "category") VALUES (1, 't1__9475fc');

-- Inserting into table: t2 --
INSERT INTO "t2" ("id", "category", "score") VALUES (1, 't2__0c9c66', 51);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM t1 WHERE EXISTS(SELECT * FROM t2 WHERE t2.category = t1.category AND t2.score > 50);

/*
Gold Result:
*/

-- Prediction Query
SELECT * FROM t1 WHERE EXISTS(SELECT * FROM t2 WHERE t2.score > 50);

/*
Prediction Result:
(1, 't1__9475fc')
*/