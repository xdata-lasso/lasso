-- Schema DDL
CREATE TABLE "R" (
    "A1" INT,
    "A2" INT
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO R VALUES (NULL, -1);
INSERT INTO R VALUES (1, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT Y.A1 AS A1, Y.A2 AS A2 FROM R AS X CROSS JOIN R AS Y WHERE X.A1 = Y.A1 AND X.A2 = Y.A2;

/*
Gold Result:
(1, 0)
*/

-- Prediction Query
SELECT DISTINCT X.A1 AS A1, X.A2 AS A2 FROM R AS X;

/*
Prediction Result:
(None, -1)
(1, 0)
*/