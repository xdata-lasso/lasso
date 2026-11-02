-- Schema DDL
CREATE TABLE "EMPLOYEE" (
    "EMPLOYEE_ID" INT,
    "DEPARTMENT_ID" INT,
    "PRIMARY_FLAG" TEXT,
    PRIMARY KEY ("EMPLOYEE_ID", "DEPARTMENT_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO EMPLOYEE VALUES (0, -10, 4045806179029623526);
INSERT INTO EMPLOYEE VALUES (0, -9, 4045806179029623526);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.employee_id, e.department_id FROM employee AS e WHERE e.primary_flag = 'Y' OR e.employee_id IN (SELECT employee_id FROM employee GROUP BY employee_id HAVING COUNT(DISTINCT department_id) = 1);

/*
Gold Result:
*/

-- Prediction Query
SELECT EMPLOYEE_ID, COALESCE(MAX(CASE WHEN PRIMARY_FLAG = 'Y' THEN DEPARTMENT_ID ELSE NULL END), MAX(DEPARTMENT_ID)) AS DEPARTMENT_ID FROM EMPLOYEE AS T GROUP BY EMPLOYEE_ID;

/*
Prediction Result:
(0, -9)
*/