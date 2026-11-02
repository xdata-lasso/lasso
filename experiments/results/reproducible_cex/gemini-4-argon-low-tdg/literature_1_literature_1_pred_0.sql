-- Schema DDL
CREATE TABLE "r1" ("a" INTEGER, "b" INTEGER);

CREATE TABLE "r2" ("a" INTEGER PRIMARY KEY, "b" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO r1 (a, b) VALUES (1, 10);
INSERT INTO r1 (a, b) VALUES (2, 20);
INSERT INTO r2 (a, b) VALUES (1, NULL);
INSERT INTO r2 (a, b) VALUES (2, 20);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT Z.A, Z.B FROM R1 AS X CROSS JOIN R2 AS Y CROSS JOIN R2 AS Z WHERE X.A = Y.A AND Y.A = Z.A AND X.A = Z.A AND Y.B = Z.B;

/*
Gold Result:
(2, 20)
*/

-- Prediction Query
SELECT Z.A, Z.B FROM R1 AS X CROSS JOIN R2 AS Y CROSS JOIN R2 AS Z WHERE X.A = Y.A AND Y.A = Z.A AND X.A = Z.A;

/*
Prediction Result:
(1, None)
(2, 20)
*/