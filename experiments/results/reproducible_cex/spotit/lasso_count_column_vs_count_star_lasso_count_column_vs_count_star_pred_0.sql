-- Schema DDL
CREATE TABLE "T" (
    "A" INT,
    "B" INT
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO T VALUES (NULL, 1);
INSERT INTO T VALUES (1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A FROM T WHERE B = 1 GROUP BY A ORDER BY COUNT(A) DESC, A NULLS LAST LIMIT 1;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT A FROM T WHERE B = 1 GROUP BY A ORDER BY COUNT(*) DESC, A NULLS LAST LIMIT 1;

/*
Prediction Result:
(1,)
*/