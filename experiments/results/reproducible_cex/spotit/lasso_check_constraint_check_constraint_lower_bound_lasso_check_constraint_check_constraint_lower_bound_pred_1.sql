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
INSERT INTO EMPLOYEES VALUES (4, 0, 6300133160441726112, 502);
INSERT INTO EMPLOYEES VALUES (5, 0, 6, 501);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT MIN(wage) FROM Employees WHERE dept = 'Engineering';

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT MIN(wage) FROM Employees;

/*
Prediction Result:
(501.0,)
*/