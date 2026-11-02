-- Schema DDL
CREATE TABLE "EMPLOYEE" (
    "EMPLOYEE_ID" INT,
    "DEPARTMENT_ID" INT,
    "PRIMARY_FLAG" TEXT,
    PRIMARY KEY ("EMPLOYEE_ID", "DEPARTMENT_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO EMPLOYEE VALUES (-1, -3, 8);
INSERT INTO EMPLOYEE VALUES (0, -2, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.employee_id, e.department_id FROM employee AS e WHERE e.primary_flag = 'Y' OR e.employee_id IN (SELECT employee_id FROM employee GROUP BY employee_id HAVING COUNT(DISTINCT department_id) = 1);

/*
Gold Result:
(-1, -3)
(0, -2)
*/

-- Prediction Query
SELECT EMPLOYEE_ID, IIF(COUNT(DEPARTMENT_ID) = 1 AND PRIMARY_FLAG = 'N', DEPARTMENT_ID, MAX(IIF(PRIMARY_FLAG = 'Y', DEPARTMENT_ID, -1))) AS DEPARTMENT_ID FROM EMPLOYEE GROUP BY EMPLOYEE_ID;

/*
Prediction Result:
(-1, -1)
(0, -1)
*/