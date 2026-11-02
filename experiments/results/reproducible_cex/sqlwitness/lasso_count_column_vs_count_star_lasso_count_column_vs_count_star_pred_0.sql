-- Schema DDL
CREATE TABLE T (A INTEGER, B INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO t (a, b) VALUES (2, 0), (NULL, 1), (0, 0), (0, NULL), (0, NULL), (0, 2), (1, NULL), (NULL, NULL), (2, 0), (2, 0), (1, 2), (NULL, NULL), (NULL, 2), (0, 0), (1, 2), (NULL, 2), (1, 2), (1, NULL), (1, NULL), (0, NULL), (0, 2), (2, 1), (2, NULL), (0, 0), (1, 2), (0, 2), (2, 1), (0, 2), (0, 0), (NULL, 0), (NULL, 1), (0, NULL), (1, 1), (NULL, 1), (2, NULL), (NULL, 1), (0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A FROM T WHERE B = 1 GROUP BY A ORDER BY COUNT(A) DESC, A NULLS LAST LIMIT 1;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT A FROM T WHERE B = 1 GROUP BY A ORDER BY COUNT(*) DESC, A NULLS LAST LIMIT 1;

/*
Prediction Result:
(None,)
*/