-- Schema DDL
CREATE TABLE "r1" ("a" INTEGER, "b" INTEGER);

CREATE TABLE "r2" ("a" INTEGER PRIMARY KEY, "b" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO r2 (a, b) VALUES (1, NULL), (0, 1), (2, 1), (3, 0), (4, 0), (5, NULL), (6, 0);
INSERT INTO r1 (a, b) VALUES (1, NULL), (0, NULL), (1, 0), (1, 0), (0, 1), (1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT Z.A, Z.B FROM R1 AS X CROSS JOIN R2 AS Y CROSS JOIN R2 AS Z WHERE X.A = Y.A AND Y.A = Z.A AND X.A = Z.A AND Y.B = Z.B;

/*
Gold Result:
(0, 1)
(0, 1)
*/

-- Prediction Query
SELECT Z.A, Z.B FROM R1 AS X CROSS JOIN R2 AS Y CROSS JOIN R2 AS Z WHERE X.A = Y.A AND Y.A = Z.A AND X.A = Z.A;

/*
Prediction Result:
(1, None)
(0, 1)
(1, None)
(1, None)
(0, 1)
(1, None)
*/