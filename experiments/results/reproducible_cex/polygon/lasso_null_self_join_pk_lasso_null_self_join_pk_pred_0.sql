-- Schema DDL
CREATE TABLE R1 (A INTEGER, B INTEGER);

CREATE TABLE R2 (A INTEGER PRIMARY KEY, B INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "R1" ("a", "b") VALUES (19, 26);
INSERT INTO "R2" ("a", "b") VALUES (19, NULL);
INSERT INTO "R2" ("a", "b") VALUES (18, 25);
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
(19, None)
*/