-- Schema DDL
CREATE TABLE T1 (id INTEGER, val INTEGER);

CREATE TABLE T2 (t1_id INTEGER, val2 INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "T1" ("id", "val") VALUES (1, 14);
INSERT INTO "T1" ("id", "val") VALUES (9, 12);
INSERT INTO "T2" ("t1_id", "val2") VALUES (9, 10);
INSERT INTO "T2" ("t1_id", "val2") VALUES (11, 9);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.val, T2.val2 FROM T1 INNER JOIN T2 ON T1.id = T2.t1_id WHERE T2.t1_id = 1;

/*
Gold Result:
*/

-- Prediction Query
SELECT T1.val, T2.val2 FROM T1 LEFT JOIN T2 ON T1.id = T2.t1_id WHERE T1.id = 1;

/*
Prediction Result:
(14, None)
*/