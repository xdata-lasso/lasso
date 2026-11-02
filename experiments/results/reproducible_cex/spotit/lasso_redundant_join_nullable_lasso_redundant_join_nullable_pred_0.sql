-- Schema DDL
CREATE TABLE "EMPLOYEES" (
    "EMP_ID" INT,
    "DEPARTMENT_ID" INT,
    "BONUS" INT,
    PRIMARY KEY ("EMP_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO EMPLOYEES VALUES (1, 0, NULL);
INSERT INTO EMPLOYEES VALUES (0, 0, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT E1.emp_id FROM employees AS E1 CROSS JOIN employees AS E2 WHERE E1.emp_id = E2.emp_id AND E1.bonus = E2.bonus;

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT E1.emp_id FROM employees AS E1 CROSS JOIN employees AS E2 WHERE E1.emp_id = E2.emp_id;

/*
Prediction Result:
(0,)
(1,)
*/