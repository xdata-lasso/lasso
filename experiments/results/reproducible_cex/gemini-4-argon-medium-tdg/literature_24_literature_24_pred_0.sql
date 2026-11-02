-- Schema DDL
CREATE TABLE "r" ("a" INTEGER, "b" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO "r" ("a", "b") VALUES (NULL, NULL);
INSERT INTO "r" ("a", "b") VALUES (1, NULL);
INSERT INTO "r" ("a", "b") VALUES (NULL, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(*) AS A FROM R AS X;

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT COUNT(Y.B) FROM R AS Y;

/*
Prediction Result:
(1,)
*/