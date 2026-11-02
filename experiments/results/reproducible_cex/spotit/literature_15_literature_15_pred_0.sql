-- Schema DDL
CREATE TABLE "A" (
    "X" INT,
    "YA" INT,
    "YX" TEXT
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO A VALUES (0, 0, 1748305809730162422);
INSERT INTO A VALUES (0, 0, 1748305809730162422);
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
*/