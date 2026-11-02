-- Schema DDL
CREATE TABLE T (A INTEGER, B INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "t" ("a", "b") VALUES (1004, 1);
INSERT INTO "t" ("a", "b") VALUES (NULL, 1);
INSERT INTO "t" ("a", "b") VALUES (NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A FROM T WHERE B = 1 GROUP BY A ORDER BY COUNT(A) DESC, A NULLS LAST LIMIT 1;

/*
Gold Result:
(1004,)
*/

-- Prediction Query
SELECT A FROM T WHERE B = 1 GROUP BY A ORDER BY COUNT(*) DESC, A NULLS LAST LIMIT 1;

/*
Prediction Result:
(None,)
*/