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
INSERT INTO EMPLOYEES VALUES (0, 0, 0, NULL, 0, 50000);
INSERT INTO EMPLOYEES VALUES (1, 0, 0, NULL, 0, 50000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name, last_name FROM Employees WHERE NOT email IS NULL AND salary >= 50000;

/*
Gold Result:
*/

-- Prediction Query
SELECT first_name, last_name FROM Employees WHERE salary >= 50000;

/*
Prediction Result:
('0', '0')
('0', '0')
*/