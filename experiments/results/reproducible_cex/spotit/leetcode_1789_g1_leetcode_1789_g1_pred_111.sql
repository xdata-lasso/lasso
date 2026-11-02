-- Schema DDL
CREATE TABLE "EMPLOYEE" (
    "EMPLOYEE_ID" INT,
    "DEPARTMENT_ID" INT,
    "PRIMARY_FLAG" TEXT,
    PRIMARY KEY ("EMPLOYEE_ID", "DEPARTMENT_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO EMPLOYEE VALUES (1, 1, NULL);
INSERT INTO EMPLOYEE VALUES (0, 0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.employee_id, e.department_id FROM employee AS e WHERE e.primary_flag = 'Y' OR e.employee_id IN (SELECT employee_id FROM employee GROUP BY employee_id HAVING COUNT(DISTINCT department_id) = 1);

/*
Gold Result:
(1, 1)
(0, 0)
*/

-- Prediction Query
SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE WHERE PRIMARY_FLAG = 'Y' OR EMPLOYEE_ID IN (SELECT EMPLOYEE_ID FROM EMPLOYEE GROUP BY EMPLOYEE_ID HAVING COUNT(DISTINCT PRIMARY_FLAG) = 1);

/*
Prediction Result:
*/