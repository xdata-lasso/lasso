-- Schema DDL
CREATE TABLE "a" ("x" INTEGER, "ya" INTEGER, "yx" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO a (x, ya, yx) VALUES (1, NULL, 'HELLO HI');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT X.X AS AX FROM A AS X WHERE X.YX = 'HELLO';

/*
Gold Result:
*/

-- Prediction Query
SELECT X.X AS AX FROM A AS X WHERE X.YX = 'HELLO HI';

/*
Prediction Result:
(1,)
*/