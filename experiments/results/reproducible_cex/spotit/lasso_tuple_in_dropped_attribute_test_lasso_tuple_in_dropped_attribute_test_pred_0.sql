-- Schema DDL
CREATE TABLE "T1" (
    "ID" INT,
    "A" INT NOT NULL,
    "B" INT NOT NULL,
    PRIMARY KEY ("ID")
);
CREATE TABLE "T2" (
    "ID" INT,
    "A" INT NOT NULL,
    "B" INT NOT NULL,
    PRIMARY KEY ("ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO T1 VALUES (0, 0, 1);
INSERT INTO T1 VALUES (1, 0, 0);
INSERT INTO T2 VALUES (-1, 1, 2);
INSERT INTO T2 VALUES (0, 1, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id FROM t1 WHERE (a, b) IN (SELECT a, b FROM t2);

/*
Gold Result:
*/

-- Prediction Query
SELECT id FROM t1 WHERE (b) IN (SELECT b FROM t2);

/*
Prediction Result:
(1,)
*/