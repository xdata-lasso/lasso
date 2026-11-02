-- Schema DDL
CREATE TABLE "R1" (
    "A" INT,
    "B" INT
);
CREATE TABLE "R2" (
    "A" INT,
    "B" INT,
    PRIMARY KEY ("A")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO R1 VALUES (0, 0);
INSERT INTO R1 VALUES (-2, 0);
INSERT INTO R2 VALUES (0, NULL);
INSERT INTO R2 VALUES (-1, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT Z.A, Z.B FROM R1 AS X CROSS JOIN R2 AS Y CROSS JOIN R2 AS Z WHERE X.A = Y.A AND Y.A = Z.A AND X.A = Z.A AND Y.B = Z.B;

/*
Gold Result:
*/

-- Prediction Query
SELECT Z.A, Z.B FROM R1 AS X CROSS JOIN R2 AS Y CROSS JOIN R2 AS Z WHERE X.A = Y.A AND Y.A = Z.A AND X.A = Z.A;

/*
Prediction Result:
(0, None)
*/