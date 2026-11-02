-- Schema DDL
CREATE TABLE "a" ("x" INTEGER, "ya" INTEGER, "yx" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO a (x, ya, yx) VALUES (10, 20, 'HELLO');
INSERT INTO a (x, ya, yx) VALUES (30, 40, 'WORLD');
INSERT INTO a (x, ya, yx) VALUES (50, 60, 'hello');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT X.X AS AX FROM A AS X WHERE X.YX = 'HELLO';

/*
Gold Result:
(10,)
*/

-- Prediction Query
SELECT X.X AS AX FROM A AS X WHERE X.YX = 'HELLO HI';

/*
Prediction Result:
*/