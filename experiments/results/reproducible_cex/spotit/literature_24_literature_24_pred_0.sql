-- Schema DDL
CREATE TABLE "R" (
    "A" INT,
    "B" INT
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO R VALUES (NULL, NULL);
INSERT INTO R VALUES (NULL, NULL);
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
(0,)
*/