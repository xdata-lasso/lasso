-- Schema DDL
CREATE TABLE "T1" (
    "ID" INT,
    "NAME" TEXT,
    PRIMARY KEY ("ID")
);
CREATE TABLE "T2" (
    "ID" INT,
    "T1_ID" INT,
    "YEAR" INT,
    PRIMARY KEY ("ID"),
    FOREIGN KEY ("T1_ID") REFERENCES "T1"("ID")
);
CREATE TABLE "T3" (
    "ID" INT,
    "YEAR" INT,
    PRIMARY KEY ("ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO T1 VALUES (0, 0);
INSERT INTO T1 VALUES (1, 0);
INSERT INTO T2 VALUES (-1, 0, 0);
INSERT INTO T2 VALUES (0, 1, 0);
INSERT INTO T3 VALUES (0, 2020);
INSERT INTO T3 VALUES (1, 2020);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM t1 WHERE NOT EXISTS(SELECT * FROM t2 WHERE t2.t1_id = t1.id AND NOT EXISTS(SELECT * FROM t3 WHERE t3.year = 2020));

/*
Gold Result:
('0',)
('0',)
*/

-- Prediction Query
SELECT name FROM t1 WHERE NOT EXISTS(SELECT * FROM t2 WHERE t2.t1_id = t1.id AND NOT EXISTS(SELECT * FROM t3 WHERE t3.year > 2020));

/*
Prediction Result:
*/