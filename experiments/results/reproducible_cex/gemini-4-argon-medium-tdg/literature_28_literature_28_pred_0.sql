-- Schema DDL
CREATE TABLE "a" ("c" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO a (c) VALUES (NULL);
INSERT INTO a (c) VALUES (1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM A AS X WHERE X.C IN (SELECT Y.C FROM A AS Y);

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT * FROM A AS X;

/*
Prediction Result:
(None,)
(1,)
*/