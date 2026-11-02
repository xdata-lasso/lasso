-- Schema DDL
CREATE TABLE "EMPLOYEE" (
    "EMPLOYEE_ID" INT,
    "DEPARTMENT_ID" INT,
    "PRIMARY_FLAG" TEXT,
    PRIMARY KEY ("EMPLOYEE_ID", "DEPARTMENT_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO EMPLOYEE VALUES (0, 1, 22757091371784758);
INSERT INTO EMPLOYEE VALUES (1, 0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.employee_id, e.department_id FROM employee AS e WHERE e.primary_flag = 'Y' OR e.employee_id IN (SELECT employee_id FROM employee GROUP BY employee_id HAVING COUNT(DISTINCT department_id) = 1);

/*
Gold Result:
(0, 1)
(1, 0)
*/

-- Prediction Query
SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE WHERE PRIMARY_FLAG = 'Y' UNION SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE GROUP BY EMPLOYEE_ID HAVING SUM(PRIMARY_FLAG = 'Y') = 0;

/*
Prediction Result:
(0, 1)
*/