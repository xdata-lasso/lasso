-- Schema DDL
CREATE TABLE "EMPLOYEES" (
    "ID" INT,
    "NAME" TEXT,
    "SALARY" FLOAT,
    "HIRE_DATE" DATE,
    "DEPARTMENT" TEXT,
    PRIMARY KEY ("ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO EMPLOYEES VALUES (-1, 0, 50000, '0001-01-01', 6300133160441726112);
INSERT INTO EMPLOYEES VALUES (0, 0, 50000, '0001-01-01', 6300133160441726112);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM employees WHERE salary >= 50000 AND department = 'Engineering';

/*
Gold Result:
*/

-- Prediction Query
SELECT name FROM employees WHERE salary < 50000 AND department = 'Engineering';

/*
Prediction Result:
*/