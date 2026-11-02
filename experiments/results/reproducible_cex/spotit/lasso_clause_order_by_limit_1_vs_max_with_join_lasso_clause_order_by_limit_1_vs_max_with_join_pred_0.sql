-- Schema DDL
CREATE TABLE "T1" (
    "ID" INT,
    "A" FLOAT,
    "B" FLOAT,
    "C" TEXT,
    PRIMARY KEY ("ID")
);
CREATE TABLE "T2" (
    "ID" INT,
    "C" TEXT,
    PRIMARY KEY ("ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO T1 VALUES (-2147483647, 0, 1, 2247869191197208847);
INSERT INTO T1 VALUES (-2147483648, -1, 0, 7);
INSERT INTO T2 VALUES (-2147483647, 9);
INSERT INTO T2 VALUES (-2147483648, 2247869191197208847);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A / B FROM T1 WHERE C = 'Alameda' ORDER BY A / B DESC, T1.id NULLS LAST LIMIT 1;

/*
Gold Result:
*/

-- Prediction Query
SELECT MAX(T1.A / T1.B) FROM T1 INNER JOIN T2 ON T1.id = T2.id WHERE T2.C = 'Alameda';

/*
Prediction Result:
(None,)
*/