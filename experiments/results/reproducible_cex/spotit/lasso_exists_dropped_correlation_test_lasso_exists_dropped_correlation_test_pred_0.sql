-- Schema DDL
CREATE TABLE "T1" (
    "ID" INT,
    "CATEGORY" TEXT NOT NULL,
    PRIMARY KEY ("ID")
);
CREATE TABLE "T2" (
    "ID" INT,
    "CATEGORY" TEXT NOT NULL,
    "SCORE" INT,
    PRIMARY KEY ("ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO T1 VALUES (-1, 5);
INSERT INTO T1 VALUES (0, 6);
INSERT INTO T2 VALUES (0, 6, 51);
INSERT INTO T2 VALUES (1, 6, 51);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM t1 WHERE EXISTS(SELECT * FROM t2 WHERE t2.category = t1.category AND t2.score > 50);

/*
Gold Result:
(0, '6')
*/

-- Prediction Query
SELECT * FROM t1 WHERE EXISTS(SELECT * FROM t2 WHERE t2.score > 50);

/*
Prediction Result:
(-1, '5')
(0, '6')
*/