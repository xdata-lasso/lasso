-- Schema DDL
CREATE TABLE "EMPLOYEES" (
    "EMP_ID" TEXT,
    "EMP_NAME" TEXT NOT NULL,
    "DEPT" TEXT,
    "WAGE" FLOAT,
    PRIMARY KEY ("EMP_ID"),
    CHECK (wage > 500)
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO EMPLOYEES VALUES (3, 0, 6300133160441726112, 501);
INSERT INTO EMPLOYEES VALUES (4, 0, 6300133160441726112, 502);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT MIN(wage) FROM Employees WHERE dept = 'Engineering';

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT MAX(wage) FROM Employees WHERE dept = 'Engineering';

/*
Prediction Result:
(None,)
*/