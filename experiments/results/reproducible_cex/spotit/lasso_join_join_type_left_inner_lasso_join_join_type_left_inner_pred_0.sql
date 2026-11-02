-- Schema DDL
CREATE TABLE "T1" (
    "ID" INT,
    "VAL" INT
);
CREATE TABLE "T2" (
    "T1_ID" INT,
    "VAL2" INT
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO T1 VALUES (1, 0);
INSERT INTO T1 VALUES (2, 0);
INSERT INTO T2 VALUES (3, 0);
INSERT INTO T2 VALUES (2, 0);
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
(0, None)
*/