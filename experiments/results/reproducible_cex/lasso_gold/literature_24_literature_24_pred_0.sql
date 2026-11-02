-- Schema DDL
CREATE TABLE "r" ("a" INTEGER, "b" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "r" ("a", "b") VALUES (1007, 1008);
INSERT INTO "r" ("a", "b") VALUES (1009, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(*) AS A FROM R AS X;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(Y.B) FROM R AS Y;

/*
Prediction Result:
(1,)
*/