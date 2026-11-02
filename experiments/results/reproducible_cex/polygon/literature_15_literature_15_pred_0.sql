-- Schema DDL
CREATE TABLE "a" ("x" INTEGER, "ya" INTEGER, "yx" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "a" ("x", "ya", "yx") VALUES (11, NULL, 'HELLO');
INSERT INTO "a" ("x", "ya", "yx") VALUES (11, NULL, 'HELLO');
INSERT INTO "a" ("x", "ya", "yx") VALUES (11, 13, 'HELLO HI');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT X.X AS AX FROM A AS X WHERE X.YX = 'HELLO';

/*
Gold Result:
(11,)
(11,)
*/

-- Prediction Query
SELECT X.X AS AX FROM A AS X WHERE X.YX = 'HELLO HI';

/*
Prediction Result:
(11,)
*/