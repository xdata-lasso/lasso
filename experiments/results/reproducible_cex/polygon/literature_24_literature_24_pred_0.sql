-- Schema DDL
CREATE TABLE "r" ("a" INTEGER, "b" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "r" ("a", "b") VALUES (0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(*) AS A FROM R AS X;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(Y.B) FROM R AS Y;

/*
Prediction Result:
(1,)
*/