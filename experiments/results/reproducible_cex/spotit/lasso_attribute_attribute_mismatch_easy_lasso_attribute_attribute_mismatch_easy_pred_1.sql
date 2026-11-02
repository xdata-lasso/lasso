-- Schema DDL
CREATE TABLE "EMPLOYEES" (
    "EMPLOYEE_ID" INT,
    "FIRST_NAME" TEXT,
    "LAST_NAME" TEXT,
    "EMAIL" TEXT,
    "PHONE_NUMBER" TEXT,
    PRIMARY KEY ("EMPLOYEE_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO EMPLOYEES VALUES (-1, 4, 0, 5, 0);
INSERT INTO EMPLOYEES VALUES (0, 6, 0, 5, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT email FROM Employees;

/*
Gold Result:
('5',)
('5',)
*/

-- Prediction Query
SELECT first_name FROM Employees;

/*
Prediction Result:
('4',)
('6',)
*/