-- Schema DDL
CREATE TABLE "EMPLOYEE" (
    "EMPLOYEE_ID" INT,
    "DEPARTMENT_ID" INT,
    "PRIMARY_FLAG" TEXT,
    PRIMARY KEY ("EMPLOYEE_ID", "DEPARTMENT_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO EMPLOYEE VALUES (0, -2147453036, 764641476062972675);
INSERT INTO EMPLOYEE VALUES (0, -2147453035, 764641476062972675);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.employee_id, e.department_id FROM employee AS e WHERE e.primary_flag = 'Y' OR e.employee_id IN (SELECT employee_id FROM employee GROUP BY employee_id HAVING COUNT(DISTINCT department_id) = 1);

/*
Gold Result:
*/

-- Prediction Query
SELECT EMPLOYEE_ID, COALESCE(MAX(IIF(PRIMARY_FLAG = 'Y', DEPARTMENT_ID, NULL)), DEPARTMENT_ID) AS DEPARTMENT_ID FROM EMPLOYEE GROUP BY EMPLOYEE_ID;

/*
Prediction Result:
(0, -2147453035)
*/