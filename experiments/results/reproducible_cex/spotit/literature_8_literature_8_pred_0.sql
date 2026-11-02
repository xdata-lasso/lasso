-- Schema DDL
CREATE TABLE "R" (
    "A" INT,
    "B" INT,
    "C" INT
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO R VALUES (10, 0, 0);
INSERT INTO R VALUES (6, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT X.B AS XB FROM R AS X WHERE X.A = 5 AND X.C < 1;

/*
Gold Result:
*/

-- Prediction Query
SELECT X.B AS XB FROM R AS X WHERE X.A < 10;

/*
Prediction Result:
(0,)
*/