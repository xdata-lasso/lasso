-- Schema DDL
CREATE TABLE "I006" (
    "ID" INT,
    "NAME" TEXT,
    "OTHER_COLUMNS" TEXT
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO I006 VALUES (1, 1, -3);
INSERT INTO I006 VALUES (2, NULL, 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id, name, other_columns FROM (SELECT LHS.name AS name, LHS.id AS id, RHS.other_columns AS other_columns FROM (SELECT name, MAX(id) AS id FROM i006 GROUP BY name) AS LHS LEFT JOIN i006 AS RHS ON (LHS.name = RHS.name AND LHS.id = RHS.id)) ORDER BY id, name NULLS LAST, other_columns NULLS LAST;

/*
Gold Result:
(1, '1', '-3')
(2, None, None)
*/

-- Prediction Query
SELECT a.* FROM i006 AS a JOIN (SELECT name, MAX(id) AS maxid FROM i006 GROUP BY name) AS b ON a.id = b.maxid;

/*
Prediction Result:
(2, None, '4')
(1, '1', '-3')
*/