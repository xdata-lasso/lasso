-- Schema DDL
CREATE TABLE "EMP" (
    "EMP_ID" INT,
    "SALARY" INT,
    PRIMARY KEY ("EMP_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO EMP VALUES (-1, 50);
INSERT INTO EMP VALUES (0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
WITH t AS (SELECT emp_id, salary AS s FROM emp) SELECT emp_id, s FROM t WHERE s > 50;

/*
Gold Result:
*/

-- Prediction Query
WITH t AS (SELECT emp_id, salary AS s FROM emp) SELECT emp_id, s FROM t WHERE s >= 50;

/*
Prediction Result:
(-1, 50)
*/