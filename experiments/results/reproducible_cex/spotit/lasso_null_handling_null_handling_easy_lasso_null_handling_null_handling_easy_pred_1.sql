-- Schema DDL
CREATE TABLE "EMPLOYEES" (
    "EMPLOYEE_ID" INT,
    "FIRST_NAME" TEXT,
    "LAST_NAME" TEXT,
    "EMAIL" TEXT,
    "DEPARTMENT" TEXT,
    "SALARY" FLOAT,
    PRIMARY KEY ("EMPLOYEE_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO EMPLOYEES VALUES (0, 0, 0, 0, 0, 50000);
INSERT INTO EMPLOYEES VALUES (1, NULL, NULL, NULL, 0, 50000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name, last_name FROM Employees WHERE NOT email IS NULL AND salary >= 50000;

/*
Gold Result:
('0', '0')
*/

-- Prediction Query
SELECT first_name, last_name FROM Employees WHERE email IS NULL AND salary >= 50000;

/*
Prediction Result:
(None, None)
*/